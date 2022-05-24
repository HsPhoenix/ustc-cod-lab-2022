# begins at 0x3000
start: 
# test for lui & auipc
lui   x11, 0x12345 # x11 = 0x12345000 305,418,240
auipc x12, 0x12345 # x12 = 0x12348004 305,430,532

# test for arithmetic & logical operations
addi  x1,  x0, 1  # x1 =  0x00000001             1
slli  x2,  x1, 1  # x2 =  0x00000002             2
sub   x3,  x1, x2 # x3 =  0xFFFFFFFF            -1
srl   x4,  x3, x2 # x4 =  0x3FFFFFFF 1,073,741,823
srai  x5,  x3, 2  # x5 =  0xFFFFFFFF            -1
slt   x6,  x5, x4 # x6 =  0x00000001             1
sltu  x7,  x5, x4 # x7 =  0x00000000             0
or    x8,  x5, x1 # x8 =  0xFFFFFFFF            -1
and   x9,  x5, x1 # x9 =  0x00000001             1
xor   x10, x5, x1 # x10 = 0xFFFFFFFE            -2

# test for jal & jalr
jal x13, jal_test # x13 = 0x00003034

# test for branch
beq  x1, x1, bne_test
addi x21, x0, 1       # if beq failed, x21 = 1
bne_test:
bne  x1, x0, blt_test
addi x22, x0, 1       # if bne failed, x22 = 1
blt_test:
blt  x0, x1, bge_test
addi x23, x0, 1       # if blt failed, x23 = 1
bge_test:
bge  x1, x0, bltu_test
addi x24, x0, 1       # if bge failed, x24 = 1
bltu_test:
bltu x4, x3, bgeu_test
addi x25, x0, 1       # if bltu failed, x25 = 1
bgeu_test:
bgeu x3, x4, ls_test
addi x26, x0, 1       # if bgeu failed, x26 = 1

# test for load & store
ls_test:
li  x15, 0x12345678
li  x16, 0xFFFFFFFF
sw  x15, 0x000(x0)  # mem[0] = 0x12345678
sh  x15, 0x004(x0)
sb  x15, 0x006(x0)
sb  x16, 0x007(x0)  # mem[1] = 0xFF785678
lw  x17, 0x000(x0)  # x17 = 0x12345678
lw  x18, 0x004(x0)  # x18 = 0xFF785678
lh  x19, 0x002(x0)  # x19 = 0x00001234
lh  x20, 0x006(x0)  # x20 = 0xFFFFFF78
lb  x27, 0x007(x0)  # x27 = 0xFFFFFFFF
lhu x28, 0x006(x0)  # x28 = 0x0000FF78
lbu x29, 0x007(x0)  # x29 = 0x000000FF

# test for btb
jal x0, start

jal_test:
jalr x14, 0(x13) # x14 = 0x000030A4
