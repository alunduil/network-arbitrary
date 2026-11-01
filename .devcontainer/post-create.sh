#!/usr/bin/env bash
set -euo pipefail

mise install

# ci.yml holds the only GHC and cabal pins Renovate bumps.
ci_version() {
  local version
  version=$(sed -n "s/^ *$1: \"\(.*\)\"$/\1/p" .github/workflows/ci.yml | head -n 1)
  echo "${version:?$1 not found in ci.yml}"
}
# set -e ignores a failed substitution inside a command's arguments.
ghc=$(ci_version GHC_VERSION)
cabal=$(ci_version CABAL_VERSION)

ghcup install ghc "$ghc" --set
ghcup install cabal "$cabal" --set
cabal update
