

def calc_min_way(min_way, d_matrix, city_visit, i, j, way, range_way):
    if (i != -1):
        way += d_matrix[i][j]
        city_visit[j] = True
        range_way.append([i, j])

    count = 0
    min_range_way = []
    for k in range(len(d_matrix)):
        if (not city_visit[k]):
            len_way, r_way = calc_min_way(min_way, d_matrix, city_visit[:], j, k, way, range_way[:])
            if (min_way > len_way):
                min_way = len_way
                min_range_way = r_way[:]
        else:
            count += 1

    if (count == len(d_matrix)):
        return way, range_way


    return min_way, min_range_way



def get_min_way(min_way, d_matrix, city_visit):
    ful_way = []
    for i in range(len(d_matrix)):
        visit = city_visit[:]
        visit[i] = True
        len_way, range_way = calc_min_way(min_way, d_matrix, visit, -1, i, 0, [])
        if (min_way > len_way):
            ful_way = range_way[:]
            min_way = len_way
    return min_way, ful_way


def full_search(d_matrix):
    min_way = 1000000
    min_way, ful_way = get_min_way(min_way, d_matrix, [False for i in range(len(d_matrix))])
    print(ful_way)
    return min_way