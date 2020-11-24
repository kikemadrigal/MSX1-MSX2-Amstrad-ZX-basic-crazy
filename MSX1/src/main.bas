

80 defint a-z
1 'Inicializamos variables de mapa'
90 gosub 11000
1 ' Variables el juego'
1 'co= contador para el movimiento del enemigo'
1 're=reproductor de música, para elegir una melodía'
1 'in=iinformación misón'
120 co=0:re=0:in$=""
1 'Inicializamos el personaje'
130 gosub 5000
1 'Inicialización enemigo'
140 gosub 6000
1 'Inicialización paquete'
150 gosub 7000 
1 'Mostramos la pantalla de bienvenida'
170 'gosub 11500
180 'print #1,"Loading tilset word 0"
1 'Ponemos un 0 el el bit 7 del rgistro 1 del vdp para poner la pantalla del color del borde'
1 'para que no se vea la carga del archivo de tileset'
1 '400 vdp(1)=vdp(1) xor 64
400 a=usr3(0)
1 'Cargamos los tiles para el mundo 0 en RAM'
420 bload"tilesw0.bin",s
1 'cargamos el buffer'
425 gosub 11100
1 'Cargamos el mapa con los niveles del word 0 e inicializamos la pantalla 0 
1 'con los valores de numero de enemigos, aparatos a capturar,etc'
430 gosub 11300
1 '450 vdp(1)=vdp(1) or 64
450 a=usr4(0)
1 'Activamos las interrupciones de los sprites para detectar las colisiones'
490 'on sprite gosub 2700:sprite on
1 'Mostramos la información del HUD'
500 gosub 2800:gosub 2900
1 'cargamos la música en la RAM y la llamamos desde basic'
510 'bload"music.bin":defusr2=&h9500:a=usr2(0):defusr3=&h9509
1 'Rutina barra espaciadora pulsada
520 strig(0) on:on strig gosub 5200
530 time=0
540 'on interval=50 gosub 2900


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
    2040 GOSUB 6600

    2041 for ft=0 to fa-1
        1 'Actualizamos los paquetes'
        2050 gosub 7700
        1 'Render paquete'
        2060 gosub 7800
    2062 next ft


     1 'Chequeamos el cambio de nivel o pantalla y actualizamos la lógica de los niveles'
     1 'Si las capturas del player llegan a 0 entonces cambiamos el nivel y llamamos a la rutina de carga de niveles e inicialización de mapas'
    2070 if pc=0 then ml=ml+1: gosub 11300
    1 'bucle'
    2080 'if co mod 10=0 then gosub 2900
2090 goto 2000
1 ' ----------------------'
1 '    FINAL MAIN LOOP
1 ' ----------------------'





1 'Reproduztor de música'
    1 'Reproductor en ensamblador'
    2200 a=usr3(0)
2220 return
1 'Reproductor de efectos d sonido'
    1 'play, c=do, d=re, e=mi, f=ft, g=sol, a=la, b=si
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
    2300 a=usr2(0)
    2310 if re=1 then PLAY"O5 L8 V4 M8000 A A D F G2 A A A A r60 G E F D C D G R8 A2 A2 A8","o1 v4 c r8 o2 c r8 o1 v6 c r8 o2 v4 c r8 o1 c r8 o2 v6 c r8"
    1 'Tirando el paquete'
    2350 if re=5 then play "l10 o4 v4 g c"
    1 'Paquete cogido'
    2360 if re=6 then play"t250 o5 v12 d v9 e" 
    1 'Pitido normal'
    2370 if re=7 then play "O5 L8 V4 M8000 A A D F G2 A A A A"
    1 'Toque fino'
    2380 if re=8 then PLAY"S1M2000T150O7C32"
   
    1 'Pasos'
    2390 if re=9 then PLAY"o2 l64 t255 v10 m6500 c"
    1 'Sound puerto, valor, para ver las notas ir a https://www.msx.org/wiki/SOUND, recuerda que el d5dh=3421 es el 34 para el tono canal a puerto 1 y en puerto 0 21'
    1 '0=Tono canal a bit menos significativo,2=tono canal b menos significativo, 4=tono canal c menos significativo de 0-255
    1 '1=Tono canal a bit mas significativo, 3=tono canal b bit mas significativo, 5=tono canal c bit mas significativo de 0 a 15 
    1 '6 ruido de 0-31
    1' 7 mezlador 0-191
    1 '8 volumen canal a, 9 volumen canal b, 10 volumen canal c de 0-16'
    1 '12 velocidad envolvente de 0-255
    1 '13 forma envolmente para que desaparezca en el tiempo la nota de 0-15'
    1 'En este ejemplo trabajamos solo con el ruido, el 6, el 8 =16 significa que vamos a variar el volumen con el 12 y el 13 para que desaparezca'
    1 'Sato personaje'
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
    2500 'pj=player jump indica si el player está saltando para desactivar la comprobación del teclado
    2510 if pj=0 then on stick(0) gosub 2580,2500,2550,2500,2590,2500,2570
    2520 if stick(0)=0 then ps=1
2530 return
1 're=8 es el efecto de sonido 8 de la rutina de reprodución de sonidos 2300
1 '3 derecha'
    2550 px=px+pv:ps=3
    2560 if co mod 2=0 then ps=ps+1
2565 return
1 '7 izquierda'
    2570 px=px-pv:ps=5
    2572 if co mod 2=0  then ps=ps+1
2573 return
1 '1 arriba'
    2580 py=py-pv:ps=2
    2582 if co mod 2=0  then ps=ps+1
2585 return
1 '5 abajo' 
    2590 py=py+pv:ps=2:
    2592 if co mod 2=0  then ps=ps+1
2595 return





1 ' ----------------------'
1 '     COLLISION SYSTEM'
1 ' ----------------------'


1 'Colision del player el paquete, esta rutina la llama las interrupciones on sprite de basic'
    1 'Colisiones del player con la pantalla'
    2600 if px>256-16 then px=256-16
    2610 if px<=0 then px=0
    2620 if py<136 then py=136
    2630 if py>192-16 then py=192-16

    1'Colision del player con los paquetes'
    2640 for i=0 to fa-1
        2650 if px < fx(i) + fw and  px + pw > fx(i) and py < fy(i) + fh and ph + py > fy(i) then gosub 2700
        1 'método de Juan
        1'2650 if fy(0)+16 > py and py < fy(0)+16 then if fx(0)<px+16 and fx(0)+16 > px then beep
    2660 next i
     1'Colision del player con el perro'
    2670 if en=1 then if px < ex(1) + fw and  px + pw > ex(1) and py < ey(1) + fh and ph + py > ey(1) then pe=pe-1:beep:gosub 2900
2690 return
1 'Colision del player con el paquete 2'
    1 'hacemos un sonido, descntamos las camputras y llamamos a la rutina eliminar'
    2700 re=6: gosub 2300: pc=pc-1:gosub 7600
    1 'Borramos lo que había antes donde sale el nombre de los ordenadores'
    2710 line (120,20)-(180,30),3,bf
    2720 preset (120,20):  print #1,"Capurado!!!"
    1 'Actualizamos el HUD'
    2730 gosub 2900
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
    2806 PRESET(10,15):PRINT#1,"Energy: "
    2810 PRESET(10,25):PRINT#1,"level: "
    2820 PRESET(10,35):PRINT#1,"faltan: "
    2830 'PRESET(10,35):PRINT#1,"Vidas: "
    2850 'PRESET(10,45):PRINT#1,"jump: "
2860 return


1 'Variables'
    1 'El borrado de lo que había antes lo hacemos con un line'
    2900 line (80,0)-(256,60),7,bf
    1 'Coloreado'
    2960 PRESET(80,15):PRINT#1,pe
    2970 PRESET(80,25):PRINT#1,m1
    2980 PRESET(80,35):PRINT#1,pc
    3000 'PRESET(80,45):PRINT#1,""pj","py","po
3020 return





























1 ' ----------------------'
1 '         PLAYER
1 ' ----------------------'
1 'Init player'
    1 'Componente position'
    1 'la posición se define en las pantallas, pw=ancho, ph=alto, pv=velocidad, capturas, etc'
    1 'pj=indica si el salto está activado para desactivar la comprobación del teclado'
    1 'po=player y old'
    5000 px=0:py=0:pw=16:ph=16:pv=8:pj=0:po=py:pe=100
    1 'Componente render: Plano 1(para el color) y 0 para el personaje, sprite del 0(para el color) y del 1 al 7 para el personaje'
    5010 pp=0:ps=1
    1 'Componente RPG=player capturas y energía o vida, se define en las pantallas'
    5030 pc=0:pe=0
5040 return

1 'Update player'
1 'pasado al sistema de input'

1 'render player'
    1 'El sprite de nuestro personaje es el 1, plano 0'
    5100 put sprite pp,(px,py),1,ps
    1 'El sprute 0 es el swter de color amarillo, plano 1'
    5110 'put sprite pp+1,(px,py),11,0
    1 '""pj","py","po'
    5120 'if pj=1 and py<po-16 then py=py-2
    5130 if pj=1 and py<po then py=py+2
    5140 if pj=1 and py=po then pj=0:strig(0)on

5190 return


1 ' Rutina barra espaciadora pulsada'
    1 'Ponemos un sonido de salto'
    5200 re=10: gosub 2300
    1 'Guardamos la posición vieja de y'
    5210 po=py:py=py-12:pj=1:strig(0)off
5290 return



    




1 '---------------------------------------------------------'
1 '------------------------ENEMIES -------------------------'
1 '---------------------------------------------------------'
1 'init enemy'
    1 'Componente position'
    1 'La mujer'
    6000 ex(0)=16*8:ey(0)=5*17
    1 'EL perro'
    6005 ex(1)=255:ey(1)=160
    1 'El crio'
    6006 ex(2)=0:ey(2)=140
    6010 'epx=0:epy=0
    1 'La velocidad en la que vuelve a tirar un'
    6015 ev(0)=40:ev(1)=8:ev(2)=8
    1 'Para saber si el enemig tiene que seguir una ruta 0 es que no'
    6020 er(0)=0:'nu(0)=0
    1 'Los sprites son el 0 y el 1'
    6030 ep(0)=1
    1 'El sprite de la mujer es el 0, el del perro es el 1'
    6035 es(0)=9:es(1)=13
    1 ' en=numero de enemigos de la pantalla,
    1 ' et=Enemigo tipo'
    6040 en=0:et(0)=0
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
    6210 ep(0)=3:es(0)=9
    1 ' cada vez que sea 20
    1 '1.Ponemos el contador a 0 y generamos un número aleatorio en contador (co),si está en er=enegigo ruta 1 le asignamos la posición aleatoria del array,
    1 '2.Le cambiamos el sprite a la mujer para que parezca que tira el paquete'
    1 '3 Emitimos el efecto de sonido re=5(linea 2300)'
    1 '4.Como hay que desactivar las colisiones de los sprites cada vez que haya una, las volvemos a activar'
    1 '5.Creamos un paquete nuevo (línea 7500)'
    6250 if co mod ev(0)=0 and er(0)=0 and fa<>fm-1 then co=0:ex(0)=rnd(1)*(160-50)+50:es(0)=es(0)+1:re=5:gosub 2300:gosub 7500
    6260 if co mod ev(0)=0 and er(0)=1 and fa<>fm-1 then co=0:ex(0)=e(rnd(1)*13):ey(0)=c(rnd(1)*13):es(0)=es(0)+1:re=5:gosub 2300:gosub 7500
    1 'Perro'
    1 'Si el numero de enemigos es 1 mostramos a la mujer y al perro'
    6270 if en=1 then gosub 6300
    1 'niño'
    1 'Si el numero de enemigos es 2 mostramos a la mujer, al perro y el niño'
    1 '6280 if en=2 then gosub 6300: gosub 6400
    1 'Solo para debugger'
    1 '6285 if co mod 40=0 then gosub 2900
6290 return

1 'Renderizar perro'
    1 'Perro '
    6300 ex(1)=ex(1)-ev(1)
    6305 if co mod 2=0 then es(1)=14
    6310 if co mod 2<>0 then es(1)=13
    6320 if ex(1)<0 then ex(1)=255:ey(1)=rnd(-time)*(192-140)+140:gosub 2900
6390 return
1 '1 'Renderizar niño
1 '    6400 ex(2)=ex(2)-ev(2)
1 '    6405 if co mod 2=0 then es(1)=15
1 '    6410 if co mod 2<>0 then es(2)=16
1 '    6420 if ex(1)>256 then ex(2)=0: ey(2)=rnd(-time)*(192-140)+140
1 '6490 return

1 'Render'
    1 'El sprite de nuestra mujer es el 9, el plano el 3'
    6600 put sprite ep(0),(ex(0),ey(0)),1,es(0)
    1 'Le ponemos un 2 plano al personaje para que le pinte los brazos de color naranja, sprite 8'
    6620 'put sprite ep(0)+1,(ex(0),ey(0)),11,8
    6630 if en=1 then put sprite 5,(ex(1),ey(1)),1,es(1)
    6640 if en=2 then put sprite 5,(ex(1),ey(1)),1,es(1) :put sprite 6,(ex(2),ey(2)),1,es(2)
6690 return




1 '---------------------------------------------------------'
1 '------------------------FIRE ----------------------------'
1 '---------------------------------------------------------'
1 'Init paquete'
    1 'El sprite del barril es el 7'
    1 'fa=Serán los paquetes que estarán activos, que deberemos pintar y actualizar
    1 'fm=paquetes máximos'
    1 'fw=ancho del sprite, solo se utilzia en colision'
    1 'fh=alto del sprite, solo se utilzia en colision'
    1 'fp=plano inicial del paquete'
    1 ''
    1 'ft=turno paquete, variable utilizada para renderizar y actualizar el paquete oportuno'
    1 'fs=paquete sprite'
    1 'fv=paquetes velocidads
    1 'fc=fire color=0=MSX,1=AMSTRAD, 2=SPECTRUM,3=ATARI'
    1 'fs esprite inicial'
    1 'fd=paquete delete'
    7000 fa=0:fm=4:fw=8:fh=2::fs=11:fp=11:fi=fs:fv=0:fd=0
    7010 dim fx(fm),fy(fm),fm(fm),fp(fm),fs(fm),fc(fm),ft(fm)
7020 return

1 'Crear paquete'
    1 'Controlamos que el plano no se pase'
    7500 if fp+fa=fi+fm then fp=fs
    7510 fp=fs+fa+1
    7520 fp(fa)=fp
    7530 fs(fa)=fs
    7535 fx(fa)=ex(0):fy(fa)=ey(0)+8
    7540 fc(fa)=rnd(-tile)*(9-4)+4
    1 'Borramos lo que había antes y mostramos un mensaje'
    7545 line (120,20)-(180,30),7,bf
    7550 if fm(ft)=0 then fc(ft)=4:preset (125,25): print #1,"MSX"
    7555 if fm(ft)=1 then fc(ft)=5:preset (125,25): print #1,"Amstrad"
    7560  if fm(ft)=2 then fc(ft)=6:preset (125,25): print #1,"Spectrum"
    7565  if fm(ft)=3 then fc(ft)=7:preset (125,25): print #1,"Atari"
    7570  if fm(ft)=3 then fc(ft)=8:preset (125,25): print #1,"Comodore"
    7575  if fm(ft)=3 then fc(ft)=9:preset (125,25): print #1,"Amiga"
    7580 fa=fa+1
    1 'Solo para debugger'
    7685 'gosub 2900
7590 return
1 'Delete paquete'
    7600 if fa<=0 then return
    7610 fp(fd)=fp(fa-1):fx(fd)=-16: fy(fd)=fy(fa-1): fc(fd)=fc(fa-1):fs(fd)=fs(fa-1)
    1 'disminuimos los paquetes activos y los planos'
    7620 fa=fa-1:fp=fp-1
    1 'Hacemos un sonido'
    7625 re=9:gosub 2300
    1 'Solo para debugger'
    7630 'gosub 2900
7690 return
1 ' update paquete'
    7700 if fa<0 then return
        1 'le sumamos a todos los que están activos la velocidad'
        7720 fy(ft)=fy(ft)+fv
        1 ' Le cambiamos el sprite al que explota si llega a una posición'
        7730 if fy(ft)>155 then fs(ft)=fs(ft)+1
        1 'So llega al final llamamos a la rutina borrar paquete'
        7740 if fy(ft)>160 then gosub 7600
7790 return
1 'render paquete'
    7800 if fa<=0 then return
    7810 put sprite fp(ft),(fx(ft),fy(ft)),fc(ft),fs(ft)
7890 return 


































1 '---------------------------------------------------------'
1 '------------------------MAPA ----------------------'
1 '---------------------------------------------------------'
1 ' inicializar_mapa
    1 'mw=mapa mundo'
    1 'ml=mapa level, el mapa empezará en el level 0'
    1 'ms=mapa seleccioando, lo hiremos cambiando    
    1 'mm= maximo de mapas, cada mundo tiene 9 mapas
    1 'mc= mapa cambia, lo utilizaremos para cambiar los copys y así cambiar la pantalla
    1 'md=Mapa dirección de la yabla de nombres'
    11000 mw=0:ml=0:ms=0:mm=9:mc=0:md=0
    11010 dim mf(512,9)
11020 return

1 'Cargar mundo con los mapas de los niveles en el buffer o array'
    11100 bload"world0.bin",r
    1 ' sabemos que niestro mapa empieza en dirección b001'
    1 'Como no vamos a usar los 3 trozos de pantalla (o bancos) en lugar de 768 (mirar la distribución de la tabla de nombres de la RAM) utilizaremos 512'
    1 '6912-6400=512(&h200)'
    1 '45057=&hb001 (del b001 al b200), 45057+512=&hb034 (del b201 al 400), 45057+(512*2)=&hb401 (del 401 al 600)
    1 'Nuestro mapa ha sido definido con tiles de 8x8 pixeles'
    1 'La definición de nuestro mapa son 512 bytes'
    1 'ml=0 = md=&hb001
    1 'ml=1 = md=&hb201
    1 'ml=2 = md=&hb401
    1 'ml=3 = md=&hb601
    1 'ml=4 = md=&hb801
    1 'ml=5 = md=&hba01
    1 'ml=6 = md=&hbc01
    1 'ml=7 = md=&hbe01

    11110 md=&hd001
    11120 for i=0 to mm-1
        1 'Esto se podría poner desde 0 hasta 512'
        11130 for j=0 to 511
            11140 tn=peek(md):md=md+1
            11150 mf(j,i)=tn
        11170 next j
    11180 next i
11190 return


1 'Cargar mapa del array y meterlo en la VRAM
    11300  bload"world0.bin",r:if ml=3 then ml=0
    11310 'a=usr3(0)
    11320 '_turbo on(mf(),ml)
    11330 if ml=0 then gosub 12000
    11331 if ml=1 then gosub 12100:re=7:gosub 2300
    11332 if ml=2 then gosub 12200:re=7:gosub 2300
    1 '11333 if ml=3 then gosub 12300:re=7:gosub 2300
    1 '11334 if ml=4 then gosub 12400:re=7:gosub 2300
    1 '11335 if ml=5 then gosub 12500:re=7:gosub 2300
    1 '11336 if ml=6 then gosub 12600:re=7:gosub 2300
    1 '11337 if ml=7 then gosub 12700:re=7:gosub 2300
    11350 for i=0 to 512
        11360 vpoke 6144+256+i,mf(i,ml)
    11380 next i 
    11420 '_turbo off
    11440 'a=usr4(0)
11490 return
1 'Modelo sin buffer, en este las líneas 11010, 11100--+ y 425 pueden ser eliminadas'
1 '1 'Cargar mapa de disco y meterlo en la VRAM
1 '    1 '1 cargamos el mapa
1 '    1 'Cada mapa ocupa 862 bytes'
1 '    1 'md=mapa dirección, la dirección d001 se la he puesto yo en el archivo binario cuando lo creé'
1 '    1 'El archivo tan solo contiene los datos de la definición de los mapas'
1 '    1 'Cuando se lea otro nivel se inicializarán las pantallas y sonorá una musiquilla'
1 '    11300 bload"world0.bin",r
1 '    1 '11300 if ml=0 then bload"level0.bin",r:gosub 12000
1 '    1 '11310 if ml=1 then bload"level1.bin",r:gosub 12300:re=7:gosub 2300
1 '    1 '11311 if ml=2 then bload"level0.bin",r:gosub 12400:re=7:gosub 2300
1 '    11315 'vdp(1)=vdp(1) xor 64
1 '    11316 a=usr3(0)
1 '    11320 '_turbo on
1 '    1 'Como no vamos a usar los 3 trozos de pantalla (o bancos) en lugar de 768 (mirar la distribución de la tabla de nombres de la RAM) utilizaremos 512'
1 '    1 '6912-6400=512(&h200)'
1 '    1 '45057=&hb001 (del b001 al b200), 45057+512=&hb034 (del b201 al 400), 45057+(512*2)=&hb401 (del 401 al 600)
1 '    11330 if ml=0 then md=&hb001:gosub 12000
1 '    11331 if ml=1 then md=&hb201:gosub 12100:re=7:gosub 2300
1 '    11332 if ml=2 then md=&hb401:gosub 12200:re=7:gosub 2300
1 '    11333 if ml=3 then md=&hb601:gosub 12300:re=7:gosub 2300
1 '    11334 if ml=4 then md=&hb801:gosub 12400:re=7:gosub 2300
1 '    11335 if ml=5 then md=&hba01:gosub 12500:re=7:gosub 2300
1 '    11336 if ml=6 then md=&hbc01:gosub 12600:re=7:gosub 2300
1 '    11337 if ml=7 then md=&hbe01:gosub 12700:re=7:gosub 2300
1 '    1 '11338 if ml=8 then md=&hb1001:gosub 12800:re=7:gosub 2300
1 '
1 '    11340 for i=0 to mm-1
1 '        1 'Copia desde base(10) 6144 (&h1800) hasta la &h1aff,6144+768=6912
1 '        1 'Nuestro mapa ha sido definido con tiles de 8x8 pixeles'
1 '        1 'La definición de nuestro mapa son 512 bytes'
1 '        11350 for j=6144+256 to 6912
1 '                1 'Como los tiles los habíamos cargado previamente en RAM ahora solo los pasamos a VRAM'
1 '                11360 vpoke j,peek(md)
1 '                11370 md=md+1
1 '        11380 next j  
1 '    11410 next i
1 '    11420 '_turbo off
1 '    11430 'vdp(1)=vdp(1) or 64
1 '    11440 a=usr4(0)
1 '11490 return




























1'------------------------------------'
1'  Pantalla de Bienvenida y records 
1'------------------------------------'
    11500 cls:preset (10,30):  print #1,"@@@@   @@@@    @    @@@@   @  @ "
    11510 preset (10,40):  print #1,"@      @@     @ @    @       @  "
    11520 preset (10,50):  print #1,"@@@@   @  @  @   @  @@@@     @  "
    11530 preset (10,120): print #1,"Tu mujer se ha vuelto loca porque no os vais a pasear y ha empezado a tirar tus consolas y juegos por la ventana"
    1 ' Con inverse ponemos el fondo de los carcacteres en el frente y el frente en el fondo'
    11540 preset (10,160): print #1, "Cursores para mover, pulsa una tecla para continuar"
    11560 preset (10,180): print #1, "libre: "fre(0)
    1 'Si no se pulsa una tecla se queda en blucle infinito reproduciebdo una música, si se pulsa se para la música'
    11570 re=1:gosub 2300
    11580 if inkey$="" then goto 11570 else a=usr2(0)
11590 return



1'------------------------------------'
1'     Pantalla Ganadora'
1'------------------------------------'
    11600 'nada
11610 return

1'------------------------------------'
1'           Game over 
1'------------------------------------'
    11700 'nada'
11710 return
1'------------------------------------'
1'    Salón de la ftma o records 
1'------------------------------------'
    11800 'nada'
11810 return


1 'Rutina pintar escenario'
    1' Vamos a pintar el suelo
    11900 LINE(0,160)-(256,170),3,bf
    1 'Vamos a pintar la casa'
    1 ' b=desplazamos el lapiz de forma absoluta y sin dibujar la trayectoria 40 pixeles eje x y 160 eje y  '
    1 'c= le ponemos el valor negro=1'
    1 'up=le decimos que dibuje 100 pixeles hacia arriba'
    11910 draw ("bm40,160c1u100")
    11920 draw ("r180d100")
    1 ' dibujamos el altillo'
    11930 draw("bm50,60u20r160d20")
11940 return



1 '-----------------------------------------------------------------------------------------'
1 '--------------------------------------MUNCO 1 -------------------------------------------'
1 '-----------------------------------------------------------------------------------------'



1 '---------------------------------------------------------'
1 '------------------------PANTALLA 0 ----------------------'
1 '---------------------------------------------------------'
1 'Init'
    1 'Objetivo coger 3 paquetes'
    12000 in$="Coger paquetes"
    1 'pc=player capturas que tiene que hacer, pe=energia player, er modo de sie el enemigo sale aleatorio o con 1 array definido'
    12050 pc=5:pe=30:er=0
    1 'posición del player abajo en el centro'
    12010 px=100:py=150
    1 'en=numero de enemigos, el 0 solo la mujer, el 1 la mujer y el perro, el 2 la mujer el perro y el niño'
    12020 en=1
    1 ' Tiempo que tarda en aparecer el malo'
    12030 ev(0)=15
    1 'Velocidad en el que caen los objetos'
    12040 fv=8

12090 return

1 '---------------------------------------------------------'
1 '------------------------PANTALLA 1 ----------------------'
1 '---------------------------------------------------------'
1 'init'
    1 'objetivo coger 3 paquetes'
    1 'Ponemos el numero de sprites de paquetes a 0'
    12100 fa=0
    1 'Ponemos que el enemigo se mueva según las coordenadas establecidas en un array'
    12110 en=0:ex(0)=8*7:ey(0)=8*10:er(0)=1
    1 'Aquí el player deberá d coger 6 aparatos'
    12120 pc=5
    1 'Actualizamos el HUD'
    12130 gosub 2900
12190 return

1 '----------------------------------------------------------------'
1 '------------------------PANTALLA 2 (ml=2) ----------------------' 
1 '----------------------------------------------------------------'
1 'Objetivo coger 3 paquete y que no te pillen'
    12200 pc=3:fa=0
    12210 ev(0)=20:er(0)=0
12210 return
1 '---------------------------------------------------------'
1 '------------------------PANTALLA 3 ----------------------'
1 '---------------------------------------------------------'
1 'Objetivo coger 3 paquete y que no te pillen'
    12300 pc= 3:ev(0)=7
12310 return
1 '---------------------------------------------------------'
1 '------------------------PANTALLA 4 ----------------------'
1 '---------------------------------------------------------'
1 'Objetivo coger 3 paquete y que no te pillen'
    12400 pc= 3:ev(0)=5
12410 return
1 '---------------------------------------------------------'
1 '------------------------PANTALLA 5 ----------------------'
1 '---------------------------------------------------------'
1 'Objetivo coger 3 paquete y que no te pillen'
    12500 pc= 1:ev(0)=10
12510 return
1 '---------------------------------------------------------'
1 '------------------------PANTALLA 6 ----------------------'
1 '---------------------------------------------------------'
1 'Objetivo coger 3 paquete y que no te pillen'
    12600 pc= 1:ev(0)=6
12610 return
1 '---------------------------------------------------------'
1 '------------------------PANTALLA 7 ----------------------'
1 '---------------------------------------------------------'
1 'Objetivo coger 3 paquete y que no te pillen'
    12700 pc= 1:ev(0)=5
12710 return
1 '---------------------------------------------------------'
1 '------------------------PANTALLA 8 ----------------------'
1 '---------------------------------------------------------'
1 'Objetivo coger 3 paquete y que no te pillen'
    12800 pc= 1:ev(0)=5
12810 return


1 '-----------------------------------------------------------------------------------------'
1 '--------------------------------------MUNCO 2 -------------------------------------------'
1 '-----------------------------------------------------------------------------------------'



