
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

<br>

• *Implemente no SimulIDE o programa no Exemplo 3 – Display de 7 Segmentos. Para tanto, realize as ligações de um display de 7 segmentos disponível no simulador no PORTD do microcontrolador. Ajustar o clock do microcontrolador PIC18F4550 para 8 MHz e o montar o botão na configuração pull-up (ajustar o valor do resistor de pull-up para 10 kΩ) no SimulIDE.*

https://github.com/user-attachments/assets/eeb78b98-a7de-4ed4-9626-a28fcc942e94

<br>

• *Levando em consideração os pontos importantes sobre a família de microcontroladores PIC, compare o PIC18F4550 com um microcontrolador da família MSC-51 (por exemplo: AT89S51) estudado anteriormente (focar nas características chaves e mais representativas entre eles: arquitetura, conjunto de instruções, pinagem, periféricos e funcionalidades disponíveis e diferenças quantitativas nas especificações).*


<br>

• *Após analisar a plataforma EasyPIC v7 fisicamente durante a aula correspondente e com base no material relacionado (manual do kit ou tirar fotos da placa durante a aula, caso preferir), faça um breve resumo (listagem) sobre os principais recursos e periféricos disponíveis nesta placa, listando suas principais funcionalidades para prototipagem em sistemas embarcados.*


<br>
