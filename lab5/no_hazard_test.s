.text
main:
sw   x0, 0x408(x0)  
addi t0, x0, 0
addi t1, x0, 0
addi t2, x0, 0
lw   t0, 0x40C(x0) 
addi t1, x0, 5
addi t2, x0, 8
sw   t0, 0x408(x0)
sw   t1, 0x408(x0)
add  t3, t1, t2
sw   t2, 0x408(x0)
addi t0, x0, 0
sw   t3, 0x408(x0)
