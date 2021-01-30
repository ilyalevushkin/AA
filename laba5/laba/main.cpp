#include "object.h"

#include <thread>
#include <mutex>
#include <queue>
#include <iostream>
#include <time.h>
#include <math.h>


mutex m1, m2, m3;
queue<object> q1, q2, q3;
size_t count_objects = 100;
size_t counter_1 = 0;
size_t counter_2 = 0;
size_t counter_3 = 0;

vector<object> objects_generator(size_t count_objects)
{
    vector<object> mas_objects;
    for (size_t i = 0; i < count_objects; i++)
    {
        object *obj = new object(i * 100);
        mas_objects.push_back(*obj);
    }
    return mas_objects;
}

void conveyer_1()
{
    timespec now, after;
    while (1)
    {
        m1.lock();
        if (!q1.empty())
        {
            auto object = q1.front();
            q1.pop();

            clock_gettime(CLOCK_REALTIME, &now);
            object.do_conveyer_1();
            clock_gettime(CLOCK_REALTIME, &after);

            object.set_time_1({now, after});

            m2.lock();
            q2.push(object);
            m2.unlock();
            counter_1++;
            if (counter_1 == count_objects)
            {
                return;
            }
        }
        m1.unlock();
    }
}

void conveyer_2()
{
    timespec now, after;
    while (1)
    {
        m2.lock();
        if (!q2.empty())
        {
            auto object = q2.front();
            q2.pop();

            clock_gettime(CLOCK_REALTIME, &now);
            object.do_conveyer_2();
            clock_gettime(CLOCK_REALTIME, &after);

            object.set_time_2({now, after});

            m3.lock();
            q3.push(object);
            m3.unlock();
            counter_2++;
            if (counter_2 == count_objects)
            {
                return;
            }
        }
        m2.unlock();
    }
}

void conveyer_3(vector<object> &return_objects)
{
    timespec now, after;
    while (1)
    {
        m3.lock();
        if (!q3.empty())
        {
            auto object = q3.front();
            q3.pop();

            clock_gettime(CLOCK_REALTIME, &now);
            object.do_conveyer_3();
            clock_gettime(CLOCK_REALTIME, &after);


            object.set_time_3({now, after});

            return_objects.push_back(object);
            counter_3++;
            if (counter_3 == count_objects)
            {
                return;
            }
        }
        m3.unlock();
    }
}

void print_time(time_for_work tim)
{
    long ms_from, ms_to; // Milliseconds
    long long ns_from, ns_to; // Nanoseconds
    time_t s_from, s_to;  // Seconds
    tm *timeinfo_from, *timeinfo_to;

    s_from  = tim.from.tv_sec;
    timeinfo_from = localtime (&s_from);
    ms_from = floor(tim.from.tv_nsec / 1.0e6); // Convert nanoseconds to milliseconds

    s_to  = tim.to.tv_sec;
    timeinfo_to = localtime (&s_to);
    ms_to = floor(tim.to.tv_nsec / 1.0e6); // Convert nanoseconds to milliseconds

    ns_from = abs(tim.from.tv_nsec - ms_from * 1.0e6);

    ns_to = abs(tim.to.tv_nsec - ms_to * 1.0e6);



    cout << "Начало: " << timeinfo_from->tm_hour <<
            ":" << timeinfo_from->tm_min << ":" <<
            timeinfo_from->tm_sec << ":" << ms_from << ":" << ns_from << endl;
    cout << "Конец: " << timeinfo_to->tm_hour <<
            ":" << timeinfo_to->tm_min << ":" <<
            timeinfo_to->tm_sec << ":" << ms_to << ":" << ns_to << endl;
}

void print_results(vector<object> res)
{
    time_for_work tim;

    for (size_t i = 0; i < res.size(); i++)
    {
        cout << "Объект " << i << ":" << endl;

        cout << "Конвейер 1: " << endl;
        tim = res[i].get_time_1();
        print_time(tim);

        cout << "Конвейер 2: " << endl;
        tim = res[i].get_time_2();
        print_time(tim);

        cout << "Конвейер 3: " << endl;
        tim = res[i].get_time_3();
        print_time(tim);
    }
}

int main()
{
    vector<object> mas_objects = objects_generator(count_objects);

    vector<object> return_objects;

    vector<thread> thr(3);

    thr[0] = thread(conveyer_1);
    thr[1] = thread(conveyer_2);
    thr[2] = thread(conveyer_3, ref(return_objects));

    for (size_t i = 0; i < count_objects; i++)
    {
        q1.push(mas_objects[i]);
    }


    for (size_t i = 0; i < thr.size(); i++)
    {
        thr[i].join();
    }

    print_results(return_objects);

    return 0;
}
