############## P1 · Script monitor del sistema ##############
Crea un script monitor.sh que cada 5 segundos guarde en monitor.log:

La fecha y hora actual
El porcentaje de CPU en uso
Los 3 procesos que más CPU consumen

#!/bin/bash
while true; do
    echo "=== $(date) ===" >> monitor.log
    # Pista: usa ps aux --sort=-%cpu | head -4
    sleep 5
done

Resolucion, se ejecuta el archivo creacon con el comando 
sh monitos.sh -> este luego genera un archivos moinitor.log con la informacion 
se puede dejar ejecutando el script en segundo plano con el comando :
sh monitor.sh &
y revisar en tiempo real la carga de la informacion en el archivo con el comando :
tail -f
para terminar con el proceso que debe apuntar el PID que se genero al ejecutar el comando en segundo plano y ejecutar el comando:
kill <PID>


############## P2 · Analizador de errores 404 ##############
Escribe un comando (o pipeline) que:

Busque en un log de Apache (o uno simulado) todas las líneas con código 404
Cuente cuántas veces aparece cada URL solicitada
Muestre las 10 URLs más pedidas que no se encontraron
Pista: grep "404" access.log | awk '{print $7}' | sort | uniq -c | sort -rn | head -10

Resolucion:
se creo un archivo con ayuda de la IA para simular un archivo de log de apache y poder aplicar el comando de busqueda para el ejecicio

############## P3 · Script de backups con rotación ##############
Crea un script que:

Comprima el directorio practica en backup_YYYYMMDD.tar.gz
Borre automáticamente los backups de más de 7 días
#!/bin/bash
tar -czf "backup_$(date +%Y%m%d).tar.gz" practica/
# Pista para borrar viejos: find . -name "backup_*.tar.gz" -mtime +7 -delete

Resolucion : 
se creo un archivo .sh con el nombre de gen_backup_daily.sh
con el script: 
-----------
#!/bin/bash

tar -czf "backup_$(date +%Y%m%d).tar.gz" ~/pruebas
## se muestran los archivos que se van a eliminar
find . -name "backup_*.tar.gz" -exec bash -c '[[ ${1//[^0-9]/} -lt $(date -d "5 days ago" +%Y%m%d) ]]' _ {} \; -print
## luego hace la eliminacion de los archivos. 
find . -name "backup_*.tar.gz" -exec bash -c '[[ ${1//[^0-9]/} -lt $(date -d "5 days ago" +%Y%m%d) ]]' _ {} \; -delete

-----------

este se ejecutar con el comando: 
sh gen_backup_daily.sh
inicialmente genera el archivo de backup con el nombre: backup_20260416.tar.gz
para simular mas archivos previos de backup se puede usar el comando:

cp backup_20260416.tar.gz backup_20260401.tar.gz
cp backup_20260416.tar.gz backup_20260402.tar.gz

luego se vulve a ejecutar el comando de ejecucion del .sh 
y este mostrar los archivos que elimina.

awk -F: '$7=="/bin/bash"' /etc/passwd

############## P4 · Reporte de usuarios del sistema ##############
Usa awk para generar un reporte de /etc/passwd que muestre tres secciones:

Usuarios con bash como shell
Usuarios con UID mayor a 1000 (usuarios reales)
Usuarios con shell no estándar (ni bash ni sh ni nologin)

Resolucion:
1. awk -F: '$7=="/bin/bash"' /etc/passwd
2 . awk -F: '$3>1000' /etc/passwd
3 . awk -F: '$7!="/bin/bash" && $7!="/bin/sh" && $7!="/usr/sbin/nologin"' /etc/passwd

############## P5 · Buscador de logs con colores ##############
Crea un script que:

Reciba un patrón como argumento: ./buscar.sh "error"
Busque en todos los .log de /var/log
Muestre las líneas con colores: rojo para error, amarillo para warning
#!/bin/bash
# Pista: usa grep con --color=always o códigos ANSI \033[31m
grep -r "$1" /var/log/*.log 2>/dev/null | \
    sed 's/error/\o033[31m&\o033[0m/gi'

Resolucion : 
se crea un archivo con el nombre find_logs_msg.sh 
con el siguiente script: 

-------

!/bin/bash

PATRON="$1"

# Comprobamos si el usuario pasó un argumento
if [ -z "$PATRON" ]; then
    echo "Uso: $0 <patrón_a_buscar>"
    exit 1
fi


grep -rh "$PATRON" /var/log/*.log 2>/dev/null | \
    sed -e 's/'"$PATRON"'/\o033[92m&\o033[0m/gi' \
        -e 's/error/\o033[31m&\o033[0m/gi' \
        -e 's/warning/\o033[33m&\o033[0m/gi'

---------

ese script lista lo que se esta buscado, pero a los que contengan la palabra 
"error" se muestra en rojo
"warning" se muestra en amarillo
"cual otra palabra" se muestra en verde