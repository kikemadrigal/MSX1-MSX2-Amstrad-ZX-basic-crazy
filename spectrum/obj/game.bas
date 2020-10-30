10 bright 1: border 7: paper 5:ink 0
20 cls
30 go sub 8000
40 let contador=0
50 go sub 5000
60 go sub 6000
70 go sub 7000 
100 print at 7,0; ink 2;paper 6;"@@@@   @@@@    @    @@@@   @  @ "
110 print at 8,0; ink 2;paper 6;"@      @@     @ @    @       @  "
120 print at 9,0; ink 2;paper 6;"@@@@   @  @  @   @  @@@@     @  "
130 print at 14,0; "Tu mujer se ha vuelto loca porque no os vais a pasear y ha empezado a tirar tus consolas y juegos por la ventana"
140 print at 20,0;inverse 1; "O/P para mover, pulsa una tecla para continuar"
150 if inkey$="" then go to 150
400 cls
410 go sub 9000
    2000 go sub 2500
    2020 go sub 5100
    2030 go sub 6200
    2040 if nb>0 then go sub 7600
    2050 go sub 2800
2090 go to 2000
    2500 if inkey$="o" then let x=x-1:let s$=d$
    2550 if inkey$="p" then let x=x+1:let s$=f$
    2580 if inkey$="" then let s$=c$
2590 return
    2800 print at 20,0;"time: ";contador;" nb: ";int(nb);" ex= ";int(ex);"       "
2820 return
    5000 let x=15:let y=18:let c$=c$
    5010 let d$=d$:let e$=e$:let f$=f$
    5020 let g$=f$:let s$=c$
5030 return
    5100 print at y,x;s$
5110 return
    6000 let ex=16:let ey=5
    6010 let epx=0:let epy=0
    6030 let a$=a$:let b$=b$
    6040 let t$=b$
6050 return
    6200 let contador=contador+1
    6210 let epx=ex:let epy=ey
    6220 if contador=10 then let ex=rnd*(27-5)+5:print at epy,epx;" ":let contador=0: go sub 7500
    6230 if contador<10 then print at ey,ex;b$
    6240 go sub 9100
6290 return
    7000 dim x(10):dim y(10):let nb=1
7010 return
    7500 let nb=nb+1
    7510 let x(nb)=ex: let y(nb)=ey
7590 return
    7600 for i=1 to nb-1
        7610 if y(i)>19 then let y(i)=y(nb):let x(i)=x(nb):let nb=nb-1:print at y(i)+1,x(i);" "
        7620 let y(i)=y(i)+1
        7630 print at y(i),x(i);h$:print at y(i)-1,x(i);" "
    7640 next i
7690 return
    8000 FOR i=0 TO 7
        8010 READ bits
        8020 POKE USR "a"+i,bits
    8030 NEXT i
    8040 let a$=" "+chr$ 144+" "
    8050 FOR i=0 TO 7
        8060 READ bits
        8070 POKE USR "b"+i,bits
    8080 NEXT i
    8090 let b$=chr$ 145
    8100 FOR i=0 TO 7
        8110 READ bits
        8120 POKE USR "c"+i,bits
    8130 NEXT i
    8140 let c$=" "+chr$ 146+" "
    8150 FOR i=0 TO 7
        8160 READ bits
        8170 POKE USR "d"+i,bits
    8180 NEXT i
    8190 let d$=" "+chr$ 147+" "
    8200 FOR i=0 TO 7
        8210 READ bits
        8220 POKE USR "e"+i,bits
    8230 NEXT i
    8240 let e$=" "+chr$ 148+" "
    8250 FOR i=0 TO 7
        8260 READ bits
        8270 POKE USR "f"+i,bits
    8280 NEXT i
    8290 let f$=" "+chr$ 149+" "
    8300 FOR i=0 TO 7
        8310 READ bits
        8320 POKE USR "g"+i,bits
    8340 NEXT i
    8350 let g$=" "+chr$ 150+" "
    8360 FOR i=0 TO 7
        8370 READ bits
        8380 POKE USR "h"+i,bits
    8390 NEXT i
    8400 let h$=chr$ 151
    8520 DATA 255,255,255,66,90,90,126,60
    8530 DATA 0,0,0,0,24,24,126,189
    8540 DATA 0,66,90,126,24,24,36,36
    8560 DATA 0,24,24,60,60,60,40,40
    8570 DATA 0,24,24,60,60,60,24,24
    8580 DATA 0,24,24,60,60,60,20,20
    8590 DATA 0,24,24,60,60,60,24,24
    8600 DATA 0,0,0,0,255,255,255,255
8700 return
    9000 for i=0 to 31: print at 19,i;paper 4;" ":next i
    9010 plot 8*4,8*3: draw 0,100: draw 190,0:draw 0,-100
    9020 plot 8*6,8*16: draw 0,20: draw 160,0:draw 0,-20
9090 return
    9100 plot 30,125:draw 190,0
9110 return
