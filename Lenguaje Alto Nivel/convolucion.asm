LW r6, r6, #0x00                ;indice para muestra 255 bits del audio real - 255 en memoria

LOOP_BETWEEN_AUDIOS:
    ADDI r6, r6, #255           ;+255 audio index
    LW r8, r8, #0               ;indeice del valor por guardar en el memoria final
    LDV r1, #0x00               ;coeficientes b CAMBIAR 0x00 por el espacio de memoria real

LOOP_AUDIO:
    LW r7, r7, #0               ;index for SUMATORIA
    LDV r2, r6                  ;muestra 255 bits del audio
    MULV r3, r2, r1             ;mul b * x

LOOP_SUMATORIA:
    BEQ r7, #15, FUERA_LOOP     ;mantener contador len(b) - 1
    ROTV r4, r3, #1             ;rotar multiplicado
    ADDV r3, r3, r4             ;sumar rotado con multiplicado
    ADDI r7, r7, #1             ;sumar uno a loop de rotacion
    JAL r5, LOOP_SUMATORIA      ;loop hasta r7 = 15

FUERA_LOOP:
    BEQ r8, #255, LOOP_BETWEEN_AUDIOS       ;if los 255 bits han sido guardados conseguir nueva muestra de audio
    STV #0x00, r3, r8                       ;guardar posicion r8 del vector r3, en memoria 0x00
    ROTV r2, r2, #1                         ;rotate vector de coeficientes b vez para ajusta multiplicacion inicial
    ADDI r8, r8, #1                         ;+1 al indice para guardar del vector final
    JAL r5, LOOP_AUDIO                      ;continuar con el siguiente indice r8, pero la misma parte del audio
    
