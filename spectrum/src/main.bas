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
1 'bright 1=utiliza los colores paper: color de fondo caracteres, ink: color de frente o tinta'
1 ' 0 negro,1 azul,2 rojo,3 magenta,4 verde,5 cyan,6 amarillo,7.blanco,8 transparente,9 contraste
10 bright 1: border 7: paper 5:ink 0
20 cls
1 ' Cargamos nuestros sprites
30 go sub 8000
1 'Variables del juego'
1 'Contador'
40 let contador=0
1 'Inicialización player'
50 go sub 5000
1 'Inicialización enemigo'
60 go sub 6000
1 'Inicialización paquete'
70 go sub 7000 




1 '-----------------Pantalla de bienvenida-------------------'
1 '100 for a=0 to 10: beep .1,a+10:next a
100 print at 7,0; ink 2;paper 6;"@@@@   @@@@    @    @@@@   @  @ "
110 print at 8,0; ink 2;paper 6;"@      @@     @ @    @       @  "
120 print at 9,0; ink 2;paper 6;"@@@@   @  @  @   @  @@@@     @  "
130 print at 14,0; "Tu mujer se ha vuelto loca porque no os vais a pasear y ha empezado a tirar tus consolas y juegos por la ventana"
1 ' Con inverse ponemos el fondo de los carcacteres en el frente y el frente en el fondo'
140 print at 20,0;inverse 1; "O/P para mover, pulsa una tecla para continuar"
1 'Si no se pulsa una tecla se queda en blucle infinito'
150 if inkey$="" then go to 150
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
410 go sub 9000
1 '--------------Fin pantalla 1-----------------------------'

1 'bluce principal'
    1 'Capturamos las teclas'
    2000 go sub 2500
    1 'actalizamos el player'
    2020 go sub 5100
    1 'Actualizamos enemigo'
    2030 go sub 6200
    1 'Actualizamos los paquetes'
    2040 if nb>0 then go sub 7600
    1 ' Mostramos la información'
    2050 go sub 2800
    1 'bucle'
2090 go to 2000


1 ' ----------------------'
1 '     INPUT SYSTEM'
1 ' ----------------------'
    2500 if inkey$="o" then let x=x-1:let s$=d$
    2550 if inkey$="p" then let x=x+1:let s$=f$
    1 '2560 IF INKEY$="q" THEN LET py=py-1
    1 '2570 IF INKEY$="a" THEN LET py=py+1
    2580 if inkey$="" then let s$=c$
2590 return


1 'HUD'
    2800 print at 20,0;"time: ";contador;" nb: ";int(nb);" ex= ";int(ex);"       "
2820 return








1 '---------------------------------------------------------'
1 '------------------------PLAYER -------------------------'
1 '---------------------------------------------------------'
1 'Init player'
    1 ' Hay que pensar que son coordenadas de 8x8px para el print, del c$ al g$ son sprites'
    1 ' Como realmente defino estas variables que contienen la definición del string del sprite en 
    1 ' las línea 8040,8090, 8240,8290,etc, y eso se hace al principio, no las puedo inicilizar aquí'
    5000 let x=15:let y=18:let c$=c$
    5010 let d$=d$:let e$=e$:let f$=f$
    1 's$ será el sprite que contendrá los otros y el que se dibujará'
    5020 let g$=f$:let s$=c$
5030 return

1 'update player'
    5100 print at y,x;s$
5110 return



1 '---------------------------------------------------------'
1 '------------------------ENEMIES -------------------------'
1 '---------------------------------------------------------'
1 'init enemy'
    1 'Componente position'
    6000 let ex=16:let ey=5
    6010 let epx=0:let epy=0
    1 'Los sprites son la a y la b'
    6030 let a$=a$:let b$=b$
    1 'le metemos a la variable que dibuja al enemigo el sprite del enemigo'
    6040 let t$=b$
6050 return

1 'update enemy'
    6200 let contador=contador+1
    1 'Nos guardamos las coordenadas antes de cambiarlas'
    6210 let epx=ex:let epy=ey
    1 ' cada vez que sea 10 el contador generamos un número aleatorio, borramos el anterior y creamos un paquete nuevo'
    6220 if contador=10 then let ex=rnd*(27-5)+5:print at epy,epx;" ":let contador=0: go sub 7500
    1 'Pintamos el enemigo
    6230 if contador<10 then print at ey,ex;b$
    1 'Volvemos a pinta la línea de la casa que se borra'
    6240 go sub 9100
6290 return


1 '---------------------------------------------------------'
1 '------------------------FIRE ----------------------------'
1 '---------------------------------------------------------'
1 'Init paquete'
    7000 dim x(10):dim y(10):let nb=1
7010 return

1 'Crear paquete'
    7500 let nb=nb+1
    7510 let x(nb)=ex: let y(nb)=ey
7590 return

1 ' update paquete'
    7600 for i=1 to nb-1
        7610 if y(i)>19 then let y(i)=y(nb):let x(i)=x(nb):let nb=nb-1:print at y(i)+1,x(i);" "
        7620 let y(i)=y(i)+1
        7630 print at y(i),x(i);h$:print at y(i)-1,x(i);" "
    7640 next i
7690 return




1 '---------------------------------------------------------'
1 '------------------------SPRITES -------------------------'
1 '---------------------------------------------------------'
1 ' Tendremos 8 sprites 2 para la mujer, 1 para el paquete que tira y 5 para el personake '

1 '1 sprite de la mujer 1'
    8000 FOR i=0 TO 7
        8010 READ bits
        1 'USR es una instrucción de spectrum que te devuelve el valor de la dirección de memoria'
        1 'Sustituye USR "a" por 65368, usr te devuelve la dirección de la memoria de donde se guardan los UDG
        8020 POKE USR "a"+i,bits
    8030 NEXT i
    1 'Fijate que la inicializacioon de los strings solo puede teber una letra'
    8040 let a$=" "+chr$ 144+" "
    1 'sprite de la mujer 2'
    8050 FOR i=0 TO 7
        8060 READ bits
        8070 POKE USR "b"+i,bits
    8080 NEXT i
    8090 let b$=chr$ 145
    1 'player mirando al frente para coger el paquete'
    8100 FOR i=0 TO 7
        8110 READ bits
        8120 POKE USR "c"+i,bits
    8130 NEXT i
    8140 let c$=" "+chr$ 146+" "
1 ''    1 'player mirando a la izquierda 1'
    8150 FOR i=0 TO 7
        8160 READ bits
        8170 POKE USR "d"+i,bits
    8180 NEXT i
    8190 let d$=" "+chr$ 147+" "
    1 'player mirando a la izquierda 2'
    8200 FOR i=0 TO 7
        8210 READ bits
        8220 POKE USR "e"+i,bits
    8230 NEXT i
    8240 let e$=" "+chr$ 148+" "
    1 'player miando a la derecha 1'
    8250 FOR i=0 TO 7
        8260 READ bits
        8270 POKE USR "f"+i,bits
    8280 NEXT i
    8290 let f$=" "+chr$ 149+" "
    1 'player miando a la derecha 2'
    8300 FOR i=0 TO 7
        8310 READ bits
        8320 POKE USR "g"+i,bits
    8340 NEXT i
    8350 let g$=" "+chr$ 150+" "
    1 'paquete'
    8360 FOR i=0 TO 7
        8370 READ bits
        8380 POKE USR "h"+i,bits
    8390 NEXT i
    8400 let h$=chr$ 151

    8520 DATA 255,255,255,66,90,90,126,60
    8530 DATA 0,0,0,0,24,24,126,189
    8540 DATA 0,66,90,126,24,24,36,36
    8560 DATA 0,24,24,60,60,60,40,40
    8570 DATA 0,24,24,60,60,60,24,24
    8580 DATA 0,24,24,60,60,60,20,20
    8590 DATA 0,24,24,60,60,60,24,24
    8600 DATA 0,0,0,0,255,255,255,255

8700 return



1 '---------------------------------------------------------'
1 '------------------------PANTALLA 1 ----------------------'
1 '---------------------------------------------------------'
1 'Rutina pintar escenario'
    1' Vamos a pintar el suelo
    9000 for i=0 to 31: print at 19,i;paper 4;" ":next i
    1 'Vamos a pintar la casa'
    9010 plot 8*4,8*3: draw 0,100: draw 190,0:draw 0,-100
    1 'Altillo'
    9020 plot 8*6,8*16: draw 0,20: draw 160,0:draw 0,-20
9090 return

1 'Rutina pintar una línea que se borra en la parte de arriba'
    9100 plot 30,125:draw 190,0
9110 return
