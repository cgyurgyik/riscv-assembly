# A function that implements the selection sort algorithm.
# Running time complexity:  O(n^2)
# Running space complexity: O(1)
#
# selection_sort(int arr[], int size)
# Requires: length(arr) == size

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

slli t5, t1, 2  # j * sizeof(int)
add t6, a0, t5
lw t4, 0(t6)    # Load arr[j]   

slli t5, t2, 2  # min_index * sizeof(int)
add t6, a0, t5  # arr[min_index]
lw t3, 0(t6)    # Load arr[min_index] 

blt t3, t4, MIN_REMAINS_SAME # if (arr[min_index] < arr[j]), don't change the min.
addi t2, t1,0   # min_index = j
MIN_REMAINS_SAME:

addi t1, t1, 1  # j = j + 1
beq x0, x0, SUBARRAY_LOOP
END_SUBARRAY_LOOP:

slli t5, t2, 2    # min_index * sizeof(int)
add t6, a0, t5    # arr[min_index]
lw t3, 0(t6)      # Load arr[min_index]  

slli t1, t0, 2    # i * sizeof(int)
add t1, t1, a0    # arr[i] 
lw t4, 0(t1)      # Load arr[i]

sw t3, 0(t1)
sw t4, 0(t6)      # swap(&arr[min_index], &arr[i])

addi t0, t0, 1   # i = i + 1
beq x0, x0, UNSORTED_ARRAY_BOUNDARY_LOOP
END_UNSORTED_ARRAY_BOUNDARY_LOOP: 

lw s0, 0(sp)
lw ra, 4(sp)
addi sp, sp, 8
jalr x0, ra, 0

EXIT:
