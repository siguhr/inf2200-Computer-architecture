	.file	"main.c"
	.text
	.globl	OPTION
	.bss
	.align 4
	.type	OPTION, @object
	.size	OPTION, 4
OPTION:
	.zero	4
	.globl	TIME
	.align 8
	.type	TIME, @object
	.size	TIME, 8
TIME:
	.zero	8
	.globl	tv1
	.align 4
	.type	tv1, @object
	.size	tv1, 8
tv1:
	.zero	8
	.globl	tv2
	.align 4
	.type	tv2, @object
	.size	tv2, 8
tv2:
	.zero	8
	.text
	.globl	c_function
	.type	c_function, @function
c_function:
.LFB6:
	.cfi_startproc
	endbr32
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$16, %esp
	call	__x86.get_pc_thunk.ax
	addl	$_GLOBAL_OFFSET_TABLE_, %eax
	movl	$0, -12(%ebp)
	movl	$0, -8(%ebp)
	movl	28(%ebp), %eax
	movl	%eax, -4(%ebp)
	jmp	.L2
.L6:
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	16(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %edx
	movl	-8(%ebp), %eax
	leal	0(,%eax,4), %ecx
	movl	20(%ebp), %eax
	addl	%ecx, %eax
	movl	(%eax), %eax
	cmpl	%eax, %edx
	jg	.L3
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	16(%ebp), %eax
	addl	%edx, %eax
	movl	-4(%ebp), %edx
	leal	0(,%edx,4), %ecx
	movl	24(%ebp), %edx
	addl	%ecx, %edx
	movl	(%eax), %eax
	movl	%eax, (%edx)
	addl	$1, -12(%ebp)
	jmp	.L4
.L3:
	movl	-8(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	20(%ebp), %eax
	addl	%edx, %eax
	movl	-4(%ebp), %edx
	leal	0(,%edx,4), %ecx
	movl	24(%ebp), %edx
	addl	%ecx, %edx
	movl	(%eax), %eax
	movl	%eax, (%edx)
	addl	$1, -8(%ebp)
.L4:
	addl	$1, -4(%ebp)
.L2:
	movl	-12(%ebp), %eax
	cmpl	8(%ebp), %eax
	jge	.L7
	movl	-8(%ebp), %eax
	cmpl	12(%ebp), %eax
	jl	.L6
	jmp	.L7
.L8:
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	16(%ebp), %eax
	addl	%edx, %eax
	movl	-4(%ebp), %edx
	leal	0(,%edx,4), %ecx
	movl	24(%ebp), %edx
	addl	%ecx, %edx
	movl	(%eax), %eax
	movl	%eax, (%edx)
	addl	$1, -12(%ebp)
	addl	$1, -4(%ebp)
.L7:
	movl	-12(%ebp), %eax
	cmpl	8(%ebp), %eax
	jl	.L8
	jmp	.L9
.L10:
	movl	-8(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	20(%ebp), %eax
	addl	%edx, %eax
	movl	-4(%ebp), %edx
	leal	0(,%edx,4), %ecx
	movl	24(%ebp), %edx
	addl	%ecx, %edx
	movl	(%eax), %eax
	movl	%eax, (%edx)
	addl	$1, -8(%ebp)
	addl	$1, -4(%ebp)
.L9:
	movl	-8(%ebp), %eax
	cmpl	12(%ebp), %eax
	jl	.L10
	nop
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE6:
	.size	c_function, .-c_function
	.globl	merge
	.type	merge, @function
merge:
.LFB7:
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
	movl	$16, %ecx
	movl	$0, %edx
	divl	%ecx
	imull	$16, %eax, %eax
	movl	%eax, %ecx
	andl	$-4096, %ecx
	movl	%esp, %edx
	subl	%ecx, %edx
.L12:
	cmpl	%edx, %esp
	je	.L13
	subl	$4096, %esp
	orl	$0, 4092(%esp)
	jmp	.L12
.L13:
	movl	%eax, %edx
	andl	$4095, %edx
	subl	%edx, %esp
	movl	%eax, %edx
	andl	$4095, %edx
	testl	%edx, %edx
	je	.L14
	andl	$4095, %eax
	subl	$4, %eax
	addl	%esp, %eax
	orl	$0, (%eax)
.L14:
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
	movl	$16, %ecx
	movl	$0, %edx
	divl	%ecx
	imull	$16, %eax, %eax
	movl	%eax, %ecx
	andl	$-4096, %ecx
	movl	%esp, %edx
	subl	%ecx, %edx
.L15:
	cmpl	%edx, %esp
	je	.L16
	subl	$4096, %esp
	orl	$0, 4092(%esp)
	jmp	.L15
.L16:
	movl	%eax, %edx
	andl	$4095, %edx
	subl	%edx, %esp
	movl	%eax, %edx
	andl	$4095, %edx
	testl	%edx, %edx
	je	.L17
	andl	$4095, %eax
	subl	$4, %eax
	addl	%esp, %eax
	orl	$0, (%eax)
.L17:
	movl	%esp, %eax
	addl	$3, %eax
	shrl	$2, %eax
	sall	$2, %eax
	movl	%eax, -16(%ebp)
	movl	$0, -40(%ebp)
	jmp	.L18
.L19:
	movl	12(%ebp), %edx
	movl	-40(%ebp), %eax
	addl	%edx, %eax
	leal	0(,%eax,4), %edx
	movl	-60(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %ecx
	movl	-24(%ebp), %eax
	movl	-40(%ebp), %edx
	movl	%ecx, (%eax,%edx,4)
	addl	$1, -40(%ebp)
.L18:
	movl	-40(%ebp), %eax
	cmpl	-36(%ebp), %eax
	jl	.L19
	movl	$0, -44(%ebp)
	jmp	.L20
.L21:
	movl	16(%ebp), %eax
	leal	1(%eax), %edx
	movl	-44(%ebp), %eax
	addl	%edx, %eax
	leal	0(,%eax,4), %edx
	movl	-60(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %ecx
	movl	-16(%ebp), %eax
	movl	-44(%ebp), %edx
	movl	%ecx, (%eax,%edx,4)
	addl	$1, -44(%ebp)
.L20:
	movl	-44(%ebp), %eax
	cmpl	-32(%ebp), %eax
	jl	.L21
	subl	$8, %esp
	pushl	$0
	leal	tv1@GOTOFF(%ebx), %eax
	pushl	%eax
	call	gettimeofday@PLT
	addl	$16, %esp
	movl	OPTION@GOTOFF(%ebx), %eax
	cmpl	$1, %eax
	jne	.L22
	subl	$8, %esp
	pushl	12(%ebp)
	pushl	-60(%ebp)
	pushl	-16(%ebp)
	pushl	-24(%ebp)
	pushl	-32(%ebp)
	pushl	-36(%ebp)
	call	asm_function@PLT
	addl	$32, %esp
	jmp	.L23
.L22:
	movl	OPTION@GOTOFF(%ebx), %eax
	cmpl	$2, %eax
	jne	.L23
	subl	$8, %esp
	pushl	12(%ebp)
	pushl	-60(%ebp)
	pushl	-16(%ebp)
	pushl	-24(%ebp)
	pushl	-32(%ebp)
	pushl	-36(%ebp)
	call	c_function
	addl	$32, %esp
.L23:
	subl	$8, %esp
	pushl	$0
	leal	tv2@GOTOFF(%ebx), %eax
	pushl	%eax
	call	gettimeofday@PLT
	addl	$16, %esp
	movl	4+tv2@GOTOFF(%ebx), %eax
	movl	4+tv1@GOTOFF(%ebx), %edx
	subl	%edx, %eax
	movl	%eax, -64(%ebp)
	fildl	-64(%ebp)
	fldl	.LC0@GOTOFF(%ebx)
	fdivrp	%st, %st(1)
	movl	tv2@GOTOFF(%ebx), %eax
	movl	tv1@GOTOFF(%ebx), %edx
	subl	%edx, %eax
	movl	%eax, -64(%ebp)
	fildl	-64(%ebp)
	faddp	%st, %st(1)
	fldl	TIME@GOTOFF(%ebx)
	faddp	%st, %st(1)
	fstpl	TIME@GOTOFF(%ebx)
	movl	%esi, %esp
	nop
	movl	-12(%ebp), %eax
	subl	%gs:20, %eax
	je	.L24
	call	__stack_chk_fail_local
.L24:
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
.LFE7:
	.size	merge, .-merge
	.globl	mergeSort
	.type	mergeSort, @function
mergeSort:
.LFB8:
	.cfi_startproc
	endbr32
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	call	__x86.get_pc_thunk.ax
	addl	$_GLOBAL_OFFSET_TABLE_, %eax
	movl	12(%ebp), %eax
	cmpl	16(%ebp), %eax
	jge	.L27
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
.L27:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE8:
	.size	mergeSort, .-mergeSort
	.section	.rodata
.LC1:
	.string	"%d "
	.text
	.globl	printArray
	.type	printArray, @function
printArray:
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
	movl	$0, -12(%ebp)
	jmp	.L29
.L30:
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	subl	$8, %esp
	pushl	%eax
	leal	.LC1@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printf@PLT
	addl	$16, %esp
	addl	$1, -12(%ebp)
.L29:
	movl	-12(%ebp), %eax
	cmpl	12(%ebp), %eax
	jl	.L30
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
.LFE9:
	.size	printArray, .-printArray
	.globl	CreateArray
	.type	CreateArray, @function
CreateArray:
.LFB10:
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
	call	__x86.get_pc_thunk.si
	addl	$_GLOBAL_OFFSET_TABLE_, %esi
	movl	$0, -12(%ebp)
	jmp	.L32
.L33:
	movl	%esi, %ebx
	call	rand@PLT
	movl	%eax, %ecx
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	8(%ebp), %eax
	leal	(%edx,%eax), %ebx
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
	movl	%eax, (%ebx)
	addl	$1, -12(%ebp)
.L32:
	movl	-12(%ebp), %eax
	cmpl	12(%ebp), %eax
	jl	.L33
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
.LFE10:
	.size	CreateArray, .-CreateArray
	.section	.rodata
.LC2:
	.string	"Usage: %s assembly or %s c\n"
.LC3:
	.string	"assembly"
.LC4:
	.string	"c"
.LC5:
	.string	"No valid option picked!"
.LC6:
	.string	"%lf\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB11:
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
	movl	%ecx, %eax
	movl	4(%eax), %edx
	movl	%edx, -60(%ebp)
	movl	%gs:20, %esi
	movl	%esi, -28(%ebp)
	xorl	%esi, %esi
	movl	%esp, %edx
	movl	%edx, %esi
	cmpl	$2, (%eax)
	je	.L35
	movl	-60(%ebp), %eax
	movl	(%eax), %edx
	movl	-60(%ebp), %eax
	movl	(%eax), %eax
	subl	$4, %esp
	pushl	%edx
	pushl	%eax
	leal	.LC2@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printf@PLT
	addl	$16, %esp
	movl	$1, %eax
	jmp	.L36
.L35:
	leal	.LC3@GOTOFF(%ebx), %eax
	movl	%eax, -52(%ebp)
	leal	.LC4@GOTOFF(%ebx), %eax
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
	jne	.L37
	movl	$1, OPTION@GOTOFF(%ebx)
	jmp	.L38
.L37:
	subl	$8, %esp
	pushl	-48(%ebp)
	pushl	-44(%ebp)
	call	strcmp@PLT
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L39
	movl	$2, OPTION@GOTOFF(%ebx)
	jmp	.L38
.L39:
	subl	$12, %esp
	leal	.LC5@GOTOFF(%ebx), %eax
	pushl	%eax
	call	puts@PLT
	addl	$16, %esp
	movl	$1, %eax
	jmp	.L36
.L38:
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
.L40:
	cmpl	%edx, %esp
	je	.L41
	subl	$4096, %esp
	orl	$0, 4092(%esp)
	jmp	.L40
.L41:
	movl	%eax, %edx
	andl	$4095, %edx
	subl	%edx, %esp
	movl	%eax, %edx
	andl	$4095, %edx
	testl	%edx, %edx
	je	.L42
	andl	$4095, %eax
	subl	$4, %eax
	addl	%esp, %eax
	orl	$0, (%eax)
.L42:
	movl	%esp, %eax
	addl	$3, %eax
	shrl	$2, %eax
	sall	$2, %eax
	movl	%eax, -32(%ebp)
	movl	$100, -56(%ebp)
	jmp	.L43
.L44:
	subl	$8, %esp
	pushl	-40(%ebp)
	pushl	-32(%ebp)
	call	CreateArray
	addl	$16, %esp
	movl	-40(%ebp), %eax
	subl	$1, %eax
	subl	$4, %esp
	pushl	%eax
	pushl	$0
	pushl	-32(%ebp)
	call	mergeSort
	addl	$16, %esp
	subl	$1, -56(%ebp)
.L43:
	cmpl	$0, -56(%ebp)
	jne	.L44
	fldl	TIME@GOTOFF(%ebx)
	subl	$4, %esp
	leal	-8(%esp), %esp
	fstpl	(%esp)
	leal	.LC6@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printf@PLT
	addl	$16, %esp
	movl	$0, %eax
.L36:
	movl	%esi, %esp
	movl	-28(%ebp), %esi
	subl	%gs:20, %esi
	je	.L46
	call	__stack_chk_fail_local
.L46:
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
.LFE11:
	.size	main, .-main
	.section	.rodata
	.align 8
.LC0:
	.long	0
	.long	1093567616
	.section	.text.__x86.get_pc_thunk.ax,"axG",@progbits,__x86.get_pc_thunk.ax,comdat
	.globl	__x86.get_pc_thunk.ax
	.hidden	__x86.get_pc_thunk.ax
	.type	__x86.get_pc_thunk.ax, @function
__x86.get_pc_thunk.ax:
.LFB12:
	.cfi_startproc
	movl	(%esp), %eax
	ret
	.cfi_endproc
.LFE12:
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
	.section	.text.__x86.get_pc_thunk.si,"axG",@progbits,__x86.get_pc_thunk.si,comdat
	.globl	__x86.get_pc_thunk.si
	.hidden	__x86.get_pc_thunk.si
	.type	__x86.get_pc_thunk.si, @function
__x86.get_pc_thunk.si:
.LFB14:
	.cfi_startproc
	movl	(%esp), %esi
	ret
	.cfi_endproc
.LFE14:
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
