@echo off




rem le ponemos el nombre al juego, máximo 9 caracteres
set nombre_juego=game
rem Aunque no hacen falta copiamos todos los archivos.bas de la carpeta src
rem los pegamos en obj (objects) y mostramos un mensajito
rem for /R src %%a in (*.bas) do (
rem     copy "%%a" obj & echo %%a)

rem Le quitamos los comentarios a game.bas
java -jar tools/deletecomments/deletecomments1.2.jar src/main.bas obj/game.bas  


rem convertimos nuestro .bas en .tap
start /wait tools/bas2tap/bas2tap -c obj/game.bas -a10 -s%nombre_juego%


rem abrimos el emulador
start /wait tools/fuse/fuse.exe --machine plus2 --graphics-filter 2x -tape obj/game.tap