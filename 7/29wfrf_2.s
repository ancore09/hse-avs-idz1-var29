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
