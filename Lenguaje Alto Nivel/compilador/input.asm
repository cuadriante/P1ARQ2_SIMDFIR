LW r6, r6, #0       ;index for LOOP_AUDIO

LOOP_AUDIO:
    LW r7, r7, #0           ;index for SUMATORIA
    LW r8, r8, #0           ;index of value to store
    LDV r8, r1               ;coeficientes b
    MULV r3, r2, r1         ;mul b * x

LOOP_SUMATORIA:
    BEQ r6, #len(b)-1, FUERA_LOOP    ;mantener contador len(b) - 1
    ROTV r4, r3, #1             ;rotar multiplicado
    ADDV r3, r3, r4             ;sumar rotado con multiplicado
    ADDI r7, r7, #1             ;sumar uno a indice de rotacion
    JAL #1, LOOP_SUMATORIA          ;loop

FUERA_LOOP:
    STV r3, r3, r8              ;store vector r3 only value r8
    ADDI r8, r8, #1         ;++ index of what to store
    ADDI r6, r6, #1         ;++ audio part
    JAL x1, LOOP_AUDIO          ;go next audio part