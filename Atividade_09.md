# Atividade 09 - Questões Pós-Aula

## Jean Carlos Pereira Cassiano - NUSP: 13864008 <br> Giovanna de Freitas Velasco - NUSP: 13676346

### Exercícios

1) *Analisando criticamente diferentes arquiteturas de microcontroladores (por meio dos datasheets), faça um breve e sucinto comparativo entre os principais recursos (focar nos mais importantes e essenciais que você consegue observar, com base no contato prévio e recursos utilizados nos projetos anteriores) dos microcontroladores PIC18F4550, STM32F103C8T6 (ou STM32F303VC – escolher um ou outro), e ESP32 WROOM Xtensa Dual Core (versão disponível na placa Devkit).*

Enquanto o PIC têm uma arquitetura Harvard de 8 bits, tanto o STM quanto ESP32 são microcontorladores de 32 bits. A arquitetura do STM32F103C8T6 é ARM Cortex-M3 com núcleo single-core, enquanto o ESP32 WROOM usa a arquitetura Xtensa LX6 com núcleo dual-core , sendo excelente para aplicações multitarefa, como IoT e conectividade. Como o PIC é um microcontrolador de 8 bits, ele é mais limitado que os outros, com um menor poder de processamento. 

Em relação à memória, o PIC possui 32 KB de flash e 2 KB de RAM, o que a torna mais restrita para armazenamento. Já o STM32F103C8T6 apresenta flash de 64 KB e RAM de 20 KB, o que é superior ao PIC, mas ainda possui limitações para alto volume de dados. Por fim, a ESP32 WROOM apresenta uma flash de 4 MB e uma RAM de 520 KB, o que permite o desenvolvimento de aplicações mais robustas.

Em relação ao clock, o PIC e o STM possuem clocks mais reduzidos (48 MHz e 72MHz) em relação à ESP32, que tem 240 MHz, sendo mais adequada para um maior desempenho e permite um processamento paralelo. Além disso, a ESP32 possui Suporte a redes sem fio como Wi-Fi, Bluetooth, o que é interessante para aplicações IOT.


<br>

2) *Testar no Wokwi o exemplo demostrado em aula referente ao blink LED na placa BluePill (microcontrolador STM32F103) ou Placa Nucleo C031C6, observando a programação no framework Arduino (e considerações caso fosse utilizado a IDE nativa (Cube IDE)) conforme tutoriais nos slides do Cap. 9.*

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

3) *Demostrar como acionar a saída PC13 (LED onboard na BluePill) a partir da programação “bare-metal” por meio da configuração direta de registradores (apresentar apenas as linhas de código e explicações sobre a configuração dos registradores envolvidos - não é necessário testar na placa, nem usar a IDE ou simulador).*

Para acender um LED na saída PC13, precisamos seguir os seguintes passos:

● Passo 1: Habilitar o clock no PORTC. Isso é feito usando o registrador RCC_APB2ENR e ativando o bit 4 IOPCEN.

● Passo 2: Configurar PC13 como saída. Isso é feito acessando os registradores GPIOC_CRL e GPIOC_CRH

● Passo 3: Colocar PC13 em nível alto. Isso pode ser feito de duas formas: podemos utilizar o registrador de dados de saída GPIOC_ODR ou o registrador de set/reset GPIOx_BSRR.

```C
RCC-> APB2ENR = 0x00000010; // 16 em hexa = 10000 (bit 4 = 1)

GPIOC->CRH =0x00200000; // 2 em hexa = 0010 nos bits CNF13 e MODE13

GPIOC->ODR =0x00002000; // 2 em hexa = 0001; sendo 2 no bit ODR13 (PC13)
// Podemos fazer também GPIOC->BSRR = 0x00002000
```
