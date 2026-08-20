# network-arbitrary

[![Hackage](https://img.shields.io/hackage/v/network-arbitrary.svg)](https://hackage.haskell.org/package/network-arbitrary)
[![CI](https://github.com/alunduil/network-arbitrary/actions/workflows/ci.yml/badge.svg)](https://github.com/alunduil/network-arbitrary/actions/workflows/ci.yml)
[![Codecov](https://codecov.io/gh/alunduil/network-arbitrary/branch/main/graph/badge.svg)](https://codecov.io/gh/alunduil/network-arbitrary)
[![License](https://img.shields.io/github/license/alunduil/network-arbitrary.svg)](LICENSE)
[![GHC](https://img.shields.io/badge/GHC-9.6%20%7C%209.8%20%7C%209.10%20%7C%209.12%20%7C%209.14-blue.svg)](https://www.haskell.org/ghc/)

[Homepage](https://github.com/alunduil/network-arbitrary)
By Alex Brandt <alunduil@gmail.com>

## Description

You can use network-arbitrary to provide Arbitrary instances for Network module types.

## Terms of use

You are free to use network-arbitrary without any conditions.  See the [LICENSE]
file for details.

## How to use network-arbitrary

```haskell
{-# LANGUAGE TypeApplications #-}
module main where

import Network.URI (URI)
import Network.URI.Arbitrary ()

main = generate (arbitrary @URI) >>= print
```

## Documentation

* [Hackage][hackage]: Hackage project page for network-arbitrary
* [The Design and Use of QuickCheck](https://begriffs.com/posts/2017-01-14-design-use-quickcheck.html): An excellent guide to using QuickCheck
* [LICENSE](./LICENSE): The license governing use of network-arbitrary
* [QuickCheck Arbitrary][arbitrary]: QuickCheck's Arbitrary class documentation
* [Hackage's Network Category][network-category]: Hackage's Network category
* [QuickCheck][quickcheck]: QuickCheck's documentation

## Getting Help

* [GitHub Issues][issues]: Support requests, bug reports, and feature requests

## How to Help

* Submit [issues] for problems or questions
* Submit [pull requests] for proposed changes

[arbitrary]: https://hackage.haskell.org/package/QuickCheck/docs/Test-QuickCheck-Arbitrary.html#t:Arbitrary
[hackage]: https://hackage.haskell.org/package/network-arbitrary
[issues]: https://github.com/alunduil/network-arbitrary/issues
[network-category]: https://hackage.haskell.org/packages/#cat:Network
[pull requests]: https://github.com/alunduil/network-arbitrary/pulls
[quickcheck]: https://hackage.haskell.org/package/QuickCheck
