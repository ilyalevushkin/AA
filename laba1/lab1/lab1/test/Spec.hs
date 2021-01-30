import Lib
import Data.List
import Test.HUnit
import System.Random


get_test_list_f1_f2 f1 f2 randGen = [TestLabel "test1" test1
                 , TestLabel "test2" test2
                 , TestLabel "test3" test3
                 , TestLabel "test4" test4
                 , TestLabel "test5" test5
                 , TestLabel "test6" test6
                  ] where
                    test1 = TestCase (assertEqual "Длина строки: 0" (f1 "" "") (f2 "" ""))
                    test2 = TestCase (assertEqual "Длина строки: 3" (f1 str1 str2) (f2 str1 str2)) where
                      str1 = take 3 $ randomRs ('a', 'z') randGen
                      str2 = take 3 $ randomRs ('a', 'z') randGen
                    test3 = TestCase (assertEqual "Длина строки: 5" (f1 str1 str2) (f2 str1 str2)) where
                      str1 = take 5 $ randomRs ('a', 'z') randGen
                      str2 = take 5 $ randomRs ('a', 'z') randGen
                    test4 = TestCase (assertEqual "Длина строки: 7" (f1 str1 str2) (f2 str1 str2)) where
                      str1 = take 7 $ randomRs ('a', 'z') randGen
                      str2 = take 7 $ randomRs ('a', 'z') randGen
                    test5 = TestCase (assertEqual "Длина строки: 9" (f1 str1 str2) (f2 str1 str2)) where
                      str1 = take 9 $ randomRs ('a', 'z') randGen
                      str2 = take 9 $ randomRs ('a', 'z') randGen
                    test6 = TestCase (assertEqual "Длина строки: 11" (f1 str1 str2) (f2 str1 str2)) where
                      str1 = take 11 $ randomRs ('a', 'z') randGen
                      str2 = take 11 $ randomRs ('a', 'z') randGen




get_test_list f = [TestLabel "test1" test1
                 , TestLabel "test2" test2
                 , TestLabel "test3" test3
                 , TestLabel "test4" test4
                 , TestLabel "test5" test5
                 , TestLabel "test6" test6
                 , TestLabel "test7" test7
                 , TestLabel "test8" test8
                  ] where
                            test1 = TestCase (assertEqual "Пустые строки" 0 (f "" ""))
                            test2 = TestCase (assertEqual "Вторая строка пуста" 1 (f "a" ""))
                            test3 = TestCase (assertEqual "Первая строка пуста" 1 (f "" "a"))
                            test4 = TestCase (assertEqual "Одинаковые строки" 0 (f "equal" "equal"))
                            test5 = TestCase (assertEqual "Входные строки в кириллице" 0 (f "одинаковые" "одинаковые"))
                            test6 = TestCase (assertEqual "Обычный случай" 5 (f "usual" "specul"))
                            test7 = TestCase (assertEqual "Случай с совпадением 1 символа" 4 (f "usual" "qswer"))
                            test8 = TestCase (assertEqual "Одна строка больше другой" 4 (f "usual" "moreusual"))


get_test_list_m f = [TestLabel "test1" test1
                   , TestLabel "test2" test2
                   , TestLabel "test3" test3
                   , TestLabel "test4" test4
                   , TestLabel "test5" test5
                   , TestLabel "test6" test6
                   , TestLabel "test7" test7
                   , TestLabel "test8" test8
                   , TestLabel "test9" test9
                    ] where
                            test1 = TestCase (assertEqual "Пустые строки" 0 (f "" ""))
                            test2 = TestCase (assertEqual "Вторая строка пуста" 1 (f "a" ""))
                            test3 = TestCase (assertEqual "Первая строка пуста" 1 (f "" "a"))
                            test4 = TestCase (assertEqual "Одинаковые строки" 0 (f "equal" "equal"))
                            test5 = TestCase (assertEqual "Входные строки в кириллице" 0 (f "одинаковые" "одинаковые"))
                            test6 = TestCase (assertEqual "Обычный случай" 5 (f "usual" "specul"))
                            test7 = TestCase (assertEqual "Случай с совпадением 1 символа" 4 (f "usual" "qswer"))
                            test8 = TestCase (assertEqual "Одна строка больше другой" 4 (f "usual" "moreusual"))
                            test9 = TestCase (assertEqual "Случай с перестановкой двух соседних букв"
                             3 (f "mroesuua" "moreusual"))



get_test_list_matr f = [TestLabel "test1" test1
                      , TestLabel "test2" test2
                      , TestLabel "test3" test3
                      , TestLabel "test4" test4
                      , TestLabel "test5" test5
                      , TestLabel "test6" test6
                      , TestLabel "test7" test7
                      , TestLabel "test8" test8
                       ] where
                            test1 = TestCase (assertEqual "Пустые строки" (0,[[0]]) (f "" ""))
                            test2 = TestCase (assertEqual "Вторая строка пуста" (1, [[0,1]]) (f "a" ""))
                            test3 = TestCase (assertEqual "Первая строка пуста" (1, [[0],[1]]) (f "" "a"))
                            test4 = TestCase (assertEqual "Одинаковые строки" (0, [
                               [0,1,2,3,4,5]
                              ,[1,0,1,2,3,4]
                              ,[2,1,0,1,2,3]
                              ,[3,2,1,0,1,2]
                              ,[4,3,2,1,0,1]
                              ,[5,4,3,2,1,0]
                              ]) (f "equal" "equal"))
                            test5 = TestCase (assertEqual "Входные строки в кириллице" (0, [
                               [0,1,2,3,4,5,6,7,8,9,10]
                              ,[1,0,1,2,3,4,5,6,7,8,9]
                              ,[2,1,0,1,2,3,4,5,6,7,8]
                              ,[3,2,1,0,1,2,3,4,5,6,7]
                              ,[4,3,2,1,0,1,2,3,4,5,6]
                              ,[5,4,3,2,1,0,1,2,3,4,5]
                              ,[6,5,4,3,2,1,0,1,2,3,4]
                              ,[7,6,5,4,3,2,1,0,1,2,3]
                              ,[8,7,6,5,4,3,2,1,0,1,2]
                              ,[9,8,7,6,5,4,3,2,1,0,1]
                              ,[10,9,8,7,6,5,4,3,2,1,0]
                              ]) (f "одинаковые" "одинаковые"))
                            test6 = TestCase (assertEqual "Обычный случай" (5, [
                               [0,1,2,3,4,5]
                              ,[1,1,1,2,3,4]
                              ,[2,2,2,2,3,4]
                              ,[3,3,3,3,3,4]
                              ,[4,4,4,4,4,4]
                              ,[5,4,5,4,5,5]
                              ,[6,5,5,5,5,5]
                              ]) (f "usual" "specul"))
                            test7 = TestCase (assertEqual "Случай с совпадением 1 символа" (4, [
                               [0,1,2,3,4,5]
                              ,[1,1,2,3,4,5]
                              ,[2,2,1,2,3,4]
                              ,[3,3,2,2,3,4]
                              ,[4,4,3,3,3,4]
                              ,[5,5,4,4,4,4]
                              ]) (f "usual" "qswer"))
                            test8 = TestCase (assertEqual "Одна строка больше другой" (4, [
                               [0,1,2,3,4,5]
                              ,[1,1,2,3,4,5]
                              ,[2,2,2,3,4,5]
                              ,[3,3,3,3,4,5]
                              ,[4,4,4,4,4,5]
                              ,[5,4,5,4,5,5]
                              ,[6,5,4,5,5,6]
                              ,[7,6,5,4,5,6]
                              ,[8,7,6,5,4,5]
                              ,[9,8,7,6,5,4]
                              ]) (f "usual" "moreusual"))

get_test_list_matr_m f = [TestLabel "test1" test1
                        , TestLabel "test2" test2
                        , TestLabel "test3" test3
                        , TestLabel "test4" test4
                        , TestLabel "test5" test5
                        , TestLabel "test6" test6
                        , TestLabel "test7" test7
                        , TestLabel "test8" test8
                        , TestLabel "test9" test9
                         ] where
                            test1 = TestCase (assertEqual "Пустые строки" (0, [[0]]) (f "" ""))
                            test2 = TestCase (assertEqual "Вторая строка пуста" (1, [[0, 1]]) (f "a" ""))
                            test3 = TestCase (assertEqual "Первая строка пуста" (1, [[0], [1]]) (f "" "a"))
                            test4 = TestCase (assertEqual "Одинаковые строки" (0,[
                               [0,1,2,3,4,5]
                              ,[1,0,1,2,3,4]
                              ,[2,1,0,1,2,3]
                              ,[3,2,1,0,1,2]
                              ,[4,3,2,1,0,1]
                              ,[5,4,3,2,1,0]
                              ]) (f "equal" "equal"))
                            test5 = TestCase (assertEqual "Входные строки в кириллице" (0,[
                               [0,1,2,3,4,5,6,7,8,9,10]
                              ,[1,0,1,2,3,4,5,6,7,8,9]
                              ,[2,1,0,1,2,3,4,5,6,7,8]
                              ,[3,2,1,0,1,2,3,4,5,6,7]
                              ,[4,3,2,1,0,1,2,3,4,5,6]
                              ,[5,4,3,2,1,0,1,2,3,4,5]
                              ,[6,5,4,3,2,1,0,1,2,3,4]
                              ,[7,6,5,4,3,2,1,0,1,2,3]
                              ,[8,7,6,5,4,3,2,1,0,1,2]
                              ,[9,8,7,6,5,4,3,2,1,0,1]
                              ,[10,9,8,7,6,5,4,3,2,1,0]
                              ]) (f "одинаковые" "одинаковые"))
                            test6 = TestCase (assertEqual "Обычный случай" (5,[
                               [0,1,2,3,4,5]
                              ,[1,1,1,2,3,4]
                              ,[2,2,2,2,3,4]
                              ,[3,3,3,3,3,4]
                              ,[4,4,4,4,4,4]
                              ,[5,4,5,4,5,5]
                              ,[6,5,5,5,5,5]
                              ]) (f "usual" "specul"))
                            test7 = TestCase (assertEqual "Случай с совпадением 1 символа" (4,[
                               [0,1,2,3,4,5]
                              ,[1,1,2,3,4,5]
                              ,[2,2,1,2,3,4]
                              ,[3,3,2,2,3,4]
                              ,[4,4,3,3,3,4]
                              ,[5,5,4,4,4,4]
                              ]) (f "usual" "qswer"))
                            test8 = TestCase (assertEqual "Одна строка больше другой" (4,[
                              [0,1,2,3,4,5]
                              ,[1,1,2,3,4,5]
                              ,[2,2,2,3,4,5]
                              ,[3,3,3,3,4,5]
                              ,[4,4,4,4,4,5]
                              ,[5,4,5,4,5,5]
                              ,[6,5,4,5,5,6]
                              ,[7,6,5,4,5,6]
                              ,[8,7,6,5,4,5]
                              ,[9,8,7,6,5,4]
                              ]) (f "usual" "moreusual"))
                            test9 = TestCase (assertEqual "Случай с перестановкой двух соседних букв"
                             (3,[
                               [0,1,2,3,4,5,6,7,8]
                              ,[1,0,1,2,3,4,5,6,7]
                              ,[2,1,1,1,2,3,4,5,6]
                              ,[3,2,1,1,2,3,4,5,6]
                              ,[4,3,2,2,1,2,3,4,5]
                              ,[5,4,3,3,2,2,2,3,4]
                              ,[6,5,4,4,3,2,2,3,4]
                              ,[7,6,5,5,4,3,2,2,3]
                              ,[8,7,6,6,5,4,3,3,2]
                              ,[9,8,7,7,6,5,4,4,3]
                              ]) (f "mroesuua" "moreusual"))


testing f symb | symb == 'l' = runTestTT $ TestList $ get_test_list f
               | otherwise   = runTestTT $ TestList $ get_test_list_m f

testing_matr f symb | symb == 'l' = runTestTT $ TestList $ get_test_list_matr f
                    | symb == 'm' = runTestTT $ TestList $ get_test_list_matr_m f


testing_matr_and_rekurs f1 f2 randGen = runTestTT $ TestList $ get_test_list_f1_f2 f1 f2 randGen


main :: IO Counts
main = do 
        putStrLn "\n\n\n\nТестирование функций первой лабораторной работы\n"
        putStrLn "Расстояние Домерау-Левенштейна"
        testing dl 'm'
        putStrLn "\n\n"
        putStrLn "Расстояние Домерау-Левенштейна (матричная форма)"
        testing dlm 'm'
        putStrLn "\n\n"
        putStrLn "Расстояние Левенштейна (матричная форма)"
        testing lm 'l'
        putStrLn "\n\n"
        putStrLn "Расстояние Левенштейна (матричная форма) + вывод матрицы"
        testing_matr vlm 'l'
        putStrLn "\n\n"
        putStrLn "Расстояние Домерау-Левенштейна (матричная форма) + вывод матрицы"
        testing_matr vdlm 'm'
        putStrLn "\n\n"
        putStrLn "Сравнение результата работы алгоритма Домерау-Левенштейна матричного и рекурсивного"
        randGen <- newStdGen
        testing_matr_and_rekurs dl dlm randGen




