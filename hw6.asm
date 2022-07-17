# Program File: hw6.asm
# Author: Spencer R. Hall
# Purpose: Calculate first 10 values in the Fibonacci Sequence

.data
fibonacci: .space 40 # This is an array that will hold the first ten numbers of the fibonacci sequence.

.text 
addi $s1, $zero, 1 # The first index in the sequence to be evaluated is at 1. It will increment it's way up to ten.
la $a1, fibonacci # Storing the base address of the fibonacci list.

loop:
	li $s2, 0 #To determine the fibonacci value we start at 0 and add our way up to n.
	li $s3, 0 # The most recent fibonacci value.
	li $s4, 1 # The second most recent.
	
	loop2:
		addi $s2, $s2, 1 # Increment Value
		add $s5, $s3, $s4 # Add up previous two numbers to get current number.
		addi $s4, $s3, 0 # Update most recent value.
		addi, $s3, $s5, 0 # Update second most recent value.
	bne $s2, $s1, loop2
	
	# Save the fibonacci value to the fibonacci list.
	sw $s5, 0($a1)
	addi $s1, $s1, 1 # Increment the index by 1.
	addi $a1, $a1, 4 # Increment the base address by 4.
bne $s1, 11, loop
