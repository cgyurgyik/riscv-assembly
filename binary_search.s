# Binary search
#
# bin_search(int[] arr, int l, int r, int x)
# int[] arr: memory address of 'arr'. Assumes each element is size 4.
# l: left boundary.
# r: right boundary.
# x: element being searched for.
# 
#
# Requires: r >= l. Returns -1 otherwise. 'arr' is in sequential order.
#           l >= 0.
#           r < length(arr).

# MAIN
addi sp, sp, 10000
addi a0, x0, 0 # hardcode the memory address to begin at 0.
addi a1, x0, 0 # hardcode l = 0.
addi a2, x0, 6 # hardcore r = 6.
addi a3, x0, 40 # hardcode x = 40.

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
jal ra, EXIT

BIN_SEARCH:
addi sp, sp, -4
sw ra, 0(sp)

bne t0, a3, NOT_FOUND # if (arr[mid] == x) return mid.
add a0, x0, t2
jalr x0, ra, 0

NOT_FOUND:

blt a2, a1, INCORRECT_BOUNDS # if (r < l) return -1.

sub t0, a2, a1 # store r-l.
srai t1, t0, 1 # store (r-l)/2.
add t2, t1, a1 # store l + (r-l)/2.

# Get the 'mid' element in 'arr'.
slli t3, t2, 2 # mid * sizeof(int)
add t3, t3, a0 # pointer to arr[mid].
lw t0, 0(t3)   # get value at arr[mid].

bne t0, a3, NOT_EQ # if (arr[mid] == x) return mid.
add a0, x0, t2
jalr x0, ra, 0

NOT_EQ:

bge a3, t0, GREATER_THAN # if (x > arr[mid]) return bin_search(arr, mid+1, r, x).
addi a2, t2, -1 # r = mid - 1 # bin_search(arr, l, mid-1, x);
jal ra, BIN_SEARCH

GREATER_THAN:
addi a1, t2, 1 # l = mid + 1
jal ra, BIN_SEARCH

RET:
lw ra, 0(sp)
addi sp, sp, 4
jalr x0, ra, 0

INCORRECT_BOUNDS:
addi a0, x0, -1
lw ra, 0(sp)
addi sp, sp, 4
jalr x0, ra, 0

EXIT:
