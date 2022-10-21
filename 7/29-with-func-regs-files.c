#include "stdio.h"
#include <stdlib.h>

int* transform(int index, int* arr, int size) {
    register int* result asm ("r12") = (int*)malloc(sizeof(int) * size);
    register int i asm ("r14");
    for (i = 0; i < size; i++) {
        result[i] = arr[i] * arr[index];
    }
    return result;
}

int main(int argc, char *argv[]) {
    register int *a asm ("r13");
    register int i asm ("r14");
    register int firstEvenNegativeIndex asm ("r15") = -1;

    FILE *fp;
    fp = fopen(argv[1], "r");
    int size;
    fscanf(fp, "%d", &size);

    a = (int *)malloc(size * sizeof(int));
    for (i = 0; i < size; i++) {
        fscanf(fp, "%d", &a[i]);
        if (a[i] < 0 && a[i] % 2 == 0 && firstEvenNegativeIndex == -1) {
            firstEvenNegativeIndex = i;
        }
    }

    if (firstEvenNegativeIndex == -1) {
        firstEvenNegativeIndex = argc - 2;
    }

    register int* b = transform(firstEvenNegativeIndex, a, size); // r12 -> rax -> rbx

    FILE *fp2;
    fp2 = fopen(argv[2], "w");
    for (i = 0; i < size; i++) {
        fprintf(fp2, "%d ", b[i]);
    }

    free(a);
    free(b);

    return 0;
}