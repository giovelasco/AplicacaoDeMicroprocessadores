# Atividade 04 - Questões Pós-Aula

### Jean Carlos Pereira Cassiano - NUSP: 13864008 <br> Giovanna de Freitas Velasco - NUSP: 13676346

## Atividade 1

### Transferência de Dados
Código para o 3081:

```assembly
      org	0000h
       
      main:
0000| 	MOV	A, #12h		; Move o valor 12 para ACC
0002| 	MOV	A, #00h		; Move o valor 00 para ACC
0004| 	MOV 	R2, #34h	; Move o valor 34 para o R2 no Banco 0
0006| 	MOV	B, #56		; Move o valor 56 em binário para B
0009| 	MOV 	0x40, P1	; Move o conteúdo de P1 para o enredeço 0x40
000C| 	SETB	RS0		; Seta o bit RS0 em 1
000E| 	MOV 	R4, #0x40	; Move o valor 04x0 para R4 no Banco 1
0010| 	MOV 	0X50, R4	; Move o conteúdo de R4 para o endereço 0x50
0012| 	MOV 	R1, 0x50	; Move o conteúdo do enderedeço 0x50 para R1
0014| 	MOV 	A, @R1		; Move o conteúdo do endereço armazenado em R1 para ACC
0015| 	MOV 	DPTR, #0X9A5B	; Move o valor 0X9A5B para 
```
Questões:

*(a) Qual foi o tempo gasto em cada linha de instrução e quantos ciclos de máquina esse programa contém? Justifique sua resposta.*

```assembly
	MOV	A, #12h		; Tempo: 1us
	MOV	A, #00h		; Tempo: 1us
	MOV 	R2, #34h	; Tempo: 1us
	MOV	B, #56		; Tempo: 2us
	MOV 	0x40, P1	; Tempo: 2us
	SETB	RS0		; Tempo: 1us
	MOV 	R4, #0x40	; Tempo: 1us
	MOV 	0X50, R4	; Tempo: 1us
	MOV 	R1, 0x50	; Tempo: 2us
	MOV 	A, @R1		; Tempo: 1us
	MOV 	DPTR, #0X9A5B	; Tempo: 2us
```
Considerando que cada ciclo de máquina tem duração de 1us, o programa contém 16 ciclos de máquina no total.

<br>

*(b) O que aconteceu ao mover uma porta inteira de 8 registradores (ex.: MOV A, P1) para um destino e por que seu valor é FF?*

Cada bit da porta foi copiado para os bits do endereço de memória. Seu valor é FF pois todos os 8 bits em valor têm valor 1 e, assim, o número hexadecimal correspondente é FF.

<br>

*(c) Qual valor apareceu no acumulador após ter movido R1 de forma indireta para ele?*

Após mover R1 indiretamente para o ACC, o valor de ACC é FF. Isso ocorre porque o valor armazenado em R1 nesse momento é 0x40 e nesse endereço de memória foi armazenada a porta P1, com todos seus bits iguais a 1.

<br>

*(d) Por que foi possível mover um valor de 4 dígitos para DPTR? Em quais registradores especiais do simulador foi possível verificar mudanças quando essa operação foi realizada? Qual o maior valor que pode ser movido para DPTR em hexadecimal?*


<br>

### Instruções Aritméticas
Código para o 3081:

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
Código para o 3081:

```assembly
org	0000h

main:
	MOV  A, #11001100B	; Move o valor 0b11001100 para ACC
	MOV	B, #10101010B	; Move o valor 0b10101010 para B
	ANL A, B	; Realiza o AND lógico entre A e B
	RR		A	; Rotaciona o ACC à direita em 1 bit
	RR		A	; Rotaciona o ACC à direita em 1 bit
	CPL A	; Realiza o complemento de ACC
	RL		A	; Rotaciona o ACC à esquerda em 1 bit
	RL		A	; Rotaciona o ACC à esquerda em 1 bit
	ORL A, B	; Realiza o OR lógico entre A e B
	XRL A, B	; Realiza o XOR lógico entre A e B
	SWAP A		; Troca os bits de 0-3 com os bits de 4-7 no ACC
```

### Instruções de Desvio Condicional e Incondicional
Código para o 3081:

```assembly
org	0000h

inicio:
	CLR	A		; Limpa o ACC
	MOV	R0, #0x10	; Move o valor 0x10 para R0

bloco1:
	JZ	bloco2		; Salta para bloco2 caso ACC nulo
	JNZ	bloco3		; Salta para bloco3 caso ACC não nulo
	NOP			; Espera 1 ciclo sem operação
	
bloco2:
	MOV	A, R0		; Move o valor de R0 para ACC
	JMP	bloco1		; Salta para o bloco1

bloco3:
	DJNZ	R0, bloco3	; Decrementa R0 e salta para bloco3 se R0 diferente de 0
	JMP	inicio		; Retorna para o inicio

```

; Duvidas: os registradores, quando não é especificado, estão no banco 0?
