// Definindo portas e variáveis globais
int contador = 0;                 // Variável para armazenar a contagem atual
int contagem_ativa = 0;           // Flag para indicar se a contagem está ativa
int interrupcoes_por_incremento = 4; // Número de interrupções para atualizar o display (valor inicial para RB0)
int contador_interrupcoes = 0;    // Contador de interrupções

// Configuração do display de 7 segmentos (cátodo comum, com underscore e ponto decimal)
char segmentos[10] = {0b00111111, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F};

void config() {
    // Configurações iniciais das portas
    TRISB = 0b00000011;    // RB0 e RB1 como entrada (botões)
    TRISD = 0x00;          // Porta D como saída (display de 7 segmentos)

    // Configuração do Timer0 em modo de 16 bits
    T0CON = 0B00000010;  //TIMER_OFF, MOD_16BITS, TIMER, PRES_1:8

    // Carrega o valor inicial do Timer0 para gerar um atraso de 250 ms
    TMR0H = 0x0B;          // Parte alta do valor inicial
    TMR0L = 0xDC;          // Parte baixa do valor inicial
    INTCON.TMR0IF = 0;  // Zera a Flag  (vai p/ 1 quando ocorrer o overflow)
    T0CON.TMR0ON = 1;   // Liga o TIMER0

    // Configuração de interrupções
    INTCON = 0xE0;   // Habilita interrupções globais, TMR0 e externas

    // Configuração inicial do display
    PORTD = 0x00;    // Display desligado
    PORTC.RC0 = 0;   // Underscore desligado inicialmente
}

// Interrupção de Timer0 para atualizar o display
void interrupt() {
    // Interrupção do botão RB0 para 1 segundo (4 interrupções de 250 ms)
    if (INTCON.INT0IF) {
        INTCON.INT0IF = 0;               // Limpa a flag de interrupção
        TMR0H = 0x0B;                    // Carrega o valor de recarga para 250 ms
        TMR0L = 0xDC;
        interrupcoes_por_incremento = 4; // 4 interrupções de 250 ms para 1 segundo
        contagem_ativa = 1;              // Ativa a contagem
    }

    // Interrupção do botão RB1 para 250 ms por incremento
    if (INTCON3.INT1IF) {
        INTCON3.INT1IF = 0;              // Limpa a flag de interrupção
        TMR0H = 0x0B;                    // Carrega o valor de recarga para 250 ms
        TMR0L = 0xDC;
        interrupcoes_por_incremento = 1; // Apenas 1 interrupção para 250 ms
        contagem_ativa = 1;              // Ativa a contagem
    }

    // Verifica se a interrupção é do Timer0
    if (INTCON.TMR0IF && contagem_ativa) {
        INTCON.TMR0IF = 0;               // Limpa a flag de interrupção do Timer0
        TMR0H = 0x0B;                    // Recarrega o Timer0 com o valor inicial para 250 ms
        TMR0L = 0xDC;

        // Incrementa o contador de interrupções
        contador_interrupcoes++;

        // Verifica se atingiu o número de interrupções para incrementar o display
        if (contador_interrupcoes >= interrupcoes_por_incremento) {
            contador_interrupcoes = 0; // Reseta o contador de interrupções

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
        // A contagem e atualização do display acontecem na interrupção
        // Logo, o loop principal apenas mantém o programa rodando
    }
}