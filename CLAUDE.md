# network-arbitrary — Claude guide

QuickCheck `Arbitrary` instances for network types. `stability: stable`,
PVP-versioned (current `1.0.0.1`), `cabal-version: 3.0`.

## Tooling inventory

Prefer these over `curl`, manual API calls, or first-principles scripts.

- Build / test: `cabal build`, `cabal test`. HLS via `hie.yaml` (cabal cradle).
- Lint / format: `pre-commit` (`.pre-commit-config.yaml`) runs
  `haskell-ci regenerate` (haskell-ci-0.18.1), hlint-3.6.1, `cabal check`,
  ormolu-0.7.3.0, cabal-fmt-0.1.9. Versions are pinned and Renovate-managed —
  don't substitute or upgrade them in passing.
- Dev environment: `.devcontainer/`.
- Supported GHC (`tested-with`): 9.4, 9.6, 9.8, 9.10.

## Scope discipline

A `stable` API under PVP with three open milestones (1.0.0.2, 1.0.0.3,
2.0.0.0) makes incidental export changes costly, and `network-uri-json`
uses this repo as its modernization template, so patterns set here spread.

- Before opening a PR, verify scope doesn't overlap linked or sibling
  issues; if uncertain, ask.
- An issue blocked by unshipped prerequisites: propose deferral with
  `blocked-by` edges, don't write premature code.
- Revert incidental out-of-scope edits before requesting review.
