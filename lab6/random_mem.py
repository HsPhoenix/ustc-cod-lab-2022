from random import randrange
import sys
with open('.\\CPU\\CPU.srcs\\sources_1\\coes\\random_mem.coe', 'w') as f:
    print('memory_initialization_radix=16;', file=f)
    print('memory_initialization_vector=', file=f)

    for i in range(256):
        print('%x' % randrange(2147483647), file=f)

    print(';', file=f)