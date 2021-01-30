#ifndef VINOGRAD_H
#define VINOGRAD_H

#pragma once

#include <iostream>
#include <vector>
#include <string>
#include <algorithm>
#include <thread>

using Matrix = std::vector<std::vector<int>>;
using namespace std;

void print_matrix(const Matrix& matrix);
Matrix std_mult(const Matrix &a, const Matrix &b);
Matrix vinograd_mult(const Matrix &a, const Matrix &b);
Matrix modified_vinograd_mult(const Matrix &a, const Matrix &b);
void random_filling_matrix(Matrix& matrix);
Matrix modified_thread_vinograd_mult(const Matrix &a, const Matrix &b, size_t count_threads);

#endif // VINOGRAD_H
