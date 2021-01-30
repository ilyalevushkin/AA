import Lib
import Data.List
import Test.HUnit
import System.Random


split_on_matrix [] n = []
split_on_matrix list n = take n list : split_on_matrix (drop n list) n

get_random_matr m n randGen = split_on_matrix (take (m*n) $ randoms randGen) n

get_test_list_random f1 f2 randGen = [TestLabel "test1" test1
                 , TestLabel "test2" test2
                 , TestLabel "test3" test3
                 , TestLabel "test4" test4
                 , TestLabel "test5" test5
                 , TestLabel "test6" test6
                  ] where
                    test1 = TestCase (assertEqual "Пустые матрицы: 0" (f1 [[]] [[]]) (f2 [[]] [[]]))
                    test2 = TestCase (assertEqual "Нечетное n (15x45 45x74)" (f1 m1 m2) (f2 m1 m2)) where
                      m1 = get_random_matr 15 45 randGen
                      m2 = get_random_matr 45 74 randGen
                    test3 = TestCase (assertEqual "Четное n (62x42 42x15)" (f1 m1 m2) (f2 m1 m2)) where
                      m1 = get_random_matr 62 42 randGen
                      m2 = get_random_matr 42 15 randGen
                    test4 = TestCase (assertEqual "Матрицы (500x50 50x50)" (f1 m1 m2) (f2 m1 m2)) where
                      m1 = get_random_matr 50 50 randGen
                      m2 = get_random_matr 50 50 randGen
                    test5 = TestCase (assertEqual "Четное n (75x75 75x75)" (f1 m1 m2) (f2 m1 m2)) where
                      m1 = get_random_matr 75 75 randGen
                      m2 = get_random_matr 75 75 randGen
                    test6 = TestCase (assertEqual "Матрицы (100x100 100x100)" (f1 m1 m2) (f2 m1 m2)) where
                      m1 = get_random_matr 100 100 randGen
                      m2 = get_random_matr 100 100 randGen



get_test_list :: ([[Int]] -> [[Int]] -> [[Int]]) -> [Test]
get_test_list f = [TestLabel "test1" test1
             , TestLabel "test2" test2
             , TestLabel "test3" test3
             , TestLabel "test4" test4
             , TestLabel "test5" test5
             , TestLabel "test6" test6
             , TestLabel "test7" test7
             , TestLabel "test8" test8
              ] where
                        test1 = TestCase (assertEqual "Пустые матрицы" [[]] (f [[]] [[]]))
                        test2 = TestCase (assertEqual "Незаполненные матрицы" [[]] (f [[2, 2], [3, 3]] [[1, 5], [3]]))
                        test3 = TestCase (assertEqual "n1 /= n2" [[]] (f [[2,4],[5,6]] [[2,5]]))
                        test4 = TestCase (assertEqual "n четное (4x6 6x1)" [
                            [28392],
                            [120],
                            [5864],
                            [7599]
                            ] (f [
                            [174, 325, 734, 275, 358, 3746],
                            [27, 4, 9, 4, 6, 2],
                            [456, 25, 97, 385, 25, 567],
                            [25, 52, 953, 264, 285, 355]
                            ] [
                            [1],
                            [2],
                            [3],
                            [4],
                            [5],
                            [6]
                            ]))
                        test5 = TestCase (assertEqual "n нечетное (5x3 3x7)" [
                            [8609, 2664, 448, 23408, 7955, 5563, 8485],
                            [6661, 2044, 318, 18103, 6156, 3674, 6238],
                            [4412, 2320, 1208, 12140, 4312, 12400, 9648],
                            [2272, 1556, 918, 6267, 2345, 6903, 5409],
                            [24648, 9186, 3212, 67427, 23001, 45343, 39933]
                            ] (f [
                            [1, 7, 9],
                            [2, 4, 7],
                            [64, 24, 4],
                            [73, 13, 2],
                            [35, 85, 24]
                            ] [
                            [1, 9, 7, 3, 4, 6, 8],
                            [25, 27, 27, 74, 25, 457, 257],
                            [937, 274, 28, 2543, 864, 262, 742]
                            ]))
                        test6 = TestCase (assertEqual "Обычный случай (3x3 3x6)" [
                            [22118,2979,2900,1407,4743,4657],
                            [384270,40986,39331,21766,82157,81527],
                            [117282,32230,28766,11774,25773,23922]] (f [
                            [1, 5, 3],
                            [5, 88, 4],
                            [25, 25, 74]
                            ] [
                            [134, 734, 23, 234, 97, 23],
                            [4356, 422, 435, 234, 928, 925],
                            [68, 45, 234, 1, 2, 3]
                            ]))
                        test7 = TestCase (assertEqual "Обычный случай №2 (1x4 4x1)" [[2142375]] (f [
                            [5, 24, 45, 8]
                            ] [
                            [35],
                            [98],
                            [24],
                            [267346]
                            ]))
                        test8 = TestCase (assertEqual "Обычный случай №3 (6x2 2x5)" [
                            [1289,31217,3776,11214,33316],
                            [444,21357,6441,19104,62376],
                            [331,6643,304,906,1964],
                            [2179,161407,59044,175098,577772],
                            [4784,259577,83681,248184,813496],
                            [549,18042,3909,11598,36972]] (f [
                            [38, 235],
                            [73, 45],
                            [2, 65],
                            [678, 29],
                            [953, 385],
                            [43, 84]
                            ] [
                            [3, 234, 87, 258, 852],
                            [5, 95, 2, 6, 4]
                            ]))





testing f = runTestTT $ TestList $ get_test_list f


testing_random f1 f2 randGen = runTestTT $ TestList $ get_test_list_random f1 f2 randGen


main :: IO Counts
main = do 
        putStrLn "\n\n\n\nТестирование функций второй лабораторной работы\n"
        putStrLn "Стандартное умножение матриц"
        testing st
        putStrLn "\n\n"
        putStrLn "Умножение матриц по Виноградову"
        testing gr
        putStrLn "\n\n"
        putStrLn "Оптимизированное умножение матриц по Виноградову"
        testing opt_gr
        putStrLn "Рандомное заполнение матриц"
        randGen <- newStdGen
        testing_random st gr randGen
        testing_random st opt_gr randGen
        testing_random opt_gr gr randGen

