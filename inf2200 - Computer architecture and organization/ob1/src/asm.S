#include "asmdef.h"

DECLARE_GLOBAL(asm_function)


################################################################################
# name:          asm_function
# action:        
# in:            
#
# out:
# modifies:
# notes:
################################################################################
FUNC(asm_function):

mrg2:
	endbr32
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	call	__x86.get_pc_thunk.ax
	addl	$_GLOBAL_OFFSET_TABLE_, %eax
	movl	$0, -12(%ebp)
	movl	$0, -8(%ebp)
	movl	28(%ebp), %eax
	movl	%eax, -4(%ebp)
	jmp	.L7
.L11:
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
	jg	.L8
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
	jmp	.L9
.L8:
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
.L9:
	addl	$1, -4(%ebp)
.L7:
	movl	-12(%ebp), %eax
	cmpl	8(%ebp), %eax
	jge	.L10
	movl	-8(%ebp), %eax
	cmpl	12(%ebp), %eax
	jl	.L11
.L10:
	pushl	-4(%ebp)
	pushl	20(%ebp)
	pushl	16(%ebp)
	pushl	24(%ebp)
	pushl	12(%ebp)
	pushl	8(%ebp)
	pushl	-8(%ebp)
	pushl	-12(%ebp)
	call	mrg3
	addl	$32, %esp
	nop
	leave
	ret
	.size	mrg2, .-mrg2
	.globl	merge
	.type	merge, @function