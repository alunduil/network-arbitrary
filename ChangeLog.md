# Revision history for network-arbitrary

## unreleased

## 1.0.0.1  -- 2024-05-26

### Added

* Support for base 4.20.0 and newer

### Deprecated

* GHC testing of 9.4
* GHC testing of 9.6

### Removed

* GHC testing for older than 9.4

## 1.0.0.0  -- 2024-04-24

### Added

* GHC testing for 9.2.*, 9.4.*, 9.6.*, 9.8.*
* Support for base 4.15, 4.16, 4.17, 4.18, and 4.19
* Support for bytestring 0.11.1.0 and newer, and 0.12.0.0 and newer
* Support for QuickCheck 2.15

### Changed

### Deprecated

* GHC testing for older than 9.4

### Fixed

### Removed

* GHC testing for <8.6.4

### Security

## 0.7.0.0  -- 2020-11-30

* Update project structure
  * stylish-haskell configuration
  * updated travis configuration
  * pre-commit
  * nix-shell with mkShell
* Bump base dependence version
* Generate relative references as well

## 0.6.0.0  -- 2020-04-11

* Update project structure.
* Migration to ghc 8.8
* Update travis.yml with haskell-ci

## 0.5.0.0  -- 2019-12-13

* Bump upper bounds of dependencies.

## 0.4.0.7  -- 2019-02-14

* Use a volume to carry configuration information forward.

## 0.4.0.6  -- 2019-02-12

* Include encrypted cabal configuration.

## 0.4.0.5  -- 2019-02-09

* Use a persistent volume to set the cabal configuration.

## 0.4.0.4  -- 2019-02-06

* Use new dist path in cloudbuild.

## 0.4.0.3  -- 2019-01-31

* Change cloudbuild to use new-sdist.

## 0.4.0.2  -- 2018-01-29

* Update hspec and hspec-discover.

## 0.4.0.1  -- 2018-12-20

* Fix cloudbuild publish configuration.

## 0.4.0.0  -- 2018-12-18

* Update email address for maintainer.
* Add disclaimer about code being my own.
* Update base, http-types, hspec, QickCheck, and hspec-discover.
* Update travis configuration.
* Add envrc to autoload environment.
* add missing other-modules for test suite
* add cloudbuild to publish to hackage

## 0.3.0.0  -- 2018-01-06

* Ensure URI shrink produces valid URIs

## 0.2.0.0  -- 2018-01-06

* Add top-level module for importing everything
* Fix README
* Add http-types instances (non-exhaustive)
* Add http-media instances (non-exhaustive)

## 0.1.0.0  -- 2018-01-05

* First version.
