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

// valores iniciais carregados no timer para contagem até 1s na razão 32 e modo 16 bits
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
} // fim do while

}  // fim da main
```

<br>

• *Implemente no SimulIDE, com base no material de aula (slides) do Cap. 7, um programa para acionar uma a saída (representada por um LED que irá piscar) a cada intervalo de tempo correspondente a contagem de tempo máxima do Timer3 (TMR3) do PIC18F4550 (ajustando todos os parâmetros com valores máximos para contagem, preescaler etc., e carregando valor inicial zero nos registradores acumuladores do TMR3). Ajustar o clock do microcontrolador PIC18F4550 para 8 MHz no SimulIDE, carregar o firmware (arquivo hex resultante da compilação no software MikroC PRO for PIC) e realizar a simulação. Apresentar na resposta o programa em linguagem C comentado e print do circuito montado e simulação realizada no SimulIDE. Este programa não faz o uso de interrupções.*


<br>

• *Implemente no SimulIDE, com base no material de aula (slides) do Cap. 7, um programa para acionar uma a saída (representada por um LED que irá piscar) a cada intervalo de tempo correspondente a contagem de tempo máxima do Timer2 (TMR2) do PIC18F4550 (ajustando todos os parâmetros com valores máximos para contagem, preescaler, postscaler etc., e definindo valor máximo no registrador PR2 * observar a diferença do
Timer2 para os demais temporizadores). Ajustar o clock do microcontrolador PIC18F4550 para 8 MHz no SimulIDE, carregar o firmware (arquivo hex resultante da compilação no software MikroC PRO for PIC) e realizar a simulação. Apresentar na resposta o programa em linguagem C comentado e print do circuito montado e simulação realizada no SimulIDE. Este programa não faz o uso de interrupções.*


<br>


### Exercício 2


• *Implemente no SimulIDE, com base no Exemplo 8, um programa para mudar o estado de uma saída (representada por um LED conectado à um dos pinos do PORTD) sempre que for sinalizado um evento (representado por um botão quando é pressionado, o qual também ilustra a leitura de um sensor conectado a uma entrada do microcontrolador). Neste caso, a implementação será realizada com uso de interrupções externas. Basicamente, o programa é um aprimoramento do Exemplo 1 (leitura de entrada e acionamento de saída – I/O digital), no qual um botão, ao ser pressionado, muda o estado de um LED. No entanto, ao invés de gastar linhas de código no programa principal para verificar se o botão foi pressionado, utiliza-se interrupções (evento por hardware que faz com que o programa salte automaticamente para a sub-rotina de tratamento somente quando o botão for pressionado). Deve-se utilizar a interrupção externa INT2. Portanto, o botão deve ser conectado na configuração pull-up ao pino do PIC18F4550 correspondente à INT2 (observar qual deve ser este pino por meio da pinagem do microcontrolador disponível no datasheet e no material de aula). Deve-se configurar o uso de interrupções por meio da ativação das chaves globais e específicas da INT2 (flags IE, IF, IP) nos registradores relacionados a esta interrupção (ver datasheet – seção Interrupts). Na sub-rotina de tratamento da interrupção (para onde o programa saltará quando o botão for pressionado), o LED deverá mudar seu nível lógico (inversão) e a INT2IF deve ser zerada (no PIC, este processo é feito manualmente). Ajustar o clock do microcontrolador PIC18F4550 para 8 MHz no SimulIDE, carregar o firmware (arquivo hex resultante da compilação no software MikroC PRO for PIC) e realizar a simulação. Apresentar na resposta o programa em linguagem C comentado e print do circuito montado e simulação realizada no SimulIDE.*


<br>


• *Implemente no SimulIDE, com base no Exemplo 7 disponibilizado no e-Disciplinas, um programa para acender um LED (conectado à um dos pinos do PORTD) após 5 eventos (representados por um botão na configuração pull-up pressionado por 5 vezes) utilizando o Timer1(TMR1) no modo contador (modo 16 bits). Para tanto, o botão deve ser conectado ao pino T13CKI do PIC18F4550 (ver qual é por meio da pinagem disponível no datasheet e no material de aula). Configurar o uso de interrupção (interrupção interna) do TMR1 (habilitar a chave de interrupções de periféricos e ativar flag IE e zerar IF referente ao TMR1). Neste contexto, a interrupção do TMR1 é um tipo especial de exceção interna, cuja sub-rotina de tratamento (para onde o programa irá saltar após a contagem de 5 eventos) será responsável por acender o LED, recarregar os registradores acumuladores do TMR1 e zerar a flag TMR1IF. Ajustar o clock do microcontrolador PIC18F4550 para 8 MHz no SimulIDE, carregar o firmware (arquivo hex resultante da compilação no software MikroC PRO for PIC) e realizar a simulação. Apresentar na resposta o programa em linguagem C comentado e print do circuito montado e simulação realizada no SimulIDE.*


<br>




