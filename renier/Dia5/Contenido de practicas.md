7 · Redirecciones y tuberías
Conceptos clave
En Linux, los programas tienen tres flujos de datos estándar:

Flujo	Número	Símbolo de redirección	Descripción
stdin	0	<	Entrada estándar (teclado por defecto)
stdout	1	> o >>	Salida estándar (pantalla por defecto)
stderr	2	2>	Errores (pantalla por defecto)
Operadores de redirección
Símbolo	Comportamiento	Ejemplo
>	Redirige stdout (sobrescribe)	ls > lista.txt
>>	Redirige stdout (añade al final)	echo "más" >> lista.txt
2>	Redirige stderr	cmd 2> errores.txt
2>&1	Une stderr con stdout	cmd > todo.txt 2>&1
/dev/null	Descarta la salida (agujero negro)	cmd 2>/dev/null
|	Tubería: stdout de uno → stdin del siguiente	ls | grep txt
Tuberías frecuentes
ls | wc -l                          # contar archivos
ps aux | grep bash                  # filtrar procesos
cut -d: -f1 /etc/passwd | sort      # extraer y ordenar
df -h | grep -v tmpfs               # disco sin sistemas temporales

8 · Procesos y sistema
Conceptos clave
En Linux, cada programa en ejecución es un proceso con un identificador único llamado PID (Process ID). El proceso raíz es systemd (o init) con PID 1, del que cuelgan todos los demás.

📌 Referencia de comandos
Comando	Descripción	Tip
ps aux	Lista todos los procesos	Combinar con grep
ps -ef	Formato alternativo con PPID	Muestra jerarquía
top	Monitor interactivo (salir con q)	M ordena por mem, P por CPU
htop	Versión mejorada con colores	Puede no estar instalado
kill PID	Termina proceso (señal SIGTERM)	El proceso puede ignorarla
kill -9 PID	Mata proceso a la fuerza (SIGKILL)	El proceso no puede ignorarla
jobs	Muestra procesos en segundo plano	
fg %1	Trae proceso al primer plano	
bg %1	Envía proceso al segundo plano	
comando &	Lanza en segundo plano	
Ctrl+Z	Pausa un proceso en primer plano	Luego bg para continuar
df -h	Espacio en disco (formato legible)	-h = human readable
who	Usuarios conectados ahora	
last reboot	Historial de reinicios	
time comando	Mide el tiempo de ejecución

9 · Procesamiento de texto con awk
Conceptos clave
awk es un lenguaje de programación minimalista para procesar texto estructurado. Procesa el archivo línea a línea, dividiéndola en campos automáticamente.

Variables automáticas
Variable	Significado
$0	La línea completa
$1, $2...	Campo 1, campo 2...
NF	Número de campos de la línea actual
NR	Número de línea actual
FS	Separador de campos (espacio por defecto)
OFS	Separador de salida
Estructura básica
awk 'BEGIN{inicio} condición{acción} END{final}' archivo
       ↑ ejecuta antes    ↑ por cada línea   ↑ ejecuta al final
Ejemplos de referencia
awk -F: '{print $1}' /etc/passwd              # campo 1, separador :
awk -F: '$3 > 1000 {print $1, $3}' /etc/passwd # filtro + impresión
awk '{suma += $1} END {print suma}' nums.txt   # suma acumulada
awk 'NR>=5 && NR<=10' archivo.txt             # rango de líneas
awk '{print NR, $0}' archivo.txt              # numerar líneas

10 · Edición de texto con sed
Conceptos clave
sed (stream editor) aplica transformaciones al texto sin abrir un editor. Es ideal para modificar archivos de configuración, limpiar logs o transformar datos en pipelines.

Comandos principales
Expresión	Qué hace	Ejemplo
s/viejo/nuevo/	Reemplaza la primera coincidencia en cada línea	sed 's/error/ERROR/'
s/viejo/nuevo/g	Reemplaza todas las coincidencias	sed 's/a/o/g'
/patrón/d	Borra las líneas que coinciden	sed '/^#/d' (borra comentarios)
-n '/patrón/p'	Imprime solo las líneas que coinciden	sed -n '/error/p'
s/^/texto/	Añade texto al inicio de cada línea	sed 's/^/# /'
s/$/texto/	Añade texto al final de cada línea	sed 's/$/ EOF/'
Nd	Borra la línea número N	sed '3d'
-i	Edita el archivo en su lugar (¡irreversible!)	sed -i 's/foo/bar/g' config.txt
⚠️ Precaución con -i: Siempre prueba sin -i primero para ver el resultado antes de modificar el archivo real. Usa -i.bak para crear una copia de seguridad automática.