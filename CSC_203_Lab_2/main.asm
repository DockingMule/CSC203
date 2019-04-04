TITLE MASM Template						(main.asm)

; Import the Irvine library functions
INCLUDE Irvine32.inc

.data
	; stringPrompts are for the initial info
	stringPrompt1 BYTE "This Program takes a string that you input and reverses it.",0
	stringPrompt2 BYTE "Please enter the string you would like reversed: ",0
	; finalPrompts are for the final outputs/reversed string
	finalPromptInput BYTE "The string you entered is: ", 0
	finalPromptReversed BYTE "Reversed it is: ", 0
	; fancyLines is to make the prgram look a little better
	fancyLines BYTE 30 DUP('~-'), 0
	;userStrings are for use with the string itself and its munipulation
	userStringInput BYTE 101 DUP(0)
	userStringLength DWORD 0
	userStringReversed BYTE 101 DUP(0)

.code
main PROC
	call Clrscr
	;---------------------------
	;INITIAL OUTPUTS AND INPUTS
	;---------------------------

	; For looks
	mov edx, OFFSET fancyLines
	CALL WriteString

	CALL Crlf

	; printing the initial information explaining program
	; and asking for a string
	mov edx, OFFSET stringPrompt1
	call WriteString

	CALL Crlf

	mov edx, OFFSET stringPrompt2
	call WriteString

	; Inputing the information given by the user into userStringInput
	mov edx, OFFSET userStringInput
	mov ecx, LENGTHOF userStringInput - 1
	call READSTRING		; calling Readstring automatically inputs the strings length into eax
	mov userStringLength, eax

	;---------------------------
	;LOOP TO REVERSE STRING
	;---------------------------

	;starting at the last non null character in userStringInput
	;input each character into userStringReversed
	mov ebx, 0 ; clear out ebx
	mov ecx, userStringLength	; for looping L1 for each character
	mov eax, userStringlength	; for use pointing to the correct character in the string
	dec eax

	;loop through userStringInput starting at the last and
	;input each character into userStringReversed starting at the beginning
	L1:
		mov dl, [userStringInput + eax]
		mov [userStringReversed + ebx], dl
		inc ebx
		dec eax
	loop L1

	;;--------------------------------
	;;FINAL OUTPUTS
	;;--------------------------------
	CALL Clrscr

	; for looks
	mov edx, OFFSET fancyLines
	CALL WriteString

	CALL Crlf

	; showing the user what string they wanted reversed
	mov edx, OFFSET finalPromptInput
	CALL WriteString
	; printing their initial string
	mov edx, OFFSET userStringInput
	CALL WriteString

	CALL Crlf

	; Showing the user their reversed string
	mov edx, OFFSET finalPromptReversed
	CALL WriteString
	; printingt thier reversed string
	mov edx, OFFSET userStringReversed
	CALL WriteString

	CALL Crlf

	; for looks
	mov edx, OFFSET fancyLines
	CALL WriteString

	CALL Crlf

	exit
main ENDP

END main