module Main where

import Lib
import Data.List
import System.CPUTime
import System.Random
import Control.Exception
--import Criterion.Main

{--import qualified Domerau_Levenshtein as Dl
import qualified Domerau_Levenshtein_Matrix as Dlm
import qualified Levenshtein_Matrix as Lm
import qualified Vivod_Levenshtein_Matrix as Vlm
import qualified Vivod_Domerau_Levenshtein_Matrix as Vdlm--}

print_matrix []     = do return ()
print_matrix (x:[]) = do print x
print_matrix (x:xs) = do print x
                         print_matrix xs


print_answer_and_matrix (k, xs) = do putStrLn "\n"
                                     print k
                                     print_matrix xs



--get_random_str 0 randGen = []
--get_random_str n randGen = () : get_random_str (n - 1) randGen

split_on_matrix [] n = []
split_on_matrix list n = take n list : split_on_matrix (drop n list) n

get_random_matr m n randGen = split_on_matrix (take (m*n) $ randoms randGen) n


exec_f_random_many_times 0 f time amount m n q = do
                putStrLn "Время выполнения: "
                putStrLn $ show (fromInteger time / fromInteger amount / 1000000) ++ (" e-6 секунд")
exec_f_random_many_times am f time amount m n q = do
                randGen <- newStdGen
                let a = get_random_matr m n randGen
                --print_matrix a
                --putStrLn "\n\n"
                randGen <- newStdGen
                let b = get_random_matr n q randGen
                --print_matrix b
                --putStrLn "\n\n"
                t <- getCPUTime
                res <- return $ f a b
                evaluate res
                t' <- getCPUTime
                exec_f_random_many_times (am - 1) f (time + t' - t) amount m n q



exec_f_many_times 0 f a b time amount = do
                putStrLn "Время выполнения: "
                putStrLn $ show (fromInteger time / fromInteger amount / 1000000) ++ (" e-6 секунд")
exec_f_many_times n f a b time amount = do
                t <- getCPUTime
                res <- return $ f a b
                evaluate res
                t' <- getCPUTime
                exec_f_many_times (n - 1) f a b (time + t' - t) amount               


convert_str_to_list str n = [read x::Int | x <- (words str)]




str_to_matr list 0 n = []
str_to_matr list m n = (convert_str_to_list (head list) n) : 
                       (str_to_matr (tail list) (m - 1) n)




--do_matrix :: Int -> Int -> Int -> Int -> ([[Int]] -> [[Int]] -> [[Int]]) -> [[Int]] -> [[Int]] -> Bool -> IO ()
do_matrix 0 _ _ _      _ _  _  _    = do return ()
do_matrix _ 0 _ _      _ _  _  _    = do return ()
do_matrix _ _ 0 _      _ _  _  _    = do return ()
do_matrix m n q amount f _  _  True = do exec_f_random_many_times amount f 0 amount m n q
do_matrix m n q amount f [] _  _    = do putStrLn "Введите первую матрицу: "
                                         str <- getLine
                                         do_matrix m n q amount f [str] [] False
do_matrix m n q amount f a  [] _    = if (length a == m) then
                                        do putStrLn "Введите вторую матрицу: "
                                           str <- getLine
                                           do_matrix m n q amount f a [str] False
                                      else
                                        do str <- getLine
                                           do_matrix m n q amount f (a ++ [str]) [] False
do_matrix m n q amount f a  b  _    = if (length b /= n) then
                                         do str <- getLine
                                            do_matrix m n q amount f a (b ++ [str]) False
                                      else
                                         do let a_number = str_to_matr a m n
                                            let b_number = str_to_matr b n q
                                            res <- return $ f a_number b_number
                                            putStrLn "Результат: "
                                            print_matrix res
                                            exec_f_many_times amount f a_number b_number 0 amount


do_func amount f = do
      putStrLn "1. Начать ввод строк"
      putStrLn "2. Случайное заполнение"
      putStrLn "0. Выход"
      answer <- getLine
      case answer of "1" -> do putStrLn "Введите размеры первой матрицы (mxn): "
                               get <- getLine
                               let m = read get::Int
                               get <- getLine
                               let n = read get::Int
                               putStrLn "Введите количество столбцов второй матрицы (q): "
                               get <- getLine
                               let q = read get::Int
                               do_matrix m n q amount f [] [] False
                               do_func amount f
                     "2" -> do putStrLn "Введите размеры первой матрицы (mxn): "
                               get <- getLine
                               let m = read get::Int
                               get <- getLine
                               let n = read get::Int
                               putStrLn "Введите количество столбцов второй матрицы (q): "
                               get <- getLine
                               let q = read get::Int
                               do_matrix m n q amount f [] [] True
                               do_func amount f
                     "0" -> do do_menu
                     _   -> do do_func amount f



how_many_times_exec f = do
                          putStrLn "Введите, сколько раз функция будет выполняться:"
                          answer <- getLine
                          let number = read answer::Integer
                          do_func number f

                         

do_menu = do putStrLn "Выберите функцию:"
             putStrLn "1. Стандартное умножение матриц"
             putStrLn "2. Умножение матриц по Виноградову"
             putStrLn "3. Оптимизированное умножение матриц по Виноградову"
             putStrLn "0. Выход"
             answer <- getLine
             case answer of "1" -> do how_many_times_exec st
                            "2" -> do how_many_times_exec gr
                            "3" -> do how_many_times_exec opt_gr
                            "0" -> do return ()
                            _   -> do do_menu

main = do do_menu