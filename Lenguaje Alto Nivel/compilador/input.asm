LW r1, r1, #0x00 
LW r2, r2, #0x01
ADD r3, r1, r2
SLT r3, r1, r2              ;indice para muestra 255 bits del audio real - 255 en memoria
SW r3, r3, #0x02             ;guardar indice en memoria 0x02
