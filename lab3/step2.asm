.data
array:	.word	0x00 0x01 0x02 0x03 0x04 0x05 0x06 0x07 0x08

.text
	la		a0, array
	lw		a1, 4(a0)
	addi	a0, a0, 16
	lw		a2, 0(a0)
	add		a2,	a2, a1
	sw		a2, 0(a0)
	addi	a0, a0, -16
	lw 		a1, 0(a0)
branch:	
	beq		a1, x0, case1
	jal		case2
case1:
	addi	a1, a1, 1
	jal 	x0, branch
case2:
	addi	a7, x0, 10
	ecall