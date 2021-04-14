.data
	mensagem: .asciiz "Digite o termo desejado: "
	saida: .asciiz "! = "
	inputInvalido: .asciiz "O valor digitado não é válido!"
	
.text
	main:
		li $v0, 4
		la $a0, mensagem
		syscall
		
		li $v0, 5
		syscall
		
		blt $v0, 0, Entrada_Invalida #entrada invalida.
		
		move $s0, $v0 #$s0 = n fatorial
		li $s1, 1 #fatorial começa com 1 (0! 1! = 1)
		li $t0, 2 #iterador começa com 2
		
		Fatorial:
			bgt $t0, $s0, Exit # i>n -> fim
			mul $s1, $s1, $t0 #n * fat
			addi $t0, $t0, 1 #incrementa iterador
			j Fatorial #retorna o loop
		
		
		#print e finalizacao do programa
		Exit:
			li $v0, 1
			move $a0, $s0
			syscall
		
			li $v0, 4
			la $a0, saida
			syscall
			
			li $v0, 1
			move $a0, $s1
			syscall
			
			li $v0, 10 
			syscall	
		
		Entrada_Invalida:
	
			li, $v0, 4
			la $a0, inputInvalido
			syscall	
		
			li $v0, 10 
			syscall 		
