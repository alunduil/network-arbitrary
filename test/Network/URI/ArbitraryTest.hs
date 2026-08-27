-- |
-- Module      : Network.URI.ArbitraryTest
-- Description : Tests for Network.URI.Arbitrary
-- Copyright   : (c) Alex Brandt, 2018
-- License     : MIT
--
-- Tests for "Network.URI.Arbitrary".
module Network.URI.ArbitraryTest
  ( tests,
  )
where

import Network.URI
  ( isURIReference,
    parseURIReference,
    uriToString,
  )
import Network.URI.Arbitrary ()
import Test.Tasty
  ( TestTree,
    testGroup,
  )
import Test.Tasty.QuickCheck
  ( testProperty,
  )

tests :: TestTree
tests =
  testGroup
    "Network.URI.Arbitrary"
    [ testProperty "isURIReference (uriToString id u \"\")" $
        \u -> isURIReference (uriToString id u ""),
      testProperty "Just u == parseURIReference (uriToString id u \"\")" $
        \u -> Just u == parseURIReference (uriToString id u "")
    ]
