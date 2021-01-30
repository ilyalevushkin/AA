from boyer_mur import *
from knut_moris_prat import *
import time


line = str(input("Введите строку: "))

subline = str(input("Введите подстроку: "))

choice = int(input("Выберете алгоритм: \n\t1)Кнут-Моррис-Пратт\n\t2)Бойер-Мур\n"))

result = -1

if (choice == 1):
    start_time = time.process_time()
    result = knut_moris_prat(line, subline)
    end_time = time.process_time()
    print(result)
    print("Время выполнения в секундах: %s seconds" % (end_time - start_time))
elif (choice == 2):
    start_time = time.process_time()
    result = boyer_mur(line, subline)
    end_time = time.process_time()
    print(result)
    print("Время выполнения в секундах: %s seconds" % (end_time - start_time))
else:
    print("Некорректный ввод")