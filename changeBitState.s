# Function to represent the state transitions of the MSI cache coherence protocol.
# MSI stands for Modified-Shared-Invalid. It can be represented with the following
# transitions:
#
# Modified -> Modified : Ld, St
# Modified -> Shared : LdMiss
# Modified -> Invalid : StMiss, WB
#
# Shared -> Shared : Ld, LdMiss 
# Shared -> Modified : St
# Shared -> Invalid : StMiss
#
# Invalid -> Invalid : StMiss, LdMiss
# Invalid -> Shared : Ld
# Invalid -> Modified : St
#
# Acronyms: Load -> Ld, 
#           Store -> St, 
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
# changeBitState(int current_state, int transition)
# Returns: the new state according to the MSI model.

# MAIN
addi sp, sp, 1000
addi a0, x0, 3  # Current state: Invalid
addi a1, x0, 10 # Transition:    Load
jal ra, CHANGE_BIT_STATE
jal ra, EXIT


CHANGE_BIT_STATE:
#prologue

# TODO.

#epilogue

EXIT:

