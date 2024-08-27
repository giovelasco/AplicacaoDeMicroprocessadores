# Atividade 02 - Questões Pós-Aula

## Jean Carlos Pereira Cassiano - NUSP: 13864008 <br> Giovanna de Freitas Velasco - NUSP: 13676346

### Questão 8

*No simulador EdSim51, digite e execute (clicando em “Assm”) as instruções abaixo:*

``` 
MOV R0, #22h
MOV 00h, #22h
```

*Qual é a diferença entre as duas instruções acima? Tente refletir porque possuem ciclos de máquina diferentes se a operação é realizada na mesma posição de memória RAM (00h ou R0 usa o mesmo espaço).*

Por mais que a operação seja realizada no mesmo espaço de memória, o set de instruções do 8051 possui múltiplas instruções do tipo MOV. Dentre elas, existe uma instrução que move um dado diretamente para o registrador R0, sem precisar especificar o local de destino na instrução. Essa instrução corresponde ao opcode 0x78, que necessita de apenas 2 bytes na memória de programa. Já a operação MOV de opcode 0x75 move um dado para um endereço de memória que precisa ser especificado na instrução depois, ocupando 3 bytes na memória de programa.

Portanto, a instrução MOV R0, #22h utiliza um ciclo por não precisar buscar novamente na memória de programa o endereço de destino do dado, uma vez que isso já está definido no próprio opcode. Já a instrução MOV 00h, #22h utiliza dois ciclos por precisar buscar o enredeço de destino na memória de programa, uma vez que o endereço de destino não foi especificado pelo opcode.

``` 
MOV A, #22h
MOV ACC, #22h
```

*Qual é a diferença entre as duas instruções acima? Tente refletir sobre a diferença de usar A ou ACC e sobre porque possuem ciclos de máquina diferentes se a operação realizada é a mesma.*


### Questão 9

*A Figura abaixo mostra um microcontrolador genérico de 8 bits com 4 registradores internos à CPU, os quais são: Instruction Register (IR), Program Counter (PC), Accumulator (ACC) e Data Pointer (DPTR). Baseado na Figura abaixo, responda às questões com verdadeiro (V) ou Falso (F):*

![image](https://github.com/user-attachments/assets/643e832e-23f2-4457-9fc3-d2ce9b168872)

( ) Trata-se de um microcontrolador de arquitetura Harvard.

( ) A memória EEPROM é de 4Kbytes e armazena as instruções que comandam o
microcontrolador.

( ) A memória SRAM é de 512 bytes e armazena dados voláteis

( ) O registrador IR tem a função de armazenar a instrução lida da memória SRAM.

( ) Para esse microcontrolador, o registrador IR deve ser de 8 bits

( ) O registrador PC armazena o endereço da instrução lida da memória EEPROM.

( ) Para esse microcontrolador, o registrador PC deve ser de 10 bits.

( ) Para esse microcontrolador, o registrador ACC deve ser de 8 bits.

( ) O registrador DPTR é um ponteiro que aponta para a última instrução lida da
memória.

( ) Para esse microcontrolador, o registrador DPTR deve ser de 10 bits.


