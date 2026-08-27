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
  ( URI,
    isURIReference,
    parseURIReference,
    uriToString,
  )
import Network.URI.Arbitrary ()
import Test.Invariant
  ( (<=>),
  )
import Test.Tasty
  ( TestTree,
    testGroup,
  )
import Test.Tasty.QuickCheck
  ( testProperty,
  )

-- | @uriToString@ maps the userinfo component through its first argument
-- so callers can redact credentials. Round-tripping needs it verbatim.
render :: URI -> String
render u = uriToString id u ""

tests :: TestTree
tests =
  testGroup
    "Network.URI.Arbitrary"
    [ testProperty "isURIReference . render" $
        isURIReference . render,
      testProperty "parseURIReference . render <=> Just" $
        parseURIReference
          . render
          <=> Just
    ]
