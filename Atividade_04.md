# Atividade 04 - Questões Pós-Aula

### Jean Carlos Pereira Cassiano - NUSP: 13864008 <br> Giovanna de Freitas Velasco - NUSP: 13676346

## Atividade 1

### Transferência de Dados
#### Código para o 3081:

```assembly
org	0000h
       
main:
	MOV	A, #12h		; Move o valor 12 para ACC
	MOV	A, #00h		; Move o valor 00 para ACC
 	MOV 	R2, #34h	; Move o valor 34 para o R2 no Banco 0
 	MOV	B, #56		; Move o valor 56 em binário para B
	MOV 	0x40, P1	; Move o conteúdo da porta P1 para o endereço 0x40
	SETB	RS0		; Seta o bit RS0 em 1
	MOV 	R4, #0x40	; Move o valor 04x0 para R4 no Banco 1
 	MOV 	0X50, R4	; Move o conteúdo de R4 para o endereço 0x50
 	MOV 	R1, 0x50	; Move o conteúdo do enderedeço 0x50 para R1
	MOV 	A, @R1		; Move o conteúdo do endereço armazenado em R1 para ACC
	MOV 	DPTR, #0X9A5B	; Move o valor 0X9A5B para DPTR
	JMP	$		; Segura o programa na última linha
	END			; Encerra o programa
```
#### Questões:

*(a) Qual foi o tempo gasto em cada linha de instrução e quantos ciclos de máquina esse programa contém? Justifique sua resposta.*

```assembly
	MOV	A, #12h		; Tempo: 1𝜇𝑠
	MOV	A, #00h		; Tempo: 1𝜇𝑠
	MOV 	R2, #34h	; Tempo: 1𝜇𝑠
	MOV	B, #56		; Tempo: 2𝜇𝑠
	MOV 	0x40, P1	; Tempo: 2𝜇𝑠
	SETB	RS0		; Tempo: 1𝜇𝑠
	MOV 	R4, #0x40	; Tempo: 1𝜇𝑠
	MOV 	0X50, R4	; Tempo: 2𝜇𝑠
	MOV 	R1, 0x50	; Tempo: 2𝜇𝑠
	MOV 	A, @R1		; Tempo: 1𝜇𝑠
	MOV 	DPTR, #0X9A5B	; Tempo: 2𝜇𝑠
```
Considerando que cada ciclo de máquina tem duração de $1 \mu s$, o programa contém 16 ciclos de máquina no total.

<br>

*(b) O que aconteceu ao mover uma porta inteira de 8 registradores (ex.: MOV A, P1) para um destino e por que seu valor é FF?*

Cada bit da porta foi copiado para os bits do endereço de memória. Seu valor é FF pois todos os 8 bits em valor têm valor 1 e, assim, o número hexadecimal correspondente é FF.

<br>

*(c) Qual valor apareceu no acumulador após ter movido R1 de forma indireta para ele?*

Após mover R1 indiretamente para o ACC, o valor de ACC é FF. Isso ocorre porque o valor armazenado em R1 nesse momento é 0x40 e nesse endereço de memória está armazenado FF, já que a porta P1 foi copiada para esse endereço com todos seus bits iguais a 1.

<br>

*(d) Por que foi possível mover um valor de 4 dígitos para DPTR? Em quais registradores especiais do simulador foi possível verificar mudanças quando essa operação foi realizada? Qual o maior valor que pode ser movido para DPTR em hexadecimal?*

O DPTR é um registrador especial interno à RAM chamado Data Pointer, que utiliza dois registradores de 8 bits (DPH e DPL) nesta ordem para endereçar qualquer valor possível de memória externa. É possível mover um valor de 4 dígitos pois o DTPR possui 16 bits no total, já que o 8051 possui endereçamento de até 64 Kbytes de memória de dados externa. Quando a intrução MOV DPTR, #0X9A5B é executada, o registrador DPH recebeu o valor 0x9A e DPL recebeu 0x5B. O maior valor em hexadecimal que pode ser movido em é 0xFFFF.

<br>

### Instruções Aritméticas
#### Código para o 3081:

```assembly
org	0000h

main:
	MOV 	ACC, #02h	; Move o valor 2 de forma imediata para ACC
	MOV 	B, #03h		; Move o valor 3 de forma imediata para B
	MOV	R4, #07h	; Move o valor 7 de forma imediata para o R4
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
	JMP	$		; Segura o programa na última linha
	END			; Encerra o programa
```

#### Questões:

*(e) Faça os seguintes testes em um programa a parte:*

*1. Por que ao mover o valor 4 para ACC, o bit menos significativo de PSW resulta em 1; e ao mover o valor 3, esse bit resulta em 0?*

O dígito menos significativo do PSW é a Parity Flag, que indica se há um número par ou ímpar de 1s no valor em binário do acumulador. Portanto, quando o valor em ACC é 4, a flag de paridade é 0, já que há dois 1s em ACC. Quando movemos o valor 3, o valor em ACC é formado por apenas um 1 e, assim, a flag de paridade é 1, monstrando que há um número ímpar de 1s no valor de ACC. 

<br>

*2. Tente decrementar 1 unidade de algum registrador ou endereço de memória cujo valor é igual a zero (ex.: DEC A, DEC Rn, ou DEC 60h, sendo A, Rn, ou 60h iguais a zero). Por que a operação resulta em FF?*

A operação resulta em 0xFF pois o microprocessador opera em um sistema de numeração binário de 8 bits e, ao decrementar um valor 0, ele "volta" ao maior valor representável em 8 bits, que é equivalente a FF em hexadecimal.

<br>

### Instruções Lógicas e Booleanas
#### Código para o 3081:

```assembly
org	0000h

main:
	MOV	A, #11001100b	; Move o valor 11001100 em binário de forma imediata para ACC
	MOV	B, #10101010b	; Move o valor 10101010 em binário de forma imediata para B
	ANL	A, B		; Realiza o AND lógico entre ACC e B
	RR	A		; Rotaciona ACC à direita em 1 bit
	RR	A		; Rotaciona ACC à direita em 1 bit
	CPL 	A		; Realiza o complemento de ACC
	RL	A		; Rotaciona o ACC à esquerda em 1 bit
	RL	A		; Rotaciona o ACC à esquerda em 1 bit
	ORL	A, B		; Realiza o OR lógico entre A e B
	XRL 	A, B		; Realiza o XOR lógico entre A e B
	SWAP 	A		; Troca os bits de 0-3 com os bits de 4-7 no ACC
	JMP	$		; Segura o programa na última linha
	END			; Encerra o programa
```

<br>

### Instruções de Desvio Condicional e Incondicional
#### Código para o 3081:

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

<br>

## Atividade 2

#### Código para o 3081:

```assembly
org	0000h

main:
	org	33h			; Origem em 33h
	MOV	R0, #20h		; Move de forma imediata o valor 20h para R0
	MOV	R1, #00h		; Move de forma imediata o valor 00h para R1

loop_1:
	MOV	A, @R0			; Move o conteúdo presente no endereço armazenado R0 para ACC
	SUBB	A, #45h			; Subtrai 45h de ACC
	JNC	loop_2			; Se não houver carry, salta para loop_2
	INC	R1			; Incrementa o valor de R1
	
loop_2:
	INC	R0			; Incrementa o valor de R0
	CJNE	R0, #24h, loop_1	; Se o valor armazenado em R0 for diferente de 24h salta para loop_1
	NOP				; Espera um ciclo
	JMP	$			; Segura o programa na última linha

	END				; Encerra o programa
```

O programa verifica as posições de memória de 0x20 até 0x23, verificando quais valores armazenados nessas posições são menores que 45h. Caso o número seja menor que 45, sua subtração no ACC terá um carry no PSW, que gera um salto para contabilizar esse número no registrador R1. Assim, a quantidade de números menores que 45h sãa armazenados no R1.

