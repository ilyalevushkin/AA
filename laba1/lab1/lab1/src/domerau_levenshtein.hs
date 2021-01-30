module Domerau_Levenshtein where

import Data.List


f ([],         [],         k) = [k]
f (xs,         [],         k) = [k + length xs]
f ([],         ys,         k) = [k + length ys]
f (xs@(x:xs'), ys@(y:ys'), k) | ((xs' /= []) && (ys' /= [])) =
                    calc_list $ (xs', ys, k + 1)
                              : (xs, ys', k + 1) 
                              : (xs', ys', k + if x == y then 0 else 1) 
                              : if ((x == head ys') && (y == head xs'))
                              then [(tail xs', tail ys', k + 1)] else []
                              | otherwise                    = 
                                calc_list $ (xs', ys, k + 1) 
                              : (xs, ys', k + 1)
                              : [(xs', ys', k + if x == y then 0 else 1)]
calc_list []     = []
calc_list (x:xs) = f x ++ calc_list xs


domerau_levenshtein s1 s2 = minimum $ calc_list [(s1, s2, 0)]