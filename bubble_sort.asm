.data 
	mensagem: .asciiz "Insira o tamanho do vetor a ser ordenado: "
	Array:
		.align 2 #alinhamento para receber inteiros
		.space 32 #array que será lido terá espaço predefinido para 8 inteiros.
	espaco: .asciiz " "
	inputInvalido: .asciiz "Tamanho invalido!"
.text
	main:
		li $v0, 4 
		la $a0, mensagem 
		syscall 
		
		li $v0, 5 
		syscall
		
		blt $v0, 1, Entrada_Invalida
		
		
		move $t0, $v0
		
		li $t1, 0 #contador para leitura dos inteiros
		la $s0, Array #array da memoria
		
		LerArray:
			beq $t1, $t0, Bubble_Sort #se $t1 = $t0 entao para a leitura
			
			li $v0, 5
			syscall
			
			move $t3, $v0
			sw $t3, ($s0) #salva no array
			
			addi $t1, $t1, 1
			addi $s0, $s0, 4 #incrementa endereço em 4 bytes
			j LerArray
			
		Bubble_Sort:	
			subi $t0, $t0, 1 #n-1
			li $t2, 1 #verifica se houve troca de posicao
		
			While:
				li $t3, 0 #iterador (i) 
				beq $t2, 0, Fim #finaliza o programa se nao houver nenhuma troca na iteraçao anterior
				li $t2, 0 
				la $s0, Array #reseta endereço do Array para a primeira posição
				For:
					beq $t3, $t0, While # i < n-1
					lw $t4, ($s0) #menor posicao
					lw $t5, 4($s0) #maior posicao
					bgt $t4, $t5, Sort #verifica esta desordenado
					j Iterador
				Sort: 
					li $t2, 1 #houve troca de posicao
					#carrega valores para troca
					lw $t4, ($s0) 
					lw $t5, 4($s0) 
					#troca prosições
					sw $t4, 4($s0) 
					sw $t5, ($s0) 
					j For 
					
				Iterador: 
					addi $s0, $s0, 4 #atualiza endereco
					addi $t3, $t3, 1 #incrementa contador
					j For
			
			Fim: #print do array
				la $s0, Array
				li $t3, 0
				
				Print:
					bgt $t3, $t0, Exit 
					
					li $v0, 1
					lw $a0, ($s0)
					syscall
					
					addi $s0, $s0, 4
					addi $t3, $t3, 1
					
					li $v0, 4
					la $a0, espaco
					syscall
					
					j Print
			
			Exit:
				li $v0, 10
				syscall	
					
			Entrada_Invalida:
				li, $v0, 4
				la $a0, inputInvalido
				syscall	
				
				j Exit	
			
		
