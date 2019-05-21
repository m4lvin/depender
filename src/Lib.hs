module Lib
    ( someFunc
    ) where

import Sample

someFunc :: IO ()
someFunc = do
  k <- c_randomNumber
  print k
