-- |
-- Module      : Network.HTTP.Types.Method.ArbitrarySpec
-- Description : Tests for Network.HTTP.Types.Method.Arbitrary
-- Copyright   : (c) Alex Brandt, 2018
-- License     : MIT
--
-- Tests for "Network.HTTP.Types.Method.Arbitrary".
module Network.HTTP.Types.Method.ArbitrarySpec
  ( main,
    spec,
  )
where

import Network.HTTP.Types.Method
  ( parseMethod,
    renderStdMethod,
  )
import Network.HTTP.Types.Method.Arbitrary ()
import Test.Hspec
  ( Spec,
    describe,
    hspec,
  )
import Test.Hspec.QuickCheck
  ( prop,
  )
import Test.Invariant
  ( (<=>),
  )

main :: IO ()
main = hspec spec

spec :: Spec
spec =
  describe "properties" $
    prop "parseMethod . renderStdMethod <=> Right" $
      parseMethod
        . renderStdMethod
        <=> Right
