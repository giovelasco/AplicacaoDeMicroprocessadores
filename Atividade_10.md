# Atividade 09 - Questões Pós-Aula

## Jean Carlos Pereira Cassiano - NUSP: 13864008 <br> Giovanna de Freitas Velasco - NUSP: 13676346

### Exercícios

Realizar as simulações abaixo no Wokwi e estudar as aplicações.

• “LED_blink” (apresentar linhas de código utilizando o framework nativo Espressif IDE para blink de um LED – escolher qualquer pino de GPIO para ligar o LED e piscar a cada 500 ms)

https://github.com/user-attachments/assets/98ede4a1-8abe-4467-9757-587987ea9826


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

• “timer_interrupt” (montar o projeto no simulador Wokwi e testar o programa disponibilizado na pasta de exemplos).

```C


#include <Arduino.h>  // Inclui a biblioteca Arduino para usar suas APIs no simulador Wokwi

const int ledPin = 13;         // Define o pino do LED como GPIO2
const int buttonPin = 2;      // Define o pino do botão como GPIO4

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
  // attachInterrupt (pino_evento, função de tratamento da interrupção, tipo de disparo)

  // a função "attachInterrupt" associa a função de interrupção ao pressionar botão
  // digitalPinToInterrupt(buttonPin) é o primeiro argumento da função que monitora o pino de GPIO buttonPin (n° 4)
  // onButtonPress: é o segundo argumento da função, chamado quando ocorrer o evento (tratamento)
  // FALLING - disparo da interrupção por boarda de descida

//Configuração do timer e interrupção interna associada à temporização
  timer = timerBegin(0, 80, true);  // timerBegin(timer_n°, prescaler, modo_contagem)
  //  Inicia o timer 0 com um prescaler de 80 e modo de contagem ascendente
  // considerando clock de 80 MHz:
  // f_timer =freq_clock/ porescaler
  // f_timer = 80.000.000/80 = 1 MHz = 1.000.000 ms (conta em microssegundos (1.000.000 ticks por segundo))

  timerAttachInterrupt(timer, &onTimer, true);  // Associa a função de interrupção ao timer
  /*
    "&" está passando o endereço da função onTimer para outra função, utilizada como uma rotina de tratamento de 
    interrupção associada ao timer, que será chamada neste contexto "true"
  */
  timerAlarmWrite(timer, 500000, true);  
  // Define o valor de comparação do temporizador para 500.000 microssegundos (500 ms)
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



• “ADC_DAC_Pot_LCD” (montar o projeto no simulador Wokwi e testar o programa inserir as bibliotecas necessárias). Explorar o recurso de comunicação I2C por meio do display LCD I2C e de leituras analógicas com ADC e DAC da ESP32 utilizando programas de exemplo disponibilizados.

```C
// ADC e DAC para leituras analógicas e controle de saída analógica
// Escrita em display LCD usando comunicação serial I2C

/*
ADC e DAC: o ESP32 Possui 2 x ADCs de 12 bits (4096 níveis) do tipo SAR (aprox. sucessivas) p/ leituras analógicas em 15 canais
e 2 x DACs de 8 bits (256 níveis) para controle de saídas - GPIO25 e GPIO26


O barramento I2C é composto por dois fios: 
SDA (Serial Data Line) para enviar e receber dados serializados - GPIO 21
SCL (serial clock)usado para sincronizar a transmissão de dados - GPIO 22

A utilização de bibliotecas abstrai as configurações I2C nos pinos acima.
No ESP32, geralmente os endereços do barramento I2C são destinados:

- 0x3C e 0x3D: Endereços típicos para displays OLED SSD1306.

-0x27, 0x3F, 0x38, 0x39: Endereços comuns para displays LCD baseados no chip PCF8574 ou PCF8574A.

-0x68 e 0x69: Endereços frequentemente usados por módulos de tempo real (RTC), como o DS3231.

- 0x40 a 0x4F: Endereços para expansores de E/S I2C, como o PCF8574.

- 0x50 a 0x57: Endereços para módulos de EEPROM I2C.

*/

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
//cria um objeto chamado lcd da classe LiquidCrystal_I2C 
//e inicializa com os parâmetros definidos anteriormente

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

Atividade extra: PicSimLab 4 velocidades

• Descreva de forma sucinta como funcionam os tirmers, interrupções, ADC e DAC na ESP32. Quais são as diferenças em relação a esses recursos no PIC18F4450?
