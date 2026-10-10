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
  ( mapSize,
    shrink,
    testProperty,
  )

-- id keeps the password that URI's Show instance would hide, which
-- round-tripping needs.
render :: URI -> String
render u = uriToString id u ""

roundTrips :: URI -> Bool
roundTrips = parseURIReference . render <=> Just

-- A full-size URI yields thousands of shrink candidates, and each one is
-- re-parsed.
shrinkSize :: Int
shrinkSize = 10

tests :: TestTree
tests =
  testGroup
    "Network.URI.Arbitrary"
    [ testProperty "isURIReference . render" $
        isURIReference . render,
      testProperty "roundTrips" roundTrips,
      testProperty "all roundTrips . shrink" $
        mapSize (min shrinkSize) $
          all roundTrips . shrink
    ]
