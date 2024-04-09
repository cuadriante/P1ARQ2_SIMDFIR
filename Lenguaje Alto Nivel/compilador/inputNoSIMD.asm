LW r1, #0x16                                        ;index a primer valor x
LW r9, #0x48                                        ;index a primer valor y

GO_NEXT_AUDIO_PART:
    LW r3, #0                                       ;contador para muestreo
    LW r6, #0                                       ;acumulador multiplicacion
    LW r7, #1                                       ;restador multiplicacion
    LW r2, #0x0                                     ;index a primer coeficiente b

LOOP_PRINCIPAL:
    LW r4, r2                                       ;cargar coeficiente b (r2) en r3
    LW r5, r1                                       ;cargar muestra cancion (r1) en r4
    
LOOP_MULTIPLICACION:
    BEQ r4, #0, DONE                                ;si el multiplicador llega a cero entonces salimos porque tenemos el producto
    ADD r6, r6, r5                                  ;sumar al acumulador el multiplicando
    SUB r4, r4, r7                                  ;decrementar el multiplicador en 1

    JAL r8, LOOP_MULTIPLICACION                     ;saltamos y seguimos loop

DONE:
    BEQ r3, #7, STORE_VALUE                         ;si se hizo el algoritmo len(b)-1 veces guardamos el valor en el primer indice de guardado
    ADDI r2, r2, #1                                 ;conseguir siguiente coeficiente
    ADDI r1, r1, #1                                 ;conseguir siguiente muestra audio
    ADDI r3, r3, #1                                 ;+1 contador muestreo

    JAL r8, LOOP_PRINCIPAL

STORE_VALUE:
    SW r6, r9                                       ;guardamos valor en memoria r8
    ADDI r9, r9, #1                                 ;+1 memoria de guardado
    SUB r2, r2, r3                                  ;restamos len(b)-1 a memoria de entrada

    JAL r8, GO_NEXT_AUDIO_PART
