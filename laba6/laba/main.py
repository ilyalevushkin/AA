from ants_algorythm import *
from full_search import *
from random import *
import time


def print_matrix(m):
    for i in m:
        print(i)

def create_random_d_matrix(len_d_matrix):
    seed(1)
    L = []
    for i in range(len_d_matrix):
        L1 = []
        for j in range(len_d_matrix):
            if (j > i):
                L1.append(randint(1, 10))
            elif (j == i):
                L1.append(0)
            else:
                L1.append(0)
        L.append(L1)

    for i in range(len_d_matrix):
        for j in range(len_d_matrix):
            if (j < i):
                L[i][j] = L[j][i]
    return L

len_d_matrix = int(input("Введите количество городов: "))

d_matrix = create_random_d_matrix(len_d_matrix)

print_matrix(d_matrix)

start_time = time.process_time()
min_way = ants_algorythm(d_matrix)
end_time = time.process_time()

#start_time = time.process_time()
#min_way = full_search(d_matrix)
#end_time = time.process_time()

print("Минимальный путь: " + str(min_way))
print("Время выполнения в секундах: %s seconds" % (end_time - start_time))


