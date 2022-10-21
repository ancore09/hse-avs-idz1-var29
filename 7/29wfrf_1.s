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
