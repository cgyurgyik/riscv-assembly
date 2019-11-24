# Memoized version of Fibonacci sequence.
#
# fib_memo(n, arr, size)
# n: nth fibonacci number.
# arr: memory address of the array. Assumes each element is size 4 (int).
# size: size of the array.
#
# Limitations: Uses the Cornell RISC-V Interpreter which has limited instruction set, so some instructions are
#              implemented using other instructions (i.e. MUL).


# MAIN
addi sp, sp, 10000
addi a0, x0, 10    # hardcode n = 10
addi a1, x0, 0     # hardcode memory address of 'arr'.
addi a2, x0, 100   # hardcode size of 'arr'.
jal ra, FIB_MEMO
jal ra, EXIT

FIB_MEMO:
addi sp, sp, -16
sw ra, 12(sp)
sw s2, 8(sp)
sw s1, 4(sp)
sw s0, 0(sp)

addi s0, a0, 0     # save n.
addi s2, x0, 0     # clean slot for s2.

# multiply n * 4 without using MUL.
addi t0, x0, 0   
LOOP:
BEQ t0, s0, LOOP_DONE
addi t0, t0, 1     # i = i + 1
addi s2, s2, 4     # memory address = memory address + sizeof(int)
BEQ x0, x0, LOOP
LOOP_DONE:

add s2, s2, a1     # arr[n]

BLT a2, a0, SKIP   # if (size < n) skip. 

lw a0, 0(s2)       # load value at arr[n].
BNE a0, x0, RET    # if arr[n] != 0 return.

SKIP:
addi a0, s0, 0     # get value of n again.
beq a0, x0, RET    # if n == 0 return 0;

addi t1, x0, 1
beq a0, t1, RET    # if n == 1 return 1;

addi a0, a0, -2    # n-2
jal ra, FIB_MEMO   # fib_memo(n-2, ...)

addi s1, a0, 0     # store return value of fib_memo
addi a0, s0, 0     # get value of n again.
addi a0, a0, -1    # n-1
jal ra, FIB_MEMO   # fib_memo(n-1, arr, size)

add a0, a0, s1     # fib_memo(n-1, arr, size) + fib_memo(n-2, arr, size)

BLT a2, s0, RET    # if (size < n) skip.
sw a0, 0(s2)       # store the answer at arr[n].

RET:
lw s0, 0(sp)
lw s1, 4(sp)
lw s2, 8(sp)
lw ra, 12(sp)
addi sp, sp, 16
jalr x0, ra, 0

EXIT:

