// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Make sure R2 is set to 0
@R2
M=0

// Add R1 to R2, R0 times.  For example, if R0 is 4 and R1 is 6, add 6 to
// R2 4 times, for a result of 24.
(LOOP)
// end loop if R0 == 0
@R0
D=M
@END
D;JEQ

// add R1 to R2
@R1
D=M
@R2
M=M+D

// decrement R0
@R0
M=M-1

// start the loop again!
@LOOP
0;JMP
(END)

// Infinite loop to terminate program
@END
0;JMP
