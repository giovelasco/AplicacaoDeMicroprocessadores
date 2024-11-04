## Projeto 2 - Cronômetro Digital com Timer e Interrupções <br> <br> Jean Carlos Pereira Cassiano - NUSP: 13864008 <br> Giovanna de Freitas Velasco - NUSP: 13676346

### Introdução

O presente projeto contém o código em Linguagem C de um Cronômetro Digital para o microcontrolador PIC18F4550. O funcionamento de tal cronômetro é idêntico
ao presente no projeto anterior (Projeto 1), porém, nesse projeto serão utilizados temporizadores e interrupções e mudança das bases de contagem a partir do 
botão pressionado. O funcionamento consiste em:

• Quando um botão conectado na porta RB0 for pressionado, um display de 7 segmentos ligado na Porta D deve contar (de 0 a 9 em loop) com período de 1s.

• Quando um segundo botão, conectado na porta RB1, for pressionado, o mesmo display de 7 segmentos deve contar com período de 0,25s.

• O display se inicia desligado e a contagem começa somente quando qualquer um dos botões é pressionado.

A simulação foi realizada no software SimulIDE, com o microprocessador PIC18F4550 com uma frequência de clock de 8 MHz. Os conceitos envolvidos no desenvolvimento
do código e da simulação estão mais detalhados a seguir:

### Conceitos Envolvidos

#### Timers

Nesse projeto, fizemos uso do Timer0 com Interrupção externa nos botões para gerar as bases de tempo da contagem e provocar as mudanças necessárias.
As configurações iniciais do Timer0 para sua utilização pretendida foram definidas no código da seguinte forma:

``` C
    // Configuração do Timer0 em modo de 16 bits
    T0CON = 0B00000010;  // TIMER_OFF, MOD_16BITS, TIMER, PRES_1:8

    // Carrega o valor inicial do Timer0 para gerar um atraso de 250 ms
    TMR0H = 0x0B;          // Parte alta do valor inicial 
    TMR0L = 0xDC;          // Parte baixa do valor inicial
    INTCON.TMR0IF = 0;  // Zera a Flag  (vai p/ 1 quando ocorrer o overflow)
    T0CON.TMR0ON = 1;   // Liga o TIMER0
```

O Timer0 foi utilizado em modo de 16 bits, modo timer e com prescale de 1:8. Esse prescale foi definido desta forma por conta de uma falha presente no SimulIDE, que
 favorece a utilização da menor razão possível do prescale a fim de obter uma contagem de tempo mais correta. O valor carregado inicialmente nos registradores
 do Timer0 foram escolhidos com base na seguinte equação:

tempo = ciclo de máquina * prescalar * (modo_16bits - valor inicial)

0,25 = 0.5 us * 8 * (65536 - x)

Resolvendo a equação para x, encontramos que x = 3036, que em hexadecimal é 0BDC C2F7. Portanto, carregamos TMR0H com 0x0B e TMR0L com 0xDC para gerar um atraso de 0,25s.

#### Interrupções

As interrupções são desvios realizados pelo hardware do microcontrolador quando determinado evento ocorre. Em nosso caso, a interrupção é causada por 
pressionar um botão, que inicia o processo de contagem no cronômetro. A habilitação dessas interrupções é realizada no código por essa configuração 
do registrador INTCON:

``` C
    // Configuração de interrupções
    INTCON = 0xE0;   // Habilita interrupções globais, TMR0 e externas
```

E a subrotina para a qual o hardware vai quando ocorrem as interrupções estão presentes na função *void interrupt()*.

#### Acionamento do display de 7 segmentos

O display está conectado na configuração cátodo comum, ou seja, os segmentos se acendem com nível lógico 1. Além disso, ele foi conectado ao PORTD de
acordo com a pinagem presente nessa tabela:

![image](https://github.com/user-attachments/assets/a8716983-5054-4eb0-a489-7cfe67ce8e60)

``` C
    // Configuração do display de 7 segmentos (cátodo comum, com underscore e ponto decimal)
    char segmentos[10] = {0b00111111, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F};
``` 

Por mais que o display presente no SimulIDE já tenha algumas resistências internas que podem ser configuradas, optamos por adicionar um array de resistores
na conexão para evidenciar a necessidade de controlar a corrente que chega no display.


### Vídeo demonstrativo


https://github.com/user-attachments/assets/75d414e8-5b0b-49ac-83ea-7304d3bb3cef


### Comparação entre Projeto 1 e Projeto 2

O Projeto 1 consistiu na elaboração do mesmo cronômetro, mas em linguagem Assembly e sem a utilização de interrupções. O programa, então, ficava sempre
verificando se houve alguma alteração no estado dos Switches 0 e 1 para iniciar a contagem. Essa espera ocupada não era eficiente, uma vez que o programa
ficava parado naquele estado até que houvesse uma mudança. 

Isso não ocorre no Projeto 2 com a utilização de interrupções, que permite que o programa siga rodando normalmente até que seja detectada uma alteração no 
estado portas designadas, nesse caso RB0 e RB1, momento em que o programa sofre um desvio para tratar a interrupção de acordo com o botão pressionado.

A precisão do tempo do cronômetro também foi maior no Projeto 2 que no Projeto 1. Isso está relacionado às IDEs utilizadas, seus propósitos e recursos oferecidos:
enquanto o SimulIDE tenta mostrar a aplicação do microcontrolador em tempo real com a utilização do Timer0, o que aumenta sua confiabilidade. Já o EdSIm8051 
mostra cada instrução que ocorre no 8051, o que diminui a precisão da contabilização do tempo por não utilizarmos um Timer, e sim medirmos uma aproximação 
do tempo de delay fazendo o programa ficar parado em determinadas linhas.

Além disso, o segundo projeto foi desenvolvido em linguagem C, que é uma linguagem com abstração maior do que Assembly, o que torna sua manipulação mais fácil.
Ademais, a linguagem C foi utilizada com maior frequência ao longo do curso de Engenharia de Computação e, portanto, nós possuímos uma maior familiaridade inicial 
com a linguagem C. 


