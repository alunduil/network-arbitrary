{-|
Module      : Network.Arbitrary
Description : Arbitrary Instances for Network
Copyright   : (c) Alex Brandt, 2018
License     : MIT

Arbitrary instances for "Network".
-}
module Network.Arbitrary () where

import Network.HTTP.Media.MediaType.Arbitrary ()
import Network.HTTP.Types.Method.Arbitrary ()
import Network.URI.Arbitrary ()
