# ===================================================================
# Reproduzir o procedimento fatorial, exibido nos slides da aula 3, 
# implementando o main, imprimindo os resultados e perguntando o 
# valor de n ao usuário.
# ===================================================================

.data
	msg: .asciiz "Digite o valor de n: "

.text
	
	.globl main
	
	main:
		li 	$s0, 1							# registrador que ira guardar o resultado final
		jal	print_message				# solicita o valor de n no console
		jal read_int						# le o valor de n
		jal calculate_factorial	# calcula o fatorial de n (n!)
		jal	print_result				# imprime o resultado
		j 	exit
	
	print_message:
		la 	$v0, 4
		la 	$a0, msg
		syscall
		jr 	$ra
		
	read_int:
		li 	$v0, 5							# código para ler um inteiro
		syscall									# executa a chamada do SO para ler
		jr 	$ra									# volta para o lugar de onde foi chamado (no caso, jal le_inteiro_do_teclado)
	
	calculate_factorial:
		mul $s0, $s0, $v0
		sub	$v0, $v0, 1
		bne $v0, 0, calculate_factorial
		jr  $ra
		
	print_result:
		la  $v0, 1
		la  $a0, ($s0)
		syscall
		jr  $ra
		
	exit:
		la $v0, 10
		syscall
