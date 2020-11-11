        output "level0.bin"

    db   #fe               ; ID archivo binario, siempre hay que poner el mismo 0FEh
    dw   INICIO            ; dirección de inicio
    dw   FINAL - 1         ; dirección final
    dw   INICIO             ; dircción del programa de ejecución (para cuando pongas r en bload"nombre_programa", r)

    org #b000 ; o 57344, org se utiliza para decirle al z80 en que posición de memoria RAM empieza nuestro programa en ensamblador

INICIO:
    ret ; el ret es necesario para que vuelva al basic
level0:
    db 26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26
    db 26,10,11,26,26,26,26,26,26,26,26,26,10,11,26,26
    db 26,26,26,26,26,26,26,26,10,11,26,26,26,26,26,26
    db 26,6,7,7,7,7,7,7,7,7,7,7,7,7,9,26
    db 26,26,2,0,2,2,2,2,2,2,2,2,2,2,26,26
    db 11,26,2,2,1,2,2,2,2,0,2,1,2,2,26,26
    db 26,26,2,16,17,18,33,33,33,33,33,17,18,2,26,26
    db 26,26,2,2,2,2,2,2,2,2,2,2,2,2,10,11
    db 26,26,2,2,3,2,2,0,2,2,2,3,2,0,26,26
    db 26,26,2,2,19,2,2,2,4,5,2,19,2,2,26,26
    db 26,12,2,2,2,2,2,2,20,21,2,2,2,2,14,26
    db 12,13,13,13,13,13,13,13,13,13,13,13,13,13,13,14
    db 13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13
    





FINAL:
