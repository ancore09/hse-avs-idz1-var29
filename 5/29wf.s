	.file	"29-with-func.c"
	.intel_syntax noprefix
	.text
	.globl	transform
	.type	transform, @function
transform:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	DWORD PTR -20[rbp], edi
	mov	QWORD PTR -32[rbp], rsi
	mov	DWORD PTR -24[rbp], edx
	mov	eax, DWORD PTR -24[rbp]
	cdqe
	sal	rax, 2
	mov	rdi, rax
	call	malloc@PLT
	mov	QWORD PTR -8[rbp], rax
	mov	DWORD PTR -12[rbp], 0
	jmp	.L2
.L3:
	mov	eax, DWORD PTR -12[rbp]
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
	mov	edx, DWORD PTR -12[rbp]
	movsx	rdx, edx
	lea	rsi, 0[0+rdx*4]
	mov	rdx, QWORD PTR -8[rbp]
	add	rdx, rsi
	imul	eax, ecx
	mov	DWORD PTR [rdx], eax
	add	DWORD PTR -12[rbp], 1
.L2:
	mov	eax, DWORD PTR -12[rbp]
	cmp	eax, DWORD PTR -24[rbp]
	jl	.L3
	mov	rax, QWORD PTR -8[rbp]
	leave
	ret
	.size	transform, .-transform
	.section	.rodata
.LC0:
	.string	"Output: "
.LC1:
	.string	"%d "
.LC2:
	.string	"N"
	.text
	.globl	main
	.type	main, @function
main:
	push	rbp
	mov	rbp, rsp
	push	rbx
	sub	rsp, 56
	mov	DWORD PTR -52[rbp], edi
	mov	QWORD PTR -64[rbp], rsi
	mov	DWORD PTR -36[rbp], -1
	mov	eax, DWORD PTR -52[rbp]
	sub	eax, 1
	cdqe
	sal	rax, 2
	mov	rdi, rax
	call	malloc@PLT
	mov	QWORD PTR -32[rbp], rax
	mov	DWORD PTR -40[rbp], 0
	jmp	.L6
.L8:
	mov	eax, DWORD PTR -40[rbp]
	cdqe
	add	rax, 1
	lea	rdx, 0[0+rax*8]
	mov	rax, QWORD PTR -64[rbp]
	add	rax, rdx
	mov	rax, QWORD PTR [rax]
	mov	edx, DWORD PTR -40[rbp]
	movsx	rdx, edx
	lea	rcx, 0[0+rdx*4]
	mov	rdx, QWORD PTR -32[rbp]
	lea	rbx, [rcx+rdx]
	mov	rdi, rax
	call	atoi@PLT
	mov	DWORD PTR [rbx], eax
	mov	eax, DWORD PTR -40[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -32[rbp]
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	test	eax, eax
	jns	.L7
	mov	eax, DWORD PTR -40[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -32[rbp]
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	and	eax, 1
	test	eax, eax
	jne	.L7
	cmp	DWORD PTR -36[rbp], -1
	jne	.L7
	mov	eax, DWORD PTR -40[rbp]
	mov	DWORD PTR -36[rbp], eax
.L7:
	add	DWORD PTR -40[rbp], 1
.L6:
	mov	eax, DWORD PTR -52[rbp]
	sub	eax, 1
	cmp	DWORD PTR -40[rbp], eax
	jl	.L8
	cmp	DWORD PTR -36[rbp], -1
	jne	.L9
	mov	eax, DWORD PTR -52[rbp]
	sub	eax, 2
	mov	DWORD PTR -36[rbp], eax
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
.L11:
	mov	eax, DWORD PTR -40[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	mov	esi, eax
	lea	rax, .LC1[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	add	DWORD PTR -40[rbp], 1
.L10:
	mov	eax, DWORD PTR -52[rbp]
	sub	eax, 1
	cmp	DWORD PTR -40[rbp], eax
	jl	.L11
	lea	rax, .LC2[rip]
	mov	rdi, rax
	call	puts@PLT
	mov	rax, QWORD PTR -32[rbp]
	mov	rdi, rax
	call	free@PLT
	mov	rax, QWORD PTR -24[rbp]
	mov	rdi, rax
	call	free@PLT
	mov	eax, 0
	mov	rbx, QWORD PTR -8[rbp]
	leave
	ret
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.2.0-19ubuntu1) 11.2.0"
	.section	.note.GNU-stack,"",@progbits
