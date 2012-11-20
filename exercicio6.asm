# ===================================================================
# Implemente em assembly do MIPS um procedimento que calcule a raiz
# quadrada inteira de um número inteiro x passado por parâmetro
# utilizando o algoritmo abaixo (descrito em C). As variáveis locais
# devem ser armazenadas na pilha e o valor do parâmetro deve ser 
# entrado pelo console. O resultado deve ser exibido na tela.
# ===================================================================

#====
# ACHEI ESSE METODO
# raiz de 25 = ?
# 1º Passo  25 −1  = 24
# 2º Passo  24 − 3 = 21
# 3º Passo  21 − 5 = 16
# 4º Passo  16 − 7 = 9
# 5º Passo  9  − 9 = 0
# 
# posição então será indice * 2 + 1
# ex: primeiro passo => 0 * 2 + 1 => 1
# 		 segundo passo => 1 * 2 + 1 => 3
#====

.data
	error_msg: .asciiz "Não é uma raiz quadrada perfeita"

.text

	.globl main
	
	main:
		jal read_int							# le o inteiro
		la 	$s0, ($v0)						# guarda o valor lido
		li	$s1, 0
		jal isqrt									# calcula a raiz quadrada		

	print_int:
		li 		$v0, 5							# código para ler um inteiro
		syscall										# executa a chamada do SO para ler
		jr 		$ra									# volta para o lugar de onde foi chamado (no caso, jal le_inteiro_do_teclado)			
	
	read_int:
		li 		$v0, 5							# código para ler um inteiro
		syscall										# executa a chamada do SO para ler
		jr 		$ra									# volta para o lugar de onde foi chamado (no caso, jal le_inteiro_do_teclado)
		
	isqrt:
		mul	$t0, $s1, 2
		add $t0, $t0, 1
		sub	$s0, $s0, $t0
		add $s1, $s1, 1						# incrementa o contador, que sera o resultado da raiz
		beq $s0, $zero, success		# se chegamos a zero a raiz é perfeita
		slt	$t0, $s0, $zero				# caso seja menor que zero, deu problema
		beq $t0, 1, error					# então mostramos mensagem de erro
		j		isqrt									# caso não ocorra nenhum dos casos acima, itera novamente
		
	error:
		la $a0, error_msg
		la $v0, 4
		syscall
		j	 exit
	
	success:
		la $v0, 1
		la $a0, ($s1)
		syscall
		j  exit
	
	exit:
		la $v0, 10
		syscall
				