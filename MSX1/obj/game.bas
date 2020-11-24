80 defint a-z
90 gosub 11000
120 co=0:re=0:in$=""
130 gosub 5000
140 gosub 6000
150 gosub 7000 
170 'gosub 11500
180 'print #1,"Loading tilset word 0"
400 a=usr3(0)
420 bload"tilesw0.bin",s
425 gosub 11100
430 gosub 11300
450 a=usr4(0)
490 'on sprite gosub 2700:sprite on
500 gosub 2800:gosub 2900
510 'bload"music.bin":defusr2=&h9500:a=usr2(0):defusr3=&h9509
520 strig(0) on:on strig gosub 5200
530 time=0
540 'on interval=50 gosub 2900
    2000 gosub 2500
    2010 gosub 2600
    2020 gosub 5100
    2030 gosub 6200
    2040 GOSUB 6600
    2041 for ft=0 to fa-1
        2050 gosub 7700
        2060 gosub 7800
    2062 next ft
    2070 if pc=0 then ml=ml+1: gosub 11300
    2080 'if co mod 10=0 then gosub 2900
2090 goto 2000
    2200 a=usr3(0)
2220 return
    2300 a=usr2(0)
    2310 if re=1 then PLAY"O5 L8 V4 M8000 A A D F G2 A A A A r60 G E F D C D G R8 A2 A2 A8","o1 v4 c r8 o2 c r8 o1 v6 c r8 o2 v4 c r8 o1 c r8 o2 v6 c r8"
    2350 if re=5 then play "l10 o4 v4 g c"
    2360 if re=6 then play"t250 o5 v12 d v9 e" 
    2370 if re=7 then play "O5 L8 V4 M8000 A A D F G2 A A A A"
    2380 if re=8 then PLAY"S1M2000T150O7C32"
   
    2390 if re=9 then PLAY"o2 l64 t255 v10 m6500 c"
    2400 if re=10 then sound 6,5:sound 8,16:sound 12,6:sound 13,9
    2410 'for i=0 to 100: next i: a=usr2(0)
2420 return
    2500 'pj=player jump indica si el player está saltando para desactivar la comprobación del teclado
    2510 if pj=0 then on stick(0) gosub 2580,2500,2550,2500,2590,2500,2570
    2520 if stick(0)=0 then ps=1
2530 return
    2550 px=px+pv:ps=3
    2560 if co mod 2=0 then ps=ps+1
2565 return
    2570 px=px-pv:ps=5
    2572 if co mod 2=0  then ps=ps+1
2573 return
    2580 py=py-pv:ps=2
    2582 if co mod 2=0  then ps=ps+1
2585 return
    2590 py=py+pv:ps=2:
    2592 if co mod 2=0  then ps=ps+1
2595 return
    2600 if px>256-16 then px=256-16
    2610 if px<=0 then px=0
    2620 if py<136 then py=136
    2630 if py>192-16 then py=192-16
    2640 for i=0 to fa-1
        2650 if px < fx(i) + fw and  px + pw > fx(i) and py < fy(i) + fh and ph + py > fy(i) then gosub 2700
    2660 next i
    2670 if en=1 then if px < ex(1) + fw and  px + pw > ex(1) and py < ey(1) + fh and ph + py > ey(1) then pe=pe-1:beep:gosub 2900
2690 return
    2700 re=6: gosub 2300: pc=pc-1:gosub 7600
    2710 line (120,20)-(180,30),3,bf
    2720 preset (120,20):  print #1,"Capurado!!!"
    2730 gosub 2900
2740 return
    2800 '
    2805 line (0,0)-(80,60),7,bf
    2806 PRESET(10,15):PRINT#1,"Energy: "
    2810 PRESET(10,25):PRINT#1,"level: "
    2820 PRESET(10,35):PRINT#1,"faltan: "
    2830 'PRESET(10,35):PRINT#1,"Vidas: "
    2850 'PRESET(10,45):PRINT#1,"jump: "
2860 return
    2900 line (80,0)-(256,60),7,bf
    2960 PRESET(80,15):PRINT#1,pe
    2970 PRESET(80,25):PRINT#1,m1
    2980 PRESET(80,35):PRINT#1,pc
    3000 'PRESET(80,45):PRINT#1,""pj","py","po
3020 return
    5000 px=0:py=0:pw=16:ph=16:pv=8:pj=0:po=py:pe=100
    5010 pp=0:ps=1
    5030 pc=0:pe=0
5040 return
    5100 put sprite pp,(px,py),1,ps
    5110 'put sprite pp+1,(px,py),11,0
    5120 'if pj=1 and py<po-16 then py=py-2
    5130 if pj=1 and py<po then py=py+2
    5140 if pj=1 and py=po then pj=0:strig(0)on
5190 return
    5200 re=10: gosub 2300
    5210 po=py:py=py-12:pj=1:strig(0)off
5290 return
    
    6000 ex(0)=16*8:ey(0)=5*17
    6005 ex(1)=255:ey(1)=160
    6006 ex(2)=0:ey(2)=140
    6010 'epx=0:epy=0
    6015 ev(0)=40:ev(1)=8:ev(2)=8
    6020 er(0)=0:'nu(0)=0
    6030 ep(0)=1
    6035 es(0)=9:es(1)=13
    6040 en=0:et(0)=0
    6050 dim e(13),c(13)
    6060 e(0)=8*2:c(0)=8*10:  e(1)=8*7:c(1)=8*10:  e(2)=8*10:c(2)=8*10: e(3)=8*12:c(3)=8*10: e(4)=8*20:c(4)=8*10
    6070 e(5)=8*2:c(5)=8*12:  e(6)=8*7:c(6)=8*12:  e(7)=8*10:c(7)=8*12: e(8)=8*12:c(8)=8*12: e(9)=8*20:c(9)=8*12
    6080 e(10)=8*17:c(10)=8*14:  e(11)=8*20:c(11)=8*14:  e(12)=8*25:c(12)=8*14
    6010 a=rnd(-time)
6090 return
    6200 co=co+1
    6210 ep(0)=3:es(0)=9
    6250 if co mod ev(0)=0 and er(0)=0 and fa<>fm-1 then co=0:ex(0)=rnd(1)*(160-50)+50:es(0)=es(0)+1:re=5:gosub 2300:gosub 7500
    6260 if co mod ev(0)=0 and er(0)=1 and fa<>fm-1 then co=0:ex(0)=e(rnd(1)*13):ey(0)=c(rnd(1)*13):es(0)=es(0)+1:re=5:gosub 2300:gosub 7500
    6270 if en=1 then gosub 6300
6290 return
    6300 ex(1)=ex(1)-ev(1)
    6305 if co mod 2=0 then es(1)=14
    6310 if co mod 2<>0 then es(1)=13
    6320 if ex(1)<0 then ex(1)=255:ey(1)=rnd(-time)*(192-140)+140:gosub 2900
6390 return
    6600 put sprite ep(0),(ex(0),ey(0)),1,es(0)
    6620 'put sprite ep(0)+1,(ex(0),ey(0)),11,8
    6630 if en=1 then put sprite 5,(ex(1),ey(1)),1,es(1)
    6640 if en=2 then put sprite 5,(ex(1),ey(1)),1,es(1) :put sprite 6,(ex(2),ey(2)),1,es(2)
6690 return
    7000 fa=0:fm=4:fw=8:fh=2::fs=11:fp=11:fi=fs:fv=0:fd=0
    7010 dim fx(fm),fy(fm),fm(fm),fp(fm),fs(fm),fc(fm),ft(fm)
7020 return
    7500 if fp+fa=fi+fm then fp=fs
    7510 fp=fs+fa+1
    7520 fp(fa)=fp
    7530 fs(fa)=fs
    7535 fx(fa)=ex(0):fy(fa)=ey(0)+8
    7540 fc(fa)=rnd(-tile)*(9-4)+4
    7545 line (120,20)-(180,30),7,bf
    7550 if fm(ft)=0 then fc(ft)=4:preset (125,25): print #1,"MSX"
    7555 if fm(ft)=1 then fc(ft)=5:preset (125,25): print #1,"Amstrad"
    7560  if fm(ft)=2 then fc(ft)=6:preset (125,25): print #1,"Spectrum"
    7565  if fm(ft)=3 then fc(ft)=7:preset (125,25): print #1,"Atari"
    7570  if fm(ft)=3 then fc(ft)=8:preset (125,25): print #1,"Comodore"
    7575  if fm(ft)=3 then fc(ft)=9:preset (125,25): print #1,"Amiga"
    7580 fa=fa+1
    7685 'gosub 2900
7590 return
    7600 if fa<=0 then return
    7610 fp(fd)=fp(fa-1):fx(fd)=-16: fy(fd)=fy(fa-1): fc(fd)=fc(fa-1):fs(fd)=fs(fa-1)
    7620 fa=fa-1:fp=fp-1
    7625 re=9:gosub 2300
    7630 'gosub 2900
7690 return
    7700 if fa<0 then return
        7720 fy(ft)=fy(ft)+fv
        7730 if fy(ft)>155 then fs(ft)=fs(ft)+1
        7740 if fy(ft)>160 then gosub 7600
7790 return
    7800 if fa<=0 then return
    7810 put sprite fp(ft),(fx(ft),fy(ft)),fc(ft),fs(ft)
7890 return 
    11000 mw=0:ml=0:ms=0:mm=9:mc=0:md=0
    11010 dim mf(512,9)
11020 return
    11100 bload"world0.bin",r
    11110 md=&hd001
    11120 for i=0 to mm-1
        11130 for j=0 to 511
            11140 tn=peek(md):md=md+1
            11150 mf(j,i)=tn
        11170 next j
    11180 next i
11190 return
    11300  bload"world0.bin",r:if ml=3 then ml=0
    11310 'a=usr3(0)
    11320 '_turbo on(mf(),ml)
    11330 if ml=0 then gosub 12000
    11331 if ml=1 then gosub 12100:re=7:gosub 2300
    11332 if ml=2 then gosub 12200:re=7:gosub 2300
    11350 for i=0 to 512
        11360 vpoke 6144+256+i,mf(i,ml)
    11380 next i 
    11420 '_turbo off
    11440 'a=usr4(0)
11490 return
    11500 cls:preset (10,30):  print #1,"@@@@   @@@@    @    @@@@   @  @ "
    11510 preset (10,40):  print #1,"@      @@     @ @    @       @  "
    11520 preset (10,50):  print #1,"@@@@   @  @  @   @  @@@@     @  "
    11530 preset (10,120): print #1,"Tu mujer se ha vuelto loca porque no os vais a pasear y ha empezado a tirar tus consolas y juegos por la ventana"
    11540 preset (10,160): print #1, "Cursores para mover, pulsa una tecla para continuar"
    11560 preset (10,180): print #1, "libre: "fre(0)
    11570 re=1:gosub 2300
    11580 if inkey$="" then goto 11570 else a=usr2(0)
11590 return
    11600 'nada
11610 return
    11700 'nada'
11710 return
    11800 'nada'
11810 return
    11900 LINE(0,160)-(256,170),3,bf
    11910 draw ("bm40,160c1u100")
    11920 draw ("r180d100")
    11930 draw("bm50,60u20r160d20")
11940 return
    12000 in$="Coger paquetes"
    12050 pc=5:pe=30:er=0
    12010 px=100:py=150
    12020 en=1
    12030 ev(0)=15
    12040 fv=8
12090 return
    12100 fa=0
    12110 en=0:ex(0)=8*7:ey(0)=8*10:er(0)=1
    12120 pc=5
    12130 gosub 2900
12190 return
    12200 pc=3:fa=0
    12210 ev(0)=20:er(0)=0
12210 return
    12300 pc= 3:ev(0)=7
12310 return
    12400 pc= 3:ev(0)=5
12410 return
    12500 pc= 1:ev(0)=10
12510 return
    12600 pc= 1:ev(0)=6
12610 return
    12700 pc= 1:ev(0)=5
12710 return
    12800 pc= 1:ev(0)=5
12810 return
