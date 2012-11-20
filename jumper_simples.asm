.text

	.globl main
	
		# read integer
		rint:
			li $v0, 5
			syscall
			jr $ra
		
		main:
			jal rint
			la  $t0, ($v0)