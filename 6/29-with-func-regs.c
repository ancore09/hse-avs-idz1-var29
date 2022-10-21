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

    a = (int *)malloc((argc - 1) * sizeof(int));
    for (i = 0; i < argc - 1; i++) {
        a[i] = atoi(argv[i + 1]);
        if (a[i] < 0 && a[i] % 2 == 0 && firstEvenNegativeIndex == -1) {
            firstEvenNegativeIndex = i;
        }
    }

    if (firstEvenNegativeIndex == -1) {
        firstEvenNegativeIndex = argc - 2;
    }

    register int* b = transform(firstEvenNegativeIndex, a, argc - 1); // r12 -> rax -> rbx

    printf("Output: ");
    for (i = 0; i < argc - 1; i++) {
        printf("%d ", b[i]);
    }
    printf("N\n");

    free(a);
    free(b);

    return 0;
}