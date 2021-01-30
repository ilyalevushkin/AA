module Standard where

import Data.List


replace n newVal (x:xs)
     | n == 0 = newVal:xs
     | otherwise = x:replace (n-1) newVal xs



--Заполнение матрицы mxq нулями
answer_fill :: Int -> Int -> [[Int]]
answer_fill 0 j = []
answer_fill i j = take j (repeat 0) : answer_fill (i - 1) j


--Берем из m-ой строки q-ый элемент и изменяем его по формуле: 
--c[m][q] += a[m][n] * b[n][q]
get_new_line_answer :: Int -> Int -> Int -> [Int] -> [Int]
get_new_line_answer j a b line = replace j ((line !! j) + a * b) line



--Изменение answer[m][q]
third_loop :: [Int] -> [[Int]] -> Int -> Int -> Int -> Int -> [[Int]] -> [[Int]]
third_loop list1_i list2 i j k n answer | k == n    = answer
                                        | otherwise = 
        third_loop list1_i list2 i j (k + 1) n $ 
          replace i (get_new_line_answer j  
            (list1_i !! k)  
            ((list2 !! k) !! j)
            (answer !! i)) answer


--Вызов третьего цикла программы
second_loop :: [Int] -> [[Int]] -> Int -> Int -> Int -> [[Int]] -> [[Int]]
second_loop list1_i list2 i j q answer | j == q    = answer
                                       | otherwise = 
        second_loop list1_i list2 i (j + 1) q $
        third_loop list1_i list2 i j 0 (length list2) answer


--Вызов второго цикла программы
first_loop :: [[Int]] -> [[Int]] -> Int -> Int -> [[Int]] -> [[Int]]
first_loop list1 list2 i m answer | i == m    = answer
                                  | otherwise = 
        first_loop list1 list2 (i + 1) m $
        second_loop (list1 !! i) list2 i 0 (length $ head list2) answer


--Вызов первого цикла программы
calc_multypl :: [[Int]] -> [[Int]] -> [[Int]]
calc_multypl list1 list2 = (first_loop list1 list2 0 (length list1)) $ answer_fill
    (length list1)  (length $ head list2)


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
standard :: [[Int]] -> [[Int]] -> [[Int]]
standard list1 list2 = if (check_matr list1 && check_matr list2) 
  then (if (check_size list1 2) == (check_size list2 1)
      then calc_multypl list1 list2 
      else [[]])
  else [[]]



