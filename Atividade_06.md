# Atividade 05 - Questões Pós-Aula

## Jean Carlos Pereira Cassiano - NUSP: 13864008 <br> Giovanna de Freitas Velasco - NUSP: 13676346

### Exercícios

• Ilustrar no SimulIDE a conexão de um botão no pino B0 do microcontrolador PIC18F4550 na configuração Pull-Up (externo), o qual ao ser pressionado deverá mudar o estado de um LED conectado ao pino D0, com base no exemplo da Atividade 1. Simule o circuito carregando o arquivo hex gerado na compilação do programa em Linguagem C que atende essa lógica, realizada no software no software MikroC PRO for PIC. Configurar o valor do resistor Pull-Up para 10 kΩ e a frequência do clock do microcontrolador para 8 MHz.

![Captura de tela 2024-10-15 104457](https://github.com/user-attachments/assets/2947e614-2a9c-4347-80cc-f67e9a7e1dbf)

Quando o botão é pressionado, o estado do LED muda. Nessa simulação, a primeira imagem é após o botão ser pressionado.

<br>

Essa imagem da simulação retrada quando o botão é pressionado novamente, em que o LED desliga.

![Captura de tela 2024-10-15 104517](https://github.com/user-attachments/assets/f2a1f5b2-37d4-4e94-9bb7-d264370d049b)

<br>

• Altere a lógica do programa do Exemplo 1 para piscar o LED a cada 500 ms (usando a função delay) enquanto o botão se manter pressionado. Ao soltar o botão, o LED deve ser desligado. 

![image](https://github.com/user-attachments/assets/890d7b9b-c259-4313-9cc7-87bc6556e5c5)

Enquanto o botão está pressionado, o LED pisca com um delay de 500ms, de acordo com o firmware adicionado. Já quando o botão está solto, o LED permanece desligado.


<br>

• Conforme exemplo demonstrado em aula (Exemplo 2), implementar o algoritmo utilizado para tratar o efeito bounce presente no programa do Exemplo 1. Compilar o programa no MikroC PRO for PIC e implementar o circuito no Simul IDE carregando o firmware (arquivo hex gerado na compilação). Ajustar o clock do microcontrolador PIC18F4550 para 8 MHz e o montar o botão na configuração pull-up (ajustar o valor do resistor de pull-up para 10 kΩ) no SimulIDE.


<br>

• Implemente no SimulIDE o programa no Exemplo 3 – Display de 7 Segmentos. Para tanto, realize as ligações de um display de 7 segmentos disponível no simulador no PORTD do microcontrolador. Ajustar o clock do microcontrolador PIC18F4550 para 8 MHz e o montar o botão na configuração pull-up (ajustar o valor do resistor de pull-up para 10 kΩ) no SimulIDE.



<br>

• Levando em consideração os pontos importantes sobre a família de microcontroladores PIC, compare o PIC18F4550 com um microcontrolador da família MSC-51 (por exemplo: AT89S51) estudado anteriormente (focar nas características chaves e mais representativas entre eles: arquitetura, conjunto de instruções, pinagem, periféricos e funcionalidades disponíveis e diferenças quantitativas nas especificações).


<br>

• Após analisar a plataforma EasyPIC v7 fisicamente durante a aula correspondente e com base no material relacionado (manual do kit ou tirar fotos da placa durante a aula, caso preferir), faça um breve resumo (listagem) sobre os principais recursos e periféricos disponíveis nesta placa, listando suas principais funcionalidades para prototipagem em sistemas embarcados.


<br>
