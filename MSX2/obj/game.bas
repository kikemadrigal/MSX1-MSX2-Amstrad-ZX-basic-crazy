70 print #1,"Ejecutando main"
80 defint a-z
90 gosub 11200
120 co=0:re=0
130 gosub 5000
140 gosub 6000
150 gosub 7000 
160 'a=usr3(0)
170 print #1,"Cargando tilesset"
180 cls:bload"tileset.bin",s,&h8000
190 gosub 13200
200 print #1,"Cargando mapa"
430 gosub 11300
450 'a=usr4(0)
490 on sprite gosub 2700:sprite on
500 gosub 2800:gosub 2900
510 'bload"music.bin":defusr2=&h9500:a=usr2(0):defusr3=&h9509
520 'on interval=2 gosub 2200:interval on
    2000 gosub 2500
    2010 gosub 2600
    2020 gosub 5100
    2030 gosub 6200
    2040 GOSUB 6300
    2050 gosub 7700
    2060 gosub 7800
    2070 if pc=0 then ml=ml+1: gosub 11300
    2080 'if co mod 10=0 then gosub 2900
2090 go to 2000
    2200 a=usr3(0)
2220 return
    2300 if re=1 then PLAY"O5 L8 V4 M8000 A A D F G2 A A A A r60 G E F D C D G R8 A2 A2 A8","o1 v4 c r8 o2 c r8 o1 v6 c r8 o2 v4 c r8 o1 c r8 o2 v6 c r8"
    2350 if re=5 then play "l10 o4 v4 g c"
    2360 if re=6 then play"t250 o5 v12 d v9 e" 
    2370 if re=7 then play "O5 L8 V4 M8000 A A D F G2 A A A A"
    2380 if re=8 then PLAY"S1M2000T150O7C32"
   
    2390 if re=9 then PLAY"o2 l64 t255 v4 m6500 c"
    2400 if re=10 then sound 6,5:sound 8,16:sound 12,6:sound 13,9
    2410 'for i=0 to 100: next i: a=usr2(0)
2420 return
    2500 'px=x:py=y
    2510 on stick(0) gosub 2580,2500,2550,2500,2590,2500,2570
    2520 if stick(0)=0 then 'ps=1
2530 return
    2550 px=px+pv:'ps=3
    2560 'if co mod 2=0 then ps=ps+1
2565 return
    2570 px=px-pv:'ps=5
    2572 'if co mod 2=0 then ps=ps+1
2573 return
    2580 py=py-pv:'ps=2
    2582 'if co mod 2=0 then ps=ps+1
2585 return
    2590 py=py+pv:'ps=2:
    2592 'if co mod 2=0 then ps=ps+1
2595 return
    2600 if px>256-16 then px=256-16
    2610 if px<=0 then px=0
    2620 if py<140 then py=140
    2630 if py>192-16 then py=192-16
    
2690 return
    2700 re=6: gosub 2300: pc=pc-1:sprite off:gosub 2900
    2710 line (120,20)-(180,30),7,bf
    2720 preset (120,20):  print #1,"Cogido!"
2730 return
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
    2980 'PRESET(80,25):PRINT#1,pw","ph","fw(0)","fh(0)
    2990 'PRESET(80,35):PRINT#1,"px:"px"py:"py
    3000 'PRESET(80,45):PRINT#1,ft
3020 return
    5000 px=0:py=0:pw=16:ph=16:pv=8
    5010 pp=0:ps=1
    5030 pc=5:pe=100
5040 return
    5100 put sprite pp,(px,py),9,ps
    5110 put sprite pp+1,(px,py),1+32,0
5190 return
    
    6000 ex=16*8:ey=5*17
    6010 'epx=0:epy=0
    6015 ev=40
    6020 er=0:nu=0
    6030 ep=1:es=9
    6040 et=0
    6050 dim e(13),c(13)
    6060 e(0)=8*2:c(0)=8*10:  e(1)=8*7:c(1)=8*10:  e(2)=8*10:c(2)=8*10: e(3)=8*12:c(3)=8*10: e(4)=8*20:c(4)=8*10
    6070 e(5)=8*2:c(5)=8*12:  e(6)=8*7:c(6)=8*12:  e(7)=8*10:c(7)=8*12: e(8)=8*12:c(8)=8*12: e(9)=8*20:c(9)=8*12
    6080 e(10)=8*17:c(10)=8*14:  e(11)=8*20:c(11)=8*14:  e(12)=8*25:c(12)=8*14
    6010 a=rnd(-time)
6090 return
    6200 co=co+1
    6210 ep=3:es=9
    6220 'epx=ex:epy=ey
    6250 if co mod ev=0 and er=0 then co=0:ex=rnd(1)*(160-50)+50:es=es+1:re=5:gosub 2300:gosub 7500:sprite on
    6260 if co mod ev=0 and er=1 then co=0:ex=e(rnd(1)*13):ey=c(rnd(1)*13):es=es+1:re=5:gosub 2300:gosub 7500:'sprite on
6290 return
    6300 put sprite ep,(ex,ey),1,es
    6320 put sprite ep+1,(ex,ey),11,8
6390 return
    7000 ft=0:fm=5:fip=10:fp=fip:fs=11:fd=0:fv=0
    7010 dim fx(fm),fy(fm),fw(fm),fh(fm),fm(fm),fp(fm),fs(fm),fc(fm),fa(fm)
7020 return
    7500 'nada'
    7502 fx(ft)=ex:fy(ft)=ey+16:fw(ft)=16:fh(ft)=16
    7504 fm(ft)=rnd(1)*(4-1)+1
    7505 fp=fp+1:if fp=10 then fp=fip
    7508 fp(ft)=fp:fs(ft)=fs
    7510 line (120,20)-(180,30),7,bf
    7520 if fm(ft)=0 then fc(ft)=1:preset (120,20): print #1,"MSX"
    7530 if fm(ft)=1 then fc(ft)=4:preset (120,20): print #1,"Amstrad"
    7540  if fm(ft)=2 then fc(ft)=6:preset (120,20): print #1,"Spectrum"
    7550  if fm(ft)=3 then fc(ft)=13:preset (120,20): print #1,"Atari"
    7560 fa(ft)=1
    7570 ft=ft+1
    7580 'gosub 2900
7590 return
    7600 fx(d)=fx(ft-1):fy(d)=fy(ft-1):fp(d)=fp(ft-1):fs(d)=fs(ft-1):fc(d)=fc(ft-1)
    7610 ft=ft-1
    7620 re=9:gosub 2300
    7630 'gosub 2900
7690 return
    7700 if ft=0 then return
    7710 for i=0 to ft-1
        7720 fy(i)=fy(i)+fv
        7730 if fy(i)>160-4 then fs(i)=fs(i)+1
        7740 if fy(i)>160 then fd=i:sprite off:gosub 7600
    7750 next i
7790 return
    7800 if ft=0 then put sprite 10,(-16,0),1,11: return
    7805 for i=0 to ft-1
        7810 if i=0 then put sprite 10,(fx(i),fy(i)),fc(i),fs(i)
        7820 if i=1 then  put sprite 11,(fx(i),fy(i)),fc(i),fs(i)
        7830 if i=2 then  put sprite 12,(fx(i),fy(i)),fc(i),fs(i)
    7880 next i
7890 return 
    11200 ml=0:ms=0:mm=1:mc=0:md=0:tn=0
11220 return
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
            11360 for c=0 to 15
                11370 tn=peek(md):md=md+1
                11380 if tn >=0 and tn <16 then copy (tn*16,0*16)-((tn*16)+16,(0*16)+16),1 to (c*16,f*16),0,tpset
                11390 if tn >=16 and tn <32 then copy ((tn-16)*16,1*16)-(((tn-16)*16)+16,(1*16)+16),1 to (c*16,f*16),0,tpset
                11400 if tn >=32 and tn <48 then copy ((tn-32)*16,2*16)-(((tn-32)*16)+16,(2*16)+16),1 to (c*16,f*16),0,tpset
                11510 next c
        11520 next f 
    11530 next i
    11540 _turbo off
    11550 'vdp(1)=vdp(1) or 64
    11560 'a=usr4(0)
11570 return
    12000 pc=3
    12010 px=100:py=150
    12020 en=1
    12030 ev=20
    12040 fv=8
12090 return
    12200 LINE(0,160)-(256,170),3,bf
    12210 draw ("bm40,160c1u100")
    12220 draw ("r180d100")
    12230 draw("bm50,60u20r160d20")
12240 return
    12300 'ft=0
    12310 ex=8*7:ey=8*10:er=1
    12320 pc=6
    12330 gosub 2900
12390 return
    12400 pc= 3:ev=5
12410 return
    13200 cls:preset (10,30):  print #1,"@@@@   @@@@    @    @@@@   @  @ "
    13210 preset (10,40):  print #1,"@      @@     @ @    @       @  "
    13220 preset (10,50):  print #1,"@@@@   @  @  @   @  @@@@     @  "
    13230 preset (10,120): print #1,"Tu mujer se ha vuelto loca porque no os vais a pasear y ha empezado a tirar tus consolas y juegos por la ventana"
    13240 preset (10,160): print #1, "Cursores para mover, pulsa una tecla para continuar"
    13250 preset (10,180): print #1, "libre: "fre(0)
    13260 re=1:gosub 2300
    13270 if inkey$="" then goto 13260 else a=usr2(0)
13290 return
