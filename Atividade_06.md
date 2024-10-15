
# Atividade 05 - Questões Pós-Aula

## Jean Carlos Pereira Cassiano - NUSP: 13864008 <br> Giovanna de Freitas Velasco - NUSP: 13676346

### Exercícios

• *Ilustrar no SimulIDE a conexão de um botão no pino B0 do microcontrolador PIC18F4550 na configuração Pull-Up (externo), o qual ao ser pressionado deverá mudar o estado de um LED conectado ao pino D0, com base no exemplo da Atividade 1. Simule o circuito carregando o arquivo hex gerado na compilação do programa em Linguagem C que atende essa lógica, realizada no software no software MikroC PRO for PIC. Configurar o valor do resistor Pull-Up para 10 kΩ e a frequência do clock do microcontrolador para 8 MHz.*

https://github.com/user-attachments/assets/0d3562db-9106-4e82-9a22-48d33cac5bd2

Código em C do programa:
``` c
void main() {
    while(1) {
        if(PORTB.RB0 ==0) {
           PORTD.RD0 =~LATD.RD0; // Inverte o nível lógico do LED em LATD
           // "~ "  inversão bit a bit  - SE incialmente RD0 = 0, receberá 1 quando
           // a teclada for pressionada; SE 1, receberá o valor 0
           Delay_ms(500);     // retarda a CPU de forma que ao pressionar a tecla..
           // a ação de fato aconteça (as intruções são executadas em nanosegundos)
        } 
    }
} 
```

<br>

• *Altere a lógica do programa do Exemplo 1 para piscar o LED a cada 500 ms (usando a função delay) enquanto o botão se manter pressionado. Ao soltar o botão, o LED deve ser desligado.*

https://github.com/user-attachments/assets/e546e13b-3df2-4f0c-ae4f-1744fc738bd4

Código em C do programa:
``` c
void main() {
    while(1) {
        if(PORTB.RB0 ==0) {
           PORTD.RD0 =~LATD.RD0; // Inverte o nível lógico do LED em LATD
           // "~ "  inversão bit a bit  - SE incialmente RD0 = 0, receberá 1 quando
           // a teclada for pressionada; SE 1, receberá o valor 0
           Delay_ms(500);     // retarda a CPU de forma que ao pressionar a tecla..
           // a ação de fato aconteça (as intruções são executadas em nanosegundos)
        } 
    }
} 

```

<br>

• *Conforme exemplo demonstrado em aula (Exemplo 2), implementar o algoritmo utilizado para tratar o efeito bounce presente no programa do Exemplo 1. Compilar o programa no MikroC PRO for PIC e implementar o circuito no Simul IDE carregando o firmware (arquivo hex gerado na compilação). Ajustar o clock do microcontrolador PIC18F4550 para 8 MHz e o montar o botão na configuração pull-up (ajustar o valor do resistor de pull-up para 10 kΩ) no SimulIDE.*

https://github.com/user-attachments/assets/e94bf9f0-fb16-480f-8bdb-5278bdf4c4a4


```c
void main() {
    unsigned char FlagAux = 0; // variável aux. do tipo char que irá permitir
    // encontrar o estado anterior do botão, para acionar ou não o LED (selo).
    // Essa variável é importante para fazer com que o LED seja acionado somente
    //quando ocorra uma mudança real, evitando acionar mais de uma vez se o estado
    //ainda estiver no mesmo nível que provocou o acionamento.

    ADCON1 |= 0XF;  // registrador presente no modelo PIC18F4550 e derivados
    // outros modelos, como PIC18F45k22, usam registradores ANSEL

// Programa

    // Tecla  - configuração da entrada
    trisb.rb0 = 1;  // configura pino RB0 como entrada
    PORTB.RB0=1; // coloca em nível 1 (pull-up)

    // LED  - saída: configuração do estado inicial
    TRISD.RD0=0; //  configura o pino como saída (=0) (consome corrente)
    PORTD.RD0 = 0; // saída incialmente em 0 (LED OFF)
    
    // TRISD = 0; // todos os pinos como saída
    // PORTD =0; //todos os pinos = 0

    // condições e loop para piscar o LED:
while(1) {
    if(PORTB.RB0 ==0 && FlagAux==0){    // AND lógico (expressão)
    // Se tecla é pressionada: true; E Flag = 0 (lembrando que valor inicial já é 0)
    // Tecla = true. Resultado: condição verdadeira e o bloco segue sendo executado

        PORTD.RD0 =!LATD.RD0;  // (TOGGLE) Inverte o nível lógico do LED em LATD
        // "!" inversão bit a bit - SE inicialmente RD0 = 0, receberá 1 quando
        // a tecla for pressionada; SE 1, receberá o valor 0

        FlagAux=1;            // A condição acima não será mais verdadeira - (aqui
        // eternamente o botão ainda estará pressionado - pois a execução é muito rápida)

        Delay_ms(40);         // trata efeito bouncing (repique mecânico do botão,
        //dentro deste intervalo de tempo não será considerado)
    }

    //fim do bloco IF, o qual em caso de falso (a tecla não for pressionada
    //ou continua pressionada (devido à velocidade do MCU - nanossegundos) mas a
    //Flag = 1), será pulado.

    // Condição oposta para repetir o loop = tecla é liberada
    if(PORTB.RB0 ==1 && FlagAux==1) // Se a tecla não estiver press. E flag = 1
    {
        FlagAux=0;       // condição para voltar ao bloco IF anterior
        Delay_ms(40);    // trata efeito bouncing
    }
} //while
} // main
```

<br>

• *Implemente no SimulIDE o programa no Exemplo 3 – Display de 7 Segmentos. Para tanto, realize as ligações de um display de 7 segmentos disponível no simulador no PORTD do microcontrolador. Ajustar o clock do microcontrolador PIC18F4550 para 8 MHz e o montar o botão na configuração pull-up (ajustar o valor do resistor de pull-up para 10 kΩ) no SimulIDE.*

https://github.com/user-attachments/assets/eeb78b98-a7de-4ed4-9626-a28fcc942e94

``` c
void main() {

```
<br>

• *Levando em consideração os pontos importantes sobre a família de microcontroladores PIC, compare o PIC18F4550 com um microcontrolador da família MSC-51 (por exemplo: AT89S51) estudado anteriormente (focar nas características chaves e mais representativas entre eles: arquitetura, conjunto de instruções, pinagem, periféricos e funcionalidades disponíveis e diferenças quantitativas nas especificações).*

Arquitetura:

Conjunto de Instruções

Pinagem:

Periféricos:

Funcionalidades Disponíveis:

Diferenças Quantitativas:

<br>

• *Após analisar a plataforma EasyPIC v7 fisicamente durante a aula correspondente e com base no material relacionado (manual do kit ou tirar fotos da placa durante a aula, caso preferir), faça um breve resumo (listagem) sobre os principais recursos e periféricos disponíveis nesta placa, listando suas principais funcionalidades para prototipagem em sistemas embarcados.*


<br>
