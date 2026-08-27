-- |
-- Module      : Main
-- Description : Test suite driver
-- Copyright   : (c) Alex Brandt, 2018
-- License     : MIT
--
-- Runs every test module. A new module has to be listed here and in
-- @other-modules@; nothing discovers it.
module Main
  ( main,
  )
where

import qualified Network.HTTP.Media.MediaType.ArbitraryTest
import qualified Network.HTTP.Types.Method.ArbitraryTest
import qualified Network.URI.ArbitraryTest
import Test.Tasty
  ( defaultMain,
    testGroup,
  )

main :: IO ()
main =
  defaultMain $
    testGroup
      "network-arbitrary"
      [ Network.HTTP.Media.MediaType.ArbitraryTest.tests,
        Network.HTTP.Types.Method.ArbitraryTest.tests,
        Network.URI.ArbitraryTest.tests
      ]
