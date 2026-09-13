#!/usr/bin/env bash
set -euo pipefail

# Derives the next PVP version from an interface diff against the last
# version Hackage actually published. Reports and mutates nothing, so it is
# safe to run locally to see what a release would pick.
#
# Both interfaces are built in the same run, so the solver resolves the same
# dependency versions for each and a diff means this package's own source
# moved. That property is also why a dependency changing a type under an
# unchanged instance head is invisible here; see "Releases and versioning"
# in README.md for the scope decision.

cabal_file=$(ls -- *.cabal)
package=$(sed -n 's/^name:[[:space:]]*//p' "$cabal_file" | tr -d '[:space:]')
current=$(sed -n 's/^version:[[:space:]]*//p' "$cabal_file" | tr -d '[:space:]')

previous=$(curl -fsSL -H 'Accept: application/json' \
  "https://hackage.haskell.org/package/$package/preferred" |
  jq -er '."normal-version"[0]')

case $previous in
  *.*.*.*) ;;
  *)
    echo "last published version '$previous' is not four-component PVP" >&2
    exit 1
    ;;
esac

# Haddock's Hoogle output is the package interface: the exposed modules and
# the instances they define. Module qualification is stripped from instance
# heads because it names the dependency's internal module layout, which a
# consumer never sees and which upstream reshuffles without breaking anyone.
fingerprint() {
  local root=$1 txt
  txt=$(find "$root/dist-newstyle" -path "*/doc/html/$package/$package.txt" -print -quit)
  if [ -z "$txt" ]; then
    echo "no Hoogle output produced under $root" >&2
    exit 1
  fi
  sed -E "/^instance /s/([A-Z][A-Za-z0-9_']*\.)+//g" "$txt" |
    grep -E '^(module|instance) ' |
    sort
}

cabal haddock --haddock-hoogle >/dev/null
head_fingerprint=$(fingerprint .)

workdir=$(mktemp -d)
trap 'rm -rf "$workdir"' EXIT

(cd "$workdir" && cabal get "$package-$previous" >/dev/null)

# Widening bounds is why this package cuts releases, so the previous release
# reliably excludes the current compiler. Only its interface is wanted and
# the build never ships, so relaxing its bounds is enough.
(cd "$workdir/$package-$previous" && cabal haddock --haddock-hoogle --allow-newer >/dev/null)
previous_fingerprint=$(fingerprint "$workdir/$package-$previous")

added=$(comm -13 <(printf '%s\n' "$previous_fingerprint") <(printf '%s\n' "$head_fingerprint"))
removed=$(comm -23 <(printf '%s\n' "$previous_fingerprint") <(printf '%s\n' "$head_fingerprint"))

# PVP 1: anything removed forces A.B, and so does adding an orphan instance.
# Every instance this package defines is an orphan -- it declares no types
# and no classes of its own -- so an added instance line is always orphan.
if [ -n "$removed" ] || printf '%s\n' "$added" | grep -q '^instance '; then
  bump=major
elif [ -n "$added" ]; then
  bump=minor
else
  bump=patch
fi

IFS=. read -r a b c d <<<"$previous"
case $bump in
  major) next="$a.$((b + 1)).0.0" ;;
  minor) next="$a.$b.$((c + 1)).0" ;;
  patch) next="$a.$b.$c.$((d + 1))" ;;
esac

# Files outside the sdist cannot reach a consumer, so CI-only churn is not a
# release. The tag is what the last publish shipped; releases before 1.0.0.0
# were tagged without the v prefix.
tag="v$previous"
git rev-parse -q --verify "refs/tags/$tag" >/dev/null 2>&1 || tag=$previous

if ! git rev-parse -q --verify "refs/tags/$tag" >/dev/null 2>&1; then
  echo "no tag for published version $previous; treating HEAD as releasable" >&2
  release=true
elif git diff --quiet "$tag" HEAD -- \
  src test "$cabal_file" ChangeLog.md README.md LICENSE Setup.hs; then
  release=false
else
  release=true
fi

{
  echo "package:   $package"
  echo "published: $previous"
  echo "declared:  $current"
  echo "bump:      $bump"
  echo "next:      $next"
  echo "release:   $release"
  if [ "$current" != "$previous" ]; then
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
} >&2

emit() {
  printf '%s=%s\n' "$1" "$2"
  [ -z "${GITHUB_OUTPUT:-}" ] || printf '%s=%s\n' "$1" "$2" >>"$GITHUB_OUTPUT"
}

emit package "$package"
emit previous "$previous"
emit bump "$bump"
emit next "$next"
emit release "$release"
