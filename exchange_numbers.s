# A function to exchange numbers between two arrays.
# exchange_numbers(int[] arr1, int[] arr2, int size)
# Requires: length(arr1) == length(arr2) == size.
#
# Example: 
#          arr1 = {1, 3, 5}, arr2 = {2, 4, 8}
#          exchange_numbers(arr1, arr2, 3);
#          // Result:
#          arr1 = {2, 4, 8}, arr2 = {1, 3, 5}

# MAIN
addi sp, sp, 10000
 # Store array values in contiguous memory at mem address 0x0:
 # {1, 3, 5}
 addi a0, x0, 0
 addi t0, x0, 1
 sw t0, 0(a0) 
 addi t0, x0, 3
 sw t0, 4(a0)
 addi t0, x0, 5
 sw t0, 8(a0)
 
 # Store array values in contiguous memory at mem address 0xc:
 # {2, 4, 8}
 addi a1, x0, 0xc
 addi t0, x0, 2
 sw t0, 0(a1) 
 addi t0, x0, 4
 sw t0, 4(a1)
 addi t0, x1, 8
 sw t0, 8(a1)

addi a2, x0, 3  # size = 3.

jal ra, EXCHANGE_NUMBERS
jal ra, EXIT

EXCHANGE_NUMBERS:
addi sp, sp, -4
sw ra, 0(sp)

add t2, a0, x0  # arr1 address
add t3, a1, x0  # arr2 address

addi t1, x0, 0 # i
LOOP:
beq t1, a2, LOOP_END # while (i < size)
lw t5, 0(t2)
lw t4, 0(t3)
sw t5, 0(t3)         # arr1[i] -> arr2[i]
sw t4, 0(t2)         # arr2[i] -> arr1[i]

addi t1, t1, 1       # i++
addi t2, t2, 4
addi t3, t3, 4       # Go to next integer address(es)
beq x0, x0, LOOP

LOOP_END:

lw ra, 0(sp)
addi sp, sp, 4
jalr x0, ra, 0

EXIT:
