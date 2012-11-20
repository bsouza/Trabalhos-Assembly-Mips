# ===================================================================
# Implemente em assembly um programa que soma o valor de uma 
# constante (const) a cada elemento de do vetor array.
# ===================================================================

.data
	constante:	.word 8
	array: 			.word 0,2,4,6,8

.text	
	li	$s0, 0							# indice atual do vetor
	li  $s1, 5							# indice maximo
	lw 	$s3, constante			# constante a ser somada

	loop:
		la  $t1, array				# endereço do array em memoria
		mul $t2, $s0, 4				# utiliza multiplos de quatro para acessar cada registro do array
		add	$t1, $t1, $t2			# soma o endereço do array com a posição
		lw	$t2, ($t1)				# carrega o valor da posição atual
		add	$t2, $t2, $s3			# soma o valor da constante
		sw	$t2, ($t1)				# salva o valor alterado
		add	$s0, $s0, 1				# pula para o proximo item
		bne $s0, $s1, loop		# enquanto não chegamos ao ultimo item, continuamos iterando