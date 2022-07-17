# Program File: hw9.asm
# Author: Spencer R. Hall
# Purpose: Recursivly determine the first 10 digits in the fibonacci sequence. Then store them in memory.

.data
sequence: .space 40 # Array to hold the fibonacci sequence.

.text
main:
	la $a0, sequence # Load base address of array to store fibonacci.
	li $a1, 1 # Start of argument for fibonacci
	
	jal fibonacci # Call fibonacci($a1)
	sw $v0, 0($a0) # Store fibonacci value in array.
	
	# Increment the index and base address.
	addi $a1, $a1, 1
	addi $a0, $a0, 4
	
	# If the sequence has reached 10 digits, terminate the program.
	beq  $a1, 11, exit

fibonacci:
	beq $a1, $zero, return_zero   # If $a1 = 0, return 0
	beq $a1, 1, return_one   # If $a1 = 1, return 1
 
	# Store return address on the stack.
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	# Call fibonacci($a1 -1)
	addi $a1, $a1, -1
	jal fibonacci
	addi $a1,$a1,1

	# Load original return address off of the stack.
	lw $ra, 0($sp)
	addi $sp, $sp, 4

	# Store result of fibonacci($a1 - 1) on the stack.
	addi $sp, $sp, -4
	sw $v0,0($sp)
	
	# Store the original return address on the stack again.
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	# Call fibonacci($a1 - 2)
	addi $a1, $a1, -2
	jal fibonacci
	addi $a1, $a1, 2

	# Load original return address back off of the stack.
	lw $ra, 0($sp)
	add $sp, $sp, 4
	
	lw $s0, 0($sp)   #Pop return value from stack
	add $sp, $sp, 4

	# Add fibonacci($a1 - 1) + fibonacci ($a1 - 2) and return.
	add $v0, $v0, $s0
	jr $ra

	return_zero:
		li $v0,0
		jr $ra
	return_one:
		li $v0,1
		jr $ra

exit:
	# Terminate the program.
	li $v0, 10
	syscall

