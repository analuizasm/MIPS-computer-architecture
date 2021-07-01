.data 
	message: .asciiz "Enter the size of the array: "
	Array:
		.align 2 #int alignment
		.space 32 #array default max size = 8
	blank_space: .asciiz " "
	size_error: .asciiz "The entered size is invalid!"
.text
	main:
		li $v0, 4 
		la $a0, message 
		syscall 
		
		li $v0, 5 
		syscall
		
		blt $v0, 1, invalid_input
		
		
		move $t0, $v0
		
		la $s0, Array 
		li $s1, 0 #iterator
		
		read_array:
			beq $s1, $t0, bubble_sort #if $s1 = $s0 -> stops input reading
			
			li $v0, 5
			syscall
			
			move $t3, $v0
			sw $t3, ($s0) #saves to array
			
			addi $s1, $s1, 1
			addi $s0, $s0, 4 #array address pointer increments by 4
			j read_array
			
		bubble_sort:	
			subi $t0, $t0, 1 #n-1
			li $s2, 1 #checks if there was a sorting in the last iteration 
		
			while:
				beq $s2, 0, end #(if $s2 = 0, the array is sorted)
				li $s2, 0 #starts without any swap
				li $s3, 0 #iterator (i) 
				la $s0, Array #address pointer goes back to the first index of the array
				
				for:
					beq $s3, $t0, while # i < n-1
					
					lw $s4, ($s0) #lowest position
					lw $s5, 4($s0) #highest position
					
					bgt $s4, $s5, sort #verify if it's sorted
					j iterator
				sort: 
					li $s2, 1 #swapped position
					
					#sorting#
					sw $s4, 4($s0) 
					sw $s5, ($s0) 
					#########
					
					j iterator 
					
				iterator: 
					addi $s0, $s0, 4 #address pointer++
					addi $s3, $s3, 1 #increments counter
					j for
			
			end: #print
				la $s0, Array
				li $s3, 0
				
				print:
					bgt $s3, $t0, exit
					
					li $v0, 1
					lw $a0, ($s0)
					syscall
					
					addi $s0, $s0, 4
					addi $s3, $s3, 1
					
					li $v0, 4
					la $a0, blank_space
					syscall
					
					j print
					
			invalid_input:
				li, $v0, 4
				la $a0, size_error
				syscall	

			exit:
				li $v0, 10
				syscall	
			
		
