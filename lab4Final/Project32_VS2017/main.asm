; Austin Alloway
; Brody Carney
; 4/30/19
; Lab 5
; Purpose:
;		Input number of characters and string of coded characters
;		decodes characters using key string
;		output decoded message
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
	mov eax, OFFSET codedMessage
	mov edi, OFFSET keypass
	mov ecx, valueCount
	CALL key

;------------------------------------------------------------------------------
; Final outputs
;------------------------------------------------------------------------------
	mov edx, OFFSET decodedMessagePrompt
	CALL WriteString

	mov edx, OFFSET codedMessage
	CALL WriteString

	exit
main ENDP

;----------------------------------------------------
key PROC
; purpose: Takes in coded string and decodes using passcode string
;		!!!INITIAL CODED STRING BECOMES OVERWRITTEN!!!
; Recieves:
;	EAX: string to decode/coded
;	EDI: String passcode
;	ECX: amount of values
; Returns:
;	EAX: decoded string
;----------------------------------------------------
mov edx, 0
mov esi, 0
decoderLoop:
	mov ebx, [eax + esi * 4]
	mov dl, [edi + ebx]
	mov [eax + esi], dl
	INC esi
	LOOP decoderLoop
	ret
key ENDP		;end of user defined procedure

END main
