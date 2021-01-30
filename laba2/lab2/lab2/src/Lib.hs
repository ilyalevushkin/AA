module Lib where

import qualified Standard
import qualified Grape
import qualified Optymize_grape


st :: [[Int]] -> [[Int]] -> [[Int]]
st a b = Standard.standard a b

gr :: [[Int]] -> [[Int]] -> [[Int]]
gr a b = Grape.grape a b

opt_gr :: [[Int]] -> [[Int]] -> [[Int]]
opt_gr a b = Optymize_grape.optymize_grape a b
