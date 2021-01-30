module Optymize_grape where


import Data.List


--Заполнение матрицы mxq нулями
answer_fill :: Int -> Int -> [[Int]]
answer_fill 0 j = []
answer_fill i j = take j (repeat 0) : answer_fill (i - 1) j




--Запуск второго цикла
mulh_loop :: Int -> Int -> Int -> [Int] -> Int -> Int
mulh_loop i k n a_i mulh_i | k >= n    = mulh_i
                           | otherwise = mulh_i + (a_i !! k) * (a_i !! (k + 1)) + 
                                         (mulh_loop i (k + 2) n a_i mulh_i)



--Высчитывание mulh/mulv; запуск первого цикла
calc_mulh :: Int -> Int -> Int -> [[Int]] -> [Int] -> [Int]
calc_mulh i m n list mulh | i == m    = mulh
                          | otherwise = calc_mulh (i + 1) m n list 
                                            ((take i mulh) ++
                                            [mulh_loop i 0 n (list !! i) (mulh !! i)] ++
                                            (reverse (take (length mulh - i - 1) $ reverse mulh)))



--Запуск второго цикла
mulv_loop :: Int -> Int -> Int -> [[Int]] -> Int -> Int
mulv_loop i k n a mulv_i   | k >= n      = mulv_i
                           | otherwise   = mulv_i + ((a !! k) !! i) * ((a !! (k + 1)) !! i) + 
                                           (mulv_loop i (k + 2) n a mulv_i)



--Высчитывание mulh/mulv; запуск первого цикла
calc_mulv :: Int -> Int -> Int -> [[Int]] -> [Int] -> [Int]
calc_mulv i q n list mulv | i == q    = mulv
                          | otherwise = calc_mulv (i + 1) q n list 
                                            ((take i mulv) ++
                                            [mulv_loop i 0 n list (mulv !! i)] ++
                                            (reverse (take (length mulv - i - 1) $ reverse mulv)))



--Третий нечетный цикл по k. k изеняется на 2
buf_nechet :: [Int] -> [[Int]] -> Int -> Int -> Int -> Int
buf_nechet a_i b j k n_minus_one | k >= n_minus_one = 0
                                 | otherwise        = (((a_i !! k) + ((b !! (k + 1)) !! j)) * 
                                ((a_i !! (k + 1)) + ((b !! k) !! j))) + 
                                (buf_nechet a_i b j (k + 2) n_minus_one)



--добавление u_nech*v_nech
add_nechet :: [Int] -> [[Int]] -> Int -> Int -> Int
add_nechet a_i b j n_minus_one = (a_i !! n_minus_one) * ((b !! n_minus_one) !! j)



--Запуск третьего нечетного цикла buf + mulh_i + mulv_j + нечетное
main_q_loop_nechet :: [Int] -> [[Int]] -> Int -> Int -> Int -> Int -> [Int] -> Int -> [Int]
main_q_loop_nechet a_i b j m q mulh_i mulv n_minus_one | j == q    = []
                                                         | otherwise = ((buf_nechet a_i b j 0 n_minus_one) - 
                                        (mulh_i + 
                                        (mulv !! j)) + (add_nechet a_i b j n_minus_one)) : 
                                    (main_q_loop_nechet a_i b (j + 1) m q mulh_i mulv n_minus_one)



--Запуск второго нечетного цикла
main_calc_nechet :: [[Int]] -> [[Int]] -> Int -> Int -> Int -> [Int] -> [Int] -> Int -> [[Int]]
main_calc_nechet a b i m q mulh mulv n_minus_one | i == m    = []
                                                   | otherwise = (main_q_loop_nechet (a !! i) b 0 m q (mulh !! i) mulv n_minus_one) : 
                        (main_calc_nechet a b (i + 1) m q mulh mulv n_minus_one)



--Третий ОБЩИЙ цикл по k. k изеняется на 2
buf :: [Int] -> [[Int]] -> Int -> Int -> Int -> Int
buf a_i b j k n | k >= n    = 0
                | otherwise = (((a_i !! k) + ((b !! (k + 1)) !! j)) * 
                                ((a_i !! (k + 1)) + ((b !! k) !! j))) + 
                                (buf a_i b j (k + 2) n)



--Запуск третьего нечетного цикла buf + mulh_i + mulv_j
main_q_loop :: [Int] -> [[Int]] -> Int -> Int -> Int -> Int -> Int -> [Int] -> [Int]
main_q_loop a_i b j m q n mulh_i mulv | j == q    = []
                                      | otherwise = ((buf a_i b j 0 n) - 
                                        (mulh_i + 
                                        (mulv !! j))) : 
                                    (main_q_loop a_i b (j + 1) m q n mulh_i mulv)


--Запуск второго четного цикла
main_calc :: [[Int]] -> [[Int]] -> Int -> Int -> Int -> Int -> [Int] -> [Int] -> [[Int]]
main_calc a b i m q n mulh mulv | i == m    = []
                                | otherwise = (main_q_loop (a !! i) b 0 m q n (mulh !! i) mulv) : 
                        (main_calc a b (i + 1) m q n mulh mulv)




--Проверяет на четность/нечетность матрицу и запускает первый цикл
calc_multypl :: [[Int]] -> [[Int]] -> Int -> Int -> Int -> [[Int]]
calc_multypl list1 list2 m q n = if not (odd n) then
                (main_calc list1 list2 0 m q n 
                (calc_mulh 0 m n list1 (take m (repeat 0)))
                (calc_mulv 0 q n list2 (take q (repeat 0))))
                else (main_calc_nechet list1 list2 0 m q 
                (calc_mulh 0 m (n - 1) list1 (take m (repeat 0)))
                (calc_mulv 0 q (n - 1) list2 (take q (repeat 0)))
                (n - 1))



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
optymize_grape :: [[Int]] -> [[Int]] -> [[Int]]
optymize_grape list1 list2 = if (check_matr list1 && check_matr list2) 
  then (if (check_size list1 2) == (check_size list2 1)
    then calc_multypl list1 list2 (length list1) 
                (length $ head list2) 
                (length list2) 
    else [[]])
  else [[]]




