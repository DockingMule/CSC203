; Austin Alloway
; Alishba Younas
; 4/17/2019
; Lab 4
; Purpose:
;		user input starting and ending number
;		and program generates random numbers as many
;		times as user chooses.
TITLE MASM Template						(main.asm)

; Import the Irvine library functions
INCLUDE Irvine32.inc

; Data declarations section used to declare variables for the program
.data
	startingNumberPrompt BYTE "What is the starting number? ",0
	endingNumberPrompt BYTE "What is the ending number? ",0
	numberOfGenerationsPrompt BYTE "How many times do you want to randomly generate a number? ",0
	endingPrompt BYTE "Thanks for running the lottery simulator...",0
	fancyLines BYTE 30 DUP ('~-'),0
	numberOfGenerations DWORD 0
	startingNumber DWORD 0
	endingNumber DWORD 0


; Code section used to write the code for the program.
.code
main PROC

	; ---------------------------------------------------
	; Gathering starting, ending, and generation numbers
	; ---------------------------------------------------

	MOV edx, OFFSET fancyLines	
	CALL writeString

	CALL crlf

	MOV edx, OFFSET startingNumberPrompt		; Getting starting number
	CALL writeString
	CALL readDec
	MOV startingNumber, eax

	MOV edx, OFFSET endingNumberPrompt			; Getting ending number
	CALL writeString
	CALL readDec
	MOV endingNumber, eax

	MOV edx, OFFSET numberOfGenerationsPrompt	; Getting number of generations	
	CALL writeString
	CALL readDec
	MOV numberofGenerations, eax

	MOV edx, OFFSET fancyLines	
	CALL writeString

	CALL crlf

	
	; ---------------------------------------------------
	; Looping each generation and printing random number
	; ---------------------------------------------------

	MOV edx, startingNumber			; for myRandom starting number
	MOV ebx, endingNumber			; for myRandom ending number
	MOV ecx, numberOfGenerations	; for loop iterations
	CALL Randomize

	L1:
		CALL myRandom			; user defined procedure
		CALL writeDec
		CALL crlf
		LOOP L1

	; ---------------------------------------------------
	; final prompt
	; ---------------------------------------------------


	MOV edx, OFFSET fancyLines		
	CALL writeString

	CALL crlf

	MOV edx, OFFSET endingPrompt
	CALL writeString

	CALL crlf

	MOV edx, OFFSET fancyLines	
	CALL writeString

	CALL crlf

	exit
main ENDP


;----------------------------------------------------
myRandom PROC
; purpose: random number within staring and ending number
; Recieves:
;	edx - starting number
;	ebx - ending number
;
; Returns:
;	eax - contains random number
;----------------------------------------------------

	MOV eax, ebx
	SUB eax, edx
	INC eax
	CALL RandomRange
	ADD eax, edx
	ret

myRandom ENDP		;end of user defined procedure

END main