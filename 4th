#include <iostream>
#include <cstdlib>
#include <ctime>
#include <pthread.h>

const int N = 3;
const int THREADS = 3;

int A[N][N], B[N][N], C[N][N];

struct Args {
    int start, end;
};
void *multiply(void *arg) {
    Args *args = (Args *)arg;
    int start = args->start;
    int end = args->end;
    for (int i = start; i < end; ++i) {
        for (int j = 0; j < N; ++j) {
            int sum = 0;
            for (int k = 0; k < N; ++k) {
                sum += A[i][k] * B[k][j];
            }
            C[i][j] = sum;
        }
    }
    pthread_exit(NULL);
}
int main() {
    srand(time(0)); 
    pthread_t threads[THREADS];
    Args args[THREADS];
    for (int i = 0; i < N; ++i) {
        for (int j = 0; j < N; ++j) {
            A[i][j] = rand() % 10;
            B[i][j] = rand() % 10;
        }
    }
    for (int i = 0; i < THREADS; ++i) {
        args[i].start = (N/THREADS)*i;
        args[i].end = (N/THREADS)*(i+1);
        pthread_create(&threads[i], NULL, multiply, (void *)&args[i]);
    }
    for (int i = 0; i < THREADS; ++i) {
        pthread_join(threads[i], NULL);
    }
    std::cout << "Matrix A:\n";
    for (int i = 0; i < N; ++i) {
        for (int j = 0; j < N; ++j) {
            std::cout << A[i][j] << " ";
        }
        std::cout << "\n";
    }
    std::cout << "\n";
    
    std::cout << "Matrix B:\n";
    for (int i = 0; i < N; ++i) {
        for (int j = 0; j < N; ++j) {
            std::cout << B[i][j] << " ";
        }
        std::cout << "\n";
    }
    std::cout << "\n";
    
    std::cout << "Matrix C:\n";
    for (int i = 0; i < N; ++i) {
        for (int j = 0; j < N; ++j) {
            std::cout << C[i][j] << " ";
        }
        std::cout << "\n";
    }
    std::cout << "\n";
    
    return 0;
}
