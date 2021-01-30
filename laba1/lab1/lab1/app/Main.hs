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


print_time t = do putStrLn "Процессорное время выполнения функции:"
                  print t



exec_f_random_many_times 0 f time amount l1 l2 = do
                putStrLn "Время выполнения: "
                putStrLn $ show (fromInteger time / fromInteger amount / 1000000) ++ (" e-6 секунд")
exec_f_random_many_times n f time amount l1 l2 = do
                randGen <- newStdGen
                let str1 = take l1 $ randomRs ('a', 'z') randGen
                randGen <- newStdGen
                let str2 = take l2 $ randomRs ('a', 'z') randGen
                t <- getCPUTime
                res <- return $ f str1 str2
                evaluate res
                t' <- getCPUTime
                exec_f_random_many_times (n - 1) f (time + t' - t) amount l1 l2



exec_f_many_times 0 f str1 str2 time amount = do
                putStrLn "Время выполнения: "
                putStrLn $ show (fromInteger time / fromInteger amount / 1000000) ++ (" e-6 секунд")
exec_f_many_times n f str1 str2 time amount = do
                t <- getCPUTime
                res <- return $ f str1 str2
                evaluate res
                t' <- getCPUTime
                exec_f_many_times (n - 1) f str1 str2 (time + t' - t) amount               



random_filling_matrix amount f = do
                                  putStrLn "Введите длину 1 строки:"
                                  randGen <- newStdGen
                                  answer <- getLine
                                  let length1 = read answer::Int
                                  let str1 = take length1 $ randomRs ('a', 'z') randGen
                                  putStrLn "Введите длину 2 строки:"
                                  randGen <- newStdGen
                                  answer <- getLine
                                  let length2 = read answer::Int
                                  let str2 = take length2 $ randomRs ('a', 'z') randGen
                                  putStrLn "Результат: "
                                  res <- return $ f str1 str2
                                  print_answer_and_matrix $ res
                                  exec_f_random_many_times amount f 0 amount length1 length2
                                  do_func_with_matrix amount f


random_filling amount f = do
                           putStrLn "Введите длину 1 строки:"
                           randGen <- newStdGen
                           answer <- getLine
                           let length1 = read answer::Int
                           let str1 = take length1 $ randomRs ('a', 'z') randGen
                           putStrLn "Введите длину 2 строки:"
                           randGen <- newStdGen
                           answer <- getLine
                           let length2 = read answer::Int
                           let str2 = take length2 $ randomRs ('a', 'z') randGen
                           putStrLn "Результат: "
                           res <- return $ f str1 str2
                           print $ res
                           exec_f_random_many_times amount f 0 amount length1 length2
                           do_func amount f


do_func_with_matrix amount f = do 
         putStrLn "1. Начать ввод строк"
         putStrLn "2. Случайное заполнение"
         putStrLn "0. Выход"
         answer <- getLine
         case answer of "1" -> do putStrLn "Введите первую строку: "
                                  answer <- getLine
                                  let str1 = answer
                                  putStrLn "Введите вторую строку: "
                                  answer <- getLine
                                  let str2 = answer
                                  t <- getCPUTime
                                  res <- return $ f str1 str2
                                  evaluate res
                                  t' <- getCPUTime
                                  putStrLn "Результат: "
                                  print_answer_and_matrix $ res
                                  exec_f_many_times amount f str1 str2 0 amount
                                  --putStrLn "Время выполнения: "
                                  --putStrLn $ show (t' - t) ++ (" e-12 секунд")
                                  --defaultMain [
                                  --     bgroup "func" [ bench "1" $ nf (f str1) str2
                                  --                   ]
                                  --            ]
                                  do_func_with_matrix amount f
                        "2" -> do random_filling_matrix amount f
                        "0" -> do do_menu
                        _   -> do do_func_with_matrix amount f

                

do_func amount f = do
      putStrLn "1. Начать ввод строк"
      putStrLn "2. Случайное заполнение"
      putStrLn "0. Выход"
      answer <- getLine
      case answer of "1" -> do putStrLn "Введите первую строку: "
                               answer <- getLine
                               let str1 = answer
                               putStrLn "Введите вторую строку: "
                               answer <- getLine
                               let str2 = answer
                               res <- return $ f str1 str2
                               putStrLn "Результат: "
                               print $ res
                               exec_f_many_times amount f str1 str2 0 amount
                               --defaultMain [
                               --    bgroup "func" [ bench "1" $ nf (f str1) str2
                               --                  ]
                               --            ]
                               do_func amount f
                     "2" -> do random_filling amount f
                     "0" -> do do_menu
                     _   -> do do_func amount f



how_many_times_exec f = do
                          putStrLn "Введите, сколько раз функция будет выполняться:"
                          answer <- getLine
                          let number = read answer::Integer
                          do_func number f


how_many_times_exec_matrix f = do
                          putStrLn "Введите, сколько раз функция будет выполняться:"
                          answer <- getLine
                          let number = read answer::Integer
                          do_func_with_matrix number f
                         

do_menu = do putStrLn "Выберите функцию:"
             putStrLn "1. Расстояние Домерау-Левенштейна"
             putStrLn "2. Расстояние Левенштейна в матричной форме"
             putStrLn "3. Расстояние Домерау-Левенштейна в матричной форме"
             putStrLn "4. Расстояние Левенштейна в матричной форме (+ вывод самой матрицы)"
             putStrLn "5. Расстояние Домерау-Левенштейна в матричной форме (+ вывод самой матрицы)"
             putStrLn "0. Выход"
             answer <- getLine
             case answer of "1" -> do how_many_times_exec dl
                            "2" -> do how_many_times_exec lm
                            "3" -> do how_many_times_exec dlm
                            "4" -> do how_many_times_exec_matrix vlm
                            "5" -> do how_many_times_exec_matrix vdlm
                            "0" -> do return ()
                            _   -> do do_menu

main = do do_menu