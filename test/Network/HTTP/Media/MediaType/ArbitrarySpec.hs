-- |
-- Module      : Network.HTTP.Media.MediaType.ArbitrarySpec
-- Description : Tests for Network.HTTP.Media.MediaType.Arbitrary
-- Copyright   : (c) Alex Brandt, 2018
-- License     : MIT
--
-- Tests for "Network.HTTP.Media.MediaType.Arbitrary".
module Network.HTTP.Media.MediaType.ArbitrarySpec
  ( main,
    spec,
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
import Test.Hspec
  ( Spec,
    describe,
    hspec,
  )
import Test.Hspec.QuickCheck
  ( prop,
  )
import Prelude hiding
  ( null,
  )

main :: IO ()
main = hspec spec

spec :: Spec
spec = describe "properties" $ do
  prop "not . null . mainType" $ not . null . original . mainType
  prop "not . null . subType" $ not . null . original . subType
