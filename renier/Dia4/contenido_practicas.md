crea las tarjetas usando y conciderando la siguiente informaicion : 
5 · Permisos avanzados
Conceptos clave
Más allá de los permisos básicos, Linux tiene tres bits especiales con comportamientos únicos:

Bit	Activar con	En archivos	En directorios	Se ve en ls -l
SUID	chmod u+s	Se ejecuta con los permisos del propietario	—	rwsr-xr-x (s en usuario)
SGID	chmod g+s	Se ejecuta con los permisos del grupo	Nuevos archivos heredan el grupo	rwxr-sr-x (s en grupo)
Sticky	chmod +t	—	Solo el dueño puede borrar sus propios archivos	rwxrwxrwt (t en otros)
🔒 Ejemplo real: /bin/passwd tiene SUID porque cualquier usuario necesita modificar /etc/shadow (que pertenece a root) para cambiar su contraseña. El SUID permite ejecutarlo "como si fueras root" temporalmente.

📁 Ejemplo real: /tmp tiene sticky bit porque es compartido por todos los usuarios, pero nadie debe poder borrar los archivos de otro.

4 · Permisos básicos
Conceptos clave
Los permisos en Linux controlan quién puede hacer qué con cada archivo. Se aplican a tres niveles y con tres tipos de acceso:

Tipos de permiso
Letra	Nombre	Valor octal	Sobre archivos	Sobre directorios
r	lectura	4	Ver el contenido	Listar con ls
w	escritura	2	Modificar o borrar	Crear/borrar archivos dentro
x	ejecución	1	Ejecutarlo como programa	Entrar con cd
Niveles de aplicación
Símbolo	Nombre	Significa
u	user	El propietario del archivo
g	group	Usuarios del mismo grupo
o	others	El resto del mundo
a	all	Los tres a la vez
Interpretando ls -l
-rwxr-xr--  1  nache  staff  1024  ene 15 10:00  script.sh
 ↑↑↑↑↑↑↑↑↑        ↑     ↑
 │└──┬──┘│        │     └── grupo propietario
 │   │   └── otros (r--)    └── propietario
 │   └── grupo (r-x)
 └── usuario (rwx)
Notación octal rápida
Octal	Binario	Permisos	Lectura humana
7	111	rwx	todo
6	110	rw-	lectura y escritura
5	101	r-x	lectura y ejecución
4	100	r--	solo lectura
0	000	---	nada
La umask
La umask define los permisos que se restan al crear archivos o directorios:

Base archivos: 666 → 666 - 022 = 644 (rw-r--r--)
Base directorios: 777 → 777 - 022 = 755 (rwxr-xr-x)

3 · Enlaces duros y simbólicos
Conceptos clave
Linux permite que un mismo contenido sea accesible desde múltiples rutas mediante enlaces. Hay dos tipos con comportamientos muy diferentes:

Enlace duro	Enlace simbólico
Comando	ln original enlace	ln -s original enlace
Funciona si se borra el original	✅ Sí (mismo inodo)	❌ No (queda "roto")
Puede cruzar sistemas de archivos	❌ No	✅ Sí
Puede apuntar a directorios	❌ No (generalmente)	✅ Sí
Se ve en ls -l	Sin indicador	Aparece con ->
🔑 Analogía: Un enlace duro es como tener dos puertas que abren la misma habitación. Un enlace simbólico es un cartel que dice "la habitación está allí" — si derribas la habitación, el cartel sigue ahí pero no lleva a nada.

2 · Creación y organización de archivos
Conceptos clave
En Linux, todo es un archivo: los directorios, los dispositivos, los procesos. Saber crear, copiar, mover y borrar es fundamental. A diferencia de Windows, los nombres son sensibles a mayúsculas: Archivo.txt y archivo.txt son dos ficheros distintos.

📌 Referencia de comandos
Comando	Descripción	Ejemplo práctico
mkdir nombre	Crea un directorio	mkdir proyecto
mkdir -p a/b/c	Crea toda la cadena de directorios a la vez	mkdir -p src/main/java
touch archivo	Crea un archivo vacío (o actualiza su fecha)	touch log.txt
cp origen destino	Copia un archivo	cp datos.csv backup/
cp -r dir1 dir2	Copia un directorio entero (recursivo)	cp -r proyecto proyecto_bak
mv viejo nuevo	Mueve o renombra	mv temp.txt definitivo.txt
rm archivo	Borra un archivo	rm borrame.txt
rm -r carpeta	Borra un directorio y todo su contenido	rm -r temporal/
rm -f archivo	Fuerza el borrado sin preguntar	rm -f *.tmp
head -n archivo	Muestra las primeras N líneas	head -5 config.txt
tail -n archivo	Muestra las últimas N líneas	tail -20 error.log
tail -f archivo	Sigue el archivo en tiempo real (ideal para logs)	tail -f app.log
wc archivo	Cuenta líneas, palabras y caracteres	wc /etc/passwd
⚠️ Cuidado: En Linux no hay papelera en la terminal. rm borra de forma permanente.
1 · Exploración de directorios
Conceptos clave
La navegación por el sistema de archivos es la habilidad más básica en Linux. Todo parte de la raíz /, y cada directorio tiene un propósito:

/bin y /usr/bin → programas ejecutables
/etc → configuraciones del sistema
/tmp → archivos temporales (se borra al reiniciar)
/dev → dispositivos del hardware
~ → tu directorio personal (/home/tu_usuario)
📌 Referencia de comandos
Comando	Descripción	Ejemplo práctico
ls	Lista archivos del directorio actual	ls /home
ls -a	Incluye archivos ocultos (empiezan por .)	ls -a ~
ls -l	Vista detallada: permisos, dueño, tamaño, fecha	ls -l /etc
ls -r	Orden alfabético inverso	ls -r /etc
ls -R	Recursivo: entra en todos los subdirectorios	ls -R /usr
cd /ruta	Cambia al directorio indicado	cd /tmp
cd ~	Va directamente a tu carpeta personal	cd ~
cd -	Vuelve al directorio anterior (muy útil)	cd -
pwd	Muestra la ruta completa donde estás	pwd
date	Fecha y hora del sistema	date
💡 Tip: Combina opciones: ls -la muestra todos los archivos (incluso ocultos) con detalles completos.