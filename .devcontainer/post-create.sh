#!/usr/bin/env bash
set -euo pipefail

mise install

# GHC and cabal stay off mise, so the versions CI pins in its workflow
# env are the ones to match.
ci_version() {
  local version
  version=$(sed -n "s/^ *$1: \"\(.*\)\"$/\1/p" .github/workflows/ci.yml | head -n 1)
  echo "${version:?$1 not found in ci.yml}"
}
# Assignments, not inline substitutions, so set -e stops on a missing pin.
ghc=$(ci_version GHC_VERSION)
cabal=$(ci_version CABAL_VERSION)

ghcup install ghc "$ghc" --set
ghcup install cabal "$cabal" --set
cabal update
