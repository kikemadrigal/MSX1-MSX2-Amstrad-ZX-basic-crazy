10 call &BBFF:call &BB4E:mode 1
20 cls: mode 0
30 gosub 8000
40 locate 9,5:print s$(1)
50 locate 9,18:print s$(2)
100 goto 100
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
 
