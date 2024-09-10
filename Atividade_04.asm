; Atividade 04 - Questões Pós-Aula

; Jean Carlos Pereira Cassiano - NUSP: 13864008 <br> Giovanna de Freitas Velasco - NUSP: 13676346

Transferência de Dados:
org		0000h

main:
	MOV		A, #12h			; Move o valor 12 para ACC
	MOV		A, #00h			; Move o valor 00 para ACC
	MOV 	R2, #34h		; Move o valor 34 para o R2 no Banco 0
	MOV		B, #56			; Move o valor 56 em binário para B
	MOV 	0x40b, P1		; Move o valor em P1 para o enredeço 0x40
	SETB	RS0				; Seta o bit RS0 em 1
	MOV 	R4, #0x40b		; Move o valor 04x0 para R4 no Banco 1
	MOV 	0X50b, R4		; Move o valor em R4 para o endereço 0x50
	MOV 	R1, 0x50b		; Move o valor  0x50 para R1
	MOV 	A, @R1			; Move R1 de forma indireta para ACC
	MOV 	DPTR, #0X9A5B	; Move o valor 0X9A5B para DPTR


	MOV 	ACC, #02h		; Move o valor 2 para ACC
	MOV 	B, #03h			; Move o valor 3 para B
	MOV		R4, #07h		; Move o valor 7 para o R4
	ADD		A, R4			; Soma o conteúdo de ACC com R4
	SUBB	A, #03h			; Subtrai 3 do valor de ACC
	INC		B				; Incrementa B em 1
	SUBB	A, B			; Subtrai o valor de B do valor de A
	MUL		AB				; Multiplica A e B

	INC 	B				; Incrementa o valor de B em 1
	INC 	B				; Incrementa o valor de B em 1

	DIV 	AB				; Divide A por B
	MOV 	0x70, A			; Move o conteúdo de A para o endereço 0x70
	MOV 	0x71, B			; Move o conteúdo de B para o endereço 0x71
	

	MOV		A, 0b11001100	; Move o valor 0b11001100 para ACC
	MOV		B, 0b10101010	; Move o valor 0b10101010 para B
	ANL		A, B			; Realiza o AND lógico entre ACC e B
	RR		A				; Rotaciona ACC à direita em 1 bit
	RR		A				; Rotaciona ACC à direita em 1 bit
	


; Duvidas: os registradores, quando não é especificado, estão no banco 0?
