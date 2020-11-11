        output "world0.bin"

    db   #fe               ; ID archivo binario, siempre hay que poner el mismo 0FEh
    dw   INICIO            ; dirección de inicio
    dw   FINAL - 1         ; dirección final
    dw   INICIO             ; dircción del programa de ejecución (para cuando pongas r en bload"nombre_programa", r)

    org #c000 ; o 57344, org se utiliza para decirle al z80 en que posición de memoria RAM empieza nuestro programa en ensamblador

INICIO:
    ret ; el ret es necesario para que vuelva al basic
Worl0:
    db 22,23,12,13,14,15,16,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,16,17,50,51,84,84,85
    db 54,55,44,45,46,47,48,49,49,49,49,49,49,49,49,49,49,49,49,49,49,49,49,49,49,48,49,82,83,20,21,22
    db 116,84,85,36,4,5,4,38,39,4,4,4,4,4,36,36,0,1,37,37,37,4,4,38,39,4,4,4,5,52,53,54
    db 116,84,85,36,4,64,65,66,67,68,128,129,130,131,132,133,130,131,130,131,132,133,65,66,67,68,69,5,5,84,84,85
    db 21,22,23,36,4,96,97,98,99,100,160,161,162,163,164,165,162,163,162,163,164,165,97,98,99,100,101,4,5,84,20,21
    db 53,54,55,36,36,4,5,6,7,5,5,32,33,4,6,7,5,4,4,4,5,4,4,6,7,4,5,4,5,84,52,53
    db 116,117,117,4,36,4,5,38,39,37,37,5,5,5,38,39,37,36,36,36,37,36,36,38,39,36,37,4,5,84,85,85
    db 84,116,117,36,36,4,5,70,71,36,37,37,37,37,70,71,5,8,9,10,11,36,37,70,71,37,5,4,5,84,85,117
    db 116,117,85,36,37,36,37,102,103,37,37,37,37,37,102,103,37,40,41,42,43,37,37,102,103,37,37,5,5,84,84,85
    db 84,116,117,4,36,37,37,37,4,4,4,4,4,4,4,4,4,72,73,74,75,37,5,5,5,36,37,37,37,116,84,85
    db 116,117,25,36,36,36,36,36,36,36,36,36,36,36,36,36,36,104,105,106,107,37,37,37,37,37,37,37,37,28,116,117
    db 24,25,57,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,27,28,29
    db 56,57,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,60,61
    db 26,27,27,59,59,59,59,59,59,59,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,27,27
    db 26,26,26,26,26,26,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,59
    db 58,58,58,58,58,58,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59
    ;level2
    db 111,111,111,112,113,85,86,111,111,111,111,111,111,112,113,85,86,111,111,111,111,112,113,85,86,111,111,111,111,112,113,85
    db 4,36,36,4,5,85,86,4,5,37,4,36,37,37,5,85,86,4,5,4,5,5,5,85,86,4,4,4,5,4,5,85
    db 4,36,12,4,5,85,86,4,12,37,36,12,36,12,5,85,86,4,12,4,5,12,5,85,86,36,12,4,37,12,5,85
    db 4,36,37,4,5,85,86,4,5,37,36,37,37,4,5,85,86,4,5,4,5,37,5,85,86,36,4,4,37,4,5,85
    db 4,36,37,4,5,85,86,4,4,5,36,36,37,4,5,85,86,4,12,4,5,12,5,85,86,36,12,36,37,12,5,85
    db 36,12,37,12,5,85,86,36,12,5,36,12,37,12,5,85,86,4,5,4,5,37,37,85,86,36,4,36,37,37,5,85
    db 36,37,37,4,5,85,86,4,5,5,36,36,37,5,37,85,86,4,12,5,5,12,37,85,86,36,12,5,36,12,5,85
    db 36,37,37,4,4,86,86,36,12,5,36,37,4,12,5,85,86,4,36,37,37,37,37,85,86,36,4,5,36,37,5,85
    db 4,5,5,5,4,86,118,36,37,4,4,4,5,5,5,85,86,4,4,4,4,5,37,85,86,36,4,5,5,5,5,117
    db 4,134,135,37,4,85,86,36,37,4,134,135,5,37,37,85,86,36,4,134,135,5,5,85,86,36,4,134,135,5,5,85
    db 4,166,167,5,4,85,86,4,4,4,166,167,5,5,5,85,86,4,4,166,167,5,5,85,86,36,36,166,167,37,37,117
    db 27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,26,26,26,26,27
    db 59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,58,58,58,58,59
    db 58,58,26,27,27,27,27,27,27,27,27,27,27,27,58,58,58,58,58,58,59,58,58,58,58,58,58,58,58,58,26,27
    db 26,26,26,26,26,26,26,26,26,26,26,26,26,26,58,59,59,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27
    db 58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59
    ;level3
    db 22,23,12,13,14,15,16,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,16,17,50,51,84,84,85
    db 54,55,44,45,46,47,48,49,49,49,49,49,49,49,49,49,49,49,49,49,49,49,49,49,49,48,49,82,83,20,21,22
    db 116,84,85,36,4,5,4,38,39,4,4,4,4,4,36,36,0,1,37,37,37,4,4,38,39,4,4,4,5,52,53,54
    db 116,84,85,36,4,64,65,66,67,68,128,129,130,131,132,133,130,131,130,131,132,133,65,66,67,68,69,5,5,84,84,85
    db 21,22,23,36,4,96,97,98,99,100,160,161,162,163,164,165,162,163,162,163,164,165,97,98,99,100,101,4,5,84,20,21
    db 53,54,55,36,36,4,5,6,7,5,5,32,33,4,6,7,5,4,4,4,5,4,4,6,7,4,5,4,5,84,52,53
    db 116,117,117,4,36,4,5,38,39,37,37,5,5,5,38,39,37,36,36,36,37,36,36,38,39,36,37,4,5,84,85,85
    db 84,116,117,36,36,4,5,70,71,36,37,37,37,37,70,71,5,8,9,10,11,36,37,70,71,37,5,4,5,84,85,117
    db 116,117,85,36,37,36,37,102,103,37,37,37,37,37,102,103,37,40,41,42,43,37,37,102,103,37,37,5,5,84,84,85
    db 84,116,117,4,36,37,37,37,4,4,4,4,4,4,4,4,4,72,73,74,75,37,5,5,5,36,37,37,37,116,84,85
    db 116,117,25,36,36,36,36,36,36,36,36,36,36,36,36,36,36,104,105,106,107,37,37,37,37,37,37,37,37,28,116,117
    db 24,25,57,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,27,28,29
    db 56,57,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,60,61
    db 26,27,27,59,59,59,59,59,59,59,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,27,27
    db 26,26,26,26,26,26,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,59
    db 58,58,58,58,58,58,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59
    ;level4
    db 111,111,111,112,113,85,86,111,111,111,111,111,111,112,113,85,86,111,111,111,111,112,113,85,86,111,111,111,111,112,113,85
    db 4,36,36,4,5,85,86,4,5,37,4,36,37,37,5,85,86,4,5,4,5,5,5,85,86,4,4,4,5,4,5,85
    db 4,36,12,4,5,85,86,4,12,37,36,12,36,12,5,85,86,4,12,4,5,12,5,85,86,36,12,4,37,12,5,85
    db 4,36,37,4,5,85,86,4,5,37,36,37,37,4,5,85,86,4,5,4,5,37,5,85,86,36,4,4,37,4,5,85
    db 4,36,37,4,5,85,86,4,4,5,36,36,37,4,5,85,86,4,12,4,5,12,5,85,86,36,12,36,37,12,5,85
    db 36,12,37,12,5,85,86,36,12,5,36,12,37,12,5,85,86,4,5,4,5,37,37,85,86,36,4,36,37,37,5,85
    db 36,37,37,4,5,85,86,4,5,5,36,36,37,5,37,85,86,4,12,5,5,12,37,85,86,36,12,5,36,12,5,85
    db 36,37,37,4,4,86,86,36,12,5,36,37,4,12,5,85,86,4,36,37,37,37,37,85,86,36,4,5,36,37,5,85
    db 4,5,5,5,4,86,118,36,37,4,4,4,5,5,5,85,86,4,4,4,4,5,37,85,86,36,4,5,5,5,5,117
    db 4,134,135,37,4,85,86,36,37,4,134,135,5,37,37,85,86,36,4,134,135,5,5,85,86,36,4,134,135,5,5,85
    db 4,166,167,5,4,85,86,4,4,4,166,167,5,5,5,85,86,4,4,166,167,5,5,85,86,36,36,166,167,37,37,117
    db 27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,26,26,26,26,27
    db 59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,58,58,58,58,59
    db 58,58,26,27,27,27,27,27,27,27,27,27,27,27,58,58,58,58,58,58,59,58,58,58,58,58,58,58,58,58,26,27
    db 26,26,26,26,26,26,26,26,26,26,26,26,26,26,58,59,59,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27
    db 58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59
    ;level5
    db 22,23,12,13,14,15,16,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,16,17,50,51,84,84,85
    db 54,55,44,45,46,47,48,49,49,49,49,49,49,49,49,49,49,49,49,49,49,49,49,49,49,48,49,82,83,20,21,22
    db 116,84,85,36,4,5,4,38,39,4,4,4,4,4,36,36,0,1,37,37,37,4,4,38,39,4,4,4,5,52,53,54
    db 116,84,85,36,4,64,65,66,67,68,128,129,130,131,132,133,130,131,130,131,132,133,65,66,67,68,69,5,5,84,84,85
    db 21,22,23,36,4,96,97,98,99,100,160,161,162,163,164,165,162,163,162,163,164,165,97,98,99,100,101,4,5,84,20,21
    db 53,54,55,36,36,4,5,6,7,5,5,32,33,4,6,7,5,4,4,4,5,4,4,6,7,4,5,4,5,84,52,53
    db 116,117,117,4,36,4,5,38,39,37,37,5,5,5,38,39,37,36,36,36,37,36,36,38,39,36,37,4,5,84,85,85
    db 84,116,117,36,36,4,5,70,71,36,37,37,37,37,70,71,5,8,9,10,11,36,37,70,71,37,5,4,5,84,85,117
    db 116,117,85,36,37,36,37,102,103,37,37,37,37,37,102,103,37,40,41,42,43,37,37,102,103,37,37,5,5,84,84,85
    db 84,116,117,4,36,37,37,37,4,4,4,4,4,4,4,4,4,72,73,74,75,37,5,5,5,36,37,37,37,116,84,85
    db 116,117,25,36,36,36,36,36,36,36,36,36,36,36,36,36,36,104,105,106,107,37,37,37,37,37,37,37,37,28,116,117
    db 24,25,57,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,27,28,29
    db 56,57,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,60,61
    db 26,27,27,59,59,59,59,59,59,59,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,27,27
    db 26,26,26,26,26,26,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,59
    db 58,58,58,58,58,58,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59
    ;level6
    db 111,111,111,112,113,85,86,111,111,111,111,111,111,112,113,85,86,111,111,111,111,112,113,85,86,111,111,111,111,112,113,85
    db 4,36,36,4,5,85,86,4,5,37,4,36,37,37,5,85,86,4,5,4,5,5,5,85,86,4,4,4,5,4,5,85
    db 4,36,12,4,5,85,86,4,12,37,36,12,36,12,5,85,86,4,12,4,5,12,5,85,86,36,12,4,37,12,5,85
    db 4,36,37,4,5,85,86,4,5,37,36,37,37,4,5,85,86,4,5,4,5,37,5,85,86,36,4,4,37,4,5,85
    db 4,36,37,4,5,85,86,4,4,5,36,36,37,4,5,85,86,4,12,4,5,12,5,85,86,36,12,36,37,12,5,85
    db 36,12,37,12,5,85,86,36,12,5,36,12,37,12,5,85,86,4,5,4,5,37,37,85,86,36,4,36,37,37,5,85
    db 36,37,37,4,5,85,86,4,5,5,36,36,37,5,37,85,86,4,12,5,5,12,37,85,86,36,12,5,36,12,5,85
    db 36,37,37,4,4,86,86,36,12,5,36,37,4,12,5,85,86,4,36,37,37,37,37,85,86,36,4,5,36,37,5,85
    db 4,5,5,5,4,86,118,36,37,4,4,4,5,5,5,85,86,4,4,4,4,5,37,85,86,36,4,5,5,5,5,117
    db 4,134,135,37,4,85,86,36,37,4,134,135,5,37,37,85,86,36,4,134,135,5,5,85,86,36,4,134,135,5,5,85
    db 4,166,167,5,4,85,86,4,4,4,166,167,5,5,5,85,86,4,4,166,167,5,5,85,86,36,36,166,167,37,37,117
    db 27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,26,26,26,26,27
    db 59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,58,58,58,58,59
    db 58,58,26,27,27,27,27,27,27,27,27,27,27,27,58,58,58,58,58,58,59,58,58,58,58,58,58,58,58,58,26,27
    db 26,26,26,26,26,26,26,26,26,26,26,26,26,26,58,59,59,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27
    db 58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59
    ;level7
    db 22,23,12,13,14,15,16,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,16,17,50,51,84,84,85
    db 54,55,44,45,46,47,48,49,49,49,49,49,49,49,49,49,49,49,49,49,49,49,49,49,49,48,49,82,83,20,21,22
    db 116,84,85,36,4,5,4,38,39,4,4,4,4,4,36,36,0,1,37,37,37,4,4,38,39,4,4,4,5,52,53,54
    db 116,84,85,36,4,64,65,66,67,68,128,129,130,131,132,133,130,131,130,131,132,133,65,66,67,68,69,5,5,84,84,85
    db 21,22,23,36,4,96,97,98,99,100,160,161,162,163,164,165,162,163,162,163,164,165,97,98,99,100,101,4,5,84,20,21
    db 53,54,55,36,36,4,5,6,7,5,5,32,33,4,6,7,5,4,4,4,5,4,4,6,7,4,5,4,5,84,52,53
    db 116,117,117,4,36,4,5,38,39,37,37,5,5,5,38,39,37,36,36,36,37,36,36,38,39,36,37,4,5,84,85,85
    db 84,116,117,36,36,4,5,70,71,36,37,37,37,37,70,71,5,8,9,10,11,36,37,70,71,37,5,4,5,84,85,117
    db 116,117,85,36,37,36,37,102,103,37,37,37,37,37,102,103,37,40,41,42,43,37,37,102,103,37,37,5,5,84,84,85
    db 84,116,117,4,36,37,37,37,4,4,4,4,4,4,4,4,4,72,73,74,75,37,5,5,5,36,37,37,37,116,84,85
    db 116,117,25,36,36,36,36,36,36,36,36,36,36,36,36,36,36,104,105,106,107,37,37,37,37,37,37,37,37,28,116,117
    db 24,25,57,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,27,28,29
    db 56,57,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,60,61
    db 26,27,27,59,59,59,59,59,59,59,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,27,27
    db 26,26,26,26,26,26,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,59
    db 58,58,58,58,58,58,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59
    ;level8
    db 111,111,111,112,113,85,86,111,111,111,111,111,111,112,113,85,86,111,111,111,111,112,113,85,86,111,111,111,111,112,113,85
    db 4,36,36,4,5,85,86,4,5,37,4,36,37,37,5,85,86,4,5,4,5,5,5,85,86,4,4,4,5,4,5,85
    db 4,36,12,4,5,85,86,4,12,37,36,12,36,12,5,85,86,4,12,4,5,12,5,85,86,36,12,4,37,12,5,85
    db 4,36,37,4,5,85,86,4,5,37,36,37,37,4,5,85,86,4,5,4,5,37,5,85,86,36,4,4,37,4,5,85
    db 4,36,37,4,5,85,86,4,4,5,36,36,37,4,5,85,86,4,12,4,5,12,5,85,86,36,12,36,37,12,5,85
    db 36,12,37,12,5,85,86,36,12,5,36,12,37,12,5,85,86,4,5,4,5,37,37,85,86,36,4,36,37,37,5,85
    db 36,37,37,4,5,85,86,4,5,5,36,36,37,5,37,85,86,4,12,5,5,12,37,85,86,36,12,5,36,12,5,85
    db 36,37,37,4,4,86,86,36,12,5,36,37,4,12,5,85,86,4,36,37,37,37,37,85,86,36,4,5,36,37,5,85
    db 4,5,5,5,4,86,118,36,37,4,4,4,5,5,5,85,86,4,4,4,4,5,37,85,86,36,4,5,5,5,5,117
    db 4,134,135,37,4,85,86,36,37,4,134,135,5,37,37,85,86,36,4,134,135,5,5,85,86,36,4,134,135,5,5,85
    db 4,166,167,5,4,85,86,4,4,4,166,167,5,5,5,85,86,4,4,166,167,5,5,85,86,36,36,166,167,37,37,117
    db 27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,26,26,26,26,27
    db 59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,58,58,58,58,59
    db 58,58,26,27,27,27,27,27,27,27,27,27,27,27,58,58,58,58,58,58,59,58,58,58,58,58,58,58,58,58,26,27
    db 26,26,26,26,26,26,26,26,26,26,26,26,26,26,58,59,59,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27
    db 58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59
    ;level9
    db 22,23,12,13,14,15,16,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,16,17,50,51,84,84,85
    db 54,55,44,45,46,47,48,49,49,49,49,49,49,49,49,49,49,49,49,49,49,49,49,49,49,48,49,82,83,20,21,22
    db 116,84,85,36,4,5,4,38,39,4,4,4,4,4,36,36,0,1,37,37,37,4,4,38,39,4,4,4,5,52,53,54
    db 116,84,85,36,4,64,65,66,67,68,128,129,130,131,132,133,130,131,130,131,132,133,65,66,67,68,69,5,5,84,84,85
    db 21,22,23,36,4,96,97,98,99,100,160,161,162,163,164,165,162,163,162,163,164,165,97,98,99,100,101,4,5,84,20,21
    db 53,54,55,36,36,4,5,6,7,5,5,32,33,4,6,7,5,4,4,4,5,4,4,6,7,4,5,4,5,84,52,53
    db 116,117,117,4,36,4,5,38,39,37,37,5,5,5,38,39,37,36,36,36,37,36,36,38,39,36,37,4,5,84,85,85
    db 84,116,117,36,36,4,5,70,71,36,37,37,37,37,70,71,5,8,9,10,11,36,37,70,71,37,5,4,5,84,85,117
    db 116,117,85,36,37,36,37,102,103,37,37,37,37,37,102,103,37,40,41,42,43,37,37,102,103,37,37,5,5,84,84,85
    db 84,116,117,4,36,37,37,37,4,4,4,4,4,4,4,4,4,72,73,74,75,37,5,5,5,36,37,37,37,116,84,85
    db 116,117,25,36,36,36,36,36,36,36,36,36,36,36,36,36,36,104,105,106,107,37,37,37,37,37,37,37,37,28,116,117
    db 24,25,57,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,27,28,29
    db 56,57,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,60,61
    db 26,27,27,59,59,59,59,59,59,59,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,27,27
    db 26,26,26,26,26,26,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,59
    db 58,58,58,58,58,58,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59
    ;level10
    db 111,111,111,112,113,85,86,111,111,111,111,111,111,112,113,85,86,111,111,111,111,112,113,85,86,111,111,111,111,112,113,85
    db 4,36,36,4,5,85,86,4,5,37,4,36,37,37,5,85,86,4,5,4,5,5,5,85,86,4,4,4,5,4,5,85
    db 4,36,12,4,5,85,86,4,12,37,36,12,36,12,5,85,86,4,12,4,5,12,5,85,86,36,12,4,37,12,5,85
    db 4,36,37,4,5,85,86,4,5,37,36,37,37,4,5,85,86,4,5,4,5,37,5,85,86,36,4,4,37,4,5,85
    db 4,36,37,4,5,85,86,4,4,5,36,36,37,4,5,85,86,4,12,4,5,12,5,85,86,36,12,36,37,12,5,85
    db 36,12,37,12,5,85,86,36,12,5,36,12,37,12,5,85,86,4,5,4,5,37,37,85,86,36,4,36,37,37,5,85
    db 36,37,37,4,5,85,86,4,5,5,36,36,37,5,37,85,86,4,12,5,5,12,37,85,86,36,12,5,36,12,5,85
    db 36,37,37,4,4,86,86,36,12,5,36,37,4,12,5,85,86,4,36,37,37,37,37,85,86,36,4,5,36,37,5,85
    db 4,5,5,5,4,86,118,36,37,4,4,4,5,5,5,85,86,4,4,4,4,5,37,85,86,36,4,5,5,5,5,117
    db 4,134,135,37,4,85,86,36,37,4,134,135,5,37,37,85,86,36,4,134,135,5,5,85,86,36,4,134,135,5,5,85
    db 4,166,167,5,4,85,86,4,4,4,166,167,5,5,5,85,86,4,4,166,167,5,5,85,86,36,36,166,167,37,37,117
    db 27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,26,26,26,26,27
    db 59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,58,58,58,58,59
    db 58,58,26,27,27,27,27,27,27,27,27,27,27,27,58,58,58,58,58,58,59,58,58,58,58,58,58,58,58,58,26,27
    db 26,26,26,26,26,26,26,26,26,26,26,26,26,26,58,59,59,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27
    db 58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59


FINAL: