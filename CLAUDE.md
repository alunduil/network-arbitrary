# network-arbitrary — Claude guide

QuickCheck `Arbitrary` instances for network types. `stability: stable`,
PVP-versioned.

## Tooling inventory

Prefer these over `curl`, manual API calls, or first-principles scripts.

- Build / test: `cabal build`, `cabal test`. HLS via `hie.yaml`.
- Lint / format: `pre-commit run --all-files`. Hook versions in
  `.pre-commit-config.yaml` are pinned and Renovate-managed — don't
  substitute or upgrade them in passing.
- Dev environment: `.devcontainer/`.
- Supported GHC: `tested-with` in `network-arbitrary.cabal`.

## Scope discipline

A `stable` API under PVP makes incidental export changes costly, and
`network-uri-json` uses this repo as its modernization template, so
patterns set here spread.

- Before opening a PR, verify scope doesn't overlap linked or sibling
  issues; if uncertain, ask.
- An issue blocked by unshipped prerequisites: propose deferral with
  `blocked-by` edges, don't write premature code.
- Revert incidental out-of-scope edits before requesting review.
