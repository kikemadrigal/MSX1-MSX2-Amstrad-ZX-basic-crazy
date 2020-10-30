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
1 ' Render system            2700'
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



1 ' Configuraión global 
1 ' color letra negro, fondo letra: azul claro, borde blanco, quitamos las letras que aparecen abajo'
10 color 1,7,15:key off:open "grp:" as #1
20 cls:screen 2,0,0
1 'Inicilizamos dispositivo: 003B, inicilizamos teclado: 003E'
25 defusr=&h003B:a=usr(0):defusr1=&h003E:a=usr1(0)
1 'Cargamos los sprites'
30 gosub 10000
1 ' Variables el juego'
40 co=0
1 'Inicializamos el personaje'
50 gosub 5000
1 'Inicialización enemigo'
60 gosub 6000
1 'Inicialización paquete'
70 gosub 7000 


1'------------------------------------'
1'  Pantalla de Bienvenida y records 
1'------------------------------------'
100 preset (10,30):  print #1,"@@@@   @@@@    @    @@@@   @  @ "
110 preset (10,40):  print #1,"@      @@     @ @    @       @  "
120 preset (10,50):  print #1,"@@@@   @  @  @   @  @@@@     @  "
130 preset (10,120): print #1,"Tu mujer se ha vuelto loca porque no os vais a pasear y ha empezado a tirar tus consolas y juegos por la ventana"
1 ' Con inverse ponemos el fondo de los carcacteres en el frente y el frente en el fondo'
140 preset (10,160): print #1, "Cursores para mover, pulsa una tecla para continuar"
1 'Si no se pulsa una tecla se queda en blucle infinito'
150 if inkey$="" then goto 150



1'------------------------------------'
1'     Pantalla Ganadora'
1'------------------------------------'


1'------------------------------------'
1'           Game over 
1'------------------------------------'




1'---------------------------------------------------------------------------------------------------------'
1'-------------------------         Pantalla 1 /screen 1                            -----------------------        
1'---------------------------------------------------------------------------------------------------------'
400 cls
1 'Pintamos l pztlla 1
430 gosub 9000
1 'Con el 0 le decimos que es la barra espaciadora y no los botones de los joystick'
1 'Cunado se pulse la barra espaciadora hiremos a la línea 11100'
440 'on strig gosub 11100:strig(0) on
1 'Activamos los intervalos para que cada segundo redibuje la linea de arriba'
460 'on interval=50 gosub 9000:interval on:time=0



1 'Solo se saldrá de este bucle si se ha llegado al final de la pantalla'
1 ' ----------------------'
1 '      MAIN LOOP
1 ' ----------------------'
    1 'bluce principal'
    1 'Capturamos las teclas'
    2000 gosub 2500
    1 'actualizamos el player'
    2020 gosub 5100
    1 'Actualizamos enemigo'
    2030 gosub 6200
    1 'Actualizamos los paquetes'
    2040 if nb>0 then gosub 7600
    1 ' Mostramos la información'
    2050 'gosub 2800
    1 'bucle'
2090 go to 2000
1 ' ----------------------'
1 '    FINAL MAIN LOOP
1 ' ----------------------'



1'---------------------------------------------------------------------------------------------------------'
1'-------------------------     Final Pantalla 1 / screen 1                         -----------------------        
1'---------------------------------------------------------------------------------------------------------'












1 ' ----------------------'
1 '     INPUT SYSTEM'
1 ' ----------------------'
1 '2 Sistema de input'
    2500 'px=x:py=y 
    2510 on stick(0) gosub 2510,2510,2550,2510,2510,2510,2570
    2520 if stick(0)=0 then ps=2
2530 return
1 '3 derecha'
2550 x=x+8:ps=4:return
1 '7 izquierda'
2570 x=x-8:ps=3:return
1 '1 arriba'
1 '2580 y=y-pv:ps=4:return
1 '1 abajo' 
1 '2590 y=y+pv:ps=2:return





1 ' ----------------------'
1 '     COLLISION SYSTEM'
1 ' ----------------------'
    1 'Colision del player con la pantalla'
    2600 ' nada'
2690 return

1 ' ----------------------'
1 '     RENDER SYSTEM'
1 ' ----------------------'
    2700 'nada'
2790 return

1 ' ----------------------'
1 '     HUD'
1 ' ----------------------'
    2800 preset(0,180) :print #1,"Time "co", nb: "nb", ex: "int(ex)
2890 return





1 ' ----------------------'
1 '         PLAYER
1 ' ----------------------'
1 'Init player'
    1 ' Hay que pensar que son coordenadas de 8x8px para el print, del c$ al g$ son sprites'
    1 ' Como realmente defino estas variables que contienen la definición del string del sprite en 
    1 ' las línea 8040,8090, 8240,8290,etc, y eso se hace al principio, no las puedo inicilizar aquí'
    5000 x=15*8:y=18*9:pp=0:ps=2
5030 return

1 'update player'
    5100 put sprite pp,(x,y),1,ps
5110 return



1 '---------------------------------------------------------'
1 '------------------------ENEMIES -------------------------'
1 '---------------------------------------------------------'
1 'init enemy'
    1 'Componente position'
    6000 ex=16*8:ey=5*9
    6010 epx=0:epy=0
    1 'El plano será 1 porque es el 2 cnjunto de 8 bytes que necesitamos tener x e y
    1 'Los sprites son el 0 y el 1'
    6030 ep=1:es=1
6050 return

1 'update enemy'
    6200 co=co+1
    6210 epx=ex:epy=ey
    1 ' cada vez que sea 10 el contador generamos un número aleatorio, borramos el anterior y creamos un paquete nuevo'
    6220 if co mod 10=0 then ex=rnd(1)*(160-50)+50:preset (epy,epx):print #1," ":co=0: gosub 7500
    1 'Pintamos el paquete'
    6230 'if contador<10 then print at ey,ex;b$
    1 'Volvemos a pinta la línea de la casa que se borra'
    6240 'go sub 9100
    6250 put sprite 1,(ex,ey),1,es
     1 'put sprite pp,(x,y),1,ps
6290 return


1 '---------------------------------------------------------'
1 '------------------------FIRE ----------------------------'
1 '---------------------------------------------------------'
1 'Init paquete'
    1 'El sprite del barril es el 7'
    7000 dim x(10), y(10):nb=1:bs=7
7010 return

1 'Crear paquete'
    7500 nb=nb+1
    7510 x(nb)=ex:y(nb)=ey
7590 return

1 ' update paquete'
    7600 for i=1 to nb-1
    1 'Si el paquete llega hasta abajo, lo borramos poniendo el último en su puesto y restamos 1 para que no lo pinte'
        7610 if y(i)>190 then y(i)=y(nb):x(i)=x(nb):nb=nb-1:preset(x(i),y(i)+1):print #1," "
        1 'Aumentamos la y en 1 para que se mueva'
        7620 y(i)=y(i)+8
        1 'Lo pintamos y borramos el punto anterior'
        7630 preset (y(i),x(i)):put sprite 2+i,(x(i),y(i)),1,bs:preset (x(i),y(i)-1):print #1," "
    7640 next i
7690 return



1 '---------------------------------------------------------'
1 '------------------------Carga de srites------------------'
1 '---------------------------------------------------------'



1 'Rutina cargar sprites con datas basic'
    10000 RESTORE
    1 ' vamos a meter 5 definiciones de sprites nuevos que serán 4 para el personaje y uno para la bola'
    10010 FOR I=0 TO 7:SP$=""
        10020 FOR J=1 TO 8:READ A$
            10025 SP$=SP$+CHR$(VAL("&H"+A$))
        10030 NEXT J
        10040 SPRITE$(I)=SP$
    10050 NEXT I
    10060 return 
    1 'Mujer lazando paquete'
    8050 DATA FF,FF,FF,42,5A,5A,7E,3C
    1 'Mujer normal'
    8060 DATA 00,00,00,00,18,18,7E,BD
    1 'player con las manos arriba de frente'
    8070 DATA 00,42,5A,7E,18,18,24,24
    1 'Player mirando hacia la izquierda'
    8080 DATA 00,18,18,3C,3C,3C,28,28
    8090 DATA 00,18,18,3C,3C,3C,18,18
    8100 DATA 00,18,18,3C,3C,3C,14,14
    8110 DATA 00,18,18,3C,3C,3C,18,18
    8120 DATA 00,00,00,00,FF,FF,FF,FF
8190 return


1 '---------------------------------------------------------'
1 '------------------------PANTALLA 1 ----------------------'
1 '---------------------------------------------------------'
1 'Rutina pintar escenario'
    1' Vamos a pintar el suelo
    9000 LINE(0,160)-(256,170),3,bf
    1 'Vamos a pintar la casa'
    1 ' b=desplazamos el lapiz de forma absoluta y sin dibujar la trayectoria 40 pixeles eje x y 160 eje y  '
    1 'c= le ponemos el valor negro=1'
    1 'up=le decimos que dibuje 100 pixeles hacia arriba'
    9010 draw ("bm40,160c1u100")
    9020 draw ("r180d100")
    1 ' dibujamos el altillo'
    9030 draw("bm50,60u20r160d20")
9090 return






