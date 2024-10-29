# Atividade 07 - Questões Pós-Aula

## Jean Carlos Pereira Cassiano - NUSP: 13864008 <br> Giovanna de Freitas Velasco - NUSP: 13676346

### Exercício 1

• *Implemente no SimulIDE, com base no Exemplo 5, um programa para piscar um LED (conectado à um dos pinos do PORTC) a cada 1 segundo, utilizando o temporizador Timer0 (TMR0) do PIC18F4550. Ajustar o clock do microcontrolador PIC18F4550 para 8 MHz no SimulIDE, carregar o firmware (arquivo hex resultante da compilação no software MikroC PRO for PIC) e realizar a simulação. Apresentar na resposta o programa em linguagem C comentado (somente as partes mais importantes) e print do circuito montado e simulação realizada no SimulIDE. Este programa não faz o uso de interrupções.*

https://github.com/user-attachments/assets/1ba1b555-be14-47d5-80ca-1e088c960f36

#### Cálculo do tempo de overflow:

  tempo = ciclo de máquina * prescalar * (modo_8_16_bits - valor inicial)

Para o tempo de 1 segundo no modo 16 bits (2^16 = 65536), com prescaler de 32, temos:
  
  1000.000us = 0.5 us * 32 *  (65536 - x)

  x = 65536 - 62500 = 3036 (valor inicial carregado nos registradores do timer0)

Note que 3036 = 0BDCh (em hexadecimal). Portanto, TMR0L = 0xDC e TMR0H = 0x0B no código.

#### Código em linguagem C:
``` C
void ConfigMCU() {
     ADCON1 |= 0x0F;
     TRISC = 0;    // PORTC como saída para o LED
     PORTC = 0;    // LED inicialmente desligado
}

void ConfigTIMER() { 
     T0CON = 0B00000100;  // inicialmente desligado, opera como timer, uso do clock, setado para prescale igual a 32

     //valores iniciais carregados no timer para contagem até 1s na razão 32 e modo 16 bits
     TMR0L = 0xDC;
     TMR0H = 0x0B;

     INTCON.TMR0IF = 0 ; // flag de overflow inicialmente zerada que vai para 1 quando ocorre o overflow

     T0CON.TMR0ON = 1; // liga do timer no registrador T0CON
}

void main() {
     ConfigMCU();
     ConfigTIMER();

     while(1) {
        if (INTCON.TMR0IF == 1) {  // se houve o overflow da contagem
           PORTC.RC2 = ~LATC.RC2;// inverte nível lógico do LED
           
           // recarrega o timer com 0BDCh para o ciclo se repetir
           TMR0L = 0xDC;
           TMR0H = 0x0B;
             
           INTCON.TMR0IF = 0; // zera a flag de overflow da contagem
        }
     }
}
```

<br>

• *Implemente no SimulIDE, com base no material de aula (slides) do Cap. 7, um programa para acionar uma a saída (representada por um LED que irá piscar) a cada intervalo de tempo correspondente a contagem de tempo máxima do Timer3 (TMR3) do PIC18F4550 (ajustando todos os parâmetros com valores máximos para contagem, preescaler etc., e carregando valor inicial zero nos registradores acumuladores do TMR3). Ajustar o clock do microcontrolador PIC18F4550 para 8 MHz no SimulIDE, carregar o firmware (arquivo hex resultante da compilação no software MikroC PRO for PIC) e realizar a simulação. Apresentar na resposta o programa em linguagem C comentado e print do circuito montado e simulação realizada no SimulIDE. Este programa não faz o uso de interrupções.*

https://github.com/user-attachments/assets/0cf8e485-4a53-4e68-8b07-ba9ba974d50b

#### Código em linguagem C:
``` C
void ConfigMCU() {
     ADCON1 |= 0x0F;
     TRISC = 0;    // PORTC como saída para o LED
     PORTC = 0;    // LED inicialmente desligado
}

void ConfigTIMER() {
     T3CON = 0B10110000;// inicialmente desligado, clock externo, sem oscilador dedicado, prescaler 1:8, Fosc/4, 16 bits

     //valores iniciais carregados no timer para contagem
     TMR3L = 0;
     TMR3H = 0;

     PIR2.TMR3IF = 0 ; // flag de overflow inicialmente zerada que vai para 1 quando ocorre o overflow

     T3CON.TMR3ON = 1; // liga o timer3
}

void main() {
     ConfigMCU();
     ConfigTIMER();

     while(1) {
        if (PIR2.TMR3IF == 1) {  // se houve o overflow da contagem
           PORTC.RC2 = ~LATC.RC2;// inverte nível lógico do LED

           // recarrega o timer para o ciclo se repetir
           TMR3L = 0;
           TMR3H = 0;

           PIR2.TMR3IF = 0; // zera a flag de overflow da contagem
        }
     }
}
```

<br>

• *Implemente no SimulIDE, com base no material de aula (slides) do Cap. 7, um programa para acionar uma a saída (representada por um LED que irá piscar) a cada intervalo de tempo correspondente a contagem de tempo máxima do Timer2 (TMR2) do PIC18F4550 (ajustando todos os parâmetros com valores máximos para contagem, preescaler, postscaler etc., e definindo valor máximo no registrador PR2 * observar a diferença do Timer2 para os demais temporizadores). Ajustar o clock do microcontrolador PIC18F4550 para 8 MHz no SimulIDE, carregar o firmware (arquivo hex resultante da compilação no software MikroC PRO for PIC) e realizar a simulação. Apresentar na resposta o programa em linguagem C comentado e print do circuito montado e simulação realizada no SimulIDE. Este programa não faz o uso de interrupções.*

https://github.com/user-attachments/assets/f08590e3-08a5-40d9-909d-3ceb660d62f9

#### Código em linguagem C:
``` C
void ConfigMCU() {
     ADCON1 |= 0x0F;
     TRISC = 0;    // PORTC como saída para o LED
     PORTC = 0;    // LED inicialmente desligado
}

void ConfigTIMER() {
     T2CON = 0B01111111; // inicialmente desligado, prescaler 1:16, postscale 1:16
     
     PR2 = 255; // valor máximo em termos de possibilidades 2^8

     PIR1.TMR2IF = 0 ; // flag de overflow inicialmente zerada que vai para 1 quando ocorre o overflow

     T2CON.TMR2ON = 1; // liga o timer3
}

void main() {
     ConfigMCU();
     ConfigTIMER();

     while(1) {
        if (PIR1.TMR2IF == 1) {  // se houve o overflow da contagem
           PORTC.RC2 = ~LATC.RC2;// inverte nível lógico do LED

           // não é preciso recarrega o timer2
           
           PIR1.TMR2IF = 0; // zera a flag de overflow da contagem
        }
     }
}
```

<br>


### Exercício 2


• *Implemente no SimulIDE, com base no Exemplo 8, um programa para mudar o estado de uma saída (representada por um LED conectado à um dos pinos do PORTD) sempre que for sinalizado um evento (representado por um botão quando é pressionado, o qual também ilustra a leitura de um sensor conectado a uma entrada do microcontrolador). Neste caso, a implementação será realizada com uso de interrupções externas. Basicamente, o programa é um aprimoramento do Exemplo 1 (leitura de entrada e acionamento de saída – I/O digital), no qual um botão, ao ser pressionado, muda o estado de um LED. No entanto, ao invés de gastar linhas de código no programa principal para verificar se o botão foi pressionado, utiliza-se interrupções (evento por hardware que faz com que o programa salte automaticamente para a sub-rotina de tratamento somente quando o botão for pressionado). Deve-se utilizar a interrupção externa INT2. Portanto, o botão deve ser conectado na configuração pull-up ao pino do PIC18F4550 correspondente à INT2 (observar qual deve ser este pino por meio da pinagem do microcontrolador disponível no datasheet e no material de aula). Deve-se configurar o uso de interrupções por meio da ativação das chaves globais e específicas da INT2 (flags IE, IF, IP) nos registradores relacionados a esta interrupção (ver datasheet – seção Interrupts). Na sub-rotina de tratamento da interrupção (para onde o programa saltará quando o botão for pressionado), o LED deverá mudar seu nível lógico (inversão) e a INT2IF deve ser zerada (no PIC, este processo é feito manualmente). Ajustar o clock do microcontrolador PIC18F4550 para 8 MHz no SimulIDE, carregar o firmware (arquivo hex resultante da compilação no software MikroC PRO for PIC) e realizar a simulação. Apresentar na resposta o programa em linguagem C comentado e print do circuito montado e simulação realizada no SimulIDE.*

https://github.com/user-attachments/assets/605b6c6e-390c-46cf-9238-907dd91dc045

#### Código em linguagem C:
``` C
void INTERRUPCAO_HIGH() iv 0x0008 ics ICS_AUTO {
  if(INTCON3.INT2IF == 1){ // verifica se a INT2 ocorreu
     PORTD.RD0 = ~LATD.RD0; // inverte o estado lógico do LED

     INTCON3.INT2IF = 0;     //  zera flag IF do INT2
   }
}

void ConfigMCU() {
 ADCON1 |= 0X0F; // configira pinos do microcontrolador como digitais

 INTCON2.RBPU = 0; // liga os resistores de pull-up do PORTB

 TRISD = 0;  // definir o pino como saída (LED)
 PORTD = 0;  // LEDs inicialmente apagados
}

void main() {
  ConfigMCU();

  // Configuração global das interrupções GIE 
  INTCON.GIEH = 1; // alta prioridade
  RCON.IPEN = 1;  // habilita níveis de prioridade

  //Configuração da interrupção individual do INT2
  INTCON3.INT2IE = 1; // ativa INT2
  INTCON3.INT2IP = 1; // alta prioridade de interrupção 
  INTCON3.INT2IF = 0; // flag responsável por acionar a interrupção inicialmente desativada

  INTCON2.INTEDG2 = 1; // borda
                       // 1 - > Borda de subida (ao soltar a tecla)
                       // 0 - > Borda de descida (ao pressionar a tecla)

  TRISB.RB2 = 1;        // pino RB2/INT2 como entrada

  while(1);   //segura o processamento (pooling)
}
```
<br>

• *Implemente no SimulIDE, com base no Exemplo 7 disponibilizado no e-Disciplinas, um programa para acender um LED (conectado à um dos pinos do PORTD) após 5 eventos (representados por um botão na configuração pull-up pressionado por 5 vezes) utilizando o Timer1(TMR1) no modo contador (modo 16 bits). Para tanto, o botão deve ser conectado ao pino T13CKI do PIC18F4550 (ver qual é por meio da pinagem disponível no datasheet e no material de aula). Configurar o uso de interrupção (interrupção interna) do TMR1 (habilitar a chave de interrupções de periféricos e ativar flag IE e zerar IF referente ao TMR1). Neste contexto, a interrupção do TMR1 é um tipo especial de exceção interna, cuja sub-rotina de tratamento (para onde o programa irá saltar após a contagem de 5 eventos) será responsável por acender o LED, recarregar os registradores acumuladores do TMR1 e zerar a flag TMR1IF. Ajustar o clock do microcontrolador PIC18F4550 para 8 MHz no SimulIDE, carregar o firmware (arquivo hex resultante da compilação no software MikroC PRO for PIC) e realizar a simulação. Apresentar na resposta o programa em linguagem C comentado e print do circuito montado e simulação realizada no SimulIDE.*

https://github.com/user-attachments/assets/a6f9b447-76ab-4771-8152-843c4951e906

#### Código em linguagem C:
``` C
void Interrupt_HIGH() iv 0x0008 ics ICS_AUTO { 
   if(PIR1.TMR1IF == 1){
       PORTD.RD2 = ~LATD.RD2; // inverte o LED
       
       // recarregar valores iniciais no Timer1
       TMR1H=0xFF;
       TMR1L=0xFB;
       
       PIR1.TMR1IF = 0; // zera a flag de overflow
    }
}

void ConfigMCU(){
 ADCON1 |= 0X0F; // pinos do microcontrolador como digitais

 TRISC.RC0=1; // RC0 como entrada pois corresponde ao pino T1CK1, que incrementa a contagem do TMR1
 PORTC.RC0=1;  // entrada C0 em pull-up
 
 TRISD = 0;   // configuração dos LEDS
 PORTD = 0; // LEDs inicialmente apagados
}

void ConfigInterrupt(){
  INTCON.GIE = 1;   // chave geral, habilita o uso de interrupção
  INTCON.PEIE = 1;   // habilita o uso de interrupções periféricas
  RCON.IPEN = 0; // apenas um nível de prioridade de interrupção

  T1CON = 0B10000011; // ativa modo 16 bits, clock em relação ao pino C0, ativa Timer1
  
  // valores iniciais para contar 5 eventos (65531 = FFFB em hexadecimal)
  TMR1H=0xFF;
  TMR1L=0xFB;

  PIR1.TMR1IF = 0;    // flag de estouro do TIMER1, iniciada em 0
  PIE1.TMR1IE = 1;    // habilita a interrupção do TIMER1
  IPR1.TMR1IP = 1;    // prioridade de interrupção do TIMER1 em alta prioridade
}

void main() {
   ConfigMCU();
   ConfigInterrupt();

  while(1); // pooling

}
```

