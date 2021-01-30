from random import *

class Ant(object):
    def __init__(self, i, towns_count):
        self.city_visit = [False for i in range(towns_count)]
        self.city_visit[i] = True
        self.edge_visit = []
        self.hole_way = 0
        self.position = i

    def get_edge_length(self, d_matrix, j):
        return d_matrix[self.position][j]

    def was(self, i):
        return self.city_visit[i]

    def move_ant(self, i, d_matrix):
        self.hole_way += d_matrix[self.position][i]
        self.edge_visit.append([self.position, i])
        self.position = i
        self.city_visit[i] = True



def calc_q(d_matrix):
    sum = 0
    count = 0
    for i in d_matrix:
        for j in i:
            sum += j
            count += 1

    return sum / count * len(d_matrix)

def create_pheromon_matrix(d_matrix, q):
    L = []
    for i in range(len(d_matrix)):
        L1 = []
        for j in range(len(d_matrix[i])):
            if (i == j):
                L1.append(0)
            else:
                L1.append(q / d_matrix[i][j])
        L.append(L1)
    return L


def random_way_choice(cities_probability):
    seed()
    rand_number = random()
    k = -1
    current_prob = 0
    for i in range(len(cities_probability)):
        current_prob += cities_probability[i]
        if (rand_number < current_prob):
            k = i
            break
    if (k == -1):
        for i in range(len(cities_probability)):
            if (cities_probability[i] > 0.000001):
                k = i
    return k

def move_ant(town, ant, d_matrix):
    ant.move_ant(town, d_matrix)


def calc_etta(d_matrix, i, j, ant):
    if (ant.was(j)):
        return 0
    return 1 / d_matrix[i][j]

def calc_town_probability(ant, pheromon_matrix, d_matrix, alpha, j):
    if (ant.was(j)):
        return 0

    betta = 1 - alpha

    znam = 0
    for i in range(len(d_matrix)):
        znam += (pheromon_matrix[ant.position][i] ** alpha) * (calc_etta(d_matrix, ant.position, i, ant) ** betta)

    p = ((pheromon_matrix[ant.position][j] ** alpha) * (calc_etta(d_matrix, ant.position, j, ant) ** betta) /
         znam)

    return p



def create_hole_way(ant, pheromon_matrix, d_matrix, alpha):
    #цикл по всем городам
    for i in range(len(d_matrix) - 1):
        #список вероятностей выбора города муравьем
        cities_probability = []
        for j in range(len(d_matrix)):
            cities_probability.append(calc_town_probability(ant, pheromon_matrix, d_matrix, alpha, j))
        town = random_way_choice(cities_probability)
        move_ant(town, ant, d_matrix)



def edge_belong_to_ant_way(i, j, ant):
    for k in range(len(ant.edge_visit)):
        if (ant.edge_visit[k][0] == i and ant.edge_visit[k][1] == j):
            return True
    return False

def refresh_pheromon_matrix(pheromon_matrix, p, q, ants, d_matrix):
    one_minus_p = 1 - p
    for i in range(len(pheromon_matrix)):
        for j in range(len(pheromon_matrix)):
            sum_pheromons = 0
            for k in range(len(ants)):
                if (edge_belong_to_ant_way(i, j, ants[k])):
                    sum_pheromons += q / ants[k].hole_way
            pher = pheromon_matrix[i][j] * one_minus_p + sum_pheromons
            if (i == j):
                pher = 0
            elif (pher < q / d_matrix[i][j]):
                pher = q / d_matrix[i][j]
            pheromon_matrix[i][j] = pher


def ants_algorythm(d_matrix):

    alpha = float(input("alpha: "))
    p = float(input("p: "))
    t_max = int(input("t_max: "))

    q = calc_q(d_matrix)
    best_hole_way = 1000000
    best_way = []

    pheromon_matrix = create_pheromon_matrix(d_matrix, q)

    for t in range(t_max):
        ants = []
        # поместил по одному муравью в город
        for i in range(len(d_matrix)):
            ant = Ant(i, len(d_matrix))
            ants.append(ant)
        #цикл по муравьям
        for i in range(len(ants)):
            create_hole_way(ants[i], pheromon_matrix, d_matrix, alpha)
            if (ants[i].hole_way < best_hole_way):
                best_hole_way = ants[i].hole_way
                best_way = ants[i].edge_visit

        #обновить феромоны на ребрах
        refresh_pheromon_matrix(pheromon_matrix, p, q, ants, d_matrix)
    print(best_way)
    return best_hole_way