.data 
	message: .asciiz "Enter a number: "
	output1: .asciiz "Fibo("
	output2: .asciiz ")is "
	input_error: .asciiz "The entered number is invalid!"
	overflow_message: .asciiz "Overflow!"
.text
	li $v0, 4 
	la $a0, message
	syscall
	
	li $v0, 5 
	syscall

	move $a0, $v0 

	blt $a0, 0, invalid_input #only positive numbers
	add $s0, $a0, $zero
	jal Fibonacci
	add $s1, $v0, $0 #returned value
	j exit
	
	Fibonacci:
		
		beq $a0, 0, Fibo_zero #n = 0 (sequence -> 0 1 1 2...)
		beq $a0, 1, Fibo_one #n = 1 
		bgt $a0, 1, Fibonacci_rec  # n > 1
		
		Fibo_zero: 
			li $v0, 0 
			jr $ra
			
			
		Fibo_one:
			li $v0, 1
			jr $ra
			
			
		Fibonacci_rec:
			addi $sp, $sp, -12 #prepares the stack for 3 ints (3 * 4 bytes = 12)
			sw $ra, 8($sp) #saves the return adress
			sw $a0, 0($sp) #current n value
			
			########fibo(n-1)########
			addi $a0, $a0, -1
			jal Fibonacci
			########################
			
			lw $a0, 0($sp) #loads the previous n (before the decrement)
			bltz $v0, error #overflow (can't get a negative number on fibonacci)
			sw $v0, 4($sp) #saves the return
			
			########fibo(n-2)########
			addi $a0, $a0, -2
			jal Fibonacci
			########################
			
			lw $t0, 4($sp) #saves the returned value (doesn't overwrite the previous value of $v0)
			add $v0, $t0, $v0 #fibo = fibo(n-1) + fibo(n-2)
			bltz $v0, exit
			
			lw $ra, 8($sp) #loads the previous address
			addi $sp, $sp, 12 #cleans the stack
			jr $ra #returns the address
		
	#print and end#		
	exit: 
	
		li, $v0, 4
		la $a0, output1
		syscall
		
		li $v0, 1
		move $a0, $s0 
		syscall
		
		li, $v0, 4
		la $a0, output2
		syscall
	
		li $v0, 1
		move $a0, $s1
		syscall
		
		j end		
		
	invalid_input:
		li, $v0, 4
		la $a0, input_error
		syscall	
		
		j end
		 
	error:
		la $a0, overflow_message
		li $v0, 4
		syscall
		
	end:
		li $v0, 10 
		syscall 
