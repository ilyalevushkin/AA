#ifndef OBJECT_H
#define OBJECT_H

#include <vector>
#include <iostream>
#include <ctime>

#define DEFAULT_SIZE 10

using namespace std;

struct time_for_work
{
    timespec from;
    timespec to;
};

class object
{
public:
    object();
    object(size_t count);
    object(vector<int> mas);

    void add_elem_to_mas(const int value);

    void delete_last_elem_from_mas();

    void do_conveyer_1();

    void do_conveyer_2();

    void do_conveyer_3();

    void set_time_1(time_for_work t1) {this->t1 = t1;}
    void set_time_2(time_for_work t2) {this->t2 = t2;}
    void set_time_3(time_for_work t3) {this->t3 = t3;}

    time_for_work get_time_1();
    time_for_work get_time_2();
    time_for_work get_time_3();

    vector<int> get_mas();


    ~object() = default;

private:
    vector<int> mas;
    time_for_work t1;
    time_for_work t2;
    time_for_work t3;
};

#endif // OBJECT_H
