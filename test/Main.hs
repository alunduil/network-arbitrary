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

import qualified Network.HTTP.Media.MediaType.ArbitraryTest as MediaType
import qualified Network.HTTP.Types.Method.ArbitraryTest as Method
import qualified Network.URI.ArbitraryTest as URI
import Test.Tasty
  ( defaultMain,
    testGroup,
  )

main :: IO ()
main =
  defaultMain $
    testGroup
      "network-arbitrary"
      [ MediaType.tests,
        Method.tests,
        URI.tests
      ]
