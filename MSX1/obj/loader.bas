
1 'Inicilizamos dispositivo: 003B, inicilizamos teclado: 003E'
10 defusr=&h003B:a=usr(0):defusr1=&h003E:a=usr1(0):defusr2=&H90:a=usr2(0)
20 defusr3=&H41:defusr4=&H44
1 ' color letra negro, fondo letra: azul claro, borde blanco, quitamos las letras que aparecen abajo'
30 color 1,7,15:key off:defint a-z
40 screen 2,2,0
50 open "grp:" as #1
60 print #1,"Loading xbasic"
70 bload"xbasic.bin",r
80 print #1,"Loading sprites"
1 'Cargamos los sprites'
90 gosub 10000
100 'print #1,"Loading tilemap word 0"
110 dim mf(512,9):gosub 11100
120 print #1,"Loading game"
130 load"game.bas",r



1 '---------------------------------------------------------'
1 '------------------------Carga de srites------------------'
1 '---------------------------------------------------------'


1 ' Patrones:'
1 'Plano 0. Player--sprites del 1 al 7'
1 'Plano 1 player 2 sprite, sprite num.0'
1 'Plano 2. Mujer---sprite 8 (para el color),9 y 10 '
1 'Plano del 10 hasta el 22 para los paquetes. sprites 11 y 12 '
1 'Rutina cargar sprites con datas basic'
    10000 RESTORE
    1 ' vamos a meter 5 definiciones de sprites nuevos que serán 4 para el personaje y uno para la bola'
    10010 FOR I=0 TO 14:SP$=""
        10020 FOR J=1 TO 32:READ A$
            10025 SP$=SP$+CHR$(VAL("&H"+A$))
        10030 NEXT J
        10040 SPRITE$(I)=SP$
    10050 NEXT I
    10060 return 
    1 ' Mujer tirando el paquete'
    10120 DATA 00,00,00,00,00,00,00,00
    10130 DATA 01,01,01,00,00,00,00,00
    10140 DATA 00,00,00,00,00,00,00,00
    10150 DATA 80,80,80,00,00,00,00,00
    10160 DATA 00,00,00,00,00,11,11,0C
    10170 DATA 03,03,03,01,01,01,02,00
    10180 DATA 00,00,00,00,00,88,88,20
    10190 DATA C0,C0,C0,80,80,80,40,00
    10200 DATA 00,00,00,00,00,01,01,00
    10210 DATA 03,03,03,01,01,01,02,00
    10220 DATA 00,00,00,00,00,80,80,00
    10230 DATA C0,C0,C0,80,80,80,40,00
    10240 DATA 00,00,00,00,00,01,01,00
    10250 DATA 03,03,03,01,01,01,01,00
    10260 DATA 00,00,00,00,00,80,80,00
    10270 DATA C0,C0,C0,80,80,80,80,00
    10280 DATA 00,00,00,00,00,01,01,00
    10290 DATA 03,03,03,01,02,02,03,00
    10300 DATA 00,00,00,00,00,80,80,00
    10310 DATA C0,C0,E0,80,40,40,60,00
    10320 DATA 00,00,00,00,00,01,01,00
    10330 DATA 03,03,03,01,01,01,01,00
    10340 DATA 00,00,00,00,00,80,80,00
    10350 DATA C0,C0,E0,80,80,80,C0,00
    10360 DATA 00,00,00,00,00,01,01,00
    10370 DATA 03,03,07,01,02,02,06,00
    10380 DATA 00,00,00,00,00,80,80,00
    10390 DATA C0,C0,C0,80,40,40,C0,00
    10400 DATA 00,00,00,00,00,01,01,00
    10410 DATA 03,03,07,01,01,01,03,00
    10420 DATA 00,00,00,00,00,80,80,00
    10430 DATA C0,C0,C0,80,80,80,80,00
    10440 DATA 00,00,00,00,00,01,02,02
    10450 DATA 02,00,00,00,00,00,00,00
    10460 DATA 00,00,00,00,00,C0,20,20
    10470 DATA 20,00,00,00,00,00,00,00
    10480 DATA 00,00,01,01,00,01,02,02
    10490 DATA 02,00,00,00,00,00,00,00
    10500 DATA 00,00,C0,C0,80,C0,20,20
    10510 DATA 20,00,00,00,00,00,00,00
    10520 DATA 00,0F,0F,0F,04,05,05,03
    10530 DATA 00,00,00,00,00,00,00,00
    10540 DATA 00,F8,F8,F8,10,D0,D0,60
    10550 DATA 00,00,00,00,00,00,00,00


    10560 DATA FF,FE,00,00,00,00,00,00
    10570 DATA 00,00,00,00,00,00,00,00
    10580 DATA 00,00,00,00,00,00,00,00
    10590 DATA 00,00,00,00,00,00,00,00

    10600 DATA 85,56,00,00,00,00,00,00
    10610 DATA 00,00,00,00,00,00,00,00
    10620 DATA 00,00,00,00,00,00,00,00
    10630 DATA 00,00,00,00,00,00,00,00

    10640 DATA 00,00,00,00,00,00,06,04
    10650 DATA 0C,3C,3F,0F,1E,28,18,00
    10660 DATA 00,00,00,00,00,00,00,00
    10670 DATA 30,20,E0,C0,60,60,C0,00

    10680 DATA 00,00,00,00,00,00,06,04
    10690 DATA 0C,3C,3F,0F,0E,14,22,00
    10700 DATA 00,00,00,00,00,00,00,00
    10710 DATA 00,04,FC,C0,60,70,20,00


    10720 DATA 60,40,C0,40,C0,A0,00,00
    10730 DATA 00,00,00,00,00,00,00,00
    10740 DATA 00,00,00,00,00,00,00,00
    10750 DATA 00,00,00,00,00,00,00,00

    10760 DATA C0,80,C0,80,C0,A0,00,00
    10770 DATA 00,00,00,00,00,00,00,00
    10780 DATA 00,00,00,00,00,00,00,00
    10790 DATA 00,00,00,00,00,00,00,00
11590 return



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

    11110 md=&hc001
    11120 for i=0 to mm-1
        1 'Esto se podría poner desde 0 hasta 512'
        11130 for j=0 to 511
            11140 tn=peek(md):md=md+1
            11150 mf(j,i)=tn
        11170 next j
    11180 next i
11190 return