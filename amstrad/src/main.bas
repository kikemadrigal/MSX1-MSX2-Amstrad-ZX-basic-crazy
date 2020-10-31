1 '    -------------------- '
1 '           CRAZY         '
1 '     BASIC MURCIA 2020   '
1 '    -------------------- '
1 ' Main                       10'
1 ' Welcome screen y records  100'
1 ' winning screen            200'
1 ' Game over                 300'
1 ' Screen 1                  400'
1 ' Main loop:               2000'
1 ' Input system:            2500'
1 ' Colision system          2600'
1 ' GUI/HUD'                 2800'
1 ' Player: --init:          5000'
1 '        |__update         5100'
1 ' Enemy:  --init:          6000'
1 '        |__update:        6200'
1 ' Fire: --init:            7000'
1 '       |_create:          7500'
1 '       --update:          7600'
1 ' Sprite definitions:      8000'
1 ' Maps definitions:       9000~'


1 ' Configuración global'
1 'inicializamos el sistema y la pantalla'
10 call &BBFF:call &BB4E:mode 1
1 'Ponemos el modo 0=20 columnas, 16 colres (tiles de 32px, ancho 640px, alto 400px'
1 'Como sabemos que el fondo de los caracteres es el canal 0 lo cambiamos a blanco con ink y mirando la tabla de colores'
1 'con border tan solo tienes que poner el color del borde'
20 cls: mode 0: border 26:ink 0,11
1 'Cargamos nuestros sprites'
30 gosub 8000
1 'Variables del juego'
40 co=0
1 'Inicializar el player'
50 gosub 5000
1 'Inicialización enemigo'
60 gosub 6000
1 'Inicialización paquete'
70 'gosub 7000 


1 '-----------------Pantalla de bienvenida-------------------'
1 '100 for a=0 to 10: beep .1,a+10:next a
100 mode 1:locate 1,7:print "  @@@@   @@@@    @    @@@@   @  @ "
110 locate 1,8:       print "  @      @@     @ @    @       @  "
120 locate 1,9:       print "  @@@@   @  @  @   @  @@@@     @  "
130 locate 1,14:print "Tu mujer se ha vuelto loca porque no os vais a pasear y ha empezado a tirar tus consolas y juegos por la ventana"
1 ' Con inverse ponemos el fondo de los carcacteres en el frente y el frente en el fondo'
140 locate 1,20:print "O/P para mover, pulsa una tecla para continuar"
1 'Si no se pulsa una tecla se queda en blucle infinito'
150 if inkey$="" then goto 150
160 mode 0
1 '----------------Final pantalla bienvenida------------------'

1'------------------------------------'
1'     Pantalla Ganadora'
1'------------------------------------'


1'------------------------------------'
1'           Game over 
1'------------------------------------'

1 '--------------Pantalla 1-----------------------------------'
400 cls
1 'cargamos el escenario'
410 gosub 9000
1 '--------------Fin pantalla 1-----------------------------'

1 'bluce principal'
    1 'Capturamos las teclas'
    2000 gosub 2500
    1 'Comprobamos las colisiones'
    2010 gosub 2600
    1 'actalizamos el player'
    2020 gosub 5100
    1 'Actualizamos enemigo'
    2030 gosub 6200
    1 'Actualizamos los paquetes'
    2040 'if nb>0 then go sub 7600
    1 ' Mostramos la información'
    2050 'gosub 2800
    1 'bucle'
2090 go to 2000




1 ' ----------------------'
1 '     INPUT SYSTEM'
1 ' ----------------------'
    2500 if inkey$="o" then x=x-1:ps$=s$(3)
    2550 if inkey$="p" then x=x+1:ps$=s$(5)
    1 '2560 IF inkey$="q" THEN LET y=y-1
    1 '2570 IF inkey$="a" THEN LET y=y+1
    2580 if inkey$="" then ps$=s$(2)
2590 return

1 ' ----------------------'
1 '   COLLISION SYSTEM'
1 ' ----------------------'
    1 'Colision con los bordes'
    2600 if x=0 then x=1
    2610 IF y=0 then y=1
2690 return


1 'HUD'
    2800 'nada'
2820 return


1 '---------------------------------------------------------'
1 '------------------------PLAYER -------------------------'
1 '---------------------------------------------------------'
1 'Init player'
    1 ' Hay que pensar que son coordenadas de 8x8px para el print, del c$ al g$ son sprites'
    1 ' Como realmente defino estas variables que contienen la definición del string del sprite en 
    1 ' las línea 8040,8090, 8240,8290,etc, y eso se hace al principio, no las puedo inicilizar aquí'
    5000 x=10:y=19:ps$=s$(2)
5030 return

1 'update player'
    5100 locate x,y:print ps$
5110 return
1 '---------------------------------------------------------'
1 '------------------------ENEMIES -------------------------'
1 '---------------------------------------------------------'
1 'init enemy'
    1 'Componente position'
    6000 ex=10:ey=6:es$=s$(1)
6050 return
1 'update enemy'
    6200 locate ex,ey:print es$
6290 return

1 '---------------------------------------------------------'
1 '------------------------FIRE ----------------------------'
1 '---------------------------------------------------------'













1 '---------------------------------------------------------'
1 '------------------------SPRITES -------------------------'
1 '---------------------------------------------------------'

1' Rutina definir 
    1 'Vamos a crear nuestros sprites a partir del caracter 246, 
    1 'para eso es necesario especificarselo a amstrad, por eso ponemos symbol afet'
    1 'Por defecto amstrad pone symbol after 240 y no podemos hacer udg por debajo de esta cifra'
    8000 symbol after 246
    1 '1 sprite de la mujer 1'
    8010 SYMBOL 246,255,255,255,66,90,90,126,60
    8020 s$(0)=" "+chr$(246)+" "
    1 'sprite de la mujer 2'
    8030 SYMBOL 247,0,0,0,0,24,24,126,189
    8040 s$(1)=" "+chr$(247)+" "
    1 'player mirando al frente para coger el paquete'
    8050 SYMBOL 248,0,66,90,126,24,24,36,36
    8060 s$(2)=" "+chr$(248)+" "
    1 'player mirando a la izquierda 1'
    8070 SYMBOL 249,0,24,24,60,60,60,40,40
    8080 s$(3)=" "+chr$(249)+" "
    1 'player mirando a la izquierda 2'
    8090 SYMBOL 250,0,24,24,60,60,60,24,24
    8100 s$(4)=" "+chr$(250)+" "
    1 'player miando a la derecha 1'
    8110 SYMBOL 251,0,24,24,60,60,60,20,20
    8120 s$(5)=" "+chr$(251)+" "
    1 'player miando a la derecha 2'
    8130 SYMBOL 252,0,24,24,60,60,60,24,24
    8140 s$(6)=" "+chr$(252)+" "
    1 'paquete'
    8150 SYMBOL 253,0,0,0,0,255,255,255,255
    8160 s$(7)=" "+chr$(253)+" "
8190 return

1 ''Rutina puntar escenario'
    1 'Movemos la pluma 50 pixeles a la derecha y 40 hacia arriba de forma absoluta(desde la esquina iferior derecha)'
    9000 move 2*32,2*32
    1 ' pintamos con draw de forma relativa a la última posición
    9010 drawr 0,7*32, 4
    9020 drawr 16*32,0,4
    9030 drawr 0,-7*32,4
    1 'Pintamos el altillo'
    9040 move 3*32,10*32
    9050 drawr 0,1*32, 4
    9060 drawr 14*32,0, 4
    9070 drawr 0,-1*32, 4
9080 return
    



