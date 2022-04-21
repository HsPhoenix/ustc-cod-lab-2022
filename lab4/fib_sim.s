.text
    addi x1, x0, 1    #x1=1
    add t1, x0, x0    #store fib series @t1

#### input f0
    sw x1, 0x404(x0)  #rdy=1
l1: 
#    lw t0, 0x410(x0)  #wait vld=1
    addi a7, x0, 5    #for simulation begin
    ecall
    mv t0, a0         #for simulation end
   
    beq t0, x0, l1
#    lw s0, 0x40c(x0)  #s0=vin
    addi a7, x0, 5    #for simulation begin
    ecall
    mv s0, a0         #for simulation end
    
    sw s0, 0x408(x0)  #out1=s0  
    sw s0, 0(t1)
    addi t1, t1, 4
    
    sw x0, 0x404(x0)  #rdy=0
l2:
#    lw t0, 0x410(x0)  #wait vld=0
    addi a7, x0, 5    #for simulation begin
    ecall
    mv t0, a0         #for simulation end
 
    beq t0, x1, l2
    
#### input f1
    sw x1, 0x404(x0)  #rdy=1
l3:
#    lw t0, 0x410(x0)  #wait vld=1
    addi a7, x0, 5    #for simulation begin
    ecall
    mv t0, a0         #for simulation end
 
    beq t0, x0, l3
#    lw s1, 0x40c(x0)  #s1=vin
    addi a7, x0, 5    #for simulation begin
    ecall
    mv s1, a0         #for simulation end
     
    sw s1, 0x408(x0)  #out1=s1
    sw s1, 0(t1)
    addi t1, t1, 4
   
    sw x0, 0x404(x0)  #rdy=0
l4:
#    lw t0, 0x410(x0)  #wait vld=0
    addi a7, x0, 5    #for simulation begin
    ecall
    mv t0, a0         #for simulation end
 
    beq t0, x1, l4 
      
#### comput fi = fi-2 + fi-1
next:
    add t0, s0, s1  #fi
    sw t0, 0x408(x0)   #out1=fi
    sw t0, 0(t1)
    addi t1, t1, 4

    add s0, x0, s1
    add s1, x0, t0

    sw x1, 0x404(x0)  #rdy=1
l5:
#    lw t0, 0x410(x0)  #wait vld=1
    addi a7, x0, 5    #for simulation begin
    ecall
    mv t0, a0         #for simulation end
 
    beq t0, x0, l5
    sw x0, 0x404(x0)  #rdy=0
l6:
#    lw t0, 0x410(x0)  #wait vld=0
    addi a7, x0, 5    #for simulation begin
    ecall
    mv t0, a0         #for simulation end
 
    beq t0, x1, l6
    jal x0, next       

