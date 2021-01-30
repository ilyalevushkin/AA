#include "vinograd.h"

Matrix std_mult(const Matrix &a, const Matrix &b) {
  if (a.empty() || b.empty() || a[0].size() != b.size()) {
    return Matrix();
  }

  size_t m = a.size();
  size_t q = b.size();
  size_t n = b[0].size();
  Matrix c(m, std::vector<int>(n, 0));

  for (size_t i = 0; i < m; i++) {
    for (size_t j = 0; j < n; j++) {
      for (size_t k = 0; k < q; k++) {
        c[i][j] = c[i][j] + a[i][k] * b[k][j];
      }
    }
  }

  return c;
}

void print_matrix(const Matrix& matrix) {
  for (auto row : matrix)
  {
    for (auto col : row)
    {
      std::cout << col << " ";
    }
    std::cout << std::endl;
  }
  std::cout << std::endl;
}

void random_filling_matrix(Matrix& matrix)
{
    for (size_t i = 0; i < matrix.size(); i++)
    {
        for (size_t j = 0; j < matrix[i].size(); j++)
        {
            matrix[i][j] = rand();
        }
    }
}

Matrix vinograd_mult(const Matrix &a, const Matrix &b) {
  if (a.empty() || b.empty() || a[0].size() != b.size()) {
    return Matrix();
  }

  size_t m = a.size();
  size_t q = b.size();
  size_t n = b[0].size();
  Matrix c(m, std::vector<int>(n, 0));

  std::vector<int> row_fact(m);
  std::vector<int> col_fact(n);

  for (size_t i = 0; i < m; i++) {
    row_fact[i] = 0;
    for (size_t j = 0; j < q / 2; j++) {
      row_fact[i] = row_fact[i] + a[i][2*j] * a[i][2*j+1];
    }
  }

  for (size_t i = 0; i < n; i++) {
    col_fact[i] = 0;
    for (size_t j = 0; j < q / 2; j++) {
      col_fact[i] = col_fact[i] + b[2*j][i] * b[2*j+1][i];
    }
  }

  for (size_t i = 0; i < m; i++) {
    for (size_t j = 0; j < n; j++) {
      c[i][j] = -row_fact[i] - col_fact[j];
      for (size_t k = 0; k < q / 2; k++) {
        c[i][j] = c[i][j] + (a[i][2*k] + b[2*k+1][j]) * (a[i][2*k+1] + b[2*k][j]);
      }
    }
  }

  if (q % 2 == 1) {
    for (size_t i = 0; i < m; i++) {
      for (size_t j = 0; j < n; j++) {
        c[i][j] = c[i][j] + a[i][q-1] * b[q-1][j];
      }
    }
  }

  return c;
}

Matrix modified_vinograd_mult(const Matrix &a, const Matrix &b) {
  if (a.empty() || b.empty() || a[0].size() != b.size()) {
    return Matrix();
  }

  size_t m = a.size();
  size_t q = b.size();
  size_t n = b[0].size();
  Matrix c(m, std::vector<int>(n, 0));

  size_t t = q - 1;
  std::vector<int> row_fact(m, 0);
  std::vector<int> col_fact(n, 0);

  for (size_t i = 0; i < m; i++) {
    for (size_t j = 0; j < t; j += 2) {
      row_fact[i] += a[i][j] * a[i][j+1];
    }
  }

  for (size_t i = 0; i < n; i++) {
    for (size_t j = 0; j < t; j += 2) {
      col_fact[i] += b[j][i] * b[j+1][i];
    }
  }

  int tmp = 0;

  for (size_t i = 0; i < m; i++) {
    for (size_t j = 0; j < n; j++) {
      tmp = -row_fact[i] - col_fact[j];
      for (size_t k = 0; k < t; k += 2) {
        tmp += (a[i][k] + b[k+1][j]) * (a[i][k+1] + b[k][j]);
      }

      c[i][j] = tmp;
    }
  }

  if (q % 2) {
    for (size_t i = 0; i < m; i++) {
      for (size_t j = 0; j < n; j++) {
        c[i][j] += a[i][q-1] * b[q-1][j];
      }
    }
  }

  return c;
}

void calc_row_fact(vector<int> &row_fact, size_t m, size_t t, const Matrix &a)
{
    for (size_t i = 0; i < m; i++)
    {
      for (size_t j = 0; j < t; j += 2)
      {
        row_fact[i] += a[i][j] * a[i][j + 1];
      }
    }
}

void calc_col_fact(vector<int> &col_fact, size_t n, size_t t, const Matrix &b)
{
    for (size_t i = 0; i < n; i++) {
      for (size_t j = 0; j < t; j += 2) {
        col_fact[i] += b[j][i] * b[j+1][i];
      }
    }
}

void par_calculations(size_t m, size_t n, size_t t, const Matrix &a,
                      const Matrix &b, Matrix &c, size_t thread,
                      size_t count_threads, const vector<int> &row_fact, const vector<int> &col_fact, int tmp)
{

    for (size_t i = thread; i < m; i += count_threads) {
      for (size_t j = 0; j < n; j++) {
        tmp = -row_fact[i] - col_fact[j];
        for (size_t k = 0; k < t; k += 2) {
          tmp += (a[i][k] + b[k + 1][j]) * (a[i][k + 1] + b[k][j]);
        }
        c[i][j] = tmp;
      }
    }
}

void calc_dop_calculations(size_t m, size_t n, size_t q, const Matrix &a, const Matrix &b, Matrix &c, size_t thread, size_t count_theads)
{
    for (size_t i = thread; i < m; i += count_theads)
    {
      for (size_t j = 0; j < n; j++)
      {
        c[i][j] += a[i][q - 1] * b[q - 1][j];
      }
    }
}

Matrix modified_thread_vinograd_mult(const Matrix &a, const Matrix &b, size_t count_threads)
{
  if (a.empty() || b.empty() || a[0].size() != b.size()) {
    return Matrix();
  }

  size_t m = a.size();
  size_t q = b.size();
  size_t n = b[0].size();
  Matrix c(m, std::vector<int>(n, 0));

  size_t t = q - 1;
  std::vector<int> row_fact(m, 0);
  std::vector<int> col_fact(n, 0);

  thread row(calc_row_fact, ref(row_fact), m, t, ref(a));
  thread col(calc_col_fact, ref(col_fact), n, t, ref(b));

  row.join();
  col.join();



  vector<thread> threads(count_threads);

  int tmp = 0;

  for (size_t i = 0; i < count_threads; i++)
  {
      threads[i] = thread(par_calculations, m, n, t, ref(a), ref(b), ref(c), i, count_threads, ref(row_fact), ref(col_fact), tmp);
  }

  for (size_t i = 0; i < count_threads; i++)
  {
      threads[i].join();
  }

  if (q % 2)
  {
    for (size_t i = 0; i < count_threads; i++)
    {
      threads[i] = thread(calc_dop_calculations, m, n, q, ref(a), ref(b), ref(c), i, count_threads);
    }

    for (size_t i = 0; i < count_threads; i++)
    {
        threads[i].join();
    }
  }

  return c;
}
