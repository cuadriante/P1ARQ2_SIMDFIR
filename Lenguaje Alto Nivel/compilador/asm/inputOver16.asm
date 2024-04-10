LW r6, #0x32                            ;indice para muestra 16 elementos del audio real en memoria - 1
LW r9, #0x48                            ;indice para segunda muestra 16 elementos del audio real en memoria - 1
LW r8, #0x64                            ;indice para guardar en memoria real - 16 en memoria

LDV r1, #0x00                               ;coeficientes b_1
LDV r2, #0x16                               ;coeficientes b_2

LOOP_BETWEEN_AUDIOS:
    LW r8, #0                           ;indice del valor por guardar en el memoria final

    ADDI r6, r6, #1                         ;+1 audio get index para primera muestra
    LDV r3, r6                              ;primera muestra 16 elementos del audio
    ADDI r9, r9, #1                         ;+1 audio get index para segunda muestra
    LDV r4, r9                              ;segunda muestra 16 elementos del audio

LOOP_AUDIO:
    LW r7, #0                           ;index for SUMATORIA
    MULV r5, r3, r1                         ;mul_1 = b_1 * x_1
    MULV r6, r4, r2                         ;mul_2 = b_2 * x_2

LOOP_SUMATORIA:
    BEQ r7, #16, FUERA_LOOP                 ;mantener contador len(b) - 1

    ROTV r10, r5, #1                        ;conv_1 rotar multiplicado mul_1 
    ADDV r10, r5, r10                       ;conv_1 sumar rotado con multiplicado mul_1
    ROTV r11, r6, #1                        ;conv_2 rotar multiplicado mul_2
    ADDV r11, r6, r11                       ;conv_2 sumar rotado con multiplicado mul_2

    ADDI r7, r7, #1                         ;sumar uno a loop de rotacion
    JAL r5, LOOP_SUMATORIA                  ;loop hasta r7 = 16
    
                        
FUERA_LOOP:
    ADDV r11, r10, r11                      ;conv_final = conv_1 + conv_2
    STV r11, r8                             ;guardar el vector r11, en espacio de memoria r9
    ADDI r8, r8, #1                         ;+1 al indice para guardar
    JAL r5, LOOP_AUDIO                      ;continuar con el siguiente indice r8, pero la misma parte del audio