// Definindo portas e vari�veis globais
int contador = 0;                 // Vari�vel para armazenar a contagem atual
int contagem_ativa = 0;           // Flag para indicar se a contagem est� ativa
int interrupcoes_por_incremento = 4; // N�mero de interrup��es para atualizar o display (valor inicial para RB0)
int contador_interrupcoes = 0;    // Contador de interrup��es

// Configura��o do display de 7 segmentos (c�todo comum, com underscore e ponto decimal)
char segmentos[10] = {0b00111111, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F};

void config() {
    // Configura��es iniciais das portas
    TRISB = 0b00000011;    // RB0 e RB1 como entrada (bot�es)
    TRISD = 0x00;          // Porta D como sa�da (display de 7 segmentos)

    // Configura��o do Timer0 em modo de 16 bits
    T0CON = 0B00000010;  //TIMER_OFF, MOD_16BITS, TIMER, PRES_1:8

    // Carrega o valor inicial do Timer0 para gerar um atraso de 250 ms
    TMR0H = 0x0B;          // Parte alta do valor inicial
    TMR0L = 0xDC;          // Parte baixa do valor inicial
    INTCON.TMR0IF = 0;  // Zera a Flag  (vai p/ 1 quando ocorrer o overflow)
    T0CON.TMR0ON = 1;   // Liga o TIMER0

    // Configura��o de interrup��es
    INTCON = 0xE0;   // Habilita interrup��es globais, TMR0 e externas

    // Configura��o inicial do display
    PORTD = 0x00;    // Display desligado
    PORTC.RC0 = 0;   // Underscore desligado inicialmente
}

// Interrup��o de Timer0 para atualizar o display
void interrupt() {
    // Interrup��o do bot�o RB0 para 1 segundo (4 interrup��es de 250 ms)
    if (INTCON.INT0IF) {
        INTCON.INT0IF = 0;               // Limpa a flag de interrup��o
        TMR0H = 0x0B;                    // Carrega o valor de recarga para 250 ms
        TMR0L = 0xDC;
        interrupcoes_por_incremento = 4; // 4 interrup��es de 250 ms para 1 segundo
        contagem_ativa = 1;              // Ativa a contagem
    }

    // Interrup��o do bot�o RB1 para 250 ms por incremento
    if (INTCON3.INT1IF) {
        INTCON3.INT1IF = 0;              // Limpa a flag de interrup��o
        TMR0H = 0x0B;                    // Carrega o valor de recarga para 250 ms
        TMR0L = 0xDC;
        interrupcoes_por_incremento = 1; // Apenas 1 interrup��o para 250 ms
        contagem_ativa = 1;              // Ativa a contagem
    }

    // Verifica se a interrup��o � do Timer0
    if (INTCON.TMR0IF && contagem_ativa) {
        INTCON.TMR0IF = 0;               // Limpa a flag de interrup��o do Timer0
        TMR0H = 0x0B;                    // Recarrega o Timer0 com o valor inicial para 250 ms
        TMR0L = 0xDC;

        // Incrementa o contador de interrup��es
        contador_interrupcoes++;

        // Verifica se atingiu o n�mero de interrup��es para incrementar o display
        if (contador_interrupcoes >= interrupcoes_por_incremento) {
            contador_interrupcoes = 0; // Reseta o contador de interrup��es

            // Incrementa o contador e reinicia se chegar a 10
            contador++;
            if (contador >= 10) {
                contador = 0;
            }

            // Atualiza o display de 7 segmentos
            PORTD = segmentos[contador];
        }
    }
}

void main() {
    config(); // Configura as portas e registradores
    while(1) {
        // A contagem e atualiza��o do display acontecem na interrup��o
        // Logo, o loop principal apenas mant�m o programa rodando
    }
}