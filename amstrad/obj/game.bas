10 call &BBFF:call &BB4E:mode 1
20 cls: mode 0: border 26:ink 0,11
30 gosub 8000
40 co=0
50 gosub 5000
60 gosub 6000
70 'gosub 7000 
100 mode 1:locate 1,7:print "  @@@@   @@@@    @    @@@@   @  @ "
110 locate 1,8:       print "  @      @@     @ @    @       @  "
120 locate 1,9:       print "  @@@@   @  @  @   @  @@@@     @  "
130 locate 1,14:print "Tu mujer se ha vuelto loca porque no os vais a pasear y ha empezado a tirar tus consolas y juegos por la ventana"
140 locate 1,20:print "O/P para mover, pulsa una tecla para continuar"
150 if inkey$="" then goto 150
160 mode 0
400 cls
410 gosub 9000
    2000 gosub 2500
    2010 gosub 2600
    2020 gosub 5100
    2030 gosub 6200
    2040 'if nb>0 then go sub 7600
    2050 'gosub 2800
2090 go to 2000
    2500 if inkey$="o" then x=x-1:ps$=s$(3)
    2550 if inkey$="p" then x=x+1:ps$=s$(5)
    2580 if inkey$="" then ps$=s$(2)
2590 return
    2600 if x=0 then x=1
    2610 IF y=0 then y=1
2690 return
    2800 'nada'
2820 return
    5000 x=10:y=19:ps$=s$(2)
5030 return
    5100 locate x,y:print ps$
5110 return
    6000 ex=10:ey=6:es$=s$(1)
6050 return
    6200 locate ex,ey:print es$
6290 return
    8000 symbol after 246
    8010 SYMBOL 246,255,255,255,66,90,90,126,60
    8020 s$(0)=" "+chr$(246)+" "
    8030 SYMBOL 247,0,0,0,0,24,24,126,189
    8040 s$(1)=" "+chr$(247)+" "
    8050 SYMBOL 248,0,66,90,126,24,24,36,36
    8060 s$(2)=" "+chr$(248)+" "
    8070 SYMBOL 249,0,24,24,60,60,60,40,40
    8080 s$(3)=" "+chr$(249)+" "
    8090 SYMBOL 250,0,24,24,60,60,60,24,24
    8100 s$(4)=" "+chr$(250)+" "
    8110 SYMBOL 251,0,24,24,60,60,60,20,20
    8120 s$(5)=" "+chr$(251)+" "
    8130 SYMBOL 252,0,24,24,60,60,60,24,24
    8140 s$(6)=" "+chr$(252)+" "
    8150 SYMBOL 253,0,0,0,0,255,255,255,255
    8160 s$(7)=" "+chr$(253)+" "
8190 return
    9000 move 2*32,2*32
    9010 drawr 0,7*32, 4
    9020 drawr 16*32,0,4
    9030 drawr 0,-7*32,4
    9040 move 3*32,10*32
    9050 drawr 0,1*32, 4
    9060 drawr 14*32,0, 4
    9070 drawr 0,-1*32, 4
9080 return
    
