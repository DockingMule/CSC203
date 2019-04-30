TITLE MASM Template						(main.asm)

; Import the Irvine library functions
INCLUDE Irvine32.inc

; Data declarations section used to declare variables for the program
.data

;------------------------------------------------------------------------------
; data variables
;------------------------------------------------------------------------------
	valueNumberPrompt BYTE "How many values are in the message? ", 0
	codedMessagePrompt BYTE "Enter the values of the coded message: ", 0
	decodedMessagePrompt BYTE "The decoded message: ", 0

	codedMessage DWORD 25 DUP (0)
	decodedMessage BYTE 25 DUP (0)
	keypass BYTE ' ','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z', 0
	valueCount DWORD 0

; Code section used to write the code for the program.
.code
main PROC
	call Clrscr
;------------------------------------------------------------------------------
; initial Prompts
;------------------------------------------------------------------------------
	mov	 edx,OFFSET valueNumberPrompt
	call WriteString
	call ReadDec
	mov valueCount, eax

	MOV edx, OFFSET codedMessagePrompt
	CALL WriteString

	CALL crlf

;------------------------------------------------------------------------------
; loop for codedmessage string
;------------------------------------------------------------------------------
	mov ecx, valueCount
	mov ebx, 0
	codedMessageLoop:
		CALL ReadDec
		mov [codedmessage + ebx * 4], eax
		INC ebx
		Loop codedMessageLoop
;------------------------------------------------------------------------------
; User Proceduer call
;------------------------------------------------------------------------------
	CALL key

;------------------------------------------------------------------------------
; Final outputs
;------------------------------------------------------------------------------
	mov edx, OFFSET decodedMessagePrompt
	CALL WriteString

	mov edx, OFFSET decodedMessage
	CALL WriteString

	exit
main ENDP

;----------------------------------------------------
key PROC
; purpose: 
; Recieves:
; Returns:
;----------------------------------------------------
mov eax, 0
mov edx, 0
mov ebx, 0
mov ecx, valueCount

decoderLoop:
	mov eax, [codedMessage + ebx * 4]
	mov dl, [keypass + eax]
	mov [decodedMessage + ebx], dl
	INC ebx
	LOOP decoderLoop

	ret
key ENDP		;end of user defined procedure

END main