#!/usr/bin/env bash
set -euo pipefail

# Prints the ChangeLog.md section apply-version.sh rolled for a version, which
# is what the GitHub release carries as its notes.

version=${1:?usage: release-notes.sh <version>}

awk -v version="$version" '
  $0 ~ "^## " version "  --" { capture = 1; next }
  capture && /^## / { exit }
  capture { print }
' ChangeLog.md
