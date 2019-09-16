# loop 100 x sw into memory: 1, 2, 3, ..., 100

# $8 for loopC
# $9 for n
# $10 for addr

# $23 as temp

addi $8, $0, 100
addi $9, $0, 1
ori $10, $0, 0x2000

loop_100:

# check 1: n is 4x
# idea: n AND 3, check result (0: 4x; 1: otherwise)
andi $23, $9, 3
beq $23, $0, related_4



# UNrelated to 4: does this
sw $9, 0($10)
j out

# related to 4: does the following
related_4:
addi $23, $0, -1
sw $23, 0($10)

out:

addi $9, $9, 1
addi $10, $10, 4
addi $8, $8, -1

bne $8, $0, loop_100
