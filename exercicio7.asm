# ALGORITIMO FICOU INCOMPLETO.. 
# ===================================================================
# Implemente o algoritmo de ordenação QuickSort em assembly do MIPS. 
# Mais detalhes sobre esse algoritmo podem ser encontrados no 
# seguinte link:  
# http://pt.wikipedia.org/wiki/Quicksort
# ===================================================================

.data
	lista: 	.word 9,3,5,7,0,4,2,8,1,6
	size: 	.word	9
	pilha:	.word 0
	
.text
	
	# $s1 => menor
	# $s2 => maior
	# $s3 => pivo
	
	main:
		la		$s0, lista			# carrega a referencia da lista
		li		$s1, 0					# carrega o valor mínimo da lista
		lw		$s2, size				# carrega o valor máximo da lista		
		li 		$t0, 2					# carrega o valor do divisor para achar o meio da lista (pivo)
		div 	$s2, $t0				# divide por dois para achar o pivo
		mflo 	$t3							# armazena o quociente da divisão em $t0
		
		la		$s3, $s1
		la		$s4, $s2
		j			quicksort
	
	quicksort:
		# $s3 => menor temporario
		# $s4 => maior temporario
		jal		find_pivot			# guarda o pivot temporario em $a3		
		jal 	increment				# incrementa o menor enquanto ele é menor que o pivo
		jal 	decrement				# decrementa o maior enquanto ele é maior que o pivo
		slt		$t0, $s3, $s4
		bne		$t0, 1, exchange	# se for menor então muda-os de posição
		bne		$t0, 1, quicksort	# se for menor continua iterando
		la		$a0, ($ra)
		
		# faltou a recursão
		# // Recursion
    # if (low < j)
    #   quicksort(low, j);
    # if (i < high)
    #   quicksort(i, high);
		
	
	find_pivot:	
		# acha o novo meio (menor + (maior - menor) / 2)
		la		$t0, 2
		sub		$t1, $s6, $s5		# (maior - menor)
		div		$t1, $t2				#	(resultado) / 2
		mflo	$t1							# pega o resultado
		add		$t1, $t1, $t6		# (menor + resultado)
		add		$t1, $s0, $t1		# pega o endereço do pivo
		lw		$a3, ($s1)			# guarda o valor do pivot temporario em $a3
		jr 		$ra
		
	# incrementa o valor de $t7 até ser igual ao pivot ($t3)
	increment:
		add 	$s3, $s3, 1				# incrementa o indice de memoria
		mul		$t6, $s3, 4				# faz dele um multiplo de 4
		add		$t6, $s0, $t6			# pega a referencia da posição correta em memoria
		lw		$t5, ($t6)				# carrega o valor salvo na memoria
		slt		$t4, $t5, $a3			# verifica se ainda ainda é menor que o pivot temporario
		bne		$t4, 1, increment	# se for continua iternado
		jr 		$ra								# caso contrario volta para a função anterior

	# decrementa o valor de $t7 até ser igual ao pivot ($t3)		
	decrement:
		sub 	$s4, $s4, 1				# decrementa o indice de memoria
		mul		$t6, $s4, 4				# faz dele um multiplo de 4
		add		$t6, $s0, $t6			# pega a referencia da posição correta em memoria
		lw		$t5, ($t6)				# carrega o valor salvo na memoria
		slt		$t4, $a3, $t5			# verifica se ainda ainda é maior que o pivot temporario
		bne		$t4, 1, decrement	# se for continua iternado
		jr 		$ra								# caso contrario volta para a função anterior
		
	# avança a pilha para o proximo bloco de memoria e guarda o endereço
	# mantido por convenção em $ra
	next:		
		la 		$s4, pilha				# pega referencia da pilha
		add		$s5, $s5, 4				# pula para o proximo indice
		add		$s6, $s4, $s5			# pega o endereço correto do indice
		sw		$s5, ($a0)				# salva o valor recebido em $a0
		jr 		$ra								# volta para a ultima chamada
		
	# retrocede a pilha para o bloco de memoria anterior e guarda o endereço
	# mantido desta posição em $a0
	back:
		la 		$s4, pilha				# pega a referencia da pilha
		sub		$s5, $s5, 4				# subtrai para retroceder o endereco da pilha
		add		$s6, $s4, $s5			#	pega o endereço correto do indice atual
		lw		$a0, ($s5)				# carrega o valor da posição em $a0 (por convenção)
		jr		$ra								# volta para a ultima chamada
		
	# inverte o menor com o maior
	exchange:
		add		$t0, $s0, $s3			# endereço do menor (teorico)
		add		$t1, $s0, $s4			# endereço do maior (teorico)
		lw		$t2, ($t0)				# carrega o valor do menor
		lw		$t3, ($t1)				# carrega o valor do maior
		sw		$t3, ($t0)				# salva o maior no endereço do menor
		sw 		$t2, ($t1)				# salva o menor no endereço do maior
		add		$s3, $s3, 1				# incrementa o menor
		sub		$s4, $s4, 1				# decrementa o maior
		jr		$ra								# volta para a ultima chamada
		