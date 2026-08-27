-- |
-- Module      : Network.HTTP.Media.MediaType.ArbitraryTest
-- Description : Tests for Network.HTTP.Media.MediaType.Arbitrary
-- Copyright   : (c) Alex Brandt, 2018
-- License     : MIT
--
-- Tests for "Network.HTTP.Media.MediaType.Arbitrary".
module Network.HTTP.Media.MediaType.ArbitraryTest
  ( tests,
  )
where

import Data.ByteString
  ( ByteString,
    null,
  )
import Data.CaseInsensitive
  ( CI,
    original,
  )
import Network.HTTP.Media.MediaType
  ( mainType,
    subType,
  )
import Network.HTTP.Media.MediaType.Arbitrary ()
import Test.Tasty
  ( TestTree,
    testGroup,
  )
import Test.Tasty.QuickCheck
  ( testProperty,
  )
import Prelude hiding
  ( null,
  )

nonEmpty :: CI ByteString -> Bool
nonEmpty = not . null . original

tests :: TestTree
tests =
  testGroup
    "Network.HTTP.Media.MediaType.Arbitrary"
    [ testProperty "nonEmpty . mainType" $ nonEmpty . mainType,
      testProperty "nonEmpty . subType" $ nonEmpty . subType
    ]
