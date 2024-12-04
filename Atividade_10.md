# Atividade 10 - Questões Pós-Aula

## Jean Carlos Pereira Cassiano - NUSP: 13864008 <br> Giovanna de Freitas Velasco - NUSP: 13676346

### Exercícios

*Realizar as simulações abaixo no Wokwi e estudar as aplicações.*

• *“LED_blink” (apresentar linhas de código utilizando o framework nativo Espressif IDE para blink de um LED – escolher qualquer pino de GPIO para ligar o LED e piscar a cada 500 ms)*

![image](https://github.com/user-attachments/assets/a43c6d44-ef0f-492a-9858-c502f5b78906)


```C
#define ledpin 13

void setup() { // configurações

pinMode(ledpin, OUTPUT); // pino 2 como saída (LED onboard da ESP32)
digitalWrite(ledpin,LOW); // escreve na saída  valor LOW (LED inicialmente desligado)

}

void loop() { // programa principal
  
digitalWrite(ledpin, HIGH);  // liga o LED (escreve valor lógio HIGH na saída - pino 2)
delay(500); // delay de 200 ms (Tempo que o LED fica ligado)
digitalWrite(ledpin, LOW); // desliga o LED (escreve valór lógico LOW na saída - pino 2)
delay(500); // delay de 200 ms (Tempo que o LED fica desligado)
// loop

}
```
<br>

Saída:

```
ets Jul 29 2019 12:21:46

rst:0x1 (POWERON_RESET),boot:0x13 (SPI_FAST_FLASH_BOOT)
configsip: 0, SPIWP:0xee
clk_drv:0x00,q_drv:0x00,d_drv:0x00,cs0_drv:0x00,hd_drv:0x00,wp_drv:0x00
mode:DIO, clock div:2
load:0x3fff0030,len:1156
load:0x40078000,len:11456
ho 0 tail 12 room 4
load:0x40080400,len:2972
entry 0x400805dc
```

<br>

• *“timer_interrupt” (montar o projeto no simulador Wokwi e testar o programa disponibilizado na pasta de exemplos).*

![image](https://github.com/user-attachments/assets/a2791d2c-abdb-4bbc-ac36-84c3d3edc062)


```C
#include <Arduino.h>  // Inclui a biblioteca Arduino para usar suas APIs no simulador Wokwi

const int ledPin = 17;         // Define o pino do LED como GPIO2
const int buttonPin = 12;      // Define o pino do botão como GPIO4

hw_timer_t *timer = NULL;  // Declara um ponteiro para uma estrutura de timer (como NULL, por enquanto ainda
// não esta apontando para algum endereço específico)

volatile bool startBlink = false;  // Variável flag para indicar o início do piscar do LED
// (volatile - pode ser alterado a qualquer tempo)

//************************************************************************************************************
// Vetor de interrupções
void IRAM_ATTR onButtonPress() {  // Função de interrupção externa de GPIO para lidar com o pressionamento do botão
  startBlink = true;  // Define a flag como verdadeira quando o botão é pressionado
}

void IRAM_ATTR onTimer() {  // Função de interrupção para lidar com o temporizador
  digitalWrite(ledPin, !digitalRead(ledPin));  // Inverte o estado do LED
}

//************************************************************************************************************
void setup() {
  Serial.begin(115200);  // Inicializa a comunicação serial com uma taxa de transmissão de 115200 bauds
  pinMode(ledPin, OUTPUT);  // Configura o pino do LED como saída
  pinMode(buttonPin, INPUT_PULLUP);  // Configura o pino do botão como entrada com pull-up interno

// Configuração da interrupção externa GPIO (botão)
  attachInterrupt(digitalPinToInterrupt(buttonPin), onButtonPress, FALLING);  

//Configuração do timer e interrupção interna associada à temporização
  timer = timerBegin(0, 80, true);  // timerBegin(timer_n°, prescaler, modo_contagem)

  timerAttachInterrupt(timer, &onTimer, true);  // Associa a função de interrupção ao timer

  timerAlarmWrite(timer, 500000, true);   // Define o valor de comparação do temporizador para 500.000 microssegundos (500 ms)
}

void loop() {
  if (startBlink) {  // Verifica se startblink é verdadeiro, 
  //ou seja, se loop que irá piscar o LED foi iniciado (somente ocorrerá ao clique do botão - interrupção)

    timerAlarmEnable(timer);  // Ativa o temporizador para piscar o LED
  } else {
    timerAlarmDisable(timer);  // Desativa o temporizador caso contrário
    digitalWrite(ledPin, LOW);  // e deixa o LED desligado 
  }
}
```

<br>

• *“ADC_DAC_Pot_LCD” (montar o projeto no simulador Wokwi e testar o programa inserir as bibliotecas necessárias). Explorar o recurso de comunicação I2C por meio do display LCD I2C e de leituras analógicas com ADC e DAC da ESP32 utilizando programas de exemplo disponibilizados.*


![image](https://github.com/user-attachments/assets/7d9a75cd-fef3-4735-97c1-4cf084bda1c6)


```C
#include <Arduino.h> // biblioteca para trabalhar com funções
// da Arduino IDE no Wokwi
#include <Wire.h>  // utilizada para a comunicação serial
#include <LiquidCrystal_I2C.h> // LCD no modo serial I2C

// Definições de pinos
const int potPin = 34;    // Pino ADC para ler o potenciômetro
const int dacPin = 25;    // Pino DAC para saída analógica

// Variáveis globais
int adcValue = 0;         // Valor lido do ADC
int dacValue = 0;         // Valor a ser escrito no DAC

// Endereço I2C do display LCD
const int lcdAddress = 0x27;
// Número de colunas e linhas do display LCD
const int lcdColumns = 16;
const int lcdRows = 2;

// Inicialização do display LCD
LiquidCrystal_I2C lcd(lcdAddress, lcdColumns, lcdRows);

void setup() {
  // Inicializa a comunicação serial
  Serial.begin(115200);
  Serial.println("ESP32 ADC to DAC Example - Iniciando");

  // Inicialização do display LCD
  lcd.init();
  lcd.backlight();

  // Configuração do pino do potenciômetro como entrada
  pinMode(potPin, INPUT);

  // Configuração do pino DAC não é necessária
  // O ESP32 cuida disso automaticamente quando usamos dacWrite()
}

void loop() {
  // Leitura do valor do potenciômetro (0-4095)
  adcValue = analogRead(potPin); 
  // analogRead é uma função do Arduino que realiza a leitura analógica do pino informado em potPin

  // A função Map realiza mapeamento do valor lido do ADC (0-4095) para o valor do DAC (0-255)
  dacValue = map(adcValue, 0, 4095, 0, 255);

  // Escreve o valor no DAC
  dacWrite(dacPin, dacValue); // função para escrever um valor analógico (de 0 a 255) em um dos pinos DAC 

  // Exibe os valores lidos e escritos no display LCD
  lcd.clear(); // limpa o display
  lcd.setCursor(0, 0); // seta o cursor
  lcd.print("ADC: ");  // escreve a mensagem "ADC:""
  lcd.print(adcValue); // escreve o valor lido em adcValue
  lcd.setCursor(0, 1);
  lcd.print("DAC: ");
  lcd.print(dacValue);

  // Exibe os valores lidos e escritos na porta serial (opcional)
  Serial.print("ADC Value: ");
  Serial.print(adcValue);
  Serial.print("  |  DAC Value: ");
  Serial.println(dacValue);

  //  atraso para evitar saturar a comunicação serial
  delay(100);
}
```

Saída:
```
ts Jul 29 2019 12:21:46

rst:0x1 (POWERON_RESET),boot:0x13 (SPI_FAST_FLASH_BOOT)
configsip: 0, SPIWP:0xee
clk_drv:0x00,q_drv:0x00,d_drv:0x00,cs0_drv:0x00,hd_drv:0x00,wp_drv:0x00
mode:DIO, clock div:2
load:0x3fff0030,len:1156
load:0x40078000,len:11456
ho 0 tail 12 room 4
load:0x40080400,len:2972
entry 0x400805dc
ESP32 ADC to DAC Example - Iniciando
ADC Value: 1001  |  DAC Value: 62
ADC Value: 1577  |  DAC Value: 98
ADC Value: 1577  |  DAC Value: 98
ADC Value: 1517  |  DAC Value: 94
ADC Value: 3062  |  DAC Value: 190
ADC Value: 3415  |  DAC Value: 212
ADC Value: 3867  |  DAC Value: 240
ADC Value: 4095  |  DAC Value: 255
ADC Value: 3899  |  DAC Value: 242
ADC Value: 2138  |  DAC Value: 133
ADC Value: 1153  |  DAC Value: 71
```

• *Descreva de forma sucinta como funcionam os tirmers, interrupções, ADC e DAC na ESP32. Quais são as diferenças em relação a esses recursos no PIC18F4450?*

A ESP32 possui timers de hardware configuráveis para operações precisas, como PWM e contagem de eventos, interrupções com múltiplos níveis de prioridade e processamento em dois núcleos, ADCs de 12 bits com até 18 canais e suporte a DMA, além de dois DACs de 8 bits para geração de sinais analógicos simples. Em comparação, o PIC18F4450 oferece timers mais limitados, geralmente de 8 ou 16 bits, menos canais ADC com resolução de 10 bits e não possui DACs integrados, além de um sistema de interrupções mais simples e sem suporte a múltiplos núcleos.

