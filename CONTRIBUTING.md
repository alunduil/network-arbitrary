# Contributing to network-arbitrary

Thanks for your interest in network-arbitrary. It's a small library that
provides [QuickCheck][quickcheck] `Arbitrary` instances for types in the
Haskell networking ecosystem. Contributions of all kinds are welcome:
bug reports, feature requests, documentation fixes, and pull requests.

## Ground rules

By participating you agree to abide by the
[Code of Conduct](./CODE_OF_CONDUCT.md).

The library's scope is deliberately narrow: `Arbitrary` instances (and the
generators supporting them) for network types. New instances for additional
network types are in scope; unrelated helpers generally are not. If you're
unsure whether something fits, open an issue before writing code.

## Reporting bugs and requesting features

Open a [GitHub issue][issues]. For bugs, include the versions of GHC and
network-arbitrary you're using and a minimal snippet that reproduces the
behavior.

## Getting started

The quickest path to a working environment is the included
[dev container](./.devcontainer/devcontainer.json), which provisions GHC via
GHCup along with `ormolu`, `cabal-fmt`, and `pre-commit`. Open the repository
in a
[Dev Containers][devcontainers]-capable editor and you're ready to build.

To set up locally instead, you'll need GHC (see `tested-with` in
[`network-arbitrary.cabal`](./network-arbitrary.cabal) for supported
versions), `cabal`, and [`pre-commit`](https://pre-commit.com).

Install the git hooks once after cloning:

```console
$ pre-commit install
```

The hooks run formatting and linting on commit (`ormolu`, `cabal-fmt`,
`hlint`, `cabal check`, and a `haskell-ci regenerate` check). CI runs the
same hooks, so installing them locally keeps your commits green.

## Running the tests

```console
$ cabal test
```

The suite uses [hspec][hspec] with `hspec-discover`, so any
`*Spec.hs` module under `test/` is picked up automatically.

## Branching and pull requests

Development is trunk-based. Branch off `main` for your change, keep the
branch short-lived, and open a pull request back into `main`; there are no
long-lived release or development branches. Rebasing on `main` before merge
is fine — please don't let branches drift.

Make sure `pre-commit run --all-files` and `cabal test` pass before
requesting review.

## Release procedure

Releases publish to [Hackage][hackage] and are cut by a maintainer:

1. Bump `version` in
   [`network-arbitrary.cabal`](./network-arbitrary.cabal) and add the
   corresponding entry to [`ChangeLog.md`](./ChangeLog.md).
2. Merge that change to `main`.
3. Publish a [GitHub Release][releases] for the new version.

Publishing the release triggers the
[`publish.yml`](./.github/workflows/publish.yml) workflow, which runs
`cabal sdist` and `cabal upload --publish` to push the package to Hackage.
No manual upload step is needed.

[devcontainers]: https://containers.dev
[hackage]: https://hackage.haskell.org/package/network-arbitrary
[hspec]: https://hspec.github.io
[issues]: https://github.com/alunduil/network-arbitrary/issues
[quickcheck]: https://hackage.haskell.org/package/QuickCheck
[releases]: https://github.com/alunduil/network-arbitrary/releases
