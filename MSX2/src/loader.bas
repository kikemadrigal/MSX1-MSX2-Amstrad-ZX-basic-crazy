1 'Inicilizamos dispositivo: 003B, inicilizamos teclado: 003E'
10 defusr=&h003B:a=usr(0):defusr1=&h003E:a=usr1(0):defusr2=&H90:a=usr2(0)
20 defusr3=&H41:defusr4=&H44
1 ' color letra negro, fondo letra: azul claro, borde blanco, quitamos las letras que aparecen abajo'
30 color 1,7,15:key off:defint a-z
40 screen 5,2,0
50 open "grp:" as #1
60 print #1,"Cargando xbasic"
70 bload"xbasic.bin",r
1 'Cargamos los sprites'
80 print #1,"Cargando sprites"
90 gosub 10000

490 print #1,"Cargando main"
500 load"game.bas",r



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
    10010 FOR I=0 TO 12:SP$=""
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
    10560 DATA 00,00,00,00,00,00,00,00
    10570 DATA 00,00,00,00,0F,0F,0F,00
    10580 DATA 00,00,00,00,00,00,00,00
    10590 DATA 00,00,00,00,F0,F0,F0,00
    10600 DATA 00,00,00,00,00,00,00,00
    10610 DATA 00,00,00,00,10,0A,0D,00
    10620 DATA 00,00,00,00,00,00,00,00
    10630 DATA 00,00,00,00,84,AC,70,00



11590 return