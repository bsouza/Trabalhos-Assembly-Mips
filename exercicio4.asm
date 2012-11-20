# ===================================================================
# Implemente em assembly do MIPS um procedimento (addsub) que execute a
# expressão f=(g+h)-(i+j), sendo essas variáveis locais ao procedimento 
# e inicializadas com valores qualquer. Depois, implemente um programa 
# main que declare localmente variáveis de mesmo nome do procedimento e
# que lhes atribua valores diferentes.
# Imprima na tela essas valores antes e depois da chamada de procedimento. 
# (Obs.: As variáveis locais são armazenadas em registradores que são os 
# mesmos no main e no addsub (guarde na pilha!). Para devolver o valor 
# para o procedimento principal, usar o $v0, assim como a convenção aconselha).
# ===================================================================

.text	

	la $t0, 3
	la $t1, 6
	la $t2, 1
	la $t3, 4
	
	jal addsub
	jal print
	jal main
	jal print
	j   exit

	main:
		la $t0, 6
		la $t1, 5
		la $t2, 7
		la $t3, 5
	
	addsub:
		add $t5, $t0, $t1		# (g+h)		
		add $t6, $t2, $t3		# (i+j)
		sub $v0, $t5, $t6		# f=(g+h)-(i+j)
		jr $ra
		
	print:
		la $a0, ($v0)
		la $v0, 1
		syscall
		jr $ra
		
	exit:
		la $v0, 10
		syscall