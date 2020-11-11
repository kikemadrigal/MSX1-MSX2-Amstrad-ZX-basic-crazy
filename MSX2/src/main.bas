1 '    -------------------- '
1 '           CRAZY         '
1 '     BASIC MURCIA 2020   '
1 '    -------------------- '
1 ' Main                       10'
1 ' Welcome scrren y records  100'
1 ' winning scrren            200'
1 ' Game over                 300'
1 ' Scrren 1                  400'
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

70 print #1,"Ejecutando main"
80 defint a-z
1 'Inicializamos variables de mapa'
90 gosub 11200
1 ' Variables el juego'
120 co=0:re=0
1 'Inicializamos el personaje'
130 gosub 5000
1 'Inicialización enemigo'
140 gosub 6000
1 'Inicialización paquete'
150 gosub 7000 

1 'Ponemos un 0 el el bit 7 del rgistro 1 del vdp para poner la pantalla del color del borde'
1 'para que no se vea la carga del archivo de tileset'
1 '400 vdp(1)=vdp(1) xor 64
160 'a=usr3(0)

1 'Cargamos los tiles en RAM'
170 print #1,"Cargando tilesset"
180 cls:bload"tileset.bin",s,&h8000
1 'Mostramos la pantalla de bienvenida'
190 gosub 13200
200 print #1,"Cargando mapa"
1 'Cargamos el mapa e inicializamos las pantallas con los valores de numero de enemigos, aparatos a capturar,etc'
430 gosub 11300
1 '450 vdp(1)=vdp(1) or 64
450 'a=usr4(0)
1 'Activamos las interrupciones de los sprites para detectar las colisiones'
490 on sprite gosub 2700:sprite on
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
    2010 gosub 2600
    1 'render player, el update lo hacemos en el sistema de input'
    2020 gosub 5100
    1 'Actualizamos enemigo'
    2030 gosub 6200
    1 'Render enemigo'
    2040 GOSUB 6300
    1 'Actualizamos los paquetes'
    2050 gosub 7700
    1 'Render paquete'
    2060 gosub 7800
     1 'Chequeamos el cambio de nivel o pantalla y actualizamos la lógica de los niveles'
    2070 if pc=0 then ml=ml+1: gosub 11300
    1 'bucle'
    2080 'if co mod 10=0 then gosub 2900
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
    1 'Vn, siendo v el volumen entre 0-15'
    1 'Mn, sindo n la modulación de la envolvente entre 0-6535 (ni caso)'
    1 'Sn, siendo n la forma de la enfolvente de 0-15, sirve para que vaya desapareciendo el sonido
    1 'Melodía completa'
    1 '2300 if re=1 then PLAY"O5 L8 V4 M8000 A A D F G2 A A A A D E F G E F D C D G R8 O5 A2 A2 A8"
    2300 if re=1 then PLAY"O5 L8 V4 M8000 A A D F G2 A A A A r60 G E F D C D G R8 A2 A2 A8","o1 v4 c r8 o2 c r8 o1 v6 c r8 o2 v4 c r8 o1 c r8 o2 v6 c r8"
    1 'Tirando el paquete'
    2350 if re=5 then play "l10 o4 v4 g c"
    1 'Paquete cogido'
    2360 if re=6 then play"t250 o5 v12 d v9 e" 
    1 'Pitido normal'
    2370 if re=7 then play "O5 L8 V4 M8000 A A D F G2 A A A A"
    1 'Toque fino'
    2380 if re=8 then PLAY"S1M2000T150O7C32"
   
    1 'Pasos'
    2390 if re=9 then PLAY"o2 l64 t255 v4 m6500 c"
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
    2400 if re=10 then sound 6,5:sound 8,16:sound 12,6:sound 13,9
    1 'Volvemos a dejar el psg como estaba'
    2410 'for i=0 to 100: next i: a=usr2(0)
2420 return




1 ' ----------------------'
1 '     INPUT SYSTEM'
1 ' ----------------------'



1 '1 ' 1 Sistema de Input
1 '    1'1 Arriba, 2 arriba derecha, 3 derecha, 4 abajo derecha, 5 abajo, 6 abajo izquierda, 7 izquierda, 8 izquierda arriba
1 '    2500 j=stick(0)
1 '    2520 if j=0 then ps=1
1 '    2530 if j=3 then px=px+pv:ps=4:if co mod 2=0 then ps=ps+1:'re=9:gosub 2300
1 '    2540 if j=7 then px=px-pv:ps=6:if co mod 2=0 then ps=ps+1:'re=9:gosub 2300
1 '    2550 if j=1 then py=py-pv:ps=2:if co mod 2=0 then ps=ps+1:'re=9:gosub 2300
1 '    2560 if j=5 then py=py+pv:ps=2:if co mod 2=0 then ps=ps+1:'re=9:gosub 2300
1 '2590 return

1 '2 Sistema de input'
    1 'Nos guardamos las posiciones del player antes de cambiarlas'
    2500 'px=x:py=y
    2510 on stick(0) gosub 2580,2500,2550,2500,2590,2500,2570
    2520 if stick(0)=0 then 'ps=1
2530 return
1 're=8 es el efecto de sonido 8 de la rutina de reprodución de sonidos 2300
1 '3 derecha'
    2550 px=px+pv:'ps=3
    2560 'if co mod 2=0 then ps=ps+1
2565 return
1 '7 izquierda'
    2570 px=px-pv:'ps=5
    2572 'if co mod 2=0 then ps=ps+1
2573 return
1 '1 arriba'
    2580 py=py-pv:'ps=2
    2582 'if co mod 2=0 then ps=ps+1
2585 return
1 '5 abajo' 
    2590 py=py+pv:'ps=2:
    2592 'if co mod 2=0 then ps=ps+1
2595 return





1 ' ----------------------'
1 '     COLLISION SYSTEM'
1 ' ----------------------'


1 'Colision del player el paquete, esta rutina la llama las interrupciones on sprite de basic'
    1 'Colisiones del player con la pantalla'
    2600 if px>256-16 then px=256-16
    2610 if px<=0 then px=0
    2620 if py<140 then py=140
    2630 if py>192-16 then py=192-16

    1 'Colision del player con los paquetes'
    1 '2640 for i=0 to ft-1
    1 '    2650 if px < fx(i) + fw(i) and  px + pw > fx(i) and py < fy(i) + fh(i) and ph + py > fy(i) then beep
    1 '    2650 if px < fx(i) + fw(i) and  px + pw > fx(i) and py < fy(i) + fh(i) and ph + py > fy(i) then beep
    1 '2660 next i
    
2690 return
1 'Colision del player con el paquete 2'
    2700 re=6: gosub 2300: pc=pc-1:sprite off:gosub 2900
    1 'Borramos lo que había antes donde sale el nombre de los ordenadores'
    2710 line (120,20)-(180,30),7,bf
    2720 preset (120,20):  print #1,"Cogido!"
2730 return



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
    2850 'PRESET(10,45):PRINT#1,"num: "
2860 return


1 'Variables'
    1 'El borrado de lo que había antes lo hacemos con un line'
    2900 line (80,0)-(256,60),7,bf
    1 'Coloreado'
    2960 PRESET(80,5):PRINT#1,ml
    2970 PRESET(80,15):PRINT#1,pc
    2980 'PRESET(80,25):PRINT#1,pw","ph","fw(0)","fh(0)
    2990 'PRESET(80,35):PRINT#1,"px:"px"py:"py
    3000 'PRESET(80,45):PRINT#1,ft
3020 return





























1 ' ----------------------'
1 '         PLAYER
1 ' ----------------------'
1 'Init player'
    1 'Componente position'
    1 'la posición se define en las pantallas, pw=ancho, ph=alto, pv=velocidad'
    5000 px=0:py=0:pw=16:ph=16:pv=8
    1 'Componente render: Plano 1(para el color) y 0 para el personaje, sprite del 0(para el color) y del 1 al 7 para el personaje'
    5010 pp=0:ps=1
    1 'Componente RPG=player capturas y energía o vida'
    5030 pc=5:pe=100
5040 return

1 'Update player'
1 'pasado al sistema de input'

1 'render player'
    1 'El sprite de nuestro personaje es el 1, plano 0'
    5100 put sprite pp,(px,py),9,ps
    1 'El sprute 0 es el swter de color amarillo, plano 1'
    5110 put sprite pp+1,(px,py),1+32,0
5190 return





    




1 '---------------------------------------------------------'
1 '------------------------ENEMIES -------------------------'
1 '---------------------------------------------------------'
1 'init enemy'
    1 'Componente position'
    6000 ex=16*8:ey=5*17
    6010 'epx=0:epy=0
    1 'La velocidad en la que vuelve a tirar un'
    6015 ev=40
    1 'Para saber si el enemig tiene que seguir una ruta 0 es que no'
    6020 er=0:nu=0
    1 'Los sprites son el 0 y el 1'
    6030 ep=1:es=9
    1 ' Enemigo tipo'
    6040 et=0
    1 'Rutas del enemigo'
    6050 dim e(13),c(13)
    1 '1 Fila de ventanas'
    6060 e(0)=8*2:c(0)=8*10:  e(1)=8*7:c(1)=8*10:  e(2)=8*10:c(2)=8*10: e(3)=8*12:c(3)=8*10: e(4)=8*20:c(4)=8*10
    1 ' 2 Fila'
    6070 e(5)=8*2:c(5)=8*12:  e(6)=8*7:c(6)=8*12:  e(7)=8*10:c(7)=8*12: e(8)=8*12:c(8)=8*12: e(9)=8*20:c(9)=8*12
    1 ' 3 Fila'
    6080 e(10)=8*17:c(10)=8*14:  e(11)=8*20:c(11)=8*14:  e(12)=8*25:c(12)=8*14
    1 'Iniciamos la secuencia de nuemeros aleatorios al azar
    6010 a=rnd(-time)
6090 return

1 'update enemy'
    1 ' aumentamos el contador para que al mod de 40 tire un paquete'
    6200 co=co+1
    1 'Le ponemos el sprite 1 que lo podemos cambiar cuando sea mod de 40'
    6210 ep=3:es=9
    6220 'epx=ex:epy=ey
    1 ' cada vez que sea 20
    1 '1.Ponemos el contador a 0 y generamos un número aleatorio en contador (co),si está en er=enegigo ruta 1 le asignamos la posición aleatoria del array,
    1 '2.Le cambiamos el sprite a la mujer para que parezca que tira el paquete'
    1 '3 Emitimos el efecto de sonido re=5(linea 2300)'
    1 '4.Como hay que desactivar las colisiones de los sprites cada vez que haya una, las volvemos a activar'
    1 '5.Creamos un paquete nuevo (línea 7500)'
    6250 if co mod ev=0 and er=0 then co=0:ex=rnd(1)*(160-50)+50:es=es+1:re=5:gosub 2300:gosub 7500:sprite on
    6260 if co mod ev=0 and er=1 then co=0:ex=e(rnd(1)*13):ey=c(rnd(1)*13):es=es+1:re=5:gosub 2300:gosub 7500:'sprite on
    1 'Solo para debugger'
    1 '6270 if co mod 40=0 then gosub 2900
6290 return

1 'Render'
    1 'El sprite de nuestra mujer es el 9, el plano el 3'
    6300 put sprite ep,(ex,ey),1,es
    1 'Le ponemos un 2 plano al personaje para que le pinte los brazos de color naranja, sprite 8'
    6320 put sprite ep+1,(ex,ey),11,8
6390 return


1 '---------------------------------------------------------'
1 '------------------------FIRE ----------------------------'
1 '---------------------------------------------------------'
1 'Init paquete'
    1 'El sprite del barril es el 7'
    1 'ft=número paquete o turno, se utiliza para ir ocupando el espacio de memoria oportuno'
    1 'fs=paquete sprite'
    1 'fv=paquete velocidad
    1 'fm=fire modelo=0=MSX,1=AMSTRAD, 2=SPECTRUM,3=ATARI'
    1 'fip= inicial plano'
    1 'fs esprite inicial'
    1 'fd paquete a borrar'
    7000 ft=0:fm=5:fip=10:fp=fip:fs=11:fd=0:fv=0
    7010 dim fx(fm),fy(fm),fw(fm),fh(fm),fm(fm),fp(fm),fs(fm),fc(fm),fa(fm)
7020 return

1 'Crear paquete'
    1 ' Para crear objetos siempre trabajaremos con un menos, en contador de número siempre habrá uno más'
    7500 'nada'
    1 'La posición será la del el player + su altura'
    7502 fx(ft)=ex:fy(ft)=ey+16:fw(ft)=16:fh(ft)=16
    1 'modelo ataris, msx, etc'
    7504 fm(ft)=rnd(1)*(4-1)+1
    1 ' plano, crearemos 10 planos o objetos como mucho que se pueden mover a la vez, el inicial será el 2'
    7505 fp=fp+1:if fp=10 then fp=fip
    1 ' INicializaremos el plano y el sprite del array'
    7508 fp(ft)=fp:fs(ft)=fs
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
    7560 fa(ft)=1
    7570 ft=ft+1
    7580 'gosub 2900
7590 return

1 'Delete paquete'
    1 '7600 fx(i)=fx(ft-1):fy(i)=fy(ft-1):fp(i)=fp(ft-1):fs(i)=fs(ft-1):fc(i)=fc(ft-1):sprite off:ft=ft-1
    1 'Pasamos todos los datos del utimo al eliminado'
    7600 fx(d)=fx(ft-1):fy(d)=fy(ft-1):fp(d)=fp(ft-1):fs(d)=fs(ft-1):fc(d)=fc(ft-1)
    1 'Descontamos 1 en el contador paa que no  dibuje 1'
    7610 ft=ft-1
    7620 re=9:gosub 2300
    7630 'gosub 2900
7690 return



1 ' update paquete'
    7700 if ft=0 then return
    7710 for i=0 to ft-1
        1 'Aumentamos la y en 1 para que se mueva'  
        7720 fy(i)=fy(i)+fv
        1 'Si el paquete llega abajo le ponemos que no está axyivo'
        1 'Si el paquete llega a 158 le cambiamos el sprite al siguiente del inicial'
        7730 if fy(i)>160-4 then fs(i)=fs(i)+1
        1 'y si llega al final los borramos'
        1 'Si llega al suelo, lo eliminamos'
        7740 if fy(i)>160 then fd=i:sprite off:gosub 7600
    7750 next i
7790 return

1 'render paquete'
    7800 if ft=0 then put sprite 10,(-16,0),1,11: return
    7805 for i=0 to ft-1
        1 'Lo pintamos'
        7810 if i=0 then put sprite 10,(fx(i),fy(i)),fc(i),fs(i)
        7820 if i=1 then  put sprite 11,(fx(i),fy(i)),fc(i),fs(i)
        7830 if i=2 then  put sprite 12,(fx(i),fy(i)),fc(i),fs(i)
    7880 next i
7890 return 



































1 '---------------------------------------------------------'
1 '------------------------MAPA ----------------------'
1 '---------------------------------------------------------'
1 ' inicializar_mapa
    1 'ml=mapa level, el mapa empezará en el level 0'
    1 'ms=mapa seleccioando, lo hiremos cambiando    
    1 'mm= maximo de mapas
    1 'mc= mapa cambia, lo utilizaremos para cambiar los copys y así cambiar la pantalla
    1 'md=Mapa dirección de la yabla de nombres'
    11200 ml=0:ms=0:mm=1:mc=0:md=0:tn=0
11220 return

1 'Cargar mapa de disco y meterlo en la VRAM
    1 '1 cargamos el mapa
    1 'Cada mapa ocupa 862 bytes'
    1 'md=mapa dirección, la dirección c001 se la he puesto yo en el archivo binario cuando lo creé'
    1 'El archivo tan solo contiene los datos de la definición de los mapas'
    1 'Cuando se lea otro nivel se inicializarán las pantallas y sonorá una musiquilla'
    11300 if ml=0 then bload"level0.bin",r:gosub 12000
    11310 if ml=1 then bload"level1.bin",r:gosub 12300:re=7:gosub 2300
    11311 if ml=2 then bload"level0.bin",r:gosub 12400:re=7:gosub 2300
    11315 'vdp(1)=vdp(1) xor 64
    11316 'a=usr3(0)
    11320 _TURBO ON (tn,mm)
    11330 md=&hb001
    13333 preset (0,0)
    11340 for i=0 to mm-1
        11350 for f=0 to 12
        1 'ahora leemos las columnas c
            11360 for c=0 to 15
                1 'Obtenemos el valor que representa al tile de la fila y la columna'
                11370 tn=peek(md):md=md+1
                11380 if tn >=0 and tn <16 then copy (tn*16,0*16)-((tn*16)+16,(0*16)+16),1 to (c*16,f*16),0,tpset
                11390 if tn >=16 and tn <32 then copy ((tn-16)*16,1*16)-(((tn-16)*16)+16,(1*16)+16),1 to (c*16,f*16),0,tpset
                11400 if tn >=32 and tn <48 then copy ((tn-32)*16,2*16)-(((tn-32)*16)+16,(2*16)+16),1 to (c*16,f*16),0,tpset
                1 '11410 if tn>=48 and tn <64 then copy ((tn-48)*16,3*16)-(((tn-48)*16)+16,(3*16)+16),1 to (c*16,f*16),0,tpset
                1 '11420 if tn>=64 and tn <80 then copy ((tn-64)*16,4*16)-(((tn-64)*16)+16,(4*16)+16),1 to (c*16,f*16),0,tpset
                1 '11430 if tn>=80 and tn <96 then copy ((tn-80)*16,5*16)-(((tn-80)*16)+16,(5*16)+16),1 to (c*16,f*16),0,tpset
                1 '11440 if tn>=96 and tn <112 then copy ((tn-96)*16,6*16)-(((tn-96)*16)+16,(6*16)+16),1 to (c*16,f*16),0,tpset
                1 '11450 if tn>=112 and tn <128 then copy ((tn-112)*16,7*16)-(((tn-112)*16)+16,(7*16)+16),1 to (c*16,f*16),0,tpset
                1 '11460 if tn>=128 and tn <144 then copy ((tn-128)*16,8*16)-(((tn-128)*16)+16,(8*16)+16),1 to (c*16,f*16),0,tpset
                1 '11470 if tn>=144 and tn <160 then copy ((tn-144)*16,9*16)-(((tn-144)*16)+16,(9*16)+16),1 to (c*16,f*16),0,tpset
                1 '11480 if tn>=160 and tn <176 then copy ((tn-160)*16,10*16)-(((tn-160)*16)+16,(10*16)+16),1 to (c*16,f*16),0,tpset
                1 '11490 if tn>=176 and tn <192 then copy ((tn-176)*16,11*16)-(((tn-176)*16)+16,(11*16)+16),1 to (c*16,f*16),0,tpset
                1 '11500 if tn>=192 and tn <208 then copy ((tn-192)*16,12*16)-(((tn-192)*16)+16,(12*16)+16),1 to (c*16,f*16),0,tpset
                11510 next c
        11520 next f 
    11530 next i
    11540 _turbo off
    11550 'vdp(1)=vdp(1) or 64
    11560 'a=usr4(0)
11570 return






1 '---------------------------------------------------------'
1 '------------------------PANTALLA 1 ----------------------'
1 '---------------------------------------------------------'
1 'Init'
    1 'Objetivo coger 3 paquetes'
    1 'pc=player capturas que tiene que hacer'
    12000 pc=3
    1 'posición del player abajo en el centro'
    12010 px=100:py=150
    1 'en=numero de enemigos'
    12020 en=1
    1 ' Tiempo que tarda en aparecer el malo'
    12030 ev=20
    1 'Velocidad en el que caen los objetos'
    12040 fv=8

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
    1 'objetivo coger 3 paquetes'
    1 'Ponemos el numero de sprites de paquetes a 0'
    12300 'ft=0
    1 'Ponemos que el enemigo se mueva según las coordenadas establecidas en un array'
    12310 ex=8*7:ey=8*10:er=1
    1 'Aquí el player deberá d coger 6 aparatos'
    12320 pc=6
    1 'Actualizamos el HUD'
    12330 gosub 2900
12390 return

1 '---------------------------------------------------------'
1 '------------------------PANTALLA 3 ----------------------'
1 '---------------------------------------------------------'
1 'Objetivo coger 3 paquete y que no te pillen'
    12400 pc= 3:ev=5
12410 return


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
    13260 re=1:gosub 2300
    13270 if inkey$="" then goto 13260 else a=usr2(0)
13290 return



1'------------------------------------'
1'     Pantalla Ganadora'
1'------------------------------------'


1'------------------------------------'
1'           Game over 
1'------------------------------------'


