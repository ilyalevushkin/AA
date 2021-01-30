module Grape where

import Data.List


replace n newVal (x:xs)
     | n == 0 = newVal:xs
     | otherwise = x:replace (n-1) newVal xs

--Заполнение матрицы mxq нулями
answer_fill :: Int -> Int -> [[Int]]
answer_fill 0 j = []
answer_fill i j = take j (repeat 0) : answer_fill (i - 1) j



mulh_loop :: Int -> Int -> Int -> [Int] -> Int -> Int
mulh_loop i k n a_i mulh_i | k == div n 2    = mulh_i
                           | otherwise       = mulh_i + (a_i !! (2 * k)) * (a_i !! (2 * k + 1)) +
                                              (mulh_loop i (k + 1) n a_i mulh_i)



calc_mulh :: Int -> Int -> Int -> [[Int]] -> [Int] -> [Int]
calc_mulh i m n list mulh | i == m    = mulh
                          | otherwise = calc_mulh (i + 1) m n list 
                                             (replace i (mulh_loop i 0 n (list !! i) (mulh !! i)) mulh)



mulv_loop :: Int -> Int -> Int -> [[Int]] -> Int -> Int
mulv_loop i k n a mulv_i   | k == div n 2    = mulv_i
                           | otherwise       = mulv_i + ((a !! (2 * k)) !! i) * ((a !! (2 * k + 1)) !! i) +
                                              (mulv_loop i (k + 1) n a mulv_i)



calc_mulv :: Int -> Int -> Int -> [[Int]] -> [Int] -> [Int]
calc_mulv i q n list mulv | i == q    = mulv
                          | otherwise = calc_mulv (i + 1) q n list 
                                             (replace i (mulv_loop i 0 n list (mulv !! i)) mulv)


nechet_q_loop :: [[Int]] -> [[Int]] -> Int -> Int -> Int -> Int -> [[Int]] -> [Int]
nechet_q_loop a b i j n q c | j == q    = (c !! i)
                            | otherwise = nechet_q_loop a b i (j + 1) n q 
                                              (
                                                replace i (replace j (((c !! i) !! j) + 
                                                  ((a !! i) !! (n - 1)) * ((b !! (n - 1)) !! j)) (c !! i)) c
                                              )



nechet_m_loop :: [[Int]] -> [[Int]] -> Int -> Int -> Int -> Int -> [[Int]] -> [[Int]]
nechet_m_loop a b i m q n c | i == m    = c
                            | otherwise = nechet_m_loop a b (i + 1) m q n
                                             (replace i (nechet_q_loop a b i 0 n q c) c)


nechet_calc :: [[Int]] -> [[Int]] -> Int -> Int -> Int -> [[Int]] -> [[Int]]
nechet_calc a b m q n c | not (odd n) = c
                        | otherwise   = nechet_m_loop a b 0 m q n c


main_k_loop :: [[Int]] -> [[Int]] -> Int -> Int -> Int -> [[Int]] -> [[Int]]
main_k_loop a b i j k c | k == div (length b) 2 = c
                        | otherwise             = main_k_loop a b i j (k + 1) (
                                replace i (replace j (((c !! i) !! j) + 
                                  ((((a !! i) !! (2 * k)) + 
                                    ((b !! (2 * k + 1)) !! j)) * 
                                                        (((a !! i) !! (2 * k + 1)) + 
                                                          ((b !! (2 * k)) !! j)))) (c !! i)) c)



main_q_loop :: [[Int]] -> [[Int]] -> [Int] -> [Int] -> Int -> Int -> [[Int]] -> [[Int]]
main_q_loop a b mulh mulv i j c | j == (length $ head b)  = c
                                | otherwise               = main_q_loop a b mulh mulv i (j + 1) (main_k_loop a b i j 0 
                                  (
                                    replace i (replace j (-1 * ((mulh !! i) + 
                                      (mulv !! j))) (c !! i)) c
                                  ))


main_calc :: [[Int]] -> [[Int]] -> [Int] -> [Int] -> Int -> [[Int]] -> [[Int]]
main_calc a b mulh mulv i c | i == (length a)  = c
                            | otherwise        = main_calc a b mulh mulv (i + 1) (main_q_loop a b mulh mulv i 0 c)




calc_multypl :: [[Int]] -> [[Int]] -> [[Int]]
calc_multypl list1 list2 = nechet_calc list1 list2 (length list1)
           (length $ head list2)
           (length list2) $ 
           main_calc list1 list2 
                 (calc_mulh 0 (length list1) (length $ head list1) list1 (take (length list1) (repeat 0)))
                 (calc_mulv 0 (length $ head list2) (length list2) list2 (take (length $ head list2) (repeat 0)))
                 0
                 (answer_fill (length list1) (length $ head list2))



--Возвращает количество строк(1)/столбцов(2) в матрице
check_size :: [[Int]] -> Int -> Int
check_size list 1 = length list
check_size list 2 = length $ head list


check_matr :: [[Int]] -> Bool
check_matr [] = True
check_matr (_:[]) = True
check_matr (x:xs) = if ((length x) == (length $ head xs))
  then check_matr xs
  else False

--Проверка на корректность умножения матриц:
--a[mxn] ; b[nxq]
grape :: [[Int]] -> [[Int]] -> [[Int]]
grape list1 list2 = if (check_matr list1 && check_matr list2) 
  then (if (check_size list1 2) == (check_size list2 1)
    then calc_multypl list1 list2 else [[]])
  else [[]]



