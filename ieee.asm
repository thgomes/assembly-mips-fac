.data
	zero: .float 0.0 # zero em float
	breakLine: .asciiz "\n"
	positive: .asciiz "+"
	negative: .asciiz "-"
	hexDigits: .asciiz "0123456789abcdef"
	hexNotation: .asciiz "0x"
	
.text
main:
	# READ INPUT
	li $v0, 6 # read float
	syscall
	lwc1 $f1, zero # add zero value to $f1
	add.s $f12, $f1, $f0 # add readed number to $f12

	# PRINT FLOAT NUMBER
	li $v0, 2 # print float number
	syscall
	jal printBreakLine

	# move from coproc1 to register
	mfc1 $t1, $f0 

	# EXTRACT AND PRINT SIGNAL
	move $a1, $t1
	jal printSignal
	jal printBreakLine
	
	# EXTRACT AND PRITN EXPOENT
	move $a1, $t1
	jal printExponent
	jal printBreakLine
	
	# EXTRACT AND PRINT MANTISSA
	move $a1, $t1
	jal printMantissa
	jal printBreakLine
	
	# END PROGRAM
	jal endProgram
	
printSignal:
	srl $t0, $a1, 31 # get signal digit
	beq $t0, 0, printPositive # print positive if digit is 0
	beq $t0, 1, printNegative #print negative if digit is 1
	return_signal_print:
	
	jr $ra
	
printExponent:
	# MASK MASK
	srl $a1, $a1, 23
	and $t0, $a1, 0xff
	# Sub
	sub $t0, $t0, 127
	# Print
	li $v0, 1 # printa inteiro
	move $a0, $t0 # move resultado da soma para $a0
	syscall # executa
	
	jr $ra
printMantissa:
	# MASK IS $S0
	addi $sp, $sp, -4
	sw $s0, 0($sp)
	# Make the mask
	li $s0, -1
	srl $s0, $s0, 9
	and $t0, $a1, $s0
	
	# Print hex symbol
	li $v0, 4
	la $a0, hexNotation
	syscall
	
	addi $t1, $zero 28 # Create iterator
	printHexLoop: 	
		srlv $t2, $t0, $t1
		and $t2, $t2, 0xf
		beq $t2, 0, printZero
		beq $t2, 1, printOne
		beq $t2, 2, printTwo
		beq $t2, 3, printThree
		beq $t2, 4, printFour
		beq $t2, 5, printFive
		beq $t2, 6, printSix
		beq $t2, 7, printSeven
		beq $t2, 8, printEight
		beq $t2, 9 printNine
		beq $t2, 10, printA
		beq $t2, 11, printB
		beq $t2, 12, printC
		beq $t2, 13, printD
		beq $t2, 14, printE
		beq $t2, 15, printF
		return_print_hex:
		beq $t1, 0, endLoop
		sub $t1, $t1, 4
		j printHexLoop
	endLoop: 
		jr $ra

printBreakLine:
	li, $v0, 4 # print command
	la, $a0, breakLine, # add break line to $a0
	syscall # print break line
	jr $ra
	
endProgram:
	li $v0, 10
	syscall
	
# CONDITIONALS ARGUMENTS
printPositive:
	# PRINT POSITIVE SIGN
	li $v0, 4
	la $a0, positive
	syscall
	j return_signal_print
printNegative:
	# PRINT NEGATIVE SIGN
	la $t8, hexDigits
	li $v0, 4
	la $a0, negative
	syscall	
	j return_signal_print

printZero:
	la $t8, hexDigits
	li $v0, 11
	lb $a0, 0($t8)
	syscall
	j return_print_hex
printOne:
	la $t8, hexDigits
	li $v0, 11
	lb $a0, 1($t8)
	syscall
	j return_print_hex
printTwo:
	la $t8, hexDigits
	li $v0, 11
	lb $a0, 2($t8)
	syscall
	j return_print_hex
printThree:
	la $t8, hexDigits
	li $v0, 11
	lb $a0, 3($t8)
	syscall
	j return_print_hex
printFour:
	la $t8, hexDigits
	li $v0, 11
	lb $a0, 4($t8)
	syscall
	j return_print_hex
printFive:
	la $t8, hexDigits
	li $v0, 11
	lb $a0, 5($t8)
	syscall
	j return_print_hex
printSix:
	la $t8, hexDigits
	li $v0, 11
	lb $a0, 6($t8)
	syscall
	j return_print_hex
printSeven:
	la $t8, hexDigits
	li $v0, 11
	lb $a0, 7($t8)
	syscall
	j return_print_hex
printEight:
	la $t8, hexDigits
	li $v0, 11
	lb $a0, 8($t8)
	syscall
	j return_print_hex
printNine:
	la $t8, hexDigits
	li $v0, 11
	lb $a0, 9($t8)
	syscall
	j return_print_hex
printA:
	la $t8, hexDigits
	li $v0, 11
	lb $a0, 10($t8)
	syscall
	j return_print_hex
printB:
	la $t8, hexDigits
	li $v0, 11
	lb $a0, 44($t8)
	syscall
	j return_print_hex
printC:
	la $t8, hexDigits
	li $v0, 11
	lb $a0, 11($t8)
	syscall
	j return_print_hex
printD:
	la $t8, hexDigits
	li $v0, 11
	lb $a0, 12($t8)
	syscall
	j return_print_hex
printE:
	la $t8, hexDigits
	li $v0, 11
	lb $a0, 13($t8)
	syscall
	j return_print_hex
printF:
	la $t8, hexDigits
	li $v0, 11
	lb $a0, 14($t8)
	syscall
	j return_print_hex
