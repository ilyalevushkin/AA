module Levenshtein_Matrix where

import Data.List

levenshtein s1 s2 = last $ foldl (transform s1) 
                                 [0..length s1] s2
               where transform str xs@(x:xs') c = res where
                            res = x + 1 : zipWith4 compute str xs xs' res
                            compute c' x y z = minimum [y + 1
                                                      , z + 1
                                                      , x + if c' == c 
                                                        then 0 else 1]