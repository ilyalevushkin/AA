module Output_Levenshtein_Matrix where

import Data.List

levenshtein s1 s2 = (last $ fst rezult, reverse $ snd rezult) where
      rezult = foldl (transform s1) (fill_list, [fill_list]) s2
           where fill_list = [0..length s1]
                 transform str (xs@(x:xs'), ys) c = (res, res : ys) where
                       res = x + 1 : zipWith4 compute str xs xs' res
                       compute c' x y z = minimum [y + 1
                                                 , z + 1
                                                 , x + if c' == c
                                                    then 0 else 1]