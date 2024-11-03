# Atividade 08 - Questões Pós-Aula

## Jean Carlos Pereira Cassiano - NUSP: 13864008 <br> Giovanna de Freitas Velasco - NUSP: 13676346

### Exercício

*Implemente no SimulIDE, os programas do Exemplo_10_ADC_LCD e, posteriormente, do Exemplo_11_ADC_LCD. Montar no SimulIDE o circuito conectado um display LCD ao PORTB (ou qualquer outro) no modo 4 bits. Realizar a leitura analógica do valor de tensão usando um potenciômetro (Vref. 0-5V). Para tanto, conectar o potenciômetro no pino RA3 ou RA5 (canal analógico AN0 ou AN4) do PIC18F4550. Ajustar o clock do microcontrolador PIC18F4550 para 8 MHz no SimulIDE, carregar o firmware (arquivo hex resultante da compilação no software MikroC PRO for PIC) e realizar a simulação. Apresentar na resposta o programa em linguagem C comentado e print do circuito montado e simulação realizada no SimulIDE. Este programa não faz o uso de interrupções.*

### Exemplo 10

https://github.com/user-attachments/assets/567a665f-f811-4978-be37-09ac763ed445

#### Código em C do Exemplo 10

``` C
void ConfigMCU(){
  TRISA.RA0 = 1;  // pino AN0 como entrada 
  PORTA.RA0 = 1;  // pull-up
  
  ADCON0 = 0B00001101;  // AN0 -> AD ligado, leitura deslig., canal AN0
  ADCON1 = 0B00000000; // tensões de ref. internas = VDD e Vss
  ADCON2 = 0B10101010; // justificativa para direita, FOSC/32 (tempo entre 2 e 25 us) e 12 TAD (tempo de conversão de cada bit + 2 TAD)
}

void ConfigLCD(){
  Lcd_Init();                        // inicializa display no modo 4 bits
  Lcd_Cmd(_LCD_CLEAR);               // apaga display
  Lcd_Cmd(_LCD_CURSOR_OFF);          // desliga cursor
  Lcd_Out(1,1,"ADC: ");              // escrita: Linha x Coluna

  // config. de pinos do LCD  (PORTB) conforme exemplo da biblioteca do compilador
  // pinos utilizados para comunicação com o display LCD
  sbit LCD_RS at LATB4_bit;  // pino 4 do PORTB interligado ao RS do display
  sbit LCD_EN at LATB5_bit;  // pino 5 do PORTB interligado ao EN do display
  sbit LCD_D4 at LATB0_bit;  // pino 0 do PORTB interligado ao D4 do display
  sbit LCD_D5 at LATB1_bit;  // pino 1 do PORTB interligado ao D5 do display
  sbit LCD_D6 at LATB2_bit;  // pino 2 do PORTB interligado ao D6 do display
  sbit LCD_D7 at LATB3_bit;  // pino 3 do PORTB interligado ao D7 do display
  
  // direção do fluxo de dados nos pinos selecionados
  sbit LCD_RS_Direction at TRISB4_bit;  // direção do fluxo de dados do pino RB4
  sbit LCD_EN_Direction at TRISB5_bit;  // direção do fluxo de dados do pino RB5
  sbit LCD_D4_Direction at TRISB0_bit;  // direção do fluxo de dados do pino RB0
  sbit LCD_D5_Direction at TRISB1_bit;  // direção do fluxo de dados do pino RB1
  sbit LCD_D6_Direction at TRISB2_bit;  // direção do fluxo de dados do pino RB2
  sbit LCD_D7_Direction at TRISB3_bit;  // direção do fluxo de dados do pino RB3
}


void main() {
  unsigned int Leitura_ADC;  // variav. de leitura ADC
  unsigned char Texto[10];  // display LCD - tipo char - int 8 bits 

  ConfigMCU();
  ConfigLCD();
  
   while(1) {
     ADCON0.GO_DONE = 1;           // liga a leitura e inicia a conversão do ADC
       while(ADCON0.GO_DONE == 1);   // pooling enquanto houver conversão
  
      Leitura_ADC = ((ADRESH << 8)| ADRESL);
  
      // mostrar os valores no display LCD 
      WordToStr(Leitura_ADC, Texto);  // conversão
      LCD_Out(1,5, Texto); // coloca o texto em determinada linha e posição 1, 5
      Delay_ms(20);       // delay para dar tempo para o LCD atualizar
   }
}
```

<br>


### Exemplo 11

https://github.com/user-attachments/assets/54c27696-d7a3-4f19-90ee-13032404dfe3

#### Código em C

``` C
void ConfigMCU(){
  TRISA.RA5 = 1;
  ADCON1 = 0B00000000; // Configura todos os canais como ADC no PIC18F4450
}

void ConfigLCD(){
  Lcd_Init();                 // Inicializa a lib. Lcd
  Lcd_Cmd(_LCD_CLEAR);       // Clear display
  Lcd_Cmd(_LCD_CURSOR_OFF);  // Cursor off
  Lcd_Out(1,1,"ADC0:");   //Escreve na Linha x Coluna do LCD o texto(valor do ADC)

  // config. de pinos do LCD  (PORTB) conforme exemplo da biblioteca do compilador
  // pinos utilizados para comunicação com o display LCD
  sbit LCD_RS at LATB4_bit;  // pino 4 do PORTB interligado ao RS do display
  sbit LCD_EN at LATB5_bit;  // pino 5 do PORTB interligado ao EN do display
  sbit LCD_D4 at LATB0_bit;  // pino 0 do PORTB interligado ao D4 do display
  sbit LCD_D5 at LATB1_bit;  // pino 1 do PORTB interligado ao D5 do display
  sbit LCD_D6 at LATB2_bit;  // pino 2 do PORTB interligado ao D6 do display
  sbit LCD_D7 at LATB3_bit;  // pino 3 do PORTB interligado ao D7 do display
  
  // direção do fluxo de dados nos pinos selecionados
  sbit LCD_RS_Direction at TRISB4_bit;  // direção do fluxo de dados do pino RB4
  sbit LCD_EN_Direction at TRISB5_bit;  // direção do fluxo de dados do pino RB5
  sbit LCD_D4_Direction at TRISB0_bit;  // direção do fluxo de dados do pino RB0
  sbit LCD_D5_Direction at TRISB1_bit;  // direção do fluxo de dados do pino RB1
  sbit LCD_D6_Direction at TRISB2_bit;  // direção do fluxo de dados do pino RB2
  sbit LCD_D7_Direction at TRISB3_bit;  // direção do fluxo de dados do pino RB3
}


void main(){
  unsigned int Valor_ADC = 0;  // var. para leitura
  unsigned char Tensao[10];    // arranjo textual para exibir no display

  ConfigMCU();
  ConfigLCD();

  ADC_Init();  // uso da função da biblioteca ADC do próprio compilador

 while(1) {
    Valor_ADC = ADC_Read(4); // função da biblioteca ADC do compilador para
    //leitura dos valores de 0 a 1023 (10 bits)  - ex.:  valor_ADC = 1023;
    // onde: 4 é o n° do canal analógico usado, no caso AN4, no pino RA5

    Valor_ADC = Valor_ADC * (1234/1023.); // formata o valor de entrada (neste caso o valor de exemplo '1234')
    // para 0 a 1023 -> com ponto no final para n° float,i.e.,o display mostrará: '12.34'

    // Formatando cada valor a ser exibido no display como "12.34"
    Tensao[0] = (Valor_ADC/1000) + '0';// div. de 2 n° inteiros - em programação
    // resulta na parte inteira do primeiro n° (ex.: 1234/1000 = 1)
    // E '1' + '0'  = 1; ou seja,  converte o valor para ASCI  para exibir no display

    Tensao[1] = (Valor_ADC/100)%10 + '0'; // div. de n° inteiros => 1234/100 = 12
    // '%' em ling. C é operação "mod"  c/ resto da divisão, ou seja, 12%10 = 2
    // portanto, formata o segundo n° no display no padrão ASCI ( '2' + '0' = 2)

    Tensao[2] = '.';    // 3° valor corresponde ao ponto - ex. 12.34

    Tensao[3] = (Valor_ADC/10)%10 + '0'; // 4° valor é a 1ªcasa decimal, portanto:
    // 1234/10 = 123%10 = 3  - formata no padrão ASCI
    Tensao[4] = (Valor_ADC/1)%10 + '0';  // formata o valor da 2ª casa decimal

    Tensao[5] = 0; // terminador NULL (ultima posição da matriz - zero indica o
    //final opeação e limita a exibição dos 5 valores anteriores: 12.34), ou seja
    // a partir daqui, não serão mais exibidos valores, os quais poderão ser
    //adicionados caso se deseja exibir, por ex., mais casas decimais

    //floatToStr(Valor_ADC , Tensao);
    //Tensao[5] = 0;


     // Exibir os valores na config. acima no display LCD:
    Lcd_Out(1,6,Tensao); // Mostra os valores no display
    Delay_ms(20);   // atualizar display
  }
}
```
