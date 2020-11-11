        output "level1.bin"

    db   #fe               ; ID archivo binario, siempre hay que poner el mismo 0FEh
    dw   INICIO            ; dirección de inicio
    dw   FINAL - 1         ; dirección final
    dw   INICIO             ; dircción del programa de ejecución (para cuando pongas r en bload"nombre_programa", r)

    org #b000 ; o 57344, org se utiliza para decirle al z80 en que posición de memoria RAM empieza nuestro programa en ensamblador

INICIO:
    ret ; el ret es necesario para que vuelva al basic
level0:


    db 27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27
    db 27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27
    db 8,8,8,27,8,8,8,8,8,27,8,8,8,8,8,27
    db 2,2,2,27,2,2,2,2,2,27,2,2,2,2,2,27
    db 2,27,2,27,2,27,2,27,2,27,2,27,2,27,2,27
    db 2,2,2,27,2,2,2,2,2,27,2,2,2,2,2,27
    db 2,27,2,27,2,27,2,27,2,27,2,27,2,27,2,27
    db 2,2,2,27,2,2,2,2,2,27,2,2,2,2,2,27
    db 35,2,2,27,2,2,35,2,2,27,2,2,35,2,2,27
    db 13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13
    db 13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13
    db 13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13
    db 13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13





FINAL:
