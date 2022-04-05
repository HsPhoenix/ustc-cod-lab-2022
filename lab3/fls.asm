.data
newline:
	.string "\n"
array:
	.word	0x0001 0x0002

.text
load: # load the arguments
	la 		a0, array	# a0 <- pointer to array
	addi	a1, x0, 10	# a1 <- number of elements
	lw		a2, 0(a0)
	lw	 	a3, 4(a0)
	addi	a0, a0, 8
	addi	a1, a1, -2
	
	# print first two elements
	addi 	a4, a2, 0
	jal		x1, print
	addi 	a4, a3, 0
	jal		x1, print

loop: # generate, store and print the array
	bge     x0, a1, exit
	add		a4, a2, a3
	sw		a4, 0(a0)
	jal		x1, print
	addi	a0, a0, 4
	addi	a2, a3, 0
	addi	a3, a4, 0
	addi	a1, a1, -1
	jal		x0, loop

print:
	addi	t0, a0, 0
	addi	a0, a4, 0
	addi	a7, x0, 1
	ecall
	la		a0, newline
	addi	a7, x0, 4
	ecall
	addi	a0, t0, 0
	jalr	x1

exit: # quit program
	addi 	a7, x0, 10
	ecall