start:
sw   x0, 0x408(x0) # out1=0

#test data hazards
addi x1, x0, 1     # x1   = 1
addi x2, x1, 1     # x2   = 2
add  x3, x1, x2    # x3   = 3
add  x4, x1, x3    # x4   = 4
add  x5, x1, x4    # x5   = 5
sw   x5, 0x408(x0) # out1 = 5

add  x6, x1, x2    # x6   = 3
add  x6, x6, x3    # x6   = 6
add  x6, x6, x4    # x6   = 10
add  x6, x6, x5    # x6   = 15
sw   x6, 0x408(x0) # out1 = 15

#test load-use hazard
lw   x7, 0x40C(x0) # x7   = in
addi x8, x7, 1     # x8   = in+1
addi x9, x8, -1    # x9   = in
sw   x9, 0x408(x0) # out1 = in



