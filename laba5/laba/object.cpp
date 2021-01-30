#include "object.h"


object::object()
{
    this->mas.resize(DEFAULT_SIZE);
    for (size_t i = 0; i < this->mas.size(); i++)
    {
        this->mas[i] = rand();
    }
}

object::object(size_t count)
{
    this->mas.resize(count);
    for (size_t i = 0; i < this->mas.size(); i++)
    {
        this->mas[i] = rand();
    }
}

object::object(vector<int> mas)
{
    this->mas = mas;
}

void object::add_elem_to_mas(const int value)
{
    this->mas.push_back(value);
}

void object::delete_last_elem_from_mas()
{
    this->mas.pop_back();
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

void add_elements(vector<int> &mas)
{
    int count_elements = DEFAULT_SIZE * 10;
    for (int i = 0; i < count_elements; i++)
    {
        mas.push_back(rand());
    }
}

void print_few_elements(const vector<int> &mas)
{
    size_t count_print_elements = mas.size() / 100; // 1% элементов будем печатать
    for (size_t i = 0; i < count_print_elements; i++)
    {
        cout << mas[i] << " ";
        if (i % 10 == 0)
        {
            cout << endl;
        }
    }
    cout << endl;
}

void object::do_conveyer_1()
{
    ShellSort(mas);
}

void object::do_conveyer_2()
{
    add_elements(mas);
}

void object::do_conveyer_3()
{
    print_few_elements(mas);
}

time_for_work object::get_time_1()
{
    return t1;
}

time_for_work object::get_time_2()
{
    return t2;
}

time_for_work object::get_time_3()
{
    return t3;
}

vector<int> object::get_mas()
{
    return mas;
}
