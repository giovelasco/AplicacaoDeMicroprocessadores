# Atividade 04 - Questões Pós-Aula

### Jean Carlos Pereira Cassiano - NUSP: 13864008 <br> Giovanna de Freitas Velasco - NUSP: 13676346

## Atividade 1

### Transferência de Dados
Código em Assembly:

```assembly
org	0000h

main:
	MOV	A, #12h		; Move o valor 12 para ACC
	MOV	A, #00h		; Move o valor 00 para ACC
	MOV 	R2, #34h	; Move o valor 34 para o R2 no Banco 0
	MOV	B, #56		; Move o valor 56 em binário para B
	MOV 	0x40b, P1	; Move o valor em P1 para o enredeço 0x40
	SETB	RS0		; Seta o bit RS0 em 1
	MOV 	R4, #0x40b	; Move o valor 04x0 para R4 no Banco 1
	MOV 	0X50b, R4	; Move o valor em R4 para o endereço 0x50
	MOV 	R1, 0x50b	; Move o valor  0x50 para R1
	MOV 	A, @R1		; Move R1 de forma indireta para ACC
	MOV 	DPTR, #0X9A5B	; Move o valor 0X9A5B para DPTR
```
Questões:

*(a) Qual foi o tempo gasto em cada linha de instrução e quantos ciclos de máquina esse programa contém? Justifique sua resposta.*


*(b) O que aconteceu ao mover uma porta inteira de 8 registradores (ex.: MOV A, P1) para um destino e por que seu valor é FF?*


*(c) Qual valor apareceu no acumulador após ter movido R1 de forma indireta para ele?*


*(d) Por que foi possível mover um valor de 4 dígitos para DPTR? Em quais registradores especiais do simulador foi possível verificar mudanças quando essa operação foi realizada? Qual o maior valor que pode ser movido para DPTR em hexadecimal?*


### Instruções Aritméticas
Código em Assembly:

```assembly
org	0000h

main:
	MOV 	ACC, #02h	; Move o valor 2 para ACC
	MOV 	B, #03h		; Move o valor 3 para B
	MOV	R4, #07h	; Move o valor 7 para o R4
	ADD	A, R4		; Soma o conteúdo de ACC com R4
	SUBB	A, #03h		; Subtrai 3 do valor de ACC
	INC	B		; Incrementa B em 1
	SUBB	A, B		; Subtrai o valor de B do valor de A
	MUL	AB		; Multiplica A e B

	INC 	B		; Incrementa o valor de B em 1
	INC 	B		; Incrementa o valor de B em 1

	DIV 	AB		; Divide A por B
	MOV 	0x70, A		; Move o conteúdo de A para o endereço 0x70
	MOV 	0x71, B		; Move o conteúdo de B para o endereço 0x71
	

	MOV	A, 0b11001100	; Move o valor 0b11001100 para ACC
	MOV	B, 0b10101010	; Move o valor 0b10101010 para B
	ANL	A, B		; Realiza o AND lógico entre ACC e B
	RR	A		; Rotaciona ACC à direita em 1 bit
	RR	A		; Rotaciona ACC à direita em 1 bit
```

Questões:

*(e) Faça os seguintes testes em um programa a parte:*

*1. Por que ao mover o valor 4 para ACC, o bit menos significativo de PSW resulta em 1; e ao mover o valor 3, esse bit resulta em 0?*


*2. Tente decrementar 1 unidade de algum registrador ou endereço de memória cujo valor é igual a zero (ex.: DEC A, DEC Rn, ou DEC 60h, sendo A, Rn, ou 60h iguais a zero). Por que a operação resulta em FF?*

### Instruções Lógicas e Booleanas
```assembly

```

### Instruções de Desvio Condicional e Incondicional
```assembly

```

; Duvidas: os registradores, quando não é especificado, estão no banco 0?
