# ------------------------------------------------
# CDA3101 Programming Assignment 1
# Artem Iryshkov UFID 2618-1472
# 09/16/15
# ------------------------------------------------
#
# MIPS Integer palindrome check program ----------
#
# ------------------------------------------------
# li - load immediate int
# la - used to load the string messages for print
# move - used to save the inputs from the user
# div - divide
# mult - multiply
# j - jump to a function
# jr - jump register
# jr $ra - jump to register of last function
# ------------------------------------------------
# Registers used:
#       t0 - user input 'num' from C++ code
#       t1 - variable 'temp' from C++ code
#       t2 - variable 'reverse' from C++ code
#
#       t4 - the integer 10
#       t6 - temp variable for multiples/quotients/remainders
# ------------------------------------------------

.data

# Console printed welcome messages
init_msg1: .asciiz "Programming assignment 1 for CDA3101\n"
init_msg2: .asciiz "This palindrome checker only deals with positive integer number.\n"

# Console printed prompt for input
prompt_msg: .asciiz "Enter a number to check if it is a palindrome or not: "

# Console printed message for results
pal_msg: .asciiz " is a palindrome number.\n\n"
notpal_msg: .asciiz " is not a palindrome number.\n\n"

.text

main:

    # Print out welcome messages

    la $a0, init_msg1   # load the first welcome message into a0
    li $v0, 4           # load the print_string function into v0
    syscall             # tell the system to print the message

    la $a0, init_msg2   # load the second welcome message into a0
    li $v0, 4           # load the print_string function into v0
    syscall             # make the syscall

    # Get user input

    la $a0, prompt_msg  # load the prompt message into a0
    li $v0, 4           # load the print_string function into v0
    syscall             # make the syscall

    li $v0, 5           # load the read_int function
    syscall             # make the syscall
    move $t0, $v0       # store the input in t0

    # Initialize some temp registers

    move $t1, $t0       # temp = num
    li $t2, 0           # reverse = 0
    li $t4, 10          # t4 = 10

    jal loop

loop:
    # while loop from C++ code

    blez $t1, endloop   # check if temp <= 0

    mult $t2, $t4       # multiply reverse by 10
    mflo $t6            # store result in t6
    move $t2, $t6       # copy the result to t2 variable 'reverse'

    div $t1, $t4        # divide temp by 10
    mfhi $t6            # store remainder in t6
    mflo $t1            # temp = temp/10

    add $t2,$t2,$t6     # reverse = reverse + temp%10

    b loop              # run the loop again

endloop:
    # check if palindrome and print message
    beq $t0, $t2, yespal # if t0 = t2, then num = reverse, yes palindrome
    bne $t0, $t2, notpal # if t0 != t2 then num != reverse, not palindrome

yespal:
    #print the original number first
    move $a0, $t0       # load the int num
    li $v0, 1           # load print_int function
    syscall

    la $a0, pal_msg     # load message to confirm palindrome
    li $v0, 4           # load print_string function
    syscall
    j exit

notpal:
    #print the original number first
    move $a0, $t0       # load the int num
    li $v0, 1           # load print_int function
    syscall

    la $a0, notpal_msg  # load message to confirm palindrome
    li $v0, 4           # load print_string function
    syscall
    j exit

exit:
    li $v0, 10          # load function to exit
    syscall
