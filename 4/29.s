	.file	"29.c"
	.intel_syntax noprefix
	.text
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
.LFB6:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	push	rbx
	sub	rsp, 56
	.cfi_offset 3, -24
	mov	DWORD PTR -52[rbp], edi		# argc
	mov	QWORD PTR -64[rbp], rsi		# argv
	mov	DWORD PTR -36[rbp], -1		# firstEvenNegativeIndex
	mov	eax, DWORD PTR -52[rbp]
	sub	eax, 1						# argc - 1
	cdqe
	sal	rax, 2						# (argc - 1) / 4
	mov	rdi, rax					
	call	malloc@PLT
	mov	QWORD PTR -32[rbp], rax		# array a
	mov	DWORD PTR -40[rbp], 0		# i
	jmp	.L2
.L4:
	mov	eax, DWORD PTR -40[rbp]		# i
	cdqe
	add	rax, 1						# i + 1
	lea	rdx, 0[0+rax*8]				# (i + 1) * 8
	mov	rax, QWORD PTR -64[rbp]		# argv
	add	rax, rdx					# argv + (i + 1) * 8
	mov	rax, QWORD PTR [rax]		# argv[i + 1]
	mov	edx, DWORD PTR -40[rbp]		# i
	movsx	rdx, edx
	lea	rcx, 0[0+rdx*4]				# i * 4
	mov	rdx, QWORD PTR -32[rbp] 	# array a
	lea	rbx, [rcx+rdx]				# a[i]
	mov	rdi, rax					# argv[i + 1]
	call	atoi@PLT				# atoi(argv[i + 1])
	mov	DWORD PTR [rbx], eax		# a[i] = atoi(argv[i + 1])
	mov	eax, DWORD PTR -40[rbp]		# i
	cdqe
	lea	rdx, 0[0+rax*4]				# i * 4
	mov	rax, QWORD PTR -32[rbp]		# array a
	add	rax, rdx					# a + i * 4
	mov	eax, DWORD PTR [rax]		# a[i]
	test	eax, eax
	jns	.L3
	mov	eax, DWORD PTR -40[rbp]		# i
	cdqe
	lea	rdx, 0[0+rax*4]				# i * 4
	mov	rax, QWORD PTR -32[rbp]		# array a
	add	rax, rdx					# a + i * 4
	mov	eax, DWORD PTR [rax]		# a[i]
	and	eax, 1						# a[i] % 2
	test	eax, eax
	jne	.L3
	cmp	DWORD PTR -36[rbp], -1
	jne	.L3
	mov	eax, DWORD PTR -40[rbp]		# i
	mov	DWORD PTR -36[rbp], eax		# firstEvenNegativeIndex = i
.L3:
	add	DWORD PTR -40[rbp], 1		# i++
.L2:
	mov	eax, DWORD PTR -52[rbp]		# argc
	sub	eax, 1						# argc - 1
	cmp	DWORD PTR -40[rbp], eax		# i < argc - 1
	jl	.L4							# goto L4 (for loop)
	cmp	DWORD PTR -36[rbp], -1
	jne	.L5
	mov	eax, DWORD PTR -52[rbp]		# argc
	sub	eax, 2						# argc - 2
	mov	DWORD PTR -36[rbp], eax		# firstEvenNegativeIndex = argc - 2
.L5:
	mov	eax, DWORD PTR -52[rbp]		# argc
	sub	eax, 1						# argc - 1
	cdqe
	sal	rax, 2						# (argc - 1) * 4
	mov	rdi, rax					
	call	malloc@PLT
	mov	QWORD PTR -24[rbp], rax		# array b
	mov	DWORD PTR -40[rbp], 0		# i
	jmp	.L6
.L7:
	mov	eax, DWORD PTR -40[rbp]		# i
	cdqe
	lea	rdx, 0[0+rax*4]				# i * 4
	mov	rax, QWORD PTR -32[rbp]		# array a
	add	rax, rdx					# a + i * 4
	mov	ecx, DWORD PTR [rax]		# a[i]
	mov	eax, DWORD PTR -36[rbp]		# firstEvenNegativeIndex
	cdqe
	lea	rdx, 0[0+rax*4]				# firstEvenNegativeIndex * 4
	mov	rax, QWORD PTR -32[rbp]		# array a
	add	rax, rdx					# a + firstEvenNegativeIndex * 4
	mov	eax, DWORD PTR [rax]		# a[firstEvenNegativeIndex]
	mov	edx, DWORD PTR -40[rbp]		# i
	movsx	rdx, edx
	lea	rsi, 0[0+rdx*4]				# i * 4
	mov	rdx, QWORD PTR -24[rbp]		# array b
	add	rdx, rsi					# b + i * 4
	imul	eax, ecx				# a[firstEvenNegativeIndex] * a[i]
	mov	DWORD PTR [rdx], eax		# b[i] = a[firstEvenNegativeIndex] * a[i]
	add	DWORD PTR -40[rbp], 1		# i++
.L6:
	mov	eax, DWORD PTR -52[rbp]		# argc
	sub	eax, 1						# argc - 1
	cmp	DWORD PTR -40[rbp], eax		# i < argc - 1
	jl	.L7
	lea	rax, .LC0[rip]				# "Output: "
	mov	rdi, rax					
	mov	eax, 0
	call	printf@PLT				# printf("Output: ")
	mov	DWORD PTR -40[rbp], 0		# i
	jmp	.L8
.L9:
	mov	eax, DWORD PTR -40[rbp]		# i
	cdqe
	lea	rdx, 0[0+rax*4]				# i * 4
	mov	rax, QWORD PTR -24[rbp]		# array b
	add	rax, rdx					# b + i * 4
	mov	eax, DWORD PTR [rax]		# b[i]
	mov	esi, eax
	lea	rax, .LC1[rip]				# "%d "
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT				# printf("%d ", b[i])
	add	DWORD PTR -40[rbp], 1		# i++
.L8:
	mov	eax, DWORD PTR -52[rbp]		# argc
	sub	eax, 1						# argc - 1
	cmp	DWORD PTR -40[rbp], eax		# i < argc - 1
	jl	.L9
	lea	rax, .LC2[rip]				# "N"
	mov	rdi, rax
	call	puts@PLT				
	mov	rax, QWORD PTR -32[rbp]		# array a
	mov	rdi, rax					
	call	free@PLT
	mov	rax, QWORD PTR -24[rbp]		# array b
	mov	rdi, rax
	call	free@PLT
	mov	eax, 0
	mov	rbx, QWORD PTR -8[rbp]
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.2.0-19ubuntu1) 11.2.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
