# Atividade 05 - Questões Pós-Aula

## Jean Carlos Pereira Cassiano - NUSP: 13864008 <br> Giovanna de Freitas Velasco - NUSP: 13676346

### Questão 10

*Responder com Verdadeiro (V) ou Falso (F) às seguintes afirmações.*

(F) A pilha é uma memória RAM sequencial do tipo FIFO.

(V) A pilha geralmente é utilizada para armazenar endereço de retorno de subrotinas e também de interrupções.

(F) O ponteiro de pilha (Stack Pointer) é um registrador que aponta para um endereço da memória ROM, que é o endereço de retorno do programa após o atendimento a uma interrupção ou sub-rotina.
(na memória RAM)

(V) As instruções PUSH e POP são exclusivas para operações com pilha.

(F) A instrução CALL <endereço> deve ser usada para indicar qual endereço o programa deve desviar no caso de um atendimento à interrupção ou chamada de sub-rotina.

(V) A instrução RET, colocada no final de uma sub-rotina, faz com que o último endereço armazenado na pilha seja carregado no registrador PC (program counter).

(F) A área da RAM interna dedicada à pilha é determinada pelo ponteiro SP, um dos SFRs, que possui tamanho 8 bits, mesmo tamanho do barramento de endereço da CPU.

(F) Geralmente são baseadas em flip-flops tipo D

<br>

### Questão 11

*Refletir se existe diferença entre o endereço armazenado em um espaço de pilha e o endereço armazenado no Stack Pointer (SP)?*

É importante ressaltar que o Stack Pointer é um registrador especial que armazena o enredeço do valor que se encontra no topo da pilha. Já os endereços do espaço de pilha estão em uma parte da memória RAM, e nela são armazenados os endereços para os quais o programa deve retornar posteriormente. Assim, o endereço do Stack Pointer aponta para a pilha, enquanto os endereços para o programa estão contidos na pilha.

<br>

### Questão 12

Supondo que um banco de 8 LEDs foi conectado à Porta P1 e um banco de 8 Switches conectado à P2 (EdSim51). Acender o LED 0 (pode ser qualquer outro) ao acionar o Switch 7 (pode ser qualquer outro). Apagar o LED ao desligar o Switch.

```assembly
org	0000h

loop_ligar:
    MOV   A, P2                 ; Move os valores dos Switches para o acumulador
    JB    ACC.7, loop_desligar  ; Se o bit do Switch 7 for 1 (desligado), saltar para o loop_desligar
    CLR   P1.0                  ; Coloca bit 0 dos LEDs em 0 (ligado)
    SJMP  loop_ligar            ; Retorna para o loop_ligar
    
loop_desligar:
    SETB  P1.0                  ; Se o bit do Switch 7 for 1 (desligado) apaga o LED 0
    SJMP  loop_ligar            ; Retorna para o loop_ligar

END                             ; Encerra o programa
```

<br>

### Questão 13
Supondo que foram conectados um banco de 8 switches na Porta P2 (EdSim51). Escrever um programa em Assembly para monitorar, quando uma das chaves for pressionada, e indicar o número da chave pressionada em R0 (Se SW3 foi pressionada, então R0 = 3).

```assembly
org		0000h                          

main:
    MOV  R0, #0                      ; Inicializa R0 com 00h - mostra o número do switch pressionado
    MOV  50H, #0                     ; Inicia a posicao 50h com 00h - será utilizada como contador para verificar o número do switch

loop_inicial:
    MOV  A, P2                       ; Carrega o valor da Porta P2 (switches) no acumulador
    CJNE  A, #0FFH, verifica_switch  ; Se alguma chave estiver pressionada (tiver valor 0), salta para o loop para verificar o número do switch
    SJMP  loop_inicial               ; Se nenhuma chave estiver pressionada, dá um salto curto de volta para o loop_inicial

verifica_switch:
    MOV  50H, #00                     ; Inicializa o contador no endereço de memória 50h com 00h

numero_switch:
    MOV  C, ACC.0                     ; Move o estado do bit 0 do acumulador para o carry
    JNC  armazena_switch              ; Se o bit for 0 (ativado), salta para armazenar o número contado até então em R0
    INC  50H                          ; Se o bit for 1 (desativado), incrementa o contador R1
    RR  A                             ; Rotaciona o acumulador para a direita, para verificar o próximo bit
    SJMP  numero_switch               ; Repete o processo para o próximo switch

armazena_switch:
    MOV R0, 50H                       ; Armazena o número do switch pressionado em R0
    SJMP loop_inicial                 ; Volta ao loop_inicial

END                                   ; Encerra o programa
```

<br>

### Questão 14
Criar uma subrotina de delay de 50 milissegundos a partir da contagem de ciclos de instruções e intervalo de tempo. Essa estrutura poderá servir para piscar um LED a cada 50 ms (ver exemplo na aula correspondente).

```assembly
org 0000h                ; 

main:
    ACALL	delay            ; Chama a função que realiza o delay de 50 milissegundos

delay:
	MOV		R1, #100         ; M

loop_delay:
	MOV 	R0, #250         ; Move o valor 250 para R0 
	DJNZ	R0, $            ; Decrementa R0 até que seja igual a zero (250 vezes)
	DJNZ	R1, loop_delay   ; Decrementa R1 e retorna para o loop inicial (100 vezes)
	
	RET                      ; Retorna para a main
```

Esse delay irá decrementar o valor de R1 100 vezes e, a cada vez, decrementará o valor em R0 250 vezes. Assim, o intervalo em que o delay irá funcionar será de 250 * 100 = 2500 ciclos. Essas instruções levam 2$\micro$s para serem executadas. Assim, o tempo total de delay é de 50ms, como requisitado.


<br>

### Questão 15
Colocou-se 3 LEDs nos endereços P1.0, P1.1 e P1.2 no microcontrolador e 3 chaves nos endereços P2.0, P2.1 e P2.2. Considerando que os LEDs acendem quando são colocado nível baixo na saída e as chaves, quando pressionadas, colocam nível baixo na porta, explique o funcionamento do programa a seguir quando cada chave é pressionada.

```assembly
  ORG 0000H

Leitura:
  JNB   P2.0, PX
  JNB   P2.1, PY
  JNB    P2.2, PZ
  LCALL   Leitura
  PX:
  MOV   P1, #0
  RET
  PY:
  MOV   P1, #00000101b
  RET
  PZ:
  MOV   A, P1
  CPL   A
  MOV   P1, A
  RET
  FIM:
  SJMP   FIM
```


