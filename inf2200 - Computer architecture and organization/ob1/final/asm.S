#include "asmdef.h"

DECLARE_GLOBAL(asm_function)
.global asm_function
_asm_function:

################################################################################
# name:          asm_function
# action:        mergesort
# in:            array
#
# out:			 array
# modifies:
# notes:
################################################################################
FUNC(asm_function):

	#This first section declares the three integers: i, j and k before the while loop.
	#This section declares the values of i, j and k and which registers they are set to.
	#i = -12, j = -8, k = -4
mrg2:
	.code32
	pushl	%ebp							#These three lines set up the stack frame
	movl	%esp, %ebp						#Move esp to ebp
	subl	$16, %esp						#Stack frame reserving - 16 bytes

	movl	$0, -12(%ebp)					#The value 0 is stored to the ebp -12 register. int i = 0
	movl	$0, -8(%ebp)					#The value 0 is stored to the ebp -8 register. int j = 0
	movl	28(%ebp), %eax					#The value of the ebp +28 register is stored to eax register. In other words, the value og l is set to the eax register
	movl	%eax, -4(%ebp)					#The value of the eax register is then stored as the value to ebp -4 register (int k = l)

	#If neither of the two conditions go through then it will break the loop and go to end of this script.
	#Two new addresses are identified, 8 and 12. They are n1 and n2 from the C implementation. 
START_OF_LOOP:
	movl	-12(%ebp), %eax					#move the value of -12 register to the eax register
	cmpl	8(%ebp), %eax					#compare eax < 8 ebp  (i < n1)
	jge	END									#If i is greater than n1, jump to END
	movl	-8(%ebp), %eax 					#move the value of -8 register to the eax register
	cmpl	12(%ebp), %eax					#compare eax < 12 ebp (j < n2)
	jge	END									#If j is greater than n2, jump to END

	#Here are two new registers identified, 16, 20 and 24. They are the L, R and arr arrays.
CONDITION_ONE:
	#The next 10 lines setup the L and R array with the i and j integers in order to compare them against each other.
	movl 	-12(%ebp), %eax					#Move the value of ebp -12 register to the eax register (i to eax)
	leal 	0(,%eax,4), %edx					#|||||
	movl 	16(%ebp), %eax					#Move the value of 16 ebp register to the eax register (L array to eax)
	addl 	%edx, %eax						#Add the edx register to the eax register (L[i])
	movl	(%eax), %edx					#Move the value of eax register to edx register (L[i] to edx)

	movl 	-8(%ebp), %eax					#Move the value of -8 ebp register to the eax register (j to eax)
	leal 	0(,%eax,4), %ecx 					#|||||
	movl 	20(%ebp), %eax					#Move the value of 20 ebp register to the eax register (R array to eax)
	addl 	%ecx, %eax						#Add the edx register to the eax register (R[j])
	movl	(%eax), %eax					#Move the value of eax register to eax register (R[j] to eax)

	cmpl	%eax, %edx						#Compare the eax register to edx register (L[i] <= R[j])
	jg 	CONDITION_TWO						#If eax (L[i]) is greater than, or equal to edx (R[j]) jump to CONDITION_TWO

	#This part is almost identical to CONDITION_TWO. The difference is to add the value of the L or R array to the output array
	movl	-12(%ebp), %eax					#Move the value of -12 ebp register to the eax register (i to eax)
	leal	0(,%eax,4), %edx 					#|||||
	movl	16(%ebp), %eax					#Move the value of 16 ebp register to the eax register (L array to eax)
	addl	%edx, %eax						#Add the edx register to the eax register (L[i])

	movl	-4(%ebp), %edx					#Move the value of -4 ebp register to the edx register (k to edx)
	leal	0(,%edx,4), %ecx 					#|||||
	movl	24(%ebp), %edx					#Move the value of 24 ebp register to the edx register (arr array to edx)
	addl	%ecx, %edx						#Add ecx register to edx register (arr[k] to edx)

	movl	(%eax), %eax					#Move the value og eax register to the eax register
	movl	%eax, (%edx)					#Move the eax register to the value of edx register (arr[k] = L[i])
	addl	$1, -12(%ebp)					#Add 1 to the value of -12 ebp register (i++)
	jmp	END_OF_LOOP.code32
	
	
CONDITION_TWO:	
	movl	-8(%ebp), %eax					#Move the value of -8 ebp register to the eax register (j to eax)
	leal	0(,%eax,4), %edx 					#|||||
	movl	20(%ebp), %eax					#Move the value of 20 ebp register to the eax register (R array to eax)
	addl	%edx, %eax						#Add the edx register to the eax register (R[i])

	movl	-4(%ebp), %edx					#Move the value of -4 ebp register to the edx register (k to edx)
	leal	0(,%edx,4), %ecx					#|||||
	movl	24(%ebp), %edx					#Move the value of 24 ebp register to the edx register (arr array to edx)
	addl	%ecx, %edx						#Add ecx register to edx register (arr[k] to edx)

	movl	(%eax), %eax					#Move the value og eax register to the eax register
	movl	%eax, (%edx)					#Move the eax register to the value of edx register (arr[k] = R[j])
	addl	$1, -8(%ebp)					#Add 1 to the value of -8 ebp register (j++)

	#This ends the loop and jumps to START_OF_LOOP, which then starts the loop once again.
END_OF_LOOP.code32:
	addl 	$1, -4(%ebp)					#Add 1 to the value of -4 ebp register (k++)
	jmp START_OF_LOOP

	#End of the script. This part just prepares to call mrg3 function and returns to the caller.
END:
	pushl	-4(%ebp)						#push the value og -4 ebp to the stack (k integer)
	pushl	20(%ebp)						#push the value og 20 ebp to the stack (R array)
	pushl	16(%ebp)						#push the value og 16 ebp to the stack (L array)
	pushl	24(%ebp)						#push the value og 24 ebp to the stack (arr array)
	pushl	12(%ebp)						#push the value og 12 ebp to the stack (n2 integer)
	pushl	8(%ebp)							#push the value og 8 ebp to the stack (n1 integer)
	pushl	-8(%ebp)						#push the value og -8 ebp to the stack (j integer)
	pushl	-12(%ebp)						#push the value og -12 ebp to the stack (i integer)
											#These are used to call mrg3 with (i, j, n1, n2, arr, L, R, k)
	call	mrg3							#Calls the mrg3 function

	addl	$32, %esp 						#Repositions the stack frame
	nop 									
	leave 									#End of function
	ret 									#Return to caller // leave
	.size	mrg2, .-mrg2 					
	.globl	merge 							
	.type	merge, @function 				