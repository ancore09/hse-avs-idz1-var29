# Отчет по ИДЗ №1

## 4 балла

### Код на C
```c
#include "stdio.h"
#include <stdlib.h>

int main(int argc, char *argv[]) {
    int *a;
    int i;
    int firstEvenNegativeIndex = -1;

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

    int *b;
    b = (int *)malloc((argc - 1) * sizeof(int));
    for (i = 0; i < argc - 1; i++) {
        b[i] = a[i] * a[firstEvenNegativeIndex];
    }

    printf("Output: ");
    for (i = 0; i < argc - 1; i++) {
        printf("%d ", b[i]);
    }
    printf("N\n");

    free(a);
    free(b);

    return 0;
}
```

### Компиляция программы без оптимизаций
```sh
gcc -masm=intel -S 29.c -o 29.s
```

### Компиляция программы с оптимизацией
```sh
gcc -O0 -Wall -masm=intel -S -fno-asynchronous-unwind-tables -fcf-protection=none 29.c -o 29c.s
```

### Тестовые прогоны

| Входные данные  | 29.s            | 29c.s           |
|-----------------|:---------------:|:---------------:|
| *пустой массив* | *пустой массив* | *пустой массив* |
| [1 2 3 4]       | [4 8 12 16]     | [4 8 12 16]     |
| [-2 1 2 3 4]    | [4 -2 -4 -6 -8] | [4 -2 -4 -6 -8] |
| [18 65 34 -8]| [-144 -520 -272 64]|[-144 -520 -272 64]|

## 5 баллов

### Код на C
```c
#include "stdio.h"
#include <stdlib.h>

int* transform(int index, int* arr, int size) {
    int* result = (int*)malloc(sizeof(int) * size);
    for (int i = 0; i < size; i++) {
        result[i] = arr[i] * arr[index];
    }
    return result;
}

int main(int argc, char *argv[]) {
    int *a;
    int i;
    int firstEvenNegativeIndex = -1;

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

    int* b = transform(firstEvenNegativeIndex, a, argc - 1);

    printf("Output: ");
    for (i = 0; i < argc - 1; i++) {
        printf("%d ", b[i]);
    }
    printf("N\n");

    free(a);
    free(b);

    return 0;
}
```

### Комментарии в asm коде
```assembly
.L9:
	mov	eax, DWORD PTR -52[rbp]		# eax = argc
	lea	edx, -1[rax]				# edx = -1 + argc (size)
	mov	rcx, QWORD PTR -32[rbp]		# rcx = array
	mov	eax, DWORD PTR -36[rbp]		# eax = firstEvenNegativeIndex
	mov	rsi, rcx					# arr
	mov	edi, eax					# index
	call	transform				# Call transform
	mov	QWORD PTR -24[rbp], rax		# return of transform
	lea	rax, .LC0[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	DWORD PTR -40[rbp], 0
	jmp	.L10
```

## 6 баллов

### Измененный код на C
```c
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
```

Без комментариев понятно в каких регистрах будут расположены переменные

### Тестовые прогоны

| Входные данные  | 29wf.s            | 29wfr.s           |
|-----------------|:---------------:|:---------------:|
| *пустой массив* | *пустой массив* | *пустой массив* |
| [1 2 3 4]       | [4 8 12 16]     | [4 8 12 16]     |
| [-2 1 2 3 4]    | [4 -2 -4 -6 -8] | [4 -2 -4 -6 -8] |
| [18 65 34 -8]| [-144 -520 -272 64]|[-144 -520 -272 64]|

## 7 баллов

### Измененный код на С для ввода/вывода из/в файл
```c
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
```

### Разбиение Asm кода на две единицы компиляции
#### 29wfrf_1.s
```assembly
	.intel_syntax noprefix
	.text
	.globl	transform
	.type	transform, @function
transform:
	push	rbp
	mov	rbp, rsp
	push	r14
	push	r12
	sub	rsp, 16
	mov	DWORD PTR -20[rbp], edi
	mov	QWORD PTR -32[rbp], rsi
	mov	DWORD PTR -24[rbp], edx
	mov	eax, DWORD PTR -24[rbp]
	cdqe
	sal	rax, 2
	mov	rdi, rax
	call	malloc@PLT
	mov	r12, rax
	mov	r14d, 0
	jmp	.L2
.L3:
	mov	eax, r14d
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -32[rbp]
	add	rax, rdx
	mov	ecx, DWORD PTR [rax]
	mov	eax, DWORD PTR -20[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -32[rbp]
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	mov	rsi, r12
	mov	edx, r14d
	movsx	rdx, edx
	sal	rdx, 2
	add	rdx, rsi
	imul	eax, ecx
	mov	DWORD PTR [rdx], eax
	mov	eax, r14d
	add	eax, 1
	mov	r14d, eax
.L2:
	mov	eax, r14d
	cmp	DWORD PTR -24[rbp], eax
	jg	.L3
	mov	rax, r12
	add	rsp, 16
	pop	r12
	pop	r14
	pop	rbp
	ret
	.size	transform, .-transform
	.section	.rodata
	.ident	"GCC: (Ubuntu 11.2.0-19ubuntu1) 11.2.0"
	.section	.note.GNU-stack,"",@progbits

```

#### 29wfrf_2.s
```assembly
	.file	"29-with-func-regs-files.c"
	.intel_syntax noprefix
	.text
	.section	.rodata
.LC0:
	.string	"r"
.LC1:
	.string	"%d"
.LC2:
	.string	"w"
.LC3:
	.string	"%d "
	.text
	.globl	main
	.type	main, @function
main:
	push	rbp
	mov	rbp, rsp
	push	r15
	push	r14
	push	r13
	push	rbx
	sub	rsp, 48
	mov	DWORD PTR -68[rbp], edi
	mov	QWORD PTR -80[rbp], rsi
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR -40[rbp], rax
	xor	eax, eax
	mov	r15d, -1
	mov	rax, QWORD PTR -80[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC0[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -56[rbp], rax
	lea	rdx, -60[rbp]
	mov	rax, QWORD PTR -56[rbp]
	lea	rcx, .LC1[rip]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf@PLT
	mov	eax, DWORD PTR -60[rbp]
	cdqe
	sal	rax, 2
	mov	rdi, rax
	call	malloc@PLT
	mov	r13, rax
	mov	r14d, 0
	jmp	.L6
.L8:
	mov	rdx, r13
	mov	eax, r14d
	cdqe
	sal	rax, 2
	add	rdx, rax
	mov	rax, QWORD PTR -56[rbp]
	lea	rcx, .LC1[rip]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf@PLT
	mov	rdx, r13
	mov	eax, r14d
	cdqe
	sal	rax, 2
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	test	eax, eax
	jns	.L7
	mov	rdx, r13
	mov	eax, r14d
	cdqe
	sal	rax, 2
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	and	eax, 1
	test	eax, eax
	jne	.L7
	mov	eax, r15d
	cmp	eax, -1
	jne	.L7
	mov	eax, r14d
	mov	r15d, eax
.L7:
	mov	eax, r14d
	add	eax, 1
	mov	r14d, eax
.L6:
	mov	edx, r14d
	mov	eax, DWORD PTR -60[rbp]
	cmp	edx, eax
	jl	.L8
	mov	eax, r15d
	cmp	eax, -1
	jne	.L9
	mov	eax, DWORD PTR -68[rbp]
	sub	eax, 2
	mov	r15d, eax
.L9:
	mov	eax, DWORD PTR -60[rbp]
	mov	rsi, r13
	mov	ecx, r15d
	mov	edx, eax
	mov	edi, ecx
	call	transform
	mov	rbx, rax
	mov	rax, QWORD PTR -80[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC2[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -48[rbp], rax
	mov	r14d, 0
	jmp	.L10
.L11:
	mov	eax, r14d
	cdqe
	sal	rax, 2
	add	rax, rbx
	mov	edx, DWORD PTR [rax]
	mov	rax, QWORD PTR -48[rbp]
	lea	rcx, .LC3[rip]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	fprintf@PLT
	mov	eax, r14d
	add	eax, 1
	mov	r14d, eax
.L10:
	mov	edx, r14d
	mov	eax, DWORD PTR -60[rbp]
	cmp	edx, eax
	jl	.L11
	mov	rax, r13
	mov	rdi, rax
	call	free@PLT
	mov	rdi, rbx
	call	free@PLT
	mov	eax, 0
	mov	rdx, QWORD PTR -40[rbp]
	sub	rdx, QWORD PTR fs:40
	je	.L13
	call	__stack_chk_fail@PLT
.L13:
	add	rsp, 48
	pop	rbx
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	ret
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.2.0-19ubuntu1) 11.2.0"
	.section	.note.GNU-stack,"",@progbits
```

### Тестовые прогоны
#### Файл input.txt:
```
4
1
-2
3
4
```
Первое число - количество чисел в файле. Далее следуют сами числа

#### Файл output.txt:
```
2 4 -6 -8
```