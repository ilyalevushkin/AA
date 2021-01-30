module Domerau_Levenshtein_Matrix where

import Data.List


second_elem (_,x,_) = x

res str xs@(x : xs') p1  = (xs, result, p1)
          where result           = x + 1 : zipWith4 compute str xs xs' result
                compute c1 x y z = minimum [y + 1
                                          , z + 1
                                          , x + if c1 == p1 then 0 else 1]

res' str xs@(x : xs') ys p1 p2  = (xs, x + 1 : result, p1)
          where result = (compute (head str) 
                                  (head xs) 
                                  (head xs') 
                                  (x + 1))
                         : zipWith6 compute_2 
                                    (tail str) 
                                    str 
                                    (tail xs) 
                                    (tail xs') 
                                    result ys
                compute   c1 x  y z     = minimum [y + 1
                                                 , z + 1
                                                 , x + if c1 == p1
                                                  then 0 else 1]
                compute_2 c1 c2 x y z k = minimum [y + 1
                                                 , z + 1
                                                 , x + if c1 == p1
                                                  then 0 else 1
                                                 , k + if 
                                                   ((c1 == p2) && (c2 == p1))
                                                  then 1 else 2]


domerau_levenshtein s1 s2 = last $ second_elem (foldl (transform s1) 
                                               ([], [0..(length s1)], ' ') s2)
                    where transform str (ys, xs@(x : xs'), p2) 
                                    p1 | ys == []  = res str xs p1
                                       | otherwise = res' str xs ys p1 p2


