# Binary search
#
# bin_search(int[] arr, int l, int r, int x)
# int[] arr: memory address of 'arr'. Assumes each element is size 4.
# l: left boundary.
# r: right boundary.
# x: element being searched for.
# 
#
# Requires: r >= l. Returns -1 otherwise.
#
# Limitations: Uses the Cornell RISC-V Interpreter which has limited instruction set, so some instructions are
#              implemented using other instructions (i.e. MUL).

# MAIN
addi sp, sp, 10000
addi a0, x0, 0 # hardcode the memory address to begin at 0.
addi a1, x0, 0 # hardcode l = 0.
addi a2, x0, 4 # hardcore r = 6.
addi a3, x0, 10 # hardcode x = 10.

# Store array values in contiguous memory:
# {2, 3, 4, 10, 40, 50, 1000}
 addi t0, x0, 2
 sw t0, 0(a0) 
 addi t0, x0, 3
 sw t0, 4(a0)
 addi t0, x0, 4
 sw t0, 8(a0)
 addi t0, x0, 10
 sw t0, 12(a0)
 addi t0, x0, 40
 sw t0, 16(a0)
 addi t0, x0, 50
 sw t0, 20(a0)
 addi t0, x0, 1000
 sw t0, 24(a0)

jal ra, BIN_SEARCH
FIN:
jal ra, EXIT

BIN_SEARCH:
addi sp, sp, 8
sw ra, 4(sp)

blt a2, a1, INCORRECT_BOUNDS # if (r < l) return -1.

sub t0, a2, a1 # store r-l.
srai t1, t0, 1 # store (r-l)/2.
add t2, t1, a1 # store l + (r-l)/2.

# Get the 'mid' element in 'arr'.
addi t3, x0, 0 # clear t3.
addi t0, x0, 0 # clear t0.

LOOP:
beq t0, t2, END_LOOP
addi t0, t0, 1
addi t3, t3, 4  # mid * sizeof(int)
beq x0, x0, LOOP
END_LOOP:

add t3, t3, a0 # pointer to arr[mid].
lw t0, 0(t3)   # get value at arr[mid].

bne t0, a3, SKIP_ONE # if (arr[mid] == x) return mid.
add a0, x0, t2
beq x0, x0, RET

SKIP_ONE:
blt t0, a3, SKIP_TWO # if (arr[mid] > x) return bin_search(arr, l, mid-1, x).
addi a2, t2, -1 # l = mid - 1
jal ra, BIN_SEARCH

SKIP_TWO:
addi a1, t2, 1 # r = mid + 1
jal ra, BIN_SEARCH

INCORRECT_BOUNDS:
addi a0, x0, -1
RET:
lw ra, 4(sp)
addi sp, sp, 8
jal ra, FIN

EXIT:
