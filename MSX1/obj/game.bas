10 defusr=&h003B:a=usr(0):defusr1=&h003E:a=usr1(0)
20 color 1,7,15:key off:defint a-z
30 screen 2,2,0
35 open "grp:" as #1
40 bload"xbasic.bin",r
50 gosub 10000
90 gosub 11200
120 let co=0
130 gosub 5000
140 gosub 6000
150 gosub 7000 
160 gosub 13200
400 vdp(1)=vdp(1) xor 64
420 bload"tileset.bin",s
430 gosub 11300
450 vdp(1)=vdp(1) or 64
470 'on strig gosub 11100:strig(0) on
480 'on interval=50 gosub 9000:interval on:time=0
490 on sprite gosub 2600:sprite on
500 gosub 2800:gosub 2900
    2000 gosub 2500
    2010 gosub 2700
    2020 gosub 5100
    2030 gosub 6200
    2040 GOSUB 6300
    2050 gosub 7600
    2060 gosub 7700
    2070 if pc=0 then ml=ml+1: gosub 11300:pc=5
2090 go to 2000
    2500 'px=x:py=y
    2510 on stick(0) gosub 2580,2500,2550,2500,2590,2500,2570
    2520 if stick(0)=0 then ps=2
2530 return
2550 x=x+pv:ps=5:return
2570 x=x-pv:ps=3:return
2580 y=y-pv:ps=3:return
2590 y=y+pv:ps=3:return
    2600 beep:sprite off: pc=pc-1:gosub 2900
    2610 line (120,20)-(180,30),7,bf
    2620 preset (120,20):  print #1,"Cogido!"
2690 return
    2700 if x>256-16 then x=256-16
    2710 if x<=0 then x=0
    2720 if y<140 then y=140
    2730 if y>192-16 then y=192-16
2740 return
    2800 '
    2805 line (0,0)-(80,60),7,bf
    2810 PRESET(10,5):PRINT#1,"level: "
    2820 PRESET(10,15):PRINT#1,"Faltan: "
    2830 'PRESET(10,25):PRINT#1,"Vidas: "
    2840 'PRESET(10,35):PRINT#1,"Modelo: "
    2850 'PRESET(10,45):PRINT#1,"num: "
2860 return
    2900 line (80,0)-(256,60),7,bf
    2960 PRESET(80,5):PRINT#1,ml
    2970 PRESET(80,15):PRINT#1,pc
    2980 'PRESET(80,25):PRINT#1,pe
    2990 'PRESET(80,35):PRINT#1,fm(0)
    3000 'PRESET(80,45):PRINT#1,ft
    3010 'PRESET(80,55):PRINT#1, "1:"y(0);",a:"fa(0)",2:"y(1)",a:"fa(1)
3020 return
    5000 x=120:y=162:px=x:py=y:pv=8
    5010 pp=0:ps=2
    5030 pc=5:pe=100
5040 return
    5100 put sprite pp,(x,y),1,ps
5110 return
    6000 ex=16*8:ey=5*17
    6010 epx=0:epy=0
    6030 ep=1:es=1
6050 return
    6200 co=co+1
    6210 epx=ex:epy=ey
    6220 if co mod 40=0 then ex=rnd(1)*(160-50)+50:co=0: gosub 7500:sprite on
6290 return
    6300 put sprite 1,(ex,ey),1,es
6310 return
    7000 ft=0:fm=5
    7010 dim x(fm), y(fm),fv(fm),fm(fm),fs(fm),fc(fm),fa(fm)
7020 return
    7500 if ft=5 then return
    7505 x(ft)=ex:y(ft)=ey+16:fv(ft)=8:fm(ft)=rnd(1)*4:fs(ft)=7:fa(ft)=1
    7510 line (120,20)-(180,30),7,bf
    7520 if fm(ft)=0 then fc(ft)=1:preset (120,20): print #1,"MSX"
    7530 if fm(ft)=1 then fc(ft)=4:preset (120,20): print #1,"Amstrad"
    7540  if fm(ft)=2 then fc(ft)=6:preset (120,20): print #1,"Spectrum"
    7550  if fm(ft)=3 then fc(ft)=13:preset (120,20): print #1,"Atari"
    7560 ft=ft+1
7590 return
    7600 if ft<=0 then return
    7605 for i=0 to ft-1
        7610 y(i)=y(i)+fv(i)
        7620 if y(i)>160 then x(i)=x(ft-1):y(i)=y(ft-1): ft=ft-1
    7640 next i
7690 return
    7700 for i=0 to ft-1
        7710 put sprite 2+i,(x(i),y(i)),fc(i),fs(i)
    7720 next i
7730 return 
    10000 RESTORE
    10010 FOR I=0 TO 7:SP$=""
        10020 FOR J=1 TO 32:READ A$
            10025 SP$=SP$+CHR$(VAL("&H"+A$))
        10030 NEXT J
        10040 SPRITE$(I)=SP$
    10050 NEXT I
    10060 return 
    10120 DATA 00,0F,0F,0F,04,05,05,03
    10130 DATA 01,01,03,06,04,07,01,01
    10140 DATA 00,F8,F8,F8,10,D0,D0,60
    10150 DATA 40,40,60,30,10,F0,40,40
    10160 DATA 00,00,00,00,00,01,01,0F
    10170 DATA 01,01,03,06,04,07,01,06
    10180 DATA 00,00,00,00,00,C0,C0,78
    10190 DATA 40,40,60,30,10,F0,40,30
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
11590 return
    11200 ml=0:ms=0:mm=1:mc=0:md=0
11220 return
    11300 if ml=0 then bload"level0.bin",r
    11310 if ml=1 then bload"level1.bin",r
    11320 _turbo on 
    11330 md=&hc001
    11340 for i=0 to mm-1
        11350 for j=6144+256 to 6912
                11360 vpoke j,peek(md)
                11370 md=md+1
        11380 next j  
    11410 next i
    11420 _turbo off
11490 return
12000 'if ml=0 then gosub 
12100 return
    12200 LINE(0,160)-(256,170),3,bf
    12210 draw ("bm40,160c1u100")
    12220 draw ("r180d100")
    12230 draw("bm50,60u20r160d20")
12240 return
    13200 cls:preset (10,30):  print #1,"@@@@   @@@@    @    @@@@   @  @ "
    13210 preset (10,40):  print #1,"@      @@     @ @    @       @  "
    13220 preset (10,50):  print #1,"@@@@   @  @  @   @  @@@@     @  "
    13230 preset (10,120): print #1,"Tu mujer se ha vuelto loca porque no os vais a pasear y ha empezado a tirar tus consolas y juegos por la ventana"
    13240 preset (10,160): print #1, "Cursores para mover, pulsa una tecla para continuar"
    13250 if inkey$="" then goto 13250
13260 return
