@echo off


rem Aunque no hacen falta copiamos todos los archivos.bas de la carpeta src
rem los pegamos en obj (objects) y mostramos un mensajito
for /R src %%a in (*.bas) do (
     copy "%%a" obj & echo %%a)

rem Le quitamos los comentarios a game.bas
rem para ejecitar el comando java tienes que tener instalado java en tu pc, prueba poniendo java -version
java -jar tools/deletecomments/deletecomments1.2.jar src/main.bas obj/game.bas  


rem conertimos nuestro .bas a dsk
rem Para la ayuda leete el archivo ManageDsk_En.txt que estla en el directorio tools/MangeDsk/ManageDsk
rem -C crea un nuevo dsk, -A añade el archivo -S le pone el nombre que le digamos
rem ejemplo añadir archivos: ManageDsk -LOld.dsk -A*.BAS -A*.BIN -SNew.dsk
start /wait tools/MangeDsk/ManageDsk -C -Aobj\loader.bas -Sdisco.dsk
start /wait tools/MangeDsk/ManageDsk -Ldisco.dsk -Aobj\game.bas -Sdisco.dsk


rem abrimos el emulador
rem por favor, pon RetroVirtualMachine -h para ver la ayuda
start /wait tools/rvm/RetroVirtualMachine -b=cpc6128 -w -i disco.dsk -c=run"game.bas\n 