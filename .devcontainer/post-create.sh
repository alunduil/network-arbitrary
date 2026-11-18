#!/usr/bin/env bash
set -euo pipefail

mise install

# Renovate bumps GHC in tested-with and cabal in ci.yml, so read both there.
first_match() {
  local version
  version=$(sed -n "$1" "$2" | head -n 1)
  echo "${version:?no version found in $2}"
}
# set -e ignores a failed substitution inside a command's arguments.
ghc=$(first_match 's/^ *GHC *== *\([0-9.]*\).*$/\1/p' network-arbitrary.cabal)
cabal=$(first_match 's/^ *CABAL_VERSION: "\(.*\)"$/\1/p' .github/workflows/ci.yml)

ghcup install ghc "$ghc" --set
ghcup install cabal "$cabal" --set
cabal update
