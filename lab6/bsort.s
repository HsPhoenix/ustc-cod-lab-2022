# Sort the whole memory and count the branch times

# bubble sort C code
# for (int i = 0; i < size; i++)
#     for (int j = i + 1; j < size; j++)
#         if (mem[j] < mem[i])
#         {
#             temp = mem[j]; 
#             mem[j] = mem[i]; 
#             mem[i] = temp;
#         }

# Memory Map
# 0x400 - out0          // led[4:0]
# 0x404 - ready         // led[7]
# 0x408 - out1          // segplay
# 0x40c - in            // sw[4:0]
# 0x410 - valid         // sw[5]
# 0x800 - branch_count
# 0x804 - success_count
# 0x808 - fail_count

# Polling Example
# while (!valid);
# out1 = xxx;
# while (valid);

.text
# memory starts at 0x000, ends at 0x3FF
    li   t0, 1024    # t0 represents for size 
    add  x1, x0, x0  # x1 = 0, represents for i

loop1:
    mv	 x2, x1      # x2 = i, represents for j
    lw   t1, 0(x1)   # t1 = mem[i]

loop2:
    lw   t2, 0(x2)   # t2 = mem[j] 
    bge  t2, t1, loop2_end  # if mem[i] >= mem[j], jump to loop2_end
    sw   t1, 0(x2)   # mem[j] = mem[i]
    sw   t2, 0(x1)   # mem[i] = mem[j]
    add  t1, x0, t2  # t1 = new mem[i]
loop2_end:
    addi x2, x2, 4   # j++
    blt  x2, t0, loop2  

    addi x1, x1, 4      # i++
    blt  x1, t0, loop1

    # Get the counters
    li   s4, 0x800
    lw   s0, 0(s4)  # s0 = branch_count
    lw   s1, 4(s4)  # s1 = success_count
    lw   s2, 8(s4)  # s2 = fail_count

    # Signal the end of the program
    sw   x0, 0x408(x0)  # segplay echoes 0

end:
	jal  x0, end

