.data
	message: .asciiz "Enter the string to be copied: "
	str_copied: 
	.space 32
	
	str_destiny: 
	.space 32
	
.text
	main:
		li $v0, 4
		la $a0, message
		syscall
		
		li $v0, 8
		la $a0, str_copied #address to store the input
		li $a1, 32 #max size of the string (32 chars)
		move $s0, $a0
		syscall
		
		la $s2, str_destiny #copy string's address
		
		
	str_copy:
		lb $s1, ($s0) #load a byte (char = 1 byte)
		beq $s1, $zero, exit #end of string -> null character
		sb $s1,($s2) #stores the char
		#####iterator#####
		addi $s2, $s2, 1 
		addi $s0, $s0, 1 
		#################
		j str_copy
	
	#print and end#	  
	exit: 
	
		li $v0, 4
		la $a0, str_destiny
		syscall
		
		li $v0, 10 
		syscall
