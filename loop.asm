# loop 100 x sw into memory: 1, 2, 3, ..., 100

# $8 for loopC
# $9 for n
# $10 for addr
# $11 for x

# $23 as temp 1
# $22 as temp 2

addi $8, $0, 100
addi $9, $0, 1
ori $10, $0, 0x2000

loop_100:

# check 1: n is 4x
# idea: n AND 3, check result (0: 4x; 1: otherwise)
andi $23, $9, 3
beq $23, $0, related_4

# check 2: n has 4 as digit in dec
add $11, $0, $9

loop_dec_digit:
addi $23, $0, 10
divu $11, $23
mfhi $23 
addi $22, $0, 4
beq $22, $23, related_4
mflo $11
bne $11, $0, loop_dec_digit


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
