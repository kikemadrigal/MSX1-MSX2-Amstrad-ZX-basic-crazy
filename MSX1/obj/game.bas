10 color 1,7,15:key off:open "grp:" as #1
20 cls:screen 2,0,0
25 defusr=&h003B:a=usr(0):defusr1=&h003E:a=usr1(0)
30 gosub 10000
40 co=0
50 gosub 5000
60 gosub 6000
70 gosub 7000 
100 preset (10,30):  print #1,"@@@@   @@@@    @    @@@@   @  @ "
110 preset (10,40):  print #1,"@      @@     @ @    @       @  "
120 preset (10,50):  print #1,"@@@@   @  @  @   @  @@@@     @  "
130 preset (10,120): print #1,"Tu mujer se ha vuelto loca porque no os vais a pasear y ha empezado a tirar tus consolas y juegos por la ventana"
140 preset (10,160): print #1, "Cursores para mover, pulsa una tecla para continuar"
150 if inkey$="" then goto 150
400 cls
430 gosub 9000
440 'on strig gosub 11100:strig(0) on
460 'on interval=50 gosub 9000:interval on:time=0
    2000 gosub 2500
    2020 gosub 5100
    2030 gosub 6200
    2040 if nb>0 then gosub 7600
    2050 'gosub 2800
2090 go to 2000
    2500 'px=x:py=y 
    2510 on stick(0) gosub 2510,2510,2550,2510,2510,2510,2570
    2520 if stick(0)=0 then ps=2
2530 return
2550 x=x+8:ps=4:return
2570 x=x-8:ps=3:return
    2600 ' nada'
2690 return
    2700 'nada'
2790 return
    2800 preset(0,180) :print #1,"Time "co", nb: "nb", ex: "int(ex)
2890 return
    5000 x=15*8:y=18*9:pp=0:ps=2
5030 return
    5100 put sprite pp,(x,y),1,ps
5110 return
    6000 ex=16*8:ey=5*9
    6010 epx=0:epy=0
    6030 ep=1:es=1
6050 return
    6200 co=co+1
    6210 epx=ex:epy=ey
    6220 if co mod 10=0 then ex=rnd(1)*(160-50)+50:preset (epy,epx):print #1," ":co=0: gosub 7500
    6230 'if contador<10 then print at ey,ex;b$
    6240 'go sub 9100
    6250 put sprite 1,(ex,ey),1,es
6290 return
    7000 dim x(10), y(10):nb=1:bs=7
7010 return
    7500 nb=nb+1
    7510 x(nb)=ex:y(nb)=ey
7590 return
    7600 for i=1 to nb-1
        7610 if y(i)>190 then y(i)=y(nb):x(i)=x(nb):nb=nb-1:preset(x(i),y(i)+1):print #1," "
        7620 y(i)=y(i)+8
        7630 preset (y(i),x(i)):put sprite 2+i,(x(i),y(i)),1,bs:preset (x(i),y(i)-1):print #1," "
    7640 next i
7690 return
    10000 RESTORE
    10010 FOR I=0 TO 7:SP$=""
        10020 FOR J=1 TO 8:READ A$
            10025 SP$=SP$+CHR$(VAL("&H"+A$))
        10030 NEXT J
        10040 SPRITE$(I)=SP$
    10050 NEXT I
    10060 return 
    8050 DATA FF,FF,FF,42,5A,5A,7E,3C
    8060 DATA 00,00,00,00,18,18,7E,BD
    8070 DATA 00,42,5A,7E,18,18,24,24
    8080 DATA 00,18,18,3C,3C,3C,28,28
    8090 DATA 00,18,18,3C,3C,3C,18,18
    8100 DATA 00,18,18,3C,3C,3C,14,14
    8110 DATA 00,18,18,3C,3C,3C,18,18
    8120 DATA 00,00,00,00,FF,FF,FF,FF
8190 return
    9000 LINE(0,160)-(256,170),3,bf
    9010 draw ("bm40,160c1u100")
    9020 draw ("r180d100")
    9030 draw("bm50,60u20r160d20")
9090 return
