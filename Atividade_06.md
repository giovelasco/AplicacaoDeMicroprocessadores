
# Atividade 05 - Questões Pós-Aula

## Jean Carlos Pereira Cassiano - NUSP: 13864008 <br> Giovanna de Freitas Velasco - NUSP: 13676346

### Exercícios

• *Ilustrar no SimulIDE a conexão de um botão no pino B0 do microcontrolador PIC18F4550 na configuração Pull-Up (externo), o qual ao ser pressionado deverá mudar o estado de um LED conectado ao pino D0, com base no exemplo da Atividade 1. Simule o circuito carregando o arquivo hex gerado na compilação do programa em Linguagem C que atende essa lógica, realizada no software no software MikroC PRO for PIC. Configurar o valor do resistor Pull-Up para 10 kΩ e a frequência do clock do microcontrolador para 8 MHz.*

https://github.com/user-attachments/assets/0d3562db-9106-4e82-9a22-48d33cac5bd2

Código em C do programa:
``` c
void main() {
    // Diretivas de pré-configuração
            ADCON1 |= 0x0F;
    
    // Configuração da entrada digital, usando um botão
            TRISB.RB0 = 1;  // configura pino RB0 como entrada no PORTB
            PORTB.RB0=1; //valor de leitura da entrada em pull-up
        
    // Config. Saída Digital (usando um LED do kit): configuração do estado inicial
            TRISD.RD0 = 0; // output - configura o pino como saída (=0)
            PORTD.RD0 = 0; // saída inicialmente desligada   (LED apagado)
    
    // Condições e loop para piscar o LED:
        while(1) // True
        {
            if(PORTB.RB0 ==0) {  // Tecla ativada em nível lógico 0
               PORTD.RD0 =~LATD.RD0; // Inverte o nível lógico do LED 
               Delay_ms(400);     // retarda a CPU de forma que ao pressionar a tecla, a ação de fato aconteça
             }
        
        } // fim do while
} // fim da main
```

<br>

• *Altere a lógica do programa do Exemplo 1 para piscar o LED a cada 500 ms (usando a função delay) enquanto o botão se manter pressionado. Ao soltar o botão, o LED deve ser desligado.*

https://github.com/user-attachments/assets/e546e13b-3df2-4f0c-ae4f-1744fc738bd4

Código em C do programa:
``` c
void main() {
    // Diretivas de pré-configuração
        ADCON1 |= 0x0F;

    // Configuração da entrada digital, usando um botão/swtich do kit como exemplo
        TRISB.RB0 = 1;  // configura pino RB0 como entrada no PORTB
        PORTB.RB0=1; //valor de leitura da entrada em pull-up, ao colocar TRISX.RX0 =1,...
    // MCU já coloca nível 1 nesta porta X

    // COnfig. Saída Digital (usando um LED do kit): configuração do estado inicial
        TRISD.RD0=0; // output - configura o pino como saída (=0) (consome corrente)
        PORTD.RD0 = 0; // saída inicialmente desligada   (LED apagado)

    // Condições e loop para piscar o LED:
    while(1) // True
    {
        if(PORTB.RB0 ==0) { // Tecla ativada em nível lógico 0 
           PORTD.RD0 =~LATD.RD0; // Inverte o nível lógico do LED
           Delay_ms(500);     // retarda a CPU de forma que ao pressionar a tecla para que a ação de fato aconteça (as intruções são executadas em nanosegundos)
         }
    
         if(PORTB.RB0 =!0) {
             PORTD.RD0 = 0;
         }
    } // fim do while
} // fim da main

```

<br>

• *Conforme exemplo demonstrado em aula (Exemplo 2), implementar o algoritmo utilizado para tratar o efeito bounce presente no programa do Exemplo 1. Compilar o programa no MikroC PRO for PIC e implementar o circuito no Simul IDE carregando o firmware (arquivo hex gerado na compilação). Ajustar o clock do microcontrolador PIC18F4550 para 8 MHz e o montar o botão na configuração pull-up (ajustar o valor do resistor de pull-up para 10 kΩ) no SimulIDE.*

https://github.com/user-attachments/assets/e94bf9f0-fb16-480f-8bdb-5278bdf4c4a4

Código em C do programa:
```c
void main() {
    // Variáveis globais
        unsigned char FlagAux = 0; // variável para tratar do efeito bouncing

    // Diretivas de pré-configuração
        ADCON1 |= 0XF; // configurações da placa utilizada

    // Tecla  - configuração da entrada
        trisb.rb0 = 1;  // configura pino RB0 como entrada
        PORTB.RB0 = 1; // coloca em nível 1 (pull-up)

    // LED  - saída: configuração do estado inicial
        TRISD.RD0 = 0; //  configura o pino como saída (=0) (consome corrente)
        PORTD.RD0 = 0; // saída incialmente em 0 (LED OFF)

    // Condições e loop para piscar o LED:
    while(1) {
        if(PORTB.RB0 ==0 && FlagAux==0){    // Se o botão é pressionado e a flag é 0
            PORTD.RD0 =!LATD.RD0;    // Inverte o nível lógico do LED 
            FlagAux = 1;    // A condição para entrar no if não é mais verdadeira e o programa não será invertido imediatamente novamente
            Delay_ms(40);    // trata efeito bouncing (repique mecânico do botão, dentro deste intervalo de tempo não será considerado)
        }
    
        // Condição oposta para repetir o loop = tecla é liberada
        if(PORTB.RB0 ==1 && FlagAux==1) { // Se o botão não estiver pressionado e e flag de suporte for igual a 1
            FlagAux = 0;       // condição para ingressar novamente no if inicial
            Delay_ms(40);    // trata bouncing
        }
    } // fim do while
} // fim da main
```

<br>

• *Implemente no SimulIDE o programa no Exemplo 3 – Display de 7 Segmentos. Para tanto, realize as ligações de um display de 7 segmentos disponível no simulador no PORTD do microcontrolador. Ajustar o clock do microcontrolador PIC18F4550 para 8 MHz e o montar o botão na configuração pull-up (ajustar o valor do resistor de pull-up para 10 kΩ) no SimulIDE.*

https://github.com/user-attachments/assets/eeb78b98-a7de-4ed4-9626-a28fcc942e94

Código em C do programa:
``` c
// Variáveis globais
    signed char ucContador = -1; // para incrementar o contador

// Função para realizar o incremento do display de 7 segmentos
    void Incremento(unsigned char Contador) { 
        switch (Contador) {      // Acionamento do display de 7 segmentos
            case 0:{ latd = 0b00111111; break;}   //  0 no display
            case 1:{ latd = 0b00000110; break;}   //  1 no display
            case 2:{ latd = 0b01011011; break;}   // 2 no display
    
            default: {PORTD = 0; ucContador = -1; break;} // zera todo o PORTD e reinicia o contador
        }
    }

// Início da função principal
void main() {
    unsigned char FlagAux = 0;

// Diretivas de pré-configuração
    ADCON1 |= 0XF;   // configuração dos pinos como digital

// Configurar os pinos de acionamentos do display:
   TRISA = 0;      // define o PORTA
   PORTA = 0b00001111; //RA0, RA1, RA2, RA3  - liga o display de 7 seg. do kit
   
// Configurações de entrada
    TRISB.RB0 = 1;  // configura pino RB0 como entrada
    PORTB.RB0 = 1; 

// Condições e loop para piscar o LED:
    while(1) {
        if(PORTB.RB0 ==0 && FlagAux==0) { // Se 
           Incremento(++ucContador);  
           FlagAux = 1;        //  A condição acima não será mais verdadeira
           Delay_ms(40);     // tratar bounce
         }
    
         if(PORTB.RB0 ==1 && FlagAux==1) {
              FlagAux = 0;     // condição para voltar ao bloco IF anterior
              Delay_ms(40);    // tratar bounce
         }
    
    } // fim do while
} // fim da main
```
<br>

• *Levando em consideração os pontos importantes sobre a família de microcontroladores PIC, compare o PIC18F4550 com um microcontrolador da família MSC-51 (por exemplo: AT89S51) estudado anteriormente (focar nas características chaves e mais representativas entre eles: arquitetura, conjunto de instruções, pinagem, periféricos e funcionalidades disponíveis e diferenças quantitativas nas especificações).*

Primeiramente, é importante notar que ambos os microcontroladores são de fabricantes distintas: enquanto o PIC é fabricado pela Microchip, a família MSC-51 é da Atmel. Em relação à arquitetura, o PIC18F4550 possui uma arquitetura Harvard, em que as memórias de programa e dados são separadas, permitindo que a CPU acesse simultaneamente a instrução e os dados. Isso permite o uso da técnica de pipeline, o que possibilita a execução de instruções em menos ciclos. Já o AT89S51 possui uma arquitetura Von Neumann, onde os programas e os dados compartilham o mesmo espaço de memória, o que torna o sistema um pouco mais simples, porém menos eficiente. O PIC18F4550 utiliza um conjunto de instruções RISC, ou seja, há menos intruções, mas elas são otimizadas para serem executadas em menos ciclos de clock. Já o AT89S51 utiliza um conjunto de instruções CISC, ou seja, tem mais instruções que podem levar mais ciclos para serem executadas.

Em relação às especificações de I/O e periféricos de cada microcontrolador, o PIC18F4550 possui 40 pinos com até 35 linhas de I/O digitais, um Conversor Analógico-Digital de 10 bits com até 13 canais, entradas de comunicação USB (USB 2.0) nativa, canais PWM, 4 timers, suporte para USART, SPI, e I2C para comunicação serial. O AT89S51 também possui 40 pinos com até 35 linhas de I/O digitais, mas ele não possui um Conversor Analógico-Digital, entradas USB ou PSW como o PIC. Ele possui 2 timers, suporte para UART, mas não possui suporte nativo para I2C ou SPI.

Para a memória de programa, o PIC18F4550 possui até 32 KB de Flash para armazenar o código do programa. Isso oferece muito espaço para programas complexos. Já o AT89S51 possui apenas 4 KB de Flash, o que limita o tamanho dos programas. Já para a memória RAM, o PIC18F4550 dispõe de 2 KB de RAM interna e o AT89S51 possui 128 bytes de RAM interna, o que é significativamente menor em comparação ao PIC. Além disso, o PIC18F4550 possui 256 bytes de EEPROM interna, que permite armazenamento de dados permanentes, enquanto o AT89S51 não possui EEPROM interna.

Por conta dessas especificações, o PIC é mais utilizado para projetos mais complexos, que envolvam uma interface USB ou controle de dispositivos analógicos. Já o 
AT89S51 é utilziado em projetos mais simples que não exigem recursos mais avançados ou grande exigência de memória.

<br>

• *Após analisar a plataforma EasyPIC v7 fisicamente durante a aula correspondente e com base no material relacionado (manual do kit ou tirar fotos da placa durante a aula, caso preferir), faça um breve resumo (listagem) sobre os principais recursos e periféricos disponíveis nesta placa, listando suas principais funcionalidades para prototipagem em sistemas embarcados.*


<br>
