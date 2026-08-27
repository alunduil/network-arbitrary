-- |
-- Module      : Network.HTTP.Types.Method.ArbitraryTest
-- Description : Tests for Network.HTTP.Types.Method.Arbitrary
-- Copyright   : (c) Alex Brandt, 2018
-- License     : MIT
--
-- Tests for "Network.HTTP.Types.Method.Arbitrary".
module Network.HTTP.Types.Method.ArbitraryTest
  ( tests,
  )
where

import Network.HTTP.Types.Method
  ( parseMethod,
    renderStdMethod,
  )
import Network.HTTP.Types.Method.Arbitrary ()
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

tests :: TestTree
tests =
  testGroup
    "Network.HTTP.Types.Method.Arbitrary"
    [ testProperty "parseMethod . renderStdMethod <=> Right" $
        parseMethod
          . renderStdMethod
          <=> Right
    ]
