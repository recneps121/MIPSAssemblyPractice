# Program File: hw8.asm
# Author: Spencer R. Hall
# Purpose: Perform a Bubble Sort as a leaf function.

.data
	array: .word 1, 10, 2, 9, 3, 8, 4, 7, 5, 6 # Array the bubble sort will be implemented on.

.text

bubble_sort:
	la $a0, array # Pass the base address of the array as a parameter in $a0.
	
	# Store $s0 on the stack.
	addi $sp, $sp, -4
	sw  $s0, 0($sp)
	li $s0, 10 # $s0 stores the length of the array.
	
	li $t0, 0 # counter for first_loop
	first_loop_start:
		#If $t0 is less than or equal to 10, end the loop.
		slt $t1, $t0, $s0
		beq $t1, $zero, first_loop_end
		
		li $t2, 1 # Counter for second_loop
		sub $t3, $s0, $t0 # 10 - $t0 is the top bound for second_loop.
		second_loop_start:
			# If $t2 is equal to or greater than 10-$t0, end the second_loop.
			slt $t4, $t2, $t3
			beq $t4, $zero, second_loop_end
			
			j should_swap
			
		
	should_swap:
		# Determine if the two values should be swapped, and call the associated function.
		lw $t5, 0($a0)
		lw  $t6, 4($a0)
		sgt  $t7, $t5, $t6
		bne $t7, $zero, swap_elements
		beq $t7, $zero, dont_swap
	
	swap_elements:
		# Swap the two values
		sw $t5, 4($a0)
		sw $t6, 0($a0)
		# Increase the base address, and the second_loop counter.
		addi $a0, $a0, 4
		addi $t2, $t2, 1
		# Return to top of the original caller loop.
		j second_loop_start
	
	dont_swap:
		# Increase the base address, and the second_loop counter.
		addi $a0, $a0, 4
		addi $t2, $t2, 1
		# Return to the top of the original caller loop.
		j second_loop_start
		
	
	first_loop_end:
		# Restore $s0, and stack.
		lw $s0, 0($sp)
		addi $sp, $sp, 4
		# Exit program.
		j quit
	
	second_loop_end:
		# Increment counter, and exit loop.
		addi $t0, $t0, 1
		la $a0, array
		j first_loop_start

quit:
	# Exit the program.
	li $v0, 10
	syscall