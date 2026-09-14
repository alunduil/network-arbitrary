#!/usr/bin/env bash
set -euo pipefail

# Writes a computed version into the cabal file and rolls the changelog's
# "## unreleased" heading over to it. Feature branches leave both alone and
# file entries under that heading; the release owns the number and the date.

version=${1:?usage: apply-version.sh <version> [date]}
date=${2:-$(date -u +%F)}

cabal_file=$(ls -- *.cabal)

# Only the value is replaced so cabal-fmt's column alignment survives.
set_cabal_version() {
  sed -i -E "s/^(version:[[:space:]]*)[^[:space:]]+/\1$version/" "$cabal_file"
}

roll_changelog() {
  awk -v version="$version" -v date="$date" '
    !rolled && tolower($0) ~ /^##[[:space:]]+unreleased[[:space:]]*$/ {
      print "## unreleased"
      print ""
      print "## " version "  -- " date
      rolled = 1
      next
    }
    { print }
    END {
      if (!rolled) {
        print "no \"## unreleased\" heading in ChangeLog.md" > "/dev/stderr"
        exit 1
      }
    }
  ' ChangeLog.md >ChangeLog.md.new

  mv ChangeLog.md.new ChangeLog.md
}

set_cabal_version
roll_changelog
