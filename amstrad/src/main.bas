1 '    -------------------- '
1 '           CRAZY         '
1 '     BASIC MURCIA 2020   '
1 '    -------------------- '
1 ' Main                       10'
1 ' Welcome screen y records  100'
1 ' winning screen            200'
1 ' Game over                 300'
1 ' Screen 1                  400'
1 ' Main loop:               2000'
1 ' Input system:            2500'
1 ' Colision system          2600'
1 ' GUI/HUD'                 2800'
1 ' Player: --init:          5000'
1 '        |__update         5100'
1 ' Enemy:  --init:          6000'
1 '        |__update:        6200'
1 ' Fire: --init:            7000'
1 '       |_create:          7500'
1 '       --update:          7600'
1 ' Sprite definitions:      8000'
1 ' Maps definitions:       9000~'


1 ' Configuración global'
1 'inicializamos el sistema y la pantalla'
10 call &BBFF:call &BB4E:mode 1
20 cls: mode 0
30 gosub 8000

40 locate 9,5:print s$(1)
50 locate 9,18:print s$(2)


100 goto 100













1 '---------------------------------------------------------'
1 '------------------------SPRITES -------------------------'
1 '---------------------------------------------------------'

1' Rutina definir 
    1 'Vamos a crear nuestros sprites a partir del caracter 246, para eso es necesario especificarselo a amstrad'
    8000 symbol after 246
    1 '1 sprite de la mujer 1'
    8010 SYMBOL 246,255,255,255,66,90,90,126,60
    8020 s$(0)=" "+chr$(246)+" "
    1 'sprite de la mujer 2'
    8030 SYMBOL 247,0,0,0,0,24,24,126,189
    8040 s$(1)=" "+chr$(247)+" "
    1 'player mirando al frente para coger el paquete'
    8050 SYMBOL 248,0,66,90,126,24,24,36,36
    8060 s$(2)=" "+chr$(248)+" "
    1 'player mirando a la izquierda 1'
    8070 SYMBOL 249,0,24,24,60,60,60,40,40
    8080 s$(3)=" "+chr$(249)+" "
    1 'player mirando a la izquierda 2'
    8090 SYMBOL 250,0,24,24,60,60,60,24,24
    8100 s$(4)=" "+chr$(250)+" "
    1 'player miando a la derecha 1'
    8110 SYMBOL 251,0,24,24,60,60,60,20,20
    8120 s$(5)=" "+chr$(251)+" "
    1 'player miando a la derecha 2'
    8130 SYMBOL 252,0,24,24,60,60,60,24,24
    8140 s$(6)=" "+chr$(252)+" "
    1 'paquete'
    8150 SYMBOL 253,0,0,0,0,255,255,255,255
    8160 s$(7)=" "+chr$(253)+" "
8190 return

 



