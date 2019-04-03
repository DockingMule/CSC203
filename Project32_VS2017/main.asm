TITLE MASM Template						(main.asm)

; Import the Irvine library functions
INCLUDE Irvine32.inc

.data
	stringPrompt BYTE "Please enter a string to reverse: ", 0
	userStringInput BYTE 51 DUP(0)
	userStringLength DWORD 0
	userStringReversed BYTE 51 DUP(0)

.code
main PROC
	call Clrscr

	; Ask the user for a string
	mov edx, OFFSET stringPrompt
	call WriteString

	mov edx, OFFSET userStringInput
	mov ecx, LENGTHOF userStringInput - 1
	call READSTRING
	mov userStringLength, eax

	;starting at the last non null character in userStringInput
	;input each character into userStringReversed
	mov ebx, 0
	mov ecx, userStringLength
	mov eax, userStringlength
	dec eax

	L1:
		mov dl, [userStringInput + eax]
		mov [userStringReversed + ebx], dl
		inc ebx
		dec eax
	loop L1

	CALL Clrscr

	mov edx, OFFSET userStringReversed
	CALL WriteString



	

	exit
main ENDP

END main