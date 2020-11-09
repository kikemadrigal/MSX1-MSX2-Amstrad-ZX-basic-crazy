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
1 ' Maps definitions:       12000~'



1 ' Configuraión global 
5 'bload"xbasic.bin",r
1 'Inicilizamos dispositivo: 003B, inicilizamos teclado: 003E'
10 defusr=&h003B:a=usr(0):defusr1=&h003E:a=usr1(0):defusr2=&H90:a=usr2(0)
15 defusr=&H41:defusr1=&H44
1 ' color letra negro, fondo letra: azul claro, borde blanco, quitamos las letras que aparecen abajo'
20 color 1,7,15:key off:defint a-z
30 screen 2,2,0
35 open "grp:" as #1
1 'Cargamos los sprites'
50 gosub 10000
1 'Inicializamos variables de mapa'
90 gosub 11200
1 ' Variables el juego'
120 co=0:ee=0
1 'Inicializamos el personaje'
130 gosub 5000
1 'Inicialización enemigo'
140 gosub 6000
1 'Inicialización paquete'
150 gosub 7000 
1 'Mostramos la pantalla de bienvenida'
160 gosub 13200
1 'Ponemos un 0 el el bit 7 del rgistro 1 del vdp para poner la pantalla del color del borde'
1 'para que no se vea la carga del archivo de tileset'
1 '400 vdp(1)=vdp(1) xor 64
400 a=usr(0)
1 'Cargamos los tiles en RAM'
420 bload"tileset.bin",s
1 'Cargamos el mapa e inicializamos las pantallas con los valores de numero de enemigos, aparatos a capturar,etc'
430 gosub 11300
1 '450 vdp(1)=vdp(1) or 64
450 a=usr1(0)
1 'Activamos las interrupciones de los sprites para detectar las colisiones'
490 on sprite gosub 2600:sprite on
1 'Mostramos la información del HUD'
500 gosub 2800:gosub 2900
1 'cargamos la música en la RAM y la llamamos desde basic'
510 'bload"music.bin":defusr2=&h9500:a=usr2(0):defusr3=&h9509
1 'Activamos los intervalos para que cada 2/60 segundos reproduzca un bloque de música'
520 'on interval=2 gosub 2200:interval on


1 'Solo se saldrá de este bucle si se ha llegado al final de la pantalla'
1 ' ----------------------'
1 '      MAIN LOOP
1 ' ----------------------'
    1 'bluce principal'
    1 'Capturamos las teclas'
    2000 gosub 2500
    1 'Chequeamos las colisiones'
    2010 gosub 2700
    1 'actualizamos el player'
    2020 gosub 5100
    1 'Actualizamos enemigo'
    2030 gosub 6200
    1 'Render enemigo'
    2040 GOSUB 6300
    1 'Actualizamos los paquetes'
    2050 gosub 7600
    1 'Render paquete'
    2060 gosub 7700
     1 'Chequeamos el cambio de nivel o pantalla y actualizamos la lógica de los niveles'
    2070 if pc=0 then ml=ml+1: gosub 11300
    1 'bucle'
2090 go to 2000
1 ' ----------------------'
1 '    FINAL MAIN LOOP
1 ' ----------------------'





1 'Reproduztor de música'
    1 'Reproductor en ensamblador'
    2200 a=usr3(0)
2220 return
1 'Reproductor de efectos d sonido'
    1 'play, c=do, d=re, e=mi, f=fa, g=sol, a=la, b=si
    1 'xvariable$, ejecuta el string que contiene variable$'
    1 'nx, número nota musical del do al si,siendo x un número entre 0-96, de la 0 octava (0-12) a la 8 octava (80-92), por defecto está la 4 octava (36-47) '
    1 'on, siedo n la octava entre 0-8'
    1 'ln, siendo n la duración de 0-64, 64 la más corta'
    1 'rn, siendo n la pausa entre 1-64, 64 las más corta'
    1 'tn, siendo n la velocidad de ejecución entre 32-255 (ni caso)'
    1 'Vn, siendo v el columen entre 0-15'
    1 'Mn, sindo n la modulación de la envolvente entre 0-6535 (ni caso)'
    1 'Sn, siendo n la forma de la enfolvente de 0-15, sirve para que vaya desapareciendo el sonido
    1 'Melodía completa'
    1 '2300 if ee=1 then PLAY"O5 L8 V4 M8000 A A D F G2 A A A A D E F G E F D C D G R8 O5 A2 A2 A8"
    2300 if ee=1 then PLAY"O5 L8 V4 M8000 A A D F G2 A A A A r60 G E F D C D G R8 A2 A2 A8","o1 v4 c r8 o2 c r8 o1 v6 c r8 o2 v4 c r8 o1 c r8 o2 v6 c r8"
    1 'Tirando el paquete'
    2350 if ee=5 then play "l10 o4 v6 g c"
    1 'Paquete cogido'
    2360 if ee=6 then play"t250 o5 v12 d v9 e" 
    1 'Pitido normal'
    2370 if ee=7 then play "O5 L8 V4 M8000 A A D F G2 A A A A"
    1 'Toque fino'
    2380 if ee=8 then PLAY"S1M2000T150O7C32"
   
    1 'Pasos'
    2390 if ee=9 then PLAY"o2 v4 m6500 c"
    1 'Sound puerto, valor, para ver las notas ir a https://www.msx.org/wiki/SOUND, recuerda que el d5dh=3421 es el 34 para el tono canal a puerto 1 y en puerto 0 21'
    1 '0=Tono canal a bit menos significativo,2=tono canal b menos significativo, 4=tono canal c menos significativo de 0-255
    1 '1=Tono canal a bit mas significativo, 3=tono canal b bit mas significativo, 5=tono canal c bit mas significativo de 0 a 15 
    1 '6 ruido de 0-31
    1' 7 mezlador 0-191
    1 '8 volumen canal a, 9 volumen canal b, 10 volumen canal c de 0-16'
    1 '12 velocidad envolvente de 0-255
    1 '13 forma envolmente para que desaparezca en el tiempo la nota de 0-15'
    1 'En este ejemplo trabajamos solo con el ruido, el 6, el 8 =16 significa que vamos a variar el volumen con el 12 y el 13 para que desaparezca'
    1 'Paquete ha explotado'
    2400 if ee=10 then sound 6,5:sound 8,16:sound 12,6:sound 13,9
    1 'Volvemos a dejar el psg como estaba'
    2410 'for i=0 to 100: next i: a=usr2(0)
2420 return




1 ' ----------------------'
1 '     INPUT SYSTEM'
1 ' ----------------------'
1 '2 Sistema de input'
    1 'Nos guardamos las posiciones del player antes de cambiarlas'
    2500 'px=x:py=y
    2510 on stick(0) gosub 2580,2500,2550,2500,2590,2500,2570
    2520 if stick(0)=0 then ps=2
2530 return
1 'ee=8 es el efecto de sonido 8 de la rutina de reprodución de sonidos 2300
1 '3 derecha'
2550 x=x+pv:ps=5:ee=9:gosub 2300:return
1 '7 izquierda'
2570 x=x-pv:ps=3:ee=9:gosub 2300:return
1 '1 arriba'
2580 y=y-pv:ps=3:ee=9:gosub 2300:return
1 '5 abajo' 
2590 y=y+pv:ps=3:ee=9:gosub 2300:return





1 ' ----------------------'
1 '     COLLISION SYSTEM'
1 ' ----------------------'


1 'Colision del player el paquete'
    1 ' hacemos el efecto de sonido 6 llamando a la rutina de sonidos 2300, deactivamos las colisiones, actualizamos el HUD, aumentamos las capturas del player'
    2600 ee=6: gosub 2300:sprite off: pc=pc-1:gosub 2900: ft=ft-1
    1 'Borramos lo que había antes donde sale el nombre de los ordenadores'
    2610 line (120,20)-(180,30),7,bf
    2620 preset (120,20):  print #1,"Cogido!"
    1 'Solo para debugger'
    2630 gosub 2900
2690 return
1 'Colsion del player con la pantalla'
    2700 if x>256-16 then x=256-16
    2710 if x<=0 then x=0
    2720 if y<140 then y=140
    2730 if y>192-16 then y=192-16
2740 return


1 ' ----------------------'
1 '     RENDER SYSTEM'
1 ' ----------------------'
   1'2700 'nada'
1' 2790 return


1 ' ----------------------'
1 '     HUD' 
1 ' ----------------------'
1 'Cabcera'
    2800 '
    2805 line (0,0)-(80,60),7,bf
    2810 PRESET(10,5):PRINT#1,"level: "
    2820 PRESET(10,15):PRINT#1,"Faltan: "
    2830 'PRESET(10,25):PRINT#1,"Vidas: "
    2840 'PRESET(10,35):PRINT#1,"Modelo: "
    2850 PRESET(10,45):PRINT#1,"num: "
2860 return


1 'Variables'
    1 'El borrado de lo que había antes lo hacemos con un line'
    2900 line (80,0)-(256,60),7,bf
    1 'Coloreado'
    2960 PRESET(80,5):PRINT#1,ml
    2970 PRESET(80,15):PRINT#1,pc
    2980 'PRESET(80,25):PRINT#1,pe
    2990 'PRESET(80,35):PRINT#1,fm(0)
    3000 PRESET(80,45):PRINT#1,ft
3020 return






1 ' ----------------------'
1 '         PLAYER
1 ' ----------------------'
1 'Init player'

    1 '15*8=120 ,18*9=162'
    1 'Componente position'
    1 'px=previo posicion x'
    5000 x=120:y=162:px=x:py=y:pv=8
    1 'Componente render: Plano y sprite'
    5010 pp=0:ps=2
    1 'Componente RPG=player capturas y vida'
    5030 pc=5:pe=100
5040 return

1 'update player'
    5100 put sprite pp,(x,y),1,ps
5110 return



1 '---------------------------------------------------------'
1 '------------------------ENEMIES -------------------------'
1 '---------------------------------------------------------'
1 'init enemy'
    1 'Componente position'
    6000 ex=16*8:ey=5*17
    6010 epx=0:epy=0
    1 'La velocidad en la que vuelve a tirar un paquete'
    6015 ev=10
    1 'Para saber si el enemig tiene que seguir una ruta 0 es que no'
    6020 er=0:nu=0
    1 'Rutas del enemigo'
    6030 dim e(13),c(13)
    1 '1 Fila de ventanas'
    6040 e(0)=8*2:c(0)=8*10:  e(1)=8*7:c(1)=8*10:  e(2)=8*10:c(2)=8*10: e(3)=8*12:c(3)=8*10: e(4)=8*20:c(4)=8*10
    1 ' 2 Fila'
    6045 e(5)=8*2:c(5)=8*12:  e(6)=8*7:c(6)=8*12:  e(7)=8*10:c(7)=8*12: e(8)=8*12:c(8)=8*12: e(9)=8*20:c(9)=8*12
    1 ' 3 Fila'
    6046 e(10)=8*17:c(10)=8*14:  e(11)=8*20:c(11)=8*14:  e(12)=8*25:c(12)=8*14
    1 'El plano será 1 porque es el 2 cnjunto de 8 bytes que necesitamos tener x e y
    1 'Los sprites son el 0 y el 1'
    6050 ep=1:es=1
6060 return

1 'update enemy'
    1 ' aumentamos el contador para que al mod de 40 tire un paquete'
    6200 co=co+1
    1 'Le ponemos el sprite 1 que lo podemos cambiar cuando sea mod de 40'
    6210 es=1
    6220 'epx=ex:epy=ey
    1 ' cada vez que sea 20
    1 '1. generamos un número aleatorio en contador (co) y lo ponemos a cero,
    1 '2.Creamos un paquete nuevo (línea 7500)'
    1 '3. Le cambiamos el sprite a la mujer para que parezca que tira el paquete'
    1 '4 Emitimos el efecto de sonido ee=5(linea 2300)'
    1 '5.Como hay que desactivar las colisiones de los sprites cada vez que haya una, las volvemos a activar'

    6250 if co mod 20=0 and er=0 then ex=rnd(1)*(160-50)+50: co=0:ee=5:es=0:gosub 2300:gosub 7500:sprite on
    6260 if co mod 20=0 and er=1 then nu=rnd(1)*13: ex=e(nu): ey=c(nu): co=0:ee=5:es=0:gosub 2300:gosub 7500:sprite on
    1 'Solo para debugger'
    6270 if co mod 20=0 then gosub 2900
6290 return

1 'Render'
    6300 put sprite 1,(ex,ey),1,es
6310 return



1 '---------------------------------------------------------'
1 '------------------------FIRE ----------------------------'
1 '---------------------------------------------------------'
1 'Init paquete'
    1 'El sprite del barril es el 7'
    1 'ft=número paquete o turno, se utiliza para ir ocupando el espacio de memoria oportuno'
    1 'fs=paquete sprite'
    1 'fv=paquete velocidad
    1 'fm=fire modelo=0=MSX,1=AMSTRAD, 2=SPECTRUM,3=ATARI'
    7000 ft=0:fm=5
    7010 dim x(fm), y(fm),fv(fm),fm(fm),fs(fm),fc(fm),fa(fm)
7020 return

1 'Crear paquete'
    1 ' Si hemos llegado al numero máximo de paquetes quepodemos crear no creamos más'
    7500 if ft=5 then return
    7505 x(ft)=ex:y(ft)=ey+16:fv(ft)=8:fm(ft)=rnd(1)*4:fs(ft)=7:fa(ft)=1
    1 'Borramos lo que había antes'
    7510 line (120,20)-(180,30),7,bf
    1 'Si es un MSX el color es un negro'
    7520 if fm(ft)=0 then fc(ft)=1:preset (120,20): print #1,"MSX"
    1 'Si es un amstrad el color es un azul'
    7530 if fm(ft)=1 then fc(ft)=4:preset (120,20): print #1,"Amstrad"
    1 'Si es un spectrum el color es un rojo'
    7540  if fm(ft)=2 then fc(ft)=6:preset (120,20): print #1,"Spectrum"
    1 'Si es un atari el color es fucsia'
    7550  if fm(ft)=3 then fc(ft)=13:preset (120,20): print #1,"Atari"
    7560 ft=ft+1
7590 return

1 'delete paquete'


1 ' update paquete'
    7600 if ft<=0 then return
    7605 for i=0 to ft-1
        1 'Si el paquete llega hasta abajo, lo borramos poniendo el último en su puesto y restamos 1 para que no lo finte'
        1 '7610 if y(i)>190 then y(i)=y(ft):x(i)=x(ft):ft=ft-1:pv=pv-1
        1 'Aumentamos la y en 1 para que se mueva'  
        7610 y(i)=y(i)+fv(i)
        1 'Si el paquete llega abajo '
        1 'Le cambiamos el sprites y le quitamos las colsiones'
        7620 if y(i)>150 then sprite off
        1 'le ponemos que no está activo, y ponemos un sonido de golpe'
        7630 if y(i)>150 then x(i)=x(ft-1):y(i)=y(ft-1):fs(ft-1)=8:fa(ft-1)=0:ft=ft-1:ee=10:gosub 2300
    7640 next i
7690 return

1 'render paquete'
    7700 for i=0 to ft-1
        1 'Lo pintamos'
        7710 if fa(i)=1 then put sprite 2+i,(x(i),y(i)),fc(i),fs(i)
    7720 next i
7730 return 

1 '---------------------------------------------------------'
1 '------------------------Carga de srites------------------'
1 '---------------------------------------------------------'



1 'Rutina cargar sprites con datas basic'
    10000 RESTORE
    1 ' vamos a meter 5 definiciones de sprites nuevos que serán 4 para el personaje y uno para la bola'
    10010 FOR I=0 TO 8:SP$=""
        10020 FOR J=1 TO 32:READ A$
            10025 SP$=SP$+CHR$(VAL("&H"+A$))
        10030 NEXT J
        10040 SPRITE$(I)=SP$
    10050 NEXT I
    10060 return 
    1 ' Mujer tirando el paquete'
    10120 DATA 00,0F,0F,0F,04,05,05,03
    10130 DATA 00,00,00,00,00,00,00,00
    10140 DATA 00,F8,F8,F8,10,D0,D0,60
    10150 DATA 00,00,00,00,00,00,00,00
    1 'Mijer que ha tirando el paquete'
    10160 DATA 00,00,01,01,00,01,02,02
    10170 DATA 02,00,00,00,00,00,00,00
    10180 DATA 00,00,C0,C0,80,C0,20,20
    10190 DATA 20,00,00,00,00,00,00,00
    1'Hombre brazos en alto
    10200 DATA 00,00,00,00,00,11,11,0C
    10210 DATA 03,03,03,01,01,01,02,00
    10220 DATA 00,00,00,00,00,88,88,20
    10230 DATA C0,C0,C0,80,80,80,40,00

    10240 DATA 00,00,00,00,00,01,01,00
    10250 DATA 03,03,07,01,02,02,06,00
    10260 DATA 00,00,00,00,00,80,80,00
    10270 DATA C0,C0,C0,80,40,40,C0,00

    10280 DATA 00,00,00,00,00,01,01,00
    10290 DATA 03,03,07,01,01,01,03,00
    10300 DATA 00,00,00,00,00,80,80,00
    10310 DATA C0,C0,C0,80,80,80,80,00

    10320 DATA 00,00,00,00,00,01,01,00
    10330 DATA 03,03,03,01,02,02,03,00
    10340 DATA 00,00,00,00,00,80,80,00
    10350 DATA C0,C0,E0,80,40,40,60,00

    10360 DATA 00,00,00,00,00,01,01,00
    10370 DATA 03,03,03,01,01,01,01,00
    10380 DATA 00,00,00,00,00,80,80,00
    10390 DATA C0,C0,E0,80,80,80,C0,00

    10400 DATA 00,00,00,00,00,00,00,00
    10410 DATA 00,00,00,00,0F,0F,0F,00
    10420 DATA 00,00,00,00,00,00,00,00
    10430 DATA 00,00,00,00,F0,F0,F0,00
    1 'Paquete roto'
    10440 DATA 00,00,00,00,00,00,00,00
    10450 DATA 00,00,00,00,10,0A,0D,00
    10460 DATA 00,00,00,00,00,00,00,00
    10470 DATA 00,00,00,00,84,AC,70,00

11590 return


1 '---------------------------------------------------------'
1 '------------------------MAPA ----------------------'
1 '---------------------------------------------------------'
1 ' inicializar_mapa
    1 'ml=mapa level, el mapa empezará en el level 0'
    1 'ms=mapa seleccioando, lo hiremos cambiando    
    1 'mm= maximo de mapas
    1 'mc= mapa cambia, lo utilizaremos para cambiar los copys y así cambiar la pantalla
    1 'md=Mapa dirección de la yabla de nombres'
    11200 ml=0:ms=0:mm=1:mc=0:md=0
11220 return

1 'Cargar mapa de disco y meterlo en la VRAM
    1 '1 cargamos el mapa
    1 'Cada mapa ocupa 862 bytes'
    1 'md=mapa dirección, la dirección c001 se la he puesto yo en el archivo binario cuando lo creé'
    1 'El archivo tan solo contiene los datos de la definición de los mapas'
    1 'Cuando se lea otro nivel se inicializarán las pantallas y sonorá una musiquilla'
    11300 if ml=0 then bload"level0.bin",r:gosub 12000
    11310 if ml=1 then bload"level1.bin",r:gosub 12300:ee=7:gosub 2300
    11315 vdp(1)=vdp(1) xor 64
    11320 '_turbo on
    11330 md=&hb001
    11340 for i=0 to mm-1
        1 'Copia desde base(10) 6144 (&h1800) hasta la &h1aff,6144+768=6912
        11350 for j=6144+256 to 6912
                1 'Como los tiles los habíamos cargado previamente en RAM ahora solo los pasamos a VRAM'
                11360 vpoke j,peek(md)
                11370 md=md+1
        11380 next j  
    11410 next i
    11420 '_turbo off
    11430 vdp(1)=vdp(1) or 64
11490 return






1 '---------------------------------------------------------'
1 '------------------------PANTALLA 1 ----------------------'
1 '---------------------------------------------------------'
1 'Init'
    12000 pc=3
12090 return



1 'Rutina pintar escenario'
    1' Vamos a pintar el suelo
    12200 LINE(0,160)-(256,170),3,bf
    1 'Vamos a pintar la casa'
    1 ' b=desplazamos el lapiz de forma absoluta y sin dibujar la trayectoria 40 pixeles eje x y 160 eje y  '
    1 'c= le ponemos el valor negro=1'
    1 'up=le decimos que dibuje 100 pixeles hacia arriba'
    12210 draw ("bm40,160c1u100")
    12220 draw ("r180d100")
    1 ' dibujamos el altillo'
    12230 draw("bm50,60u20r160d20")
12240 return
1 '---------------------------------------------------------'
1 '------------------------PANTALLA 2 ----------------------'
1 '---------------------------------------------------------'
1 'init'
    1 'Ponemos el numero de sprites de paquetes a 0'
    12300 ft=0
    1 'Ponemos que el enemigo se mueva según las coordenadas establecidas en un array'
    12310 ex=8*7:ey=8*10:er=1
    1 'Aquí el player deberá d coger 6 aparatos'
    12320 pc=6
    1 'Actualizamos el HUD'
    12330 gosub 2900
12390 return




1'------------------------------------'
1'  Pantalla de Bienvenida y records 
1'------------------------------------'
    13200 cls:preset (10,30):  print #1,"@@@@   @@@@    @    @@@@   @  @ "
    13210 preset (10,40):  print #1,"@      @@     @ @    @       @  "
    13220 preset (10,50):  print #1,"@@@@   @  @  @   @  @@@@     @  "
    13230 preset (10,120): print #1,"Tu mujer se ha vuelto loca porque no os vais a pasear y ha empezado a tirar tus consolas y juegos por la ventana"
    1 ' Con inverse ponemos el fondo de los carcacteres en el frente y el frente en el fondo'
    13240 preset (10,160): print #1, "Cursores para mover, pulsa una tecla para continuar"
    13250 preset (10,180): print #1, "libre: "fre(0)
    1 'Si no se pulsa una tecla se queda en blucle infinito reproduciebdo una música, si se pulsa se para la música'
    13260 ee=1:gosub 2300
    13270 if inkey$="" then goto 13260 else a=usr2(0)
13290 return



1'------------------------------------'
1'     Pantalla Ganadora'
1'------------------------------------'


1'------------------------------------'
1'           Game over 
1'------------------------------------'


