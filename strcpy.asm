.data
	mensagem: .asciiz "Digite a string a ser copiada:"
	str_origem: 
	.space 32
	
	str_destino: 
	.space 32
	
.text
	main:
		li $v0, 4
		la $a0, mensagem
		syscall
		
		li $v0, 8
		la $a0, str_origem #local a ser armazenado a string lida
		li $a1, 32 #tamanho maximo da string
		move $s0, $a0
		syscall
		
		la $s2, str_destino #carregando endereço de destino no $s2
		
	strCopy:
		lb $s1, ($s0) #carregando o byte em $s1 (cada char tem 1 byte)
		beq $s1, $zero, Exit #caracter nulo = fim da string
		sb $s1,($s2) #salvando byte no endereço de destino
		addi $s2, $s2, 1 #incrementando 1 byte no endereço de destino
		addi $s0, $s0, 1 #incrementando 1 byte no endereço de origem
		j strCopy
		  
	Exit: #print e fim do programa
	
		li $v0, 4
		la $a0, str_destino
		syscall
		
		li $v0, 10 
		syscall
