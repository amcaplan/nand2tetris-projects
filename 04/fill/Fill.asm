// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

(EVENT_LOOP)
// Read from the keyboard
@KBD
D=M
// Whiten if keyboard is 0 (unpressed), otherwise blacken
@WHITEN
D;JEQ
@BLACKEN
0;JMP
@EVENT_LOOP
0;JMP

(WHITEN)
// Set R2 to white (0) and color!
@R2
M=0
@COLOR
0;JMP

(BLACKEN)
// Set R2 to black (-1) and color!
@R2
M=-1

(COLOR)
// Set a counter to 0; store that counter in R0.
@R0
M=0
(COLOR_LOOP)
// Exit the loop if we've colored the whole screen.
@R0
D=M
@8192
D=A-D // 8192 - number of rows we've already done
@EVENT_LOOP
D;JEQ // Exit if we've done all the rows!

// The current word to color is @SCREEN + the counter
@R0
D=M
@SCREEN
D=D+A
@current_word
M=D

// Color current_word with the color value stored in R2.
@R2
D=M
@current_word
A=M
M=D

// Increment the counter and restart the loop.
@R0
M=M+1
@COLOR_LOOP
0;JMP
