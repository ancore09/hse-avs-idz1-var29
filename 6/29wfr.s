	.file	"29-with-func-regs.c"
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
	push	r15
	push	r14
	push	r13
	push	rbx
	sub	rsp, 16
	mov	DWORD PTR -36[rbp], edi
	mov	QWORD PTR -48[rbp], rsi
	mov	r15d, -1
	mov	eax, DWORD PTR -36[rbp]
	sub	eax, 1
	cdqe
	sal	rax, 2
	mov	rdi, rax
	call	malloc@PLT
	mov	r13, rax
	mov	r14d, 0
	jmp	.L6
.L8:
	mov	eax, r14d
	cdqe
	add	rax, 1
	lea	rdx, 0[0+rax*8]
	mov	rax, QWORD PTR -48[rbp]
	add	rax, rdx
	mov	rax, QWORD PTR [rax]
	mov	rcx, r13
	mov	edx, r14d
	movsx	rdx, edx
	sal	rdx, 2
	lea	rbx, [rcx+rdx]
	mov	rdi, rax
	call	atoi@PLT
	mov	DWORD PTR [rbx], eax
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
	mov	eax, DWORD PTR -36[rbp]
	sub	eax, 1
	mov	edx, r14d
	cmp	eax, edx
	jg	.L8
	mov	eax, r15d
	cmp	eax, -1
	jne	.L9
	mov	eax, DWORD PTR -36[rbp]
	sub	eax, 2
	mov	r15d, eax
.L9:
	mov	eax, DWORD PTR -36[rbp]
	sub	eax, 1
	mov	rsi, r13
	mov	ecx, r15d
	mov	edx, eax
	mov	edi, ecx
	call	transform
	mov	rbx, rax
	lea	rax, .LC0[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	r14d, 0
	jmp	.L10
.L11:
	mov	eax, r14d
	cdqe
	sal	rax, 2
	add	rax, rbx
	mov	eax, DWORD PTR [rax]
	mov	esi, eax
	lea	rax, .LC1[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	eax, r14d
	add	eax, 1
	mov	r14d, eax
.L10:
	mov	eax, DWORD PTR -36[rbp]
	sub	eax, 1
	mov	edx, r14d
	cmp	eax, edx
	jg	.L11
	lea	rax, .LC2[rip]
	mov	rdi, rax
	call	puts@PLT
	mov	rax, r13
	mov	rdi, rax
	call	free@PLT
	mov	rdi, rbx
	call	free@PLT
	mov	eax, 0
	add	rsp, 16
	pop	rbx
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	ret
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.2.0-19ubuntu1) 11.2.0"
	.section	.note.GNU-stack,"",@progbits
