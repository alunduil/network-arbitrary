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
  ( null,
  )
import Data.CaseInsensitive
  ( original,
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

tests :: TestTree
tests =
  testGroup
    "Network.HTTP.Media.MediaType.Arbitrary"
    [ testProperty "not . null . mainType" $ not . null . original . mainType,
      testProperty "not . null . subType" $ not . null . original . subType
    ]
