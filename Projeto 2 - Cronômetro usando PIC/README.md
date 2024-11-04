## Projeto 2 - Cronômetro Digital com Timer e Interrupções

O presente projeto contém o código em Linguagem C de um Cronômetro Digital para o microcontrolador PIC18F4550. O funcionamento de tal cronômetro é idêntico
ao presente no projeto anterior (Projeto 1), porém, nesse projeto serão utilizados temporizadores e interrupções e mudança das bases de contagem a partir do 
botão pressionado. O funcionamento consiste em:

• Quando um botão conectado na porta RB0 for pressionado, um display de 7 segmentos ligado na Porta D deve contar (de 0 a 9 em loop) com período de 1s.

• Quando um segundo botão, conectado na porta RB1, for pressionado, o mesmo display de 7 segmentos deve contar com período de 0,25s.

• O display se inicia desligado e a contagem começa somente quando qualquer um dos botões é pressionado.

A simulação foi realizada no software SimulIde, com o microprocessador PIC18F4550 com uma frequência de clock de 8 MHz. Os conceitos envolvidos no desenvolvimento
do código e da simulação estão mais detalhados a seguir:

### Conceitos Envolvidos

#### Timers

#### Interrupções

#### Acionamento do display de 7 segmentos

![image](https://github.com/user-attachments/assets/2231bdae-8a3c-4e54-baf9-52cdbed33283)




