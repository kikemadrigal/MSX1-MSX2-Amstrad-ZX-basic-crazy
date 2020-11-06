@echo off
set TARGET_DSK=disco.dsk

if exist %TARGET_DSK% del /f /Q %TARGET_DSK%
copy tools\Disk-Manager\main.dsk .\%TARGET_DSK%



rem Copiando todos los archivos.bas de la carpeta src
rem los pegamos en objects y mostramos un mensajito
for /R src %%a in (*.bas) do (
    copy "%%a" obj & echo %%a)
rem Copiando todos los archivos.bin de la carpeta bin
rem los pegamos en objects y mostramos un mensajito
for /R bin %%a in (*.bin) do (
    copy "%%a" obj & echo %%a)


rem Le quitamos los comentarios a game.bas
java -jar tools/deletecomments/deletecomments1.2.jar src/main.bas obj/game.bas  

rem Lo tokenizamos
rem start /wait tools/tokenizer/msxbatoken.py obj/game.asc obj/game.bas 


rem añadimos todos los .bas de la carpeta obj al disco
rem por favor mirar for /?
for /R obj/ %%a in (*.bas) do (
    start /wait tools/Disk-Manager/DISKMGR.exe -A -F -C %TARGET_DSK% "%%a")   

rem añadimos todos los arhivos binarios de la carpeta bin al disco
rem recuerda que un sc2, sc5, sc8 es también un archivo binario, renombralo
rem por favor mirar for /?
for /R bin/ %%a in (*.bin) do (
    start /wait tools/Disk-Manager/DISKMGR.exe -A -F -C %TARGET_DSK% "%%a")   

rem abrimos nuestro emulador preferido
rem copy %TARGET_DSK% tools\emulators\BlueMSX
rem start /wait tools/emulators/BlueMSX/blueMSX.exe -diska %TARGET_DSK%
rem start /wait emulators/fMSX/fMSX.exe -diska %TARGET_DSK%


rem MSX 1
rem start /wait tools/emulators/openmsx/openmsx.exe  -ext Sony_HBD-50 -ext ram32k -diska %TARGET_DSK% 
rem start /wait tools/emulators/openmsx/openmsx.exe -script tools/emulators/openmsx/emul_start_config.txt
rem MSX2
start /wait tools/emulators/openmsx/openmsx.exe -machine Philips_NMS_8255 -diska %TARGET_DSK%
rem MSX2+
rem start /wait tools/emulators/openmsx/openmsx.exe -machine Sony_HB-F1XV -diska %TARGET_DSK%