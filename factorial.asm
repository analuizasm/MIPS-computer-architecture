.data
	input_message: .asciiz "Enter a positive number less than 13: "
	output1: .asciiz "factorial("
	output2: .asciiz ") is "
	invalid_input: .asciiz "The entered value is not valid!"
	
.text
	main:
		li $v0, 4
		la $a0, input_message
		syscall
		
		li $v0, 5
		syscall
		
		blt $v0, 0, invalid_value #negative number -> invalid input
		bge $v0, 13, invalid_value #factorial of a number >= 13 -> overflow
		
		move $s0, $v0 #$s0 = n factorial
		li $s1, 1 #(0! == 1, 1! == 1)
		li $t0, 2 
		
		Factorial:
			bgt $t0, $s0, Exit # i>n -> end
			mul $s1, $s1, $t0 #n * fact
			addi $t0, $t0, 1 #iterator++
			j Factorial #loop
		
		
		#print and end
		Exit:
			li $v0, 4
			la $a0, output1
			syscall
			
			li $v0, 1
			move $a0, $s0
			syscall
		
			li $v0, 4
			la $a0, output2
			syscall
			
			li $v0, 1
			move $a0, $s1
			syscall
			j end
		
		invalid_value:
	
			li, $v0, 4
			la $a0, invalid_input
			syscall	
			
		end:
			li $v0, 10 
			syscall		
