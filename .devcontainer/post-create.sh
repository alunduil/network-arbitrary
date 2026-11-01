#!/usr/bin/env bash
set -euo pipefail

mise install

# GHC and cabal stay off mise, so the versions CI pins in its workflow
# env are the ones to match.
pin() {
  sed -n "s/^ *$1: \"\(.*\)\"$/\1/p" .github/workflows/ci.yml | head -n 1
}
ghc=$(pin GHC_VERSION)
cabal=$(pin CABAL_VERSION)

ghcup install ghc "${ghc:?GHC_VERSION not found in ci.yml}" --set
ghcup install cabal "${cabal:?CABAL_VERSION not found in ci.yml}" --set
cabal update
