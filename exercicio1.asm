# ===================================================================
# Faça um programa usando o assembly do MIPS que execute o cálculo 
#	da expressão: 
# a = (b + c) - (d + e + f). 
# O resultado deve aparecer na tela e os dados devem ser 
# inseridos pelo console.
# ===================================================================

.data
	in:        .word
	operators: .word

.text	

	# $t7 => mantém ponteiro para indice da lista
	# $s0 => mantém ponteiro para a lista
	
	main:
		li		$t7, 4							# inicializa o indice com 0
		la    $s0, operators			# carrega o ponteiro da lista de numeros para $s0
		jal		read_all	  				# le todos os valores do teclado
		
	rint:
		li 		$v0, 5							# código para ler um inteiro
		syscall										# executa a chamada do SO para ler
		sw 		$v0, in		 					# coloca o código lido em in
		jr 		$ra									# volta para o lugar de onde foi chamado (no caso, jal le_inteiro_do_teclado)
		
	add_to_list:		
		add   $t0, $s0, $t7				# combina o indice e a lista
		lw		$t1, in							# pega o último valor de entrada
		sw		$t1, ($t0)					# salva na posição atual da lista
		jr 		$ra									# volta para a última subrotina
	
	read_all:		
		jal 	rint      					# le o proximo inteiro
		jal		add_to_list					# salva o valor lido na posição atual da lista
		addi  $t7, $t7, 4					# incrementa indice
		bne   $t7, 24, read_all		# enquanto for menor que cinco continua iterando
		j	    calculate						# chama a subrotina de calculo
		
	get_next:
		add 	$t2, $s0, $t7				# pega o endereço do item na lista
		lw		$t0, ($t2)					# guarda o valor do item em $t0
		addi	$t7, $t7, 4					# move o indice da lista para o proximo item
		jr 		$ra									# volta para a subrotina
		
	calculate:					
		# zera indice da lista
		li		$t7, 4	
		
		# parte 1 => 							a = (b + c)				
		jal		get_next						# pega o proximo da lista
		la		$s1, ($t0)					# guarda o valor de B em $s1				
		jal		get_next						# pega o proximo da lista
		la		$s2, ($t0)					# guarda o valor de C em $s2
		
		li    $t1, 0							# força o valor de zero em $t1 (reinicia estado)
		add   $t1, $s1, $s2				# a = (b + c)
		
		# parte 2 => 							t2 = (d + e + f)		
		jal		get_next						# pega o proximo da lista
		la		$s1, ($t0)					# guarda o valor de D em $s1				
		jal		get_next						# pega o proximo da lista
		la		$s2, ($t0)					# guarda o valor de E em $s2		
		jal		get_next						# pega o proximo da lista
		la		$s3, ($t0)					# guarda o valor de F em $s3

		li    $t2, 0							# força o valor de zero em $t2 (reinicia estado)		
		add		$t2, $s1, $s2				# t2 = d + e
		add   $t2, $t2, $s3				# t2 = (d + e + f)
		
		# parte 3 => 							a = (b + c) - (d + e + f)
		sub		$t1, $t1, $t2				# (b + c) - (d + e + f)		
		j			end
		
	end:
		li    $v0, 1							# código para imprimir um inteiro
		la 		$a0, ($t1)
		syscall