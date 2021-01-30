#include "vinograd.h"

#include <x86intrin.h>
#include <math.h>

using namespace std;


long long get_dif(long long i1, long long i2, const Matrix &m1, const Matrix &m2)
{
    i1  = __rdtsc();
    Matrix m3 = modified_vinograd_mult(m1, m2);
    i2  = __rdtsc();

    return abs(i2 - i1);
}

long long get_dif_threads(long long i1, long long i2, const Matrix &m1, const Matrix &m2, size_t count_threads)
{
    i1  = __rdtsc();
    Matrix m4 = modified_thread_vinograd_mult(m1, m2, count_threads);
    i2  = __rdtsc();

    return abs(i2 - i1);
}

void run_optymize_vinograd(const Matrix &m1, const Matrix &m2, int calc_amount)
{
    long long i1, i2;
    long long sr_dif;
    i1 = 0;
    i2 = 0;

    sr_dif = 0;

    for (int i = 0; i < calc_amount; i++)
    {
        sr_dif += get_dif(i1, i2, m1, m2);
    }

    sr_dif /= calc_amount;

    cout << "Modified_vinograd: " << sr_dif << endl;
}

void run_thread_optymize_vinograd(const Matrix &m1, const Matrix &m2, int calc_amount)
{
    long long i1, i2;
    long long sr_dif;
    sr_dif = 0;
    size_t count_threads;

    cout << "Введите количество потоков: ";
    cin >> count_threads;

    for (int i = 0; i < calc_amount; i++)
    {
        sr_dif += get_dif_threads(i1, i2, m1, m2, count_threads);
    }

    sr_dif /= calc_amount;

    cout << "Threads(" << count_threads << "): " << sr_dif << endl;
}

int main()
{
    Matrix m1(100, vector<int>(100));
    Matrix m2(100, vector<int>(100));
    random_filling_matrix(m1);
    random_filling_matrix(m2);

    //print_matrix(m1);
    //print_matrix(m2);

    int calc_amount = 100;
    int choice;

    while(1)
    {

        cout << "Выберите алгоритм: " << endl;
        cout << "1. Оптимизированный алгоритм Винограда" << endl;
        cout << "2. Оптимизированный распараллеленый алгоритм Винограда" << endl;
        cout << "0. Выход" << endl;

        cin >> choice;

        switch(choice)
        {
        case 1:
        {
            run_optymize_vinograd(m1, m2, calc_amount);
            break;
        }
        case 2:
        {
            run_thread_optymize_vinograd(m1, m2, calc_amount);
            break;
        }
        case 0:
        {
            return 0;
        }
        default:
        {
            break;
        }
        }
    }


    //print_matrix(m3);

    //print_matrix(m4);
}
