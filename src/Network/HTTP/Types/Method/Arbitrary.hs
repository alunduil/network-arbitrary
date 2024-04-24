{-# OPTIONS_GHC -fno-warn-orphans #-}

-- |
-- Module      : Network.HTTP.Types.Method.Arbitrary
-- Description : Arbitrary Instances for Network.HTTP.Types.Method
-- Copyright   : (c) Alex Brandt, 2018
-- License     : MIT
--
-- Arbitrary instances for "Network.HTTP.Types.Method".
module Network.HTTP.Types.Method.Arbitrary () where

import Network.HTTP.Types.Method
  ( StdMethod (..),
  )
import Test.QuickCheck
  ( Arbitrary (arbitrary),
    elements,
  )

instance Arbitrary StdMethod where
  arbitrary =
    elements [GET, POST, HEAD, PUT, DELETE, TRACE, CONNECT, OPTIONS, PATCH]
