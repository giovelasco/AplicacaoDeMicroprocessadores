
_config:

;Projeto2.c,10 :: 		void config() {
;Projeto2.c,12 :: 		TRISB = 0b00000011;    // RB0 e RB1 como entrada (botões)
	MOVLW       3
	MOVWF       TRISB+0 
;Projeto2.c,13 :: 		TRISD = 0x00;          // Porta D como saída (display de 7 segmentos)
	CLRF        TRISD+0 
;Projeto2.c,14 :: 		TRISC = 0xFE;          // RC0 como saída para controlar o underscore
	MOVLW       254
	MOVWF       TRISC+0 
;Projeto2.c,17 :: 		T0CON = 0B00000010;  //TIMER_OFF, MOD_16BITS, TIMER, PRES_1:8
	MOVLW       2
	MOVWF       T0CON+0 
;Projeto2.c,20 :: 		TMR0H = 0x0B;          // Parte alta do valor inicial (0xC2F7)
	MOVLW       11
	MOVWF       TMR0H+0 
;Projeto2.c,21 :: 		TMR0L = 0xCC;          // Parte baixa do valor inicial
	MOVLW       204
	MOVWF       TMR0L+0 
;Projeto2.c,22 :: 		INTCON.TMR0IF = 0;  // Zera a Flag  (vai p/ 1 quando ocorrer o overflow)
	BCF         INTCON+0, 2 
;Projeto2.c,23 :: 		T0CON.TMR0ON = 1;   // Liga o TIMER0
	BSF         T0CON+0, 7 
;Projeto2.c,26 :: 		INTCON = 0xE0;   // Habilita interrupções globais, TMR0 e externas
	MOVLW       224
	MOVWF       INTCON+0 
;Projeto2.c,29 :: 		PORTD = 0x00;    // Display desligado
	CLRF        PORTD+0 
;Projeto2.c,30 :: 		PORTC.RC0 = 0;   // Underscore desligado inicialmente
	BCF         PORTC+0, 0 
;Projeto2.c,31 :: 		}
L_end_config:
	RETURN      0
; end of _config

_interrupt:

;Projeto2.c,34 :: 		void interrupt() {
;Projeto2.c,36 :: 		if (INTCON.INT0IF) {
	BTFSS       INTCON+0, 1 
	GOTO        L_interrupt0
;Projeto2.c,37 :: 		INTCON.INT0IF = 0;               // Limpa a flag de interrupção
	BCF         INTCON+0, 1 
;Projeto2.c,38 :: 		TMR0H = 0x0B;                    // Carrega o valor de recarga para 250 ms
	MOVLW       11
	MOVWF       TMR0H+0 
;Projeto2.c,39 :: 		TMR0L = 0xCC;
	MOVLW       204
	MOVWF       TMR0L+0 
;Projeto2.c,40 :: 		interrupcoes_por_incremento = 4; // 4 interrupções de 250 ms para 1 segundo
	MOVLW       4
	MOVWF       _interrupcoes_por_incremento+0 
	MOVLW       0
	MOVWF       _interrupcoes_por_incremento+1 
;Projeto2.c,41 :: 		contagem_ativa = 1;              // Ativa a contagem
	MOVLW       1
	MOVWF       _contagem_ativa+0 
	MOVLW       0
	MOVWF       _contagem_ativa+1 
;Projeto2.c,42 :: 		}
L_interrupt0:
;Projeto2.c,45 :: 		if (INTCON3.INT1IF) {
	BTFSS       INTCON3+0, 0 
	GOTO        L_interrupt1
;Projeto2.c,46 :: 		INTCON3.INT1IF = 0;              // Limpa a flag de interrupção
	BCF         INTCON3+0, 0 
;Projeto2.c,47 :: 		TMR0H = 0x0B;                    // Carrega o valor de recarga para 250 ms
	MOVLW       11
	MOVWF       TMR0H+0 
;Projeto2.c,48 :: 		TMR0L = 0xCC;
	MOVLW       204
	MOVWF       TMR0L+0 
;Projeto2.c,49 :: 		interrupcoes_por_incremento = 1; // Apenas 1 interrupção para 250 ms
	MOVLW       1
	MOVWF       _interrupcoes_por_incremento+0 
	MOVLW       0
	MOVWF       _interrupcoes_por_incremento+1 
;Projeto2.c,50 :: 		contagem_ativa = 1;              // Ativa a contagem
	MOVLW       1
	MOVWF       _contagem_ativa+0 
	MOVLW       0
	MOVWF       _contagem_ativa+1 
;Projeto2.c,51 :: 		}
L_interrupt1:
;Projeto2.c,54 :: 		if (INTCON.TMR0IF && contagem_ativa) {
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt4
	MOVF        _contagem_ativa+0, 0 
	IORWF       _contagem_ativa+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt4
L__interrupt11:
;Projeto2.c,55 :: 		INTCON.TMR0IF = 0;               // Limpa a flag de interrupção do Timer0
	BCF         INTCON+0, 2 
;Projeto2.c,56 :: 		TMR0H = 0x0B;                    // Recarrega o Timer0 com o valor inicial para 250 ms
	MOVLW       11
	MOVWF       TMR0H+0 
;Projeto2.c,57 :: 		TMR0L = 0xCC;
	MOVLW       204
	MOVWF       TMR0L+0 
;Projeto2.c,60 :: 		contador_interrupcoes++;
	INFSNZ      _contador_interrupcoes+0, 1 
	INCF        _contador_interrupcoes+1, 1 
;Projeto2.c,63 :: 		if (contador_interrupcoes >= interrupcoes_por_incremento) {
	MOVLW       128
	XORWF       _contador_interrupcoes+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _interrupcoes_por_incremento+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt15
	MOVF        _interrupcoes_por_incremento+0, 0 
	SUBWF       _contador_interrupcoes+0, 0 
L__interrupt15:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt5
;Projeto2.c,64 :: 		contador_interrupcoes = 0; // Reseta o contador de interrupções
	CLRF        _contador_interrupcoes+0 
	CLRF        _contador_interrupcoes+1 
;Projeto2.c,67 :: 		contador++;
	INFSNZ      _contador+0, 1 
	INCF        _contador+1, 1 
;Projeto2.c,68 :: 		if (contador >= 10) {
	MOVLW       128
	XORWF       _contador+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt16
	MOVLW       10
	SUBWF       _contador+0, 0 
L__interrupt16:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt6
;Projeto2.c,69 :: 		contador = 0;
	CLRF        _contador+0 
	CLRF        _contador+1 
;Projeto2.c,70 :: 		}
L_interrupt6:
;Projeto2.c,73 :: 		PORTD = segmentos[contador];
	MOVLW       _segmentos+0
	ADDWF       _contador+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_segmentos+0)
	ADDWFC      _contador+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       PORTD+0 
;Projeto2.c,76 :: 		if (contador == 0) {
	MOVLW       0
	XORWF       _contador+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt17
	MOVLW       0
	XORWF       _contador+0, 0 
L__interrupt17:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt7
;Projeto2.c,77 :: 		PORTC.RC0 = 1; // Liga o underscore
	BSF         PORTC+0, 0 
;Projeto2.c,78 :: 		} else {
	GOTO        L_interrupt8
L_interrupt7:
;Projeto2.c,79 :: 		PORTC.RC0 = 0; // Desliga o underscore
	BCF         PORTC+0, 0 
;Projeto2.c,80 :: 		}
L_interrupt8:
;Projeto2.c,81 :: 		}
L_interrupt5:
;Projeto2.c,82 :: 		}
L_interrupt4:
;Projeto2.c,83 :: 		}
L_end_interrupt:
L__interrupt14:
	RETFIE      1
; end of _interrupt

_main:

;Projeto2.c,85 :: 		void main() {
;Projeto2.c,86 :: 		config(); // Configura as portas e registradores
	CALL        _config+0, 0
;Projeto2.c,87 :: 		while(1) {
L_main9:
;Projeto2.c,90 :: 		}
	GOTO        L_main9
;Projeto2.c,91 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
