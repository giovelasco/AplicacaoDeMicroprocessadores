# Atividade 09 - Questões Pós-Aula

## Jean Carlos Pereira Cassiano - NUSP: 13864008 <br> Giovanna de Freitas Velasco - NUSP: 13676346

### Exercícios

● *Analisando criticamente diferentes arquiteturas de microcontroladores (por meio dos datasheets), faça um breve e sucinto comparativo entre os principais recursos (focar nos mais importantes e essenciais que você consegue observar, com base no contato prévio e recursos utilizados nos projetos anteriores) dos microcontroladores PIC18F4550, STM32F103C8T6 (ou STM32F303VC – escolher um ou outro), e ESP32 WROOM Xtensa Dual Core (versão disponível na placa Devkit).*

1. Arquitetura e Núcleos de Processamento
PIC18F4550:

Arquitetura: Harvard, 8 bits.
Núcleo: Single-core (PIC18).
Limitado para tarefas que não demandam processamento intensivo.


STM32F103C8T6:
Arquitetura: ARM Cortex-M3, 32 bits.
Núcleo: Single-core.
Muito mais eficiente para operações matemáticas e tarefas de tempo real em comparação ao PIC.


ESP32 WROOM:
Arquitetura: Xtensa LX6, 32 bits.
Núcleo: Dual-core.
Excelente para aplicações multitarefa, como IoT e conectividade.


2. Clock e Desempenho
PIC18F4550:

Clock: até 48 MHz.
Performance suficiente para tarefas simples, mas limitado em relação aos demais.
STM32F103C8T6:

Clock: até 72 MHz.
Maior eficiência energética e capacidade para aplicações embarcadas mais complexas.
ESP32 WROOM:

Clock: até 240 MHz.
Muito superior, ideal para aplicações que exigem alto desempenho e processamento paralelo.
3. Memória (Flash/RAM)
PIC18F4550:

Flash: 32 KB.
RAM: 2 KB.
Restritivo para armazenamento de código e dados.
STM32F103C8T6:

Flash: 64 KB.
RAM: 20 KB.
Bem mais flexível, mas ainda limitado para sistemas com alto volume de dados.
ESP32 WROOM:

Flash: 4 MB (na Devkit).
RAM: 520 KB SRAM + 8 KB RTC.
Alta capacidade, permitindo desenvolvimento de aplicações mais robustas.
4. Interfaces de Comunicação
PIC18F4550:

USB (Host/Device), I²C, SPI, USART.
Funcional, mas menos diversificado comparado aos outros.
STM32F103C8T6:

I²C, SPI, USART, CAN, USB.
Boa diversidade, incluindo suporte para CAN.
ESP32 WROOM:

Wi-Fi, Bluetooth, I²C, SPI, UART, CAN.
Suporte a redes sem fio torna-o imbatível em aplicações IoT.
5. Consumo de Energia
PIC18F4550:

Consumo moderado. Projetado para eficiência em tarefas simples.
Bom para aplicações alimentadas por baterias pequenas.
STM32F103C8T6:

Consumo eficiente, com modos de baixo consumo bem otimizados.
Ideal para sistemas embarcados.
ESP32 WROOM:

Consumo elevado devido à conectividade sem fio.
Modo de baixa energia disponível, mas ainda menos eficiente que o STM32.
6. Facilidade de Desenvolvimento e Comunidade
PIC18F4550:

Ferramentas: MPLAB X, XC8.
Comunidade mais restrita e curva de aprendizado maior.
STM32F103C8T6:

Ferramentas: STM32CubeIDE, Keil, ou plataformas como Arduino.
Comunidade grande, com ampla documentação e suporte.
ESP32 WROOM:

Ferramentas: ESP-IDF, Arduino, MicroPython.
Excelente comunidade e recursos bem documentados.
7. Aplicações Típicas
PIC18F4550: Sistemas simples como controle de dispositivos e automação básica.
STM32F103C8T6: Aplicações embarcadas mais complexas, incluindo sistemas de tempo real e controle.
ESP32 WROOM: Aplicações IoT, processamento intensivo e conectividade Wi-Fi/Bluetooth.
Conclusão
PIC18F4550: Adequado para tarefas básicas e com baixo custo.
STM32F103C8T6: Balanceado entre custo e desempenho; ideal para projetos de média complexidade.
ESP32 WROOM: Melhor opção para IoT e projetos que exigem conectividade e alto desempenho.


<br>

● *Testar no Wokwi o exemplo demostrado em aula referente ao blink LED na placa BluePill (microcontrolador STM32F103) ou Placa Nucleo C031C6, observando a programação no framework Arduino (e considerações caso fosse utilizado a IDE nativa (Cube IDE)) conforme tutoriais nos slides do Cap. 9.*

https://github.com/user-attachments/assets/dba75260-e5ff-4758-bf48-9f584c38f566

<br>

``` C
#define LED PB12 // Define porta do LED

void setup() {
  pinMode(LED, OUTPUT); // Define LED como saída
}

void loop() {
  digitalWrite(LED, HIGH); // Liga porta do LED
  delay(700);
  digitalWrite(LED, LOW); // Desliga porta do LED
  delay(700);
}

```

<br>

● *Demostrar como acionar a saída PC13 (LED onboard na BluePill) a partir da programação “bare-metal” por meio da configuração direta de registradores (apresentar apenas as linhas de código e explicações sobre a configuração dos registradores envolvidos - não é necessário testar na placa, nem usar a IDE ou simulador).*




