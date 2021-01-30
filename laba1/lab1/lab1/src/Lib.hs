module Lib where

import qualified Domerau_Levenshtein
import qualified Domerau_Levenshtein_Matrix
import qualified Levenshtein_Matrix
import qualified Output_Levenshtein_Matrix
import qualified Output_Domerau_Levenshtein_Matrix


dl :: String -> String -> Int
dl str1 str2 = Domerau_Levenshtein.domerau_levenshtein str1 str2

dlm :: String -> String -> Int
dlm str1 str2 = Domerau_Levenshtein_Matrix.domerau_levenshtein str1 str2

lm :: String -> String -> Int
lm str1 str2 = Levenshtein_Matrix.levenshtein str1 str2

vlm :: String -> String -> (Int, [[Int]])
vlm str1 str2 = Output_Levenshtein_Matrix.levenshtein str1 str2

vdlm :: String -> String -> (Int, [[Int]])
vdlm str1 str2 = Output_Domerau_Levenshtein_Matrix.domerau_levenshtein str1 str2