# Function to represent the state transitions of the MSI cache coherence protocol.
# MSI stands for Modified-Shared-Invalid. It can be represented with the following
# transitions:
#
# Modified -> Modified : Ld, St
# Modified -> Shared : LdMiss
# Modified -> Invalid : StMiss, WB
#
# Shared -> Shared : Ld, LdMiss, WB 
# Shared -> Modified : St
# Shared -> Invalid : StMiss
#
# Invalid -> Invalid : StMiss, LdMiss, WB
# Invalid -> Shared : Ld
# Invalid -> Modified : St
#
# Acronyms: Ld -> Load, 
#           St -> Store, 
#           LdMiss -> Load Miss (from another processor), 
#           StMiss -> Store Miss (from another processor), 
#           WB -> Writeback
#
# Unfortunately, we will have to deal in magic numbers:
#
# 1: Modified
# 2: Shared
# 3: Invalid
#
# 10: Ld
# 20: St
# 30: LdMiss
# 40: StMiss
# 50: WB
#
# change_MSI_state(int current_state, int transition)
# Returns: the new state according to the MSI model.
# Requires: 
#           'current_state': 1, 2, 3
#           'transition':    10, 20, 30, 40, 50

addi gp, gp, 10000

# MAIN
addi t1, x0, 1    # Store gloal variable
addi t2, x0, 2    # values of Modified, Shared, Invalid.
addi t3, x0, 3    # i.e. 
sw t1, 0(gp)      # MODIFIED = 1;
sw t2, 4(gp)
sw t3, 8(gp)

addi t0, x0, 10   # Store global variable 
addi t1, x0, 20   # values of Ld, St, LdMiss, StMiss, WB
addi t2, x0, 30
addi t3, x0, 40
addi t4, x0, 50
sw t0, -4(gp)
sw t1, -8(gp)
sw t2, -12(gp)
sw t3, -16(gp)
sw t4, -20(gp)

addi sp, sp, 1000
addi a0, x0, 3  # Current state: Invalid
addi a1, x0, 10 # Transition:    Load
jal ra, CHANGE_BIT_STATE
jal ra, EXIT

CHANGE_BIT_STATE:
addi sp, sp, -4
sw ra, 0(sp)

lw t1, 0(gp)
lw t2, 4(gp)
lw t3, 8(gp)

beq a0, t1, MODIFIED
beq a0, t2, SHARED
beq a0, t3, INVALID

beq x0, x0, RET # Current state is not one of the three states.

MODIFIED:
lw t0, -4(gp)
lw t1, -8(gp)
lw t2, -12(gp)
lw t3, -16(gp)
lw t4, -20(gp)

beq a1, t0, M_LOAD
beq a1, t1, M_STORE
beq a1, t2, M_LOAD_MISS
beq a1, t3, M_STORE_MISS
beq a1, t4, M_WB
beq x0, x0, RET # transition is not one of the five transitions.

M_LOAD:
M_STORE:
beq x0, x0, RET

M_LOAD_MISS:
addi a0, x0, 2
beq x0, x0, RET

M_STORE_MISS:
addi a0, x0, 3
beq x0, x0, RET

M_WB:
addi a0, x0, 3
beq x0, x0, RET

SHARED:
lw t0, -4(gp)
lw t1, -8(gp)
lw t2, -12(gp)
lw t3, -16(gp)
lw t4, -20(gp)

beq a1, t0, S_LOAD
beq a1, t1, S_STORE
beq a1, t2, S_LOAD_MISS
beq a1, t3, S_STORE_MISS
beq a1, t4, S_WB
beq x0, x0, RET # transition is not one of the five transitions.

S_STORE:
addi a0, x0, 1
beq x0, x0, RET

S_LOAD_MISS:
S_LOAD:
S_WB:
beq x0, x0, RET

S_STORE_MISS:
addi a0, x0, 3
beq x0, x0, RET

INVALID:
lw t0, -4(gp)
lw t1, -8(gp)
lw t2, -12(gp)
lw t3, -16(gp)
lw t4, -20(gp)

beq a1, t0, I_LOAD
beq a1, t1, I_STORE
beq a1, t2, I_LOAD_MISS
beq a1, t3, I_STORE_MISS
beq a1, t4, I_WB
beq x0, x0, RET # transition is not one of the five transitions.

I_LOAD:
addi a0, x0, 2
beq x0, x0, RET

I_STORE:
addi a0, x0, 1
beq x0, x0, RET

I_LOAD_MISS:
I_STORE_MISS:
I_WB:
beq x0, x0, RET

RET:
lw ra, 0(sp)
addi sp, sp, 4
jalr x0, ra, 0

EXIT:
