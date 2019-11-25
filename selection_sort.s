# A function that implements the selection sort algorithm.
# Time complexity:  O(n^2)
# Space complexity: O(1)
#
# selection_sort(int arr[], int size)
# Requires: length(arr) == size
#
# Limitations: Uses the Cornell RISC-V Interpreter which has limited instruction set, so some instructions are
#              implemented using other instructions.

# MAIN
addi sp, sp, 10000
# Store array values in contiguous memory at mem address 0x0:
# {1, 5, 3, 4, 10, 22, 2, 3, 44}
 addi a0, x0, 0

 addi t0, x0, 1
 sw t0, 0(a0) 
 addi t0, x0, 5
 sw t0, 4(a0)
 addi t0, x0, 3
 sw t0, 8(a0)
 addi t0, x0, 4
 sw t0, 12(a0)
 addi t0, x0, 10
 sw t0, 16(a0)
 addi t0, x0, 22
 sw t0, 20(a0)
 addi t0, x0, 2
 sw t0, 24(a0)
 addi t0, x0, 3
 sw t0, 28(a0)
 addi t0, x0, 44
 sw t0, 32(a0)

addi a1, x0, 9   # size of 'arr'

jal ra, SEL_SORT
jal ra, EXIT

SEL_SORT:
addi sp, sp, -8
sw ra, 4(sp)
sw s0, 0(sp)

addi t0, x0, 0 # i
addi t1, x0, 0 # j
addi t2, x0, 0 # min_index

addi s0, a1, 0 # store n.
addi a1, a1, -1 # n-1
UNSORTED_ARRAY_BOUNDARY_LOOP:
beq t0, a1, END_UNSORTED_ARRAY_BOUNDARY_LOOP # (while i < (n-1))

addi t2, t0, 0   # min_index = i
addi t1, t0, 1   # j = i + 1

SUBARRAY_LOOP:   
beq t1, s0, END_SUBARRAY_LOOP # (while j < n)

# BEGIN: Load arr[j] into t4
addi t5, x0, 0       # k = 0
addi t6, a0, 0       # Begin at memory address of 'arr'.

LOAD_ARR_J_LOOP:
beq t5, t1, END_LOAD_ARR_J_LOOP # while (k < j)
addi t6, t6, 4       # Add sizeof(int)
addi t5, t5, 1       # k = k + 1
beq x0, x0, LOAD_ARR_J_LOOP
END_LOAD_ARR_J_LOOP:
lw t4, 0(t6)
# END: Load arr[j] into t4

# BEGIN: Load arr[min_idx] into t3
addi t5, x0, 0       # k = 0
addi t6, a0, 0       # Begin at memory address of 'arr'.

LOAD_ARR_MIN_IDX_LOOP:
beq t5, t2, END_LOAD_ARR_MIN_IDX_LOOP # while (k < min_index)
addi t6, t6, 4       # Add sizeof(int)
addi t5, t5, 1       # k = k + 1
beq x0, x0, LOAD_ARR_MIN_IDX_LOOP
END_LOAD_ARR_MIN_IDX_LOOP:
lw t3, 0(t6)
# END: Load arr[min_idx] into t3

blt t3, t4, MIN_REMAINS_SAME # if (arr[min_index] < arr[j]), don't change the min.
addi t2, t1,0 # min_index = j
MIN_REMAINS_SAME:

addi t1, t1, 1  # j = j + 1
beq x0, x0, SUBARRAY_LOOP
END_SUBARRAY_LOOP:

# Begin swap.
addi t5, x0, 0       # k = 0
addi t6, a0, 0       # Begin at memory address of 'arr'.

LOAD_SWAP_MIN_INDEX:
beq t5, t2, END_LOAD_SWAP_MIN_INDEX # while (k < min_index)
addi t6, t6, 4       # Add sizeof(int)
addi t5, t5, 1       # k = k + 1
beq x0, x0, LOAD_SWAP_MIN_INDEX
END_LOAD_SWAP_MIN_INDEX:
lw t3, 0(t6)

addi a5, x0, 0       # k = 0
addi a6, a0, 0       # Begin at memory address of 'arr'.

LOAD_SWAP_ARR_MIN_IDX:
beq a5, t0, END_LOAD_SWAP_ARR_MIN_IDX # while (k < i)
addi a6, a6, 4       # Add sizeof(int)
addi a5, a5, 1       # k = k + 1
beq x0, x0, LOAD_SWAP_ARR_MIN_IDX
END_LOAD_SWAP_ARR_MIN_IDX:
lw t4, 0(a6)

# Perform stores.
sw t3, 0(a6)
sw t4, 0(t6)

# End swap.

addi t0, t0, 1   # i = i + 1
beq x0, x0, UNSORTED_ARRAY_BOUNDARY_LOOP
END_UNSORTED_ARRAY_BOUNDARY_LOOP: 

lw s0, 0(sp)
lw ra, 4(sp)
addi sp, sp, 8
jalr x0, ra, 0

EXIT:
