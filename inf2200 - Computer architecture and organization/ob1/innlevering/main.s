	.file	"main.c"
	.text
	.globl	OPTION
	.bss
	.align 4
	.type	OPTION, @object
	.size	OPTION, 4
OPTION:
	.zero	4
	.text
	.globl	mrg3
	.type	mrg3, @function
mrg3:
.LFB6:
	.cfi_startproc
	endbr32
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	.cfi_offset 3, -12
	call	__x86.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
1:	call	*mcount@GOT(%ebx)
	movl	%ebx, %eax
	jmp	.L2
.L3:
	movl	8(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	28(%ebp), %eax
	addl	%edx, %eax
	movl	36(%ebp), %edx
	leal	0(,%edx,4), %ecx
	movl	24(%ebp), %edx
	addl	%ecx, %edx
	movl	(%eax), %eax
	movl	%eax, (%edx)
	addl	$1, 8(%ebp)
	addl	$1, 36(%ebp)
.L2:
	movl	8(%ebp), %eax
	cmpl	16(%ebp), %eax
	jl	.L3
	jmp	.L4
.L5:
	movl	12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	32(%ebp), %eax
	addl	%edx, %eax
	movl	36(%ebp), %edx
	leal	0(,%edx,4), %ecx
	movl	24(%ebp), %edx
	addl	%ecx, %edx
	movl	(%eax), %eax
	movl	%eax, (%edx)
	addl	$1, 12(%ebp)
	addl	$1, 36(%ebp)
.L4:
	movl	12(%ebp), %eax
	cmpl	20(%ebp), %eax
	jl	.L5
	nop
	nop
	movl	-4(%ebp), %ebx
	leave
	.cfi_restore 5
	.cfi_restore 3
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE6:
	.size	mrg3, .-mrg3
	.globl	c_function
	.type	c_function, @function
c_function:
.LFB7:
	.cfi_startproc
	endbr32
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$16, %esp
	.cfi_offset 3, -12
	call	__x86.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
1:	call	*mcount@GOT(%ebx)
	movl	%ebx, %eax
	movl	$0, -16(%ebp)
	movl	$0, -12(%ebp)
	movl	28(%ebp), %eax
	movl	%eax, -8(%ebp)
	jmp	.L7
.L11:
	movl	-16(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	16(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %edx
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %ecx
	movl	20(%ebp), %eax
	addl	%ecx, %eax
	movl	(%eax), %eax
	cmpl	%eax, %edx
	jg	.L8
	movl	-16(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	16(%ebp), %eax
	addl	%edx, %eax
	movl	-8(%ebp), %edx
	leal	0(,%edx,4), %ecx
	movl	24(%ebp), %edx
	addl	%ecx, %edx
	movl	(%eax), %eax
	movl	%eax, (%edx)
	addl	$1, -16(%ebp)
	jmp	.L9
.L8:
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	20(%ebp), %eax
	addl	%edx, %eax
	movl	-8(%ebp), %edx
	leal	0(,%edx,4), %ecx
	movl	24(%ebp), %edx
	addl	%ecx, %edx
	movl	(%eax), %eax
	movl	%eax, (%edx)
	addl	$1, -12(%ebp)
.L9:
	addl	$1, -8(%ebp)
.L7:
	movl	-16(%ebp), %eax
	cmpl	8(%ebp), %eax
	jge	.L10
	movl	-12(%ebp), %eax
	cmpl	12(%ebp), %eax
	jl	.L11
.L10:
	pushl	-8(%ebp)
	pushl	20(%ebp)
	pushl	16(%ebp)
	pushl	24(%ebp)
	pushl	12(%ebp)
	pushl	8(%ebp)
	pushl	-12(%ebp)
	pushl	-16(%ebp)
	call	mrg3
	addl	$32, %esp
	nop
	movl	-4(%ebp), %ebx
	leave
	.cfi_restore 5
	.cfi_restore 3
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE7:
	.size	c_function, .-c_function
	.globl	merge
	.type	merge, @function
merge:
.LFB8:
	.cfi_startproc
	endbr32
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%esi
	pushl	%ebx
	subl	$64, %esp
	.cfi_offset 6, -12
	.cfi_offset 3, -16
	call	__x86.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
1:	call	*mcount@GOT(%ebx)
	movl	%ebx, %ecx
	movl	8(%ebp), %eax
	movl	%eax, -60(%ebp)
	movl	%gs:20, %eax
	movl	%eax, -12(%ebp)
	xorl	%eax, %eax
	movl	%esp, %eax
	movl	%eax, %esi
	movl	16(%ebp), %eax
	subl	12(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -36(%ebp)
	movl	20(%ebp), %eax
	subl	16(%ebp), %eax
	movl	%eax, -32(%ebp)
	movl	-36(%ebp), %eax
	leal	-1(%eax), %edx
	movl	%edx, -28(%ebp)
	leal	0(,%eax,4), %edx
	movl	$16, %eax
	subl	$1, %eax
	addl	%edx, %eax
	movl	$16, %ebx
	movl	$0, %edx
	divl	%ebx
	imull	$16, %eax, %eax
	movl	%eax, %ebx
	andl	$-4096, %ebx
	movl	%esp, %edx
	subl	%ebx, %edx
.L13:
	cmpl	%edx, %esp
	je	.L14
	subl	$4096, %esp
	orl	$0, 4092(%esp)
	jmp	.L13
.L14:
	movl	%eax, %edx
	andl	$4095, %edx
	subl	%edx, %esp
	movl	%eax, %edx
	andl	$4095, %edx
	testl	%edx, %edx
	je	.L15
	andl	$4095, %eax
	subl	$4, %eax
	addl	%esp, %eax
	orl	$0, (%eax)
.L15:
	movl	%esp, %eax
	addl	$3, %eax
	shrl	$2, %eax
	sall	$2, %eax
	movl	%eax, -24(%ebp)
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	%edx, -20(%ebp)
	leal	0(,%eax,4), %edx
	movl	$16, %eax
	subl	$1, %eax
	addl	%edx, %eax
	movl	$16, %ebx
	movl	$0, %edx
	divl	%ebx
	imull	$16, %eax, %eax
	movl	%eax, %ebx
	andl	$-4096, %ebx
	movl	%esp, %edx
	subl	%ebx, %edx
.L16:
	cmpl	%edx, %esp
	je	.L17
	subl	$4096, %esp
	orl	$0, 4092(%esp)
	jmp	.L16
.L17:
	movl	%eax, %edx
	andl	$4095, %edx
	subl	%edx, %esp
	movl	%eax, %edx
	andl	$4095, %edx
	testl	%edx, %edx
	je	.L18
	andl	$4095, %eax
	subl	$4, %eax
	addl	%esp, %eax
	orl	$0, (%eax)
.L18:
	movl	%esp, %eax
	addl	$3, %eax
	shrl	$2, %eax
	sall	$2, %eax
	movl	%eax, -16(%ebp)
	movl	$0, -40(%ebp)
	jmp	.L19
.L20:
	movl	12(%ebp), %edx
	movl	-40(%ebp), %eax
	addl	%edx, %eax
	leal	0(,%eax,4), %edx
	movl	-60(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %ebx
	movl	-24(%ebp), %eax
	movl	-40(%ebp), %edx
	movl	%ebx, (%eax,%edx,4)
	addl	$1, -40(%ebp)
.L19:
	movl	-40(%ebp), %eax
	cmpl	-36(%ebp), %eax
	jl	.L20
	movl	$0, -44(%ebp)
	jmp	.L21
.L22:
	movl	16(%ebp), %eax
	leal	1(%eax), %edx
	movl	-44(%ebp), %eax
	addl	%edx, %eax
	leal	0(,%eax,4), %edx
	movl	-60(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %ebx
	movl	-16(%ebp), %eax
	movl	-44(%ebp), %edx
	movl	%ebx, (%eax,%edx,4)
	addl	$1, -44(%ebp)
.L21:
	movl	-44(%ebp), %eax
	cmpl	-32(%ebp), %eax
	jl	.L22
	movl	OPTION@GOTOFF(%ecx), %eax
	cmpl	$1, %eax
	jne	.L23
	subl	$8, %esp
	pushl	12(%ebp)
	pushl	-60(%ebp)
	pushl	-16(%ebp)
	pushl	-24(%ebp)
	pushl	-32(%ebp)
	pushl	-36(%ebp)
	movl	%ecx, %ebx
	call	asm_function@PLT
	addl	$32, %esp
	jmp	.L24
.L23:
	movl	OPTION@GOTOFF(%ecx), %eax
	cmpl	$2, %eax
	jne	.L24
	subl	$8, %esp
	pushl	12(%ebp)
	pushl	-60(%ebp)
	pushl	-16(%ebp)
	pushl	-24(%ebp)
	pushl	-32(%ebp)
	pushl	-36(%ebp)
	call	c_function
	addl	$32, %esp
.L24:
	movl	%esi, %esp
	nop
	movl	-12(%ebp), %eax
	subl	%gs:20, %eax
	je	.L25
	call	__stack_chk_fail_local
.L25:
	leal	-8(%ebp), %esp
	popl	%ebx
	.cfi_restore 3
	popl	%esi
	.cfi_restore 6
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE8:
	.size	merge, .-merge
	.globl	mergeSort
	.type	mergeSort, @function
mergeSort:
.LFB9:
	.cfi_startproc
	endbr32
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$20, %esp
	.cfi_offset 3, -12
	call	__x86.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
1:	call	*mcount@GOT(%ebx)
	movl	%ebx, %eax
	movl	12(%ebp), %eax
	cmpl	16(%ebp), %eax
	jge	.L28
	movl	16(%ebp), %eax
	subl	12(%ebp), %eax
	movl	%eax, %edx
	shrl	$31, %edx
	addl	%edx, %eax
	sarl	%eax
	movl	%eax, %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	movl	%eax, -12(%ebp)
	subl	$4, %esp
	pushl	-12(%ebp)
	pushl	12(%ebp)
	pushl	8(%ebp)
	call	mergeSort
	addl	$16, %esp
	movl	-12(%ebp), %eax
	addl	$1, %eax
	subl	$4, %esp
	pushl	16(%ebp)
	pushl	%eax
	pushl	8(%ebp)
	call	mergeSort
	addl	$16, %esp
	pushl	16(%ebp)
	pushl	-12(%ebp)
	pushl	12(%ebp)
	pushl	8(%ebp)
	call	merge
	addl	$16, %esp
.L28:
	nop
	movl	-4(%ebp), %ebx
	leave
	.cfi_restore 5
	.cfi_restore 3
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE9:
	.size	mergeSort, .-mergeSort
	.section	.rodata
.LC0:
	.string	"%d "
	.text
	.globl	printArray
	.type	printArray, @function
printArray:
.LFB10:
	.cfi_startproc
	endbr32
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$20, %esp
	.cfi_offset 3, -12
	call	__x86.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
1:	call	*mcount@GOT(%ebx)
	movl	$0, -12(%ebp)
	jmp	.L30
.L31:
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	subl	$8, %esp
	pushl	%eax
	leal	.LC0@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printf@PLT
	addl	$16, %esp
	addl	$1, -12(%ebp)
.L30:
	movl	-12(%ebp), %eax
	cmpl	12(%ebp), %eax
	jl	.L31
	subl	$12, %esp
	pushl	$10
	call	putchar@PLT
	addl	$16, %esp
	nop
	movl	-4(%ebp), %ebx
	leave
	.cfi_restore 5
	.cfi_restore 3
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE10:
	.size	printArray, .-printArray
	.globl	CreateArray
	.type	CreateArray, @function
CreateArray:
.LFB11:
	.cfi_startproc
	endbr32
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%esi
	pushl	%ebx
	subl	$16, %esp
	.cfi_offset 6, -12
	.cfi_offset 3, -16
	call	__x86.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
1:	call	*mcount@GOT(%ebx)
	movl	$0, -12(%ebp)
	jmp	.L33
.L34:
	call	rand@PLT
	movl	%eax, %ecx
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	8(%ebp), %eax
	leal	(%edx,%eax), %esi
	movl	$1125899907, %edx
	movl	%ecx, %eax
	imull	%edx
	movl	%edx, %eax
	sarl	$19, %eax
	movl	%ecx, %edx
	sarl	$31, %edx
	subl	%edx, %eax
	imull	$2000000, %eax, %edx
	movl	%ecx, %eax
	subl	%edx, %eax
	movl	%eax, (%esi)
	addl	$1, -12(%ebp)
.L33:
	movl	-12(%ebp), %eax
	cmpl	12(%ebp), %eax
	jl	.L34
	nop
	nop
	addl	$16, %esp
	popl	%ebx
	.cfi_restore 3
	popl	%esi
	.cfi_restore 6
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE11:
	.size	CreateArray, .-CreateArray
	.section	.rodata
.LC1:
	.string	"Usage: %s assembly or %s c\n"
.LC2:
	.string	"assembly"
.LC3:
	.string	"c"
.LC4:
	.string	"No valid option picked!"
.LC5:
	.string	"Given array is "
.LC6:
	.string	"\n\nSorted array is "
	.text
	.globl	main
	.type	main, @function
main:
.LFB12:
	.cfi_startproc
	endbr32
	leal	4(%esp), %ecx
	.cfi_def_cfa 1, 0
	andl	$-16, %esp
	pushl	-4(%ecx)
	pushl	%ebp
	movl	%esp, %ebp
	.cfi_escape 0x10,0x5,0x2,0x75,0
	pushl	%esi
	pushl	%ebx
	pushl	%ecx
	.cfi_escape 0xf,0x3,0x75,0x74,0x6
	.cfi_escape 0x10,0x6,0x2,0x75,0x7c
	.cfi_escape 0x10,0x3,0x2,0x75,0x78
	subl	$60, %esp
	call	__x86.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
1:	call	*mcount@GOT(%ebx)
	movl	%ecx, %eax
	movl	4(%eax), %edx
	movl	%edx, -60(%ebp)
	movl	%gs:20, %esi
	movl	%esi, -28(%ebp)
	xorl	%esi, %esi
	movl	%esp, %edx
	movl	%edx, %esi
	cmpl	$2, (%eax)
	je	.L36
	movl	-60(%ebp), %eax
	movl	(%eax), %edx
	movl	-60(%ebp), %eax
	movl	(%eax), %eax
	subl	$4, %esp
	pushl	%edx
	pushl	%eax
	leal	.LC1@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printf@PLT
	addl	$16, %esp
	movl	$1, %eax
	jmp	.L37
.L36:
	leal	.LC2@GOTOFF(%ebx), %eax
	movl	%eax, -52(%ebp)
	leal	.LC3@GOTOFF(%ebx), %eax
	movl	%eax, -48(%ebp)
	movl	-60(%ebp), %eax
	movl	4(%eax), %eax
	movl	%eax, -44(%ebp)
	subl	$8, %esp
	pushl	-52(%ebp)
	pushl	-44(%ebp)
	call	strcmp@PLT
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L38
	movl	$1, OPTION@GOTOFF(%ebx)
	jmp	.L39
.L38:
	subl	$8, %esp
	pushl	-48(%ebp)
	pushl	-44(%ebp)
	call	strcmp@PLT
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L40
	movl	$2, OPTION@GOTOFF(%ebx)
	jmp	.L39
.L40:
	subl	$12, %esp
	leal	.LC4@GOTOFF(%ebx), %eax
	pushl	%eax
	call	puts@PLT
	addl	$16, %esp
	movl	$1, %eax
	jmp	.L37
.L39:
	movl	$1000000, -40(%ebp)
	movl	-40(%ebp), %eax
	leal	-1(%eax), %edx
	movl	%edx, -36(%ebp)
	leal	0(,%eax,4), %edx
	movl	$16, %eax
	subl	$1, %eax
	addl	%edx, %eax
	movl	$16, %ecx
	movl	$0, %edx
	divl	%ecx
	imull	$16, %eax, %eax
	movl	%eax, %ecx
	andl	$-4096, %ecx
	movl	%esp, %edx
	subl	%ecx, %edx
.L41:
	cmpl	%edx, %esp
	je	.L42
	subl	$4096, %esp
	orl	$0, 4092(%esp)
	jmp	.L41
.L42:
	movl	%eax, %edx
	andl	$4095, %edx
	subl	%edx, %esp
	movl	%eax, %edx
	andl	$4095, %edx
	testl	%edx, %edx
	je	.L43
	andl	$4095, %eax
	subl	$4, %eax
	addl	%esp, %eax
	orl	$0, (%eax)
.L43:
	movl	%esp, %eax
	addl	$3, %eax
	shrl	$2, %eax
	sall	$2, %eax
	movl	%eax, -32(%ebp)
	movl	$5, -56(%ebp)
	jmp	.L44
.L45:
	subl	$12, %esp
	leal	.LC5@GOTOFF(%ebx), %eax
	pushl	%eax
	call	puts@PLT
	addl	$16, %esp
	subl	$8, %esp
	pushl	-40(%ebp)
	pushl	-32(%ebp)
	call	CreateArray
	addl	$16, %esp
	subl	$8, %esp
	pushl	-40(%ebp)
	pushl	-32(%ebp)
	call	printArray
	addl	$16, %esp
	movl	-40(%ebp), %eax
	subl	$1, %eax
	subl	$4, %esp
	pushl	%eax
	pushl	$0
	pushl	-32(%ebp)
	call	mergeSort
	addl	$16, %esp
	subl	$12, %esp
	leal	.LC6@GOTOFF(%ebx), %eax
	pushl	%eax
	call	puts@PLT
	addl	$16, %esp
	subl	$8, %esp
	pushl	-40(%ebp)
	pushl	-32(%ebp)
	call	printArray
	addl	$16, %esp
	subl	$1, -56(%ebp)
.L44:
	cmpl	$0, -56(%ebp)
	jne	.L45
	movl	$0, %eax
.L37:
	movl	%esi, %esp
	movl	-28(%ebp), %esi
	subl	%gs:20, %esi
	je	.L47
	call	__stack_chk_fail_local
.L47:
	leal	-12(%ebp), %esp
	popl	%ecx
	.cfi_restore 1
	.cfi_def_cfa 1, 0
	popl	%ebx
	.cfi_restore 3
	popl	%esi
	.cfi_restore 6
	popl	%ebp
	.cfi_restore 5
	leal	-4(%ecx), %esp
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE12:
	.size	main, .-main
	.section	.text.__x86.get_pc_thunk.bx,"axG",@progbits,__x86.get_pc_thunk.bx,comdat
	.globl	__x86.get_pc_thunk.bx
	.hidden	__x86.get_pc_thunk.bx
	.type	__x86.get_pc_thunk.bx, @function
__x86.get_pc_thunk.bx:
.LFB13:
	.cfi_startproc
	movl	(%esp), %ebx
	ret
	.cfi_endproc
.LFE13:
	.hidden	__stack_chk_fail_local
	.ident	"GCC: (Ubuntu 10.3.0-1ubuntu1~20.10) 10.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 4
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 4
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 4
4:
