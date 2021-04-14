.data 
	mensagem: .asciiz "Digite o valor a ser calculado: "
	saida: .asciiz "F("
	saida2: .asciiz ")= "
	inputInvalido: .asciiz "Entrada invalida!"
.text
	li $v0, 4 
	la $a0, mensagem
	syscall
	
	li $v0, 5 
	syscall

	move $a0, $v0 #$a0 = valor desejado
	
	blt $a0, 0, Entrada_Invalida #entrada invalida
	
	add $s0, $a0, $zero
	jal Fibonacci
	move $t1, $v0 #resultado retornado
	j Exit
	
	Fibonacci:
		
		beq $a0, 0, Fibo_zero #n = 0 (sequencia começando em zero (0 1 1 2...)
		beq $a0, 1, Fibo_um #n = 1 
		bgt $a0, 1, Fibonacci_rec  # n > 1
		
		Fibo_zero: 
			li $v0, 0 
			jr $ra
			
			
		Fibo_um:
			li $v0, 1
			jr $ra
			
			
		Fibonacci_rec:
			addi $sp, $sp, -12 #prepara pilha para 3 espaços
			sw $ra, 8($sp) #salvando endereço de retorno
			sw $a0, 0($sp) #salva o n atual
			
			#f(n-1)
			addi $a0, $a0, -1 
			jal Fibonacci
			
			lw $a0, 0($sp) #carrega o n anterior ao decremento
			sw $v0, 4($sp) #salva o retorno
			
			#f(n-2)
			addi $a0, $a0, -2 
			jal Fibonacci
	
			lw $t0, 4($sp) #salva valor retornado em uma outra varival para nao sobrescrever o $v0
			add $v0, $t0, $v0 #fib = fib(n-1) + fib(n+2)
			
			lw $ra, 8($sp) #carrega endereço de retorno anterior
			addi $sp, $sp, 12 #esvazia pilha
			jr $ra #retorna
		
	#print e finalização		
	Exit: 
	
		li, $v0, 4
		la $a0, saida
		syscall
		
		li $v0, 1
		move $a0, $s0 
		syscall
		
		li, $v0, 4
		la $a0, saida2
		syscall
	
		li $v0, 1
		move $a0, $t1
		syscall
		
		li $v0, 10 
		syscall 
		
	Entrada_Invalida:
		li, $v0, 4
		la $a0, inputInvalido
		syscall	
		
		li $v0, 10 
		syscall 
	
	
