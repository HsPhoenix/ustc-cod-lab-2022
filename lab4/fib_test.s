.text
start:
    # test for auipc, addi, jal
    auipc   t0, 0x12342     # t0 <- 0x12345000
    addi    x1, x0, 1       # x1 <- 1
    sw      t0, 0x408(x0)   # echo t0
    jal     x2, next_step   # wait for io

    # test for add, sub
    addi    t1, x0, 0x24    # t1 <- 0x24
    addi    t2, x0, 0x13    # t2 <- 0x13
    add     t3, t1, t2      # t3 <- 0x37
    sw      t3, 0x408(x0)   # echo t3
    jal     x2, next_step   # wait for io
    sub     t3, t1, t2      # t3 <- 0x11
    sw      t3, 0x408(x0)   # echo t3
    jal     x2, next_step   # wait for io

    # test for lw, sw
    sw      t0, 0x000(x0)   # mem[0] <- 0x12345000
    jal     x2, next_step   # wait for io
    lw      t3, 0x000(x0)   # t3 <- mem[0]
    sw      t3, 0x408(x0)   # echo t3
    jal     x2, next_step   # wait for io
    jal     x0, start

# test for blt, beq, jalr
next_step:
    sw      x0, 0x404(x0)   # set ready bit
poll_up:
    lw      t3, 0x410(x0)
    blt     t3, x1, poll_up
poll_down:
    lw      t3, 0x410(x0)
    beq     t3, x1, poll_down
    sw      x1, 0x404(x0)   # reset ready bit
    jalr    x0, x2, 0