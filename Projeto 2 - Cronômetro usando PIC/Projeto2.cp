#line 1 "C:/Users/gigif/Desktop/Projeto 2 - Cronômetro usando PIC/Projeto2.c"

int contador = 0;
int contagem_ativa = 0;
int interrupcoes_por_incremento = 4;
int contador_interrupcoes = 0;


char segmentos[10] = {0b00111111, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F};

void config() {

 TRISB = 0b00000011;
 TRISD = 0x00;
 TRISC = 0xFE;


 T0CON = 0B00000010;


 TMR0H = 0x0B;
 TMR0L = 0xDC;
 INTCON.TMR0IF = 0;
 T0CON.TMR0ON = 1;


 INTCON = 0xE0;


 PORTD = 0x00;
 PORTC.RC0 = 0;
}


void interrupt() {

 if (INTCON.INT0IF) {
 INTCON.INT0IF = 0;
 TMR0H = 0x0B;
 TMR0L = 0xDC;
 interrupcoes_por_incremento = 4;
 contagem_ativa = 1;
 }


 if (INTCON3.INT1IF) {
 INTCON3.INT1IF = 0;
 TMR0H = 0x0B;
 TMR0L = 0xDC;
 interrupcoes_por_incremento = 1;
 contagem_ativa = 1;
 }


 if (INTCON.TMR0IF && contagem_ativa) {
 INTCON.TMR0IF = 0;
 TMR0H = 0x0B;
 TMR0L = 0xDC;


 contador_interrupcoes++;


 if (contador_interrupcoes >= interrupcoes_por_incremento) {
 contador_interrupcoes = 0;


 contador++;
 if (contador >= 10) {
 contador = 0;
 }


 PORTD = segmentos[contador];


 if (contador == 0) {
 PORTC.RC0 = 1;
 } else {
 PORTC.RC0 = 0;
 }
 }
 }
}

void main() {
 config();
 while(1) {


 }
}
