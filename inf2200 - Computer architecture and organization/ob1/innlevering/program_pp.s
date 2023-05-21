# 1 "asm.S"
# 1 "<built-in>"
# 1 "<command-line>"
# 31 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 32 "<command-line>" 2
# 1 "asm.S"
# 1 "asmdef.h" 1
# 2 "asm.S" 2

.globl asm_function; .type asm_function, @function
.global asm_function
_asm_function:

################################################################################
# name: asm_function
# action: mergesort
# in: array

# out: array
# modifies:
# notes:
################################################################################
asm_function:

 #This first section declares the three integers: i, j and k before the while loop.
 #This section declares the values of i, j and k and which registers they are set to.
 #i = -12, j = -8, k = -4
mrg2:
 .code32
 pushl %ebp #|
 movl %esp, %ebp #|
 subl $16, %esp #|

 movl $0, -12(%ebp) #The value 0 is moved to the -12 ebp register. int i = 0
 movl $0, -8(%ebp) #The value 0 is moved to the -8 ebp register. int j = 0
 movl 28(%ebp), %eax #The value of the 28 ebp register is moved to eax register. In other words, the value og l is set to the eax register
 movl %eax, -4(%ebp) #The eax register is then moved as the value to -4 ebp register (int k = l)
 jmp START_OF_LOOP

 #Here are two new registers identified, 16, 20 and 24. They are the L, R and arr arrays.
CONDITION_ONE:
 movl -12(%ebp), %eax #Move the value of -12 ebp register to the eax register (i to eax)
 leal 0(,%eax,4), %edx #|||||
 movl 16(%ebp), %eax #Move the value of 16 ebp register to the eax register (L array to eax)
 addl %edx, %eax #Add the edx register to the eax register (L[i])
 movl (%eax), %edx #Move the value of eax register to edx register (L[i] to edx)

 movl -8(%ebp), %eax #Move the value of -8 ebp register to the eax register (j to eax)
 leal 0(,%eax,4), %ecx #|||||
 movl 20(%ebp), %eax #Move the value of 20 ebp register to the eax register (R array to eax)
 addl %ecx, %eax #Add the edx register to the eax register (R[j])
 movl (%eax), %eax #Move the value of eax register to eax register (R[j] to eax)

 cmpl %eax, %edx #Compare the eax register to edx register (L[i] <= R[j])
 jg CONDITION_TWO #If eax (L[i]) is greater than, or equal to edx (R[j]) jump to CONDITION_TWO

 movl -12(%ebp), %eax #Move the value of -12 ebp register to the eax register (i to eax)
 leal 0(,%eax,4), %edx #|||||
 movl 16(%ebp), %eax #Move the value of 16 ebp register to the eax register (L array to eax)
 addl %edx, %eax #Add the edx register to the eax register (L[i])

 movl -4(%ebp), %edx #Move the value of -4 ebp register to the edx register (k to edx)
 leal 0(,%edx,4), %ecx #|||||
 movl 24(%ebp), %edx #Move the value of 24 ebp register to the edx register (arr array to edx)
 addl %ecx, %edx #Add ecx register to edx register (arr[k] to edx)

 movl (%eax), %eax #Move the value og eax register to the eax register
 movl %eax, (%edx) #Move the eax register to the value of edx register (arr[k] = L[i])
 addl $1, -12(%ebp) #Add 1 to the value of -12 ebp register (i++)
 jmp END_OF_LOOP.code32


CONDITION_TWO:
 movl -8(%ebp), %eax #Move the value of -8 ebp register to the eax register (j to eax)
 leal 0(,%eax,4), %edx #|||||
 movl 20(%ebp), %eax #Move the value of 20 ebp register to the eax register (R array to eax)
 addl %edx, %eax #Add the edx register to the eax register (R[i])

 movl -4(%ebp), %edx #Move the value of -4 ebp register to the edx register (k to edx)
 leal 0(,%edx,4), %ecx #|||||
 movl 24(%ebp), %edx #Move the value of 24 ebp register to the edx register (arr array to edx)
 addl %ecx, %edx #Add ecx register to edx register (arr[k] to edx)

 movl (%eax), %eax #Move the value og eax register to the eax register
 movl %eax, (%edx) #Move the eax register to the value of edx register (arr[k] = R[j])
 addl $1, -8(%ebp) #Add 1 to the value of -8 ebp register (j++)

 #This ends the loop and jumps to the section below, which then starts the loop once again.
END_OF_LOOP.code32:
 addl $1, -4(%ebp) #Add 1 to the value of -4 ebp register (k++)

 #Reason start of loop is at the end is because of the double condition with AND bool operator.
 #If neither of the two conditions go through then it will end the loop, and to do so the program just keeps going to the END section just below.
 #Two new addresses are identified, 8 and 12. They are n1 and n2 from the C implementation.
START_OF_LOOP:
 movl -12(%ebp), %eax #move the value of -12 register to the eax register
 cmpl 8(%ebp), %eax #compare eax < 8 ebp (i < n1)
 jge END #If i is larger than n1, jump to END
 movl -8(%ebp), %eax #move the value of -8 register to the eax register
 cmpl 12(%ebp), %eax #compare eax < 12 ebp (j < n2)
 jl CONDITION_ONE #If j is less than n2, jump to CONDITION_ONE

END:
 pushl -4(%ebp) #push the value og -4 ebp to the stack (k integer)
 pushl 20(%ebp) #push the value og 20 ebp to the stack (R array)
 pushl 16(%ebp) #push the value og 16 ebp to the stack (L array)
 pushl 24(%ebp) #push the value og 24 ebp to the stack (arr array)
 pushl 12(%ebp) #push the value og 12 ebp to the stack (n2 integer)
 pushl 8(%ebp) #push the value og 8 ebp to the stack (n1 integer)
 pushl -8(%ebp) #push the value og -8 ebp to the stack (j integer)
 pushl -12(%ebp) #push the value og -12 ebp to the stack (i integer)
           #These are used to call mrg3 with (i, j, n1, n2, arr, L, R, k)
 call mrg3 #Calls the mrg3 function
 addl $32, %esp #|||||
 nop #|||||
 leave #End of function
 ret #Return
 .size mrg2, .-mrg2 #|||||
 .globl merge #|||||
 .type merge, @function #Why is this important?
