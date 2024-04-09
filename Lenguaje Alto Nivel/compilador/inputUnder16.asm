LW r6, r6, #0x16                            ;indice para muestra 16 elementos del audio real - 7 en memoria
LW r9, r9, #0x48                            ;indice para guardar en memoria real
LDV r1, #0x00                               ;coeficientes b CAMBIAR 0x00 por el espacio de memoria real

LOOP_BETWEEN_AUDIOS:
    ADDI r6, r6, #7                         ;+(x-(b-1)) audio get index EN ESTE CASO B = 8 COEFICIENTES
    LW r8, r8, #0                           ;indice del valor por guardar en el memoria final
    LDV r2, r6                              ;muestra 16 elementos del audio

LOOP_AUDIO:
    LW r7, r7, #0                           ;index for SUMATORIA
    MULV r3, r2, r1                         ;mul b * x

LOOP_SUMATORIA:
    BEQ r7, #8, FUERA_LOOP                  ;mantener contador len(b) - 1
    ROTV r4, r3, #1                         ;rotar multiplicado
    ADDV r4, r3, r4                         ;sumar rotado con multiplicado
    ADDI r7, r7, #1                         ;sumar uno a loop de rotacion
    JAL r5, LOOP_SUMATORIA                  ;loop hasta r7 = 8

FUERA_LOOP:
    STV r4, r9                              ;guardar el vector r4, en espacio de memoria r9
    ROTV r2, r2, #1                         ;rotate vector de x para ajustar multiplicacion inicial y se hace x-b veces
    ADDI r8, r8, #1                         ;+1 al indice para guardar
    BEQ r8, #8, LOOP_BETWEEN_AUDIOS         ;if los 8 bits han sido guardados conseguir nueva muestra de audio
    ADDI r9, r9, #1                         ;+1 al espacio de memoria para guardar para que termine en +(x-(b-1))
    JAL r5, LOOP_AUDIO                      ;continuar con el siguiente indice r8, pero la misma parte del audio