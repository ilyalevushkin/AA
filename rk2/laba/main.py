from regular import *
from machine import *
import time

line = str(input("Введите строку: "))

choice = int(input("Выберете способ нахождения факультетов: \n\t1)Регулярные выражения\n\t2)Конечные автоматы\n"))


if (choice == 1):
    start_time = time.process_time()
    result = regular(line)
    end_time = time.process_time()
    print(result)
    print("Время выполнения в секундах: %s seconds" % (end_time - start_time))
elif (choice == 2):
    start_time = time.process_time()
    result = machine(line)
    end_time = time.process_time()
    print(result)
    print("Время выполнения в секундах: %s seconds" % (end_time - start_time))
else:
    print("Некорректный ввод")