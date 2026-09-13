#!/usr/bin/env bash
set -euo pipefail

# Derives the next PVP version from an interface diff against the last
# version Hackage published. Mutates nothing, so it can be run locally to
# see what a release would pick.
#
# Both interfaces are built in the same run, so the solver resolves the same
# dependency versions for each and a diff means this package's own source
# moved. README.md's "Releases and versioning" covers what that costs.

readonly HACKAGE="https://hackage.haskell.org"

# Files outside the sdist cannot reach a consumer, so CI-only churn is not a
# release.
readonly SDIST_PATHS=(src test ChangeLog.md README.md LICENSE Setup.hs)

cabal_file=$(ls -- *.cabal)

cabal_field() {
  sed -n "s/^$1:[[:space:]]*//p" "$cabal_file" | tr -d '[:space:]'
}

published_version() {
  local version
  version=$(curl -fsSL -H 'Accept: application/json' \
    "$HACKAGE/package/$package/preferred" |
    jq -er '."normal-version"[0]')

  # next_version addresses PVP positions by index, so a version of another
  # shape has to stop the run rather than be bumped at the wrong position.
  case $version in
    *.*.*.*) ;;
    *)
      echo "last published version '$version' is not four-component PVP" >&2
      return 1
      ;;
  esac

  printf '%s\n' "$version"
}

build_interface() {
  local dir=$1
  shift
  (cd "$dir" && cabal haddock --haddock-hoogle "$@" >/dev/null)
}

# Haddock's Hoogle output is the package interface: the exposed modules and
# the instances they define. Module qualification comes off instance heads
# because it names the dependency's internal module layout, which no
# consumer sees.
read_interface() {
  local dir=$1 hoogle
  hoogle=$(find "$dir/dist-newstyle" -path "*/doc/html/$package/$package.txt" -print -quit)

  if [ -z "$hoogle" ]; then
    echo "no Hoogle output produced under $dir" >&2
    return 1
  fi

  sed -E "/^instance /s/([A-Z][A-Za-z0-9_']*\.)+//g" "$hoogle" |
    grep -E '^(module|instance) ' |
    sort
}

# Widening bounds is why this package cuts releases, so the previous release
# reliably excludes the current compiler. Only its interface is wanted and
# the build never ships, so relaxing its bounds is enough.
published_interface() {
  local parent=$1 unpacked="$1/$package-$published"
  (cd "$parent" && cabal get "$package-$published" >/dev/null)
  build_interface "$unpacked" --allow-newer
  read_interface "$unpacked"
}

added_instance() {
  printf '%s\n' "$1" | grep -q '^instance '
}

# PVP 1: anything removed forces A.B, and so does adding an orphan instance.
# This package declares no types and no classes, so every instance it
# defines is an orphan and an added instance line always forces A.B.
classify_bump() {
  local added=$1 removed=$2

  if [ -n "$removed" ] || added_instance "$added"; then
    printf 'major\n'
  elif [ -n "$added" ]; then
    printf 'minor\n'
  else
    printf 'patch\n'
  fi
}

next_version() {
  local version=$1 bump=$2 a b c d
  IFS=. read -r a b c d <<<"$version"

  case $bump in
    major) printf '%s.%s.0.0\n' "$a" "$((b + 1))" ;;
    minor) printf '%s.%s.%s.0\n' "$a" "$b" "$((c + 1))" ;;
    patch) printf '%s.%s.%s.%s\n' "$a" "$b" "$c" "$((d + 1))" ;;
  esac
}

# Releases before 1.0.0.0 were tagged without the v prefix.
published_tag() {
  local candidate
  for candidate in "v$published" "$published"; do
    if git rev-parse -q --verify "refs/tags/$candidate" >/dev/null 2>&1; then
      printf '%s\n' "$candidate"
      return 0
    fi
  done
  return 1
}

has_releasable_changes() {
  local tag
  if ! tag=$(published_tag); then
    echo "no tag for published version $published; treating HEAD as releasable" >&2
    return 0
  fi
  ! git diff --quiet "$tag" HEAD -- "${SDIST_PATHS[@]}" "$cabal_file"
}

report() {
  echo "package:   $package"
  echo "published: $published"
  echo "declared:  $declared"
  echo "bump:      $bump"
  echo "next:      $next"
  echo "release:   $release"

  if [ "$declared" != "$published" ]; then
    echo
    echo "note: ${cabal_file}'s version: does not match the published version."
    echo "      The next version is derived from what Hackage shipped."
  fi

  if [ -n "$added" ] || [ -n "$removed" ]; then
    echo
    echo "interface diff:"
    printf '%s\n' "$removed" | sed '/^$/d; s/^/  - /'
    printf '%s\n' "$added" | sed '/^$/d; s/^/  + /'
  fi
}

emit() {
  printf '%s=%s\n' "$1" "$2"
  [ -z "${GITHUB_OUTPUT:-}" ] || printf '%s=%s\n' "$1" "$2" >>"$GITHUB_OUTPUT"
}

package=$(cabal_field name)
declared=$(cabal_field version)
published=$(published_version)

workdir=$(mktemp -d)
trap 'rm -rf "$workdir"' EXIT

build_interface .
head_interface=$(read_interface .)
previous_interface=$(published_interface "$workdir")

added=$(comm -13 <(printf '%s\n' "$previous_interface") <(printf '%s\n' "$head_interface"))
removed=$(comm -23 <(printf '%s\n' "$previous_interface") <(printf '%s\n' "$head_interface"))

bump=$(classify_bump "$added" "$removed")
next=$(next_version "$published" "$bump")

if has_releasable_changes; then
  release=true
else
  release=false
fi

report >&2

emit package "$package"
emit published "$published"
emit bump "$bump"
emit next "$next"
emit release "$release"
