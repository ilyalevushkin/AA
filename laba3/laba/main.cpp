#include <stdlib.h>
#include <x86intrin.h>
#include <math.h>

#include <iostream>
#include <vector>

using namespace std;



void gnome_sort(vector<int>& sort)
{
    int size = sort.size();
    for (size_t i = 0; i < size - 1; i++)
    {
        if (sort[i] > sort[i + 1])
        {
            swap(sort[i], sort[i + 1]);
            if (i > 0)
            {
                i -= 2; //вычитается два и потом прибавляется один
            }
        }
    }
}


void comb(vector<int>& sort)
{
    int size = sort.size();
    double fakt = 1.2473309; // фактор уменьшения
    int step = size - 1;

    while (step >= 1)
    {
        step /= fakt;
        for (int i = 0; i < size - step; i++)
        {
            if (sort[i] > sort[i + step])
            {
                swap(sort[i], sort[i + step]);
            }
        }
    }
    // сортировка пузырьком
    bool swapped;
    for (int i = 0; i < size - 1; i++)
    {
        swapped = false;
        for (int j = 0; j < size - i - 1; j++)
        {
            if (sort[j] > sort[j + 1])
            {
                swap(sort[j], sort[j + 1]);
                swapped = true;
            }
        }
        if (!swapped)
            break;
    }
}


//Сортировка Шелла по возрастанию элементов.
void ShellSort (vector<int>& array)               // * ∆k = (b∆k−1)/2  ∆0 = N
{
    int tmp;
    int size = array.size();
    for (int step = size / 2; step > 0; step /= 2)
    {
        // Сортировка вставками подсписков с шагом равным step
        for (int i = step; i < size; i++)
        {
            // Сортировка вставками подсписков
            for (int j = i - step; j >= 0 && array[size_t(j)] > array[size_t(j + step)]; j -= step)
            {
                tmp = array[size_t(j)];
                array[size_t(j)] = array[size_t(j + step)];
                array[size_t(j + step)] = tmp;
            }
        }
    }
}


void print_mas(vector<int>& array)
{
    for (size_t i = 0; i < array.size(); i++)
    {
        cout << array[i] << " ";
    }
    cout << endl;
}

void input_sort(void (*sort)(vector<int>&))
{
    int length, num;
    string str;
    while (true)
    {
        cout << "Введите длину массива" << endl;
        cin >> str;

        length = atoi(str.c_str());
        if (length == 0)
        {
            cout << "Длина не может быть 0 или символом!" << endl;
        }
        else if (length < 0)
        {
            cout << "Длина не может быть отрицательной!" << endl;
        }
        else
        {
            size_t size = size_t(length);
            vector<int> mas(size);
            cout << "Введите элементы массива:" << endl;
            for (size_t i = 0; i < size; i++)
            {
                cin >> str;
                if (str.length() == 1)
                {
                    if (str[0] == '0')
                    {
                        mas[i] = 0;
                        continue;
                    }
                }
                num = atoi(str.c_str());
                if (num == 0)
                {
                    cout << "Введено не число (нецелое число)!" << endl;
                    i--;
                    continue;
                }
                mas[i] = num;
            }
            long long i1, i2;
            i1 = __rdtsc();
            sort(mas);
            i2 = __rdtsc();
            cout << "Результат сортировки: " << endl;
            print_mas(mas);
            cout << "Процессорное время выполнения сортировки (в тиках): " << abs(i2 - i1) << endl;
            break;
        }
    }
}


void order_input(vector<int> &mas, size_t length, bool flag)
{
    int number = rand() % 1000;
    if (flag)
    {
        for (size_t i = 0; i < length; i++)
        {
            mas[i] = number;
            number += 1;
        }
    }
    else
    {
        for (int i = 0; i < length; i++)
        {
            mas[i] = number;
            number -= 1;
        }
    }
}

void random_input(vector<int> &mas, size_t length)
{
    for (size_t i = 0; i < length; i++)
    {
        mas[i] = rand();
    }
}

void zero_input(vector<int> &mas, size_t length)
{
    for (size_t i = 0; i < length; i++)
    {
        mas[i] = 0;
    }
}

void random_sort(void (*sort)(vector<int>&))
{
    int length, num, amount, filling;
    string str;
    while (true)
    {
        cout << "Введите длину массива" << endl;
        cin >> str;

        length = atoi(str.c_str());
        if (length == 0)
        {
            cout << "Длина не может быть 0 или символом!" << endl;
        }
        else if (length < 0)
        {
            cout << "Длина не может быть отрицательной!" << endl;
        }
        else
        {
            long long i1, i2;
            long long summ = 0;
            size_t size = size_t(length);
            vector<int> mas(size);
            while (true)
            {
                cout << "Введите, сколько раз функция будет выполняться" << endl;
                cin >> str;
                amount = atoi(str.c_str());
                if (amount > 0)
                {
                    while (true)
                    {
                        cout << "Выберите случай:" << endl;
                        cout << "1. Худший случай" << endl;
                        cout << "2. Средний случай" << endl;
                        cout << "3. Лучший случай" << endl;
                        cin >> str;
                        filling = atoi(str.c_str());
                        if (filling > 0)
                        {
                            for (int k = 0; k < amount; k++)
                            {
                                switch(filling) {
                                case 1:
                                    order_input(mas, size, false);
                                    break;
                                case 2:
                                    random_input(mas, size);
                                    break;
                                case 3:
                                    order_input(mas, size, true);
                                    break;
                                default:
                                    zero_input(mas, size);
                                    break;
                                }
                                //print_mas(mas);
                                i1 = __rdtsc();
                                sort(mas);
                                i2 = __rdtsc();
                                summ += abs(i2 - i1);
                            }
                            break;
                        }
                    }
                    break;
                }
            }
            cout << "Среднее процессорное время выполнения функции (в тиках):" << summ / amount << endl;
            break;
        }
    }
}


void work_with_sort(void (*sort)(vector<int>&))
{
    unsigned int choice;
    bool flag = true;
    while (flag)
    {
        cout << "1. Начать ввод массива" << endl;
        cout << "2. Случайное заполнение" << endl;
        cout << "0. Выход" << endl;
        cin >> choice;
        switch (choice) {
        case 1:
            input_sort(sort);
            break;
        case 2:
            random_sort(sort);
            break;
        case 0:
            flag = false;
            break;
        default:
            break;
        }
    }
}

int main()
{
    unsigned int choice;
    bool flag = true;
    while (flag)
    {
        cout << "Выберите сортировку:" << endl;
        cout << "1. Сортировка Шелла" << endl;
        cout << "2. Сортировка расческой" << endl;
        cout << "3. Гномья сортировка" << endl;
        cout << "0. Выход" << endl;
        cin >> choice;
        switch (choice) {
        case 1:
            work_with_sort(ShellSort);
            break;
        case 2:
            work_with_sort(comb);
            break;
        case 3:
            work_with_sort(gnome_sort);
            break;
        case 0:
            flag = false;
            break;
        default:
            break;
        }

    }
    return 0;
}
