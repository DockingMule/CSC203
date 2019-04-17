;Austin Alloway
;4/13/2019
;Lab 3
;Purpose: 
;	input: user name, major, birthyear, and graduation year
;	output: name, major, and age at graduation
TITLE MASM Template						(main.asm)

; Import the Irvine library functions
INCLUDE Irvine32.inc

.data
	namePrompt BYTE "What is your name > ", 0
	majorPrompt BYTE "What is your major in college > ", 0
	birthYearPrompt BYTE "What year were you born > ", 0
	graduationYearPrompt BYTE "What year are you expected to graduate > ", 0
	fancyLines BYTE 40 DUP ('~-'), 0

	final1 BYTE ", you will be ", 0
	final2 BYTE " years old when you graduate with a degree in ", 0
	final3 BYTE ".", 0

	userName BYTE 101 DUP (0);
	major BYTE 101 DUP (0);
	birthYear DWORD 0;
	graduationYear DWORD 0;
	graduationAge DWORD 0;

.code
main PROC
	call Clrscr
	;--------------------------------------
	; INITIAL PROMPTS AND INPUUTS
	;--------------------------------------

	mov edx, OFFSET fancyLines	; For Looks
	CALL WriteString
	CALL crlf

	mov edx, OFFSET namePrompt	; Gathering user Name
	CALL WriteString
	mov edx, OFFSET userName
	mov ecx, LENGTHOF userName - 1
	CALL ReadString

	mov edx, OFFSET majorPrompt	; Gathering user Major
	CALL WriteString
	mov edx, OFFSET major
    mov ecx, LENGTHOF major - 1       
    call ReadString

	mov edx, OFFSET birthYearPrompt	; Gathering user birth year
	CALL WriteString
	CALL ReadDec		
	MOV birthYear, eax	

	
	mov edx, OFFSET graduationYearPrompt	; Gathering user graduation date
	CALL WriteString
	CALL ReadDec
	MOV graduationYear, eax	
	
	CALL crlf
	mov edx, OFFSET fancyLines	; For Looks
	CALL WriteString
	

	;--------------------------------------
	; GETTING AGE AT GRADUATION
	;--------------------------------------

	MOV eax, graduationYear
	MOV ebx, birthYear
	CALL subValues
	MOV graduationAge, ecx

	;--------------------------------------
	; FINAL OUTPUTS
	;--------------------------------------

	CALL crlf

	mov edx, OFFSET userName
	CALL WriteString

	mov edx, OFFSET final1
	CALL WriteString

	mov eax, graduationAge
	CALL WriteDec

	mov edx, OFFSET final2
	CALL WriteString

	mov edx, OFFSET major
	CALL WriteString

	mov edx, OFFSET final3
	CALL WriteString

	CALL crlf
	mov edx, OFFSET fancyLines	; For Looks
	CALL WriteString


	exit
main ENDP

;----------------------------------------------------
subValues PROC
; purpose: subtracts two valies and returns their difference
; Recieves:
;	eax - contains first value to subtract from
;	ebx - second value for subtracing
;
; Returns:
;	ecx - contains difference of two input values
;----------------------------------------------------

	MOV ecx, 0
	ADD ecx, eax
	SUB ecx, ebx
	ret
subValues ENDP		;end of user defined procedure

END main