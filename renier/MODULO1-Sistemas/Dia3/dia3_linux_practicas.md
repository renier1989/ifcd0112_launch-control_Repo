
 Fecha: Lunes 13 de Abril de 2026 Profesor: Juan Marcelo Gutiérrez Miranda Módulo: MF0223_3 — UF1465: Computadores para bases de datos
 
# 🐧 Manual de Prácticas Linux — Día 3
> 120 ejercicios autocontenidos para dominar la línea de comandos

---

## 📋 Índice rápido

| # | Tema | Ejercicios |
|---|------|-----------|
| 1 | [Exploración de directorios](#1--exploración-de-directorios) | 1 – 12 |
| 2 | [Creación y organización de archivos](#2--creación-y-organización-de-archivos) | 13 – 30 |
| 3 | [Enlaces duros y simbólicos](#3--enlaces-duros-y-simbólicos) | 31 – 40 |
| 4 | [Permisos básicos (chmod, umask)](#4--permisos-básicos) | 41 – 55 |
| 5 | [Permisos avanzados (SUID, SGID, Sticky)](#5--permisos-avanzados) | 56 – 65 |
| 6 | [Búsqueda con find y grep](#6--búsqueda-con-find-y-grep) | 66 – 75 |
| 7 | [Redirecciones y tuberías](#7--redirecciones-y-tuberías) | 76 – 85 |
| 8 | [Procesos y sistema](#8--procesos-y-sistema) | 86 – 95 |
| 9 | [Procesamiento de texto con awk](#9--procesamiento-de-texto-con-awk) | 96 – 105 |
| 10 | [Edición de texto con sed](#10--edición-de-texto-con-sed) | 106 – 115 |
| 11 | [Administración de servicios con systemd](#11--administración-de-servicios-con-systemd) | 116 – 120 |
| 12 | [Mini-proyectos integradores](#12--mini-proyectos-integradores) | P1 – P5 |

> **Consejo:** Cada ejercicio es independiente. Si uno te bloquea, pasa al siguiente y vuelve después.

---

## 1 · Exploración de directorios

### Conceptos clave

La navegación por el sistema de archivos es la habilidad más básica en Linux. Todo parte de la raíz `/`, y cada directorio tiene un propósito:

- `/bin` y `/usr/bin` → programas ejecutables
- `/etc` → configuraciones del sistema
- `/tmp` → archivos temporales (se borra al reiniciar)
- `/dev` → dispositivos del hardware
- `~` → tu directorio personal (`/home/tu_usuario`)

### 📌 Referencia de comandos

| Comando | Descripción | Ejemplo práctico |
|---------|-------------|-----------------|
| `ls` | Lista archivos del directorio actual | `ls /home` |
| `ls -a` | Incluye archivos ocultos (empiezan por `.`) | `ls -a ~` |
| `ls -l` | Vista detallada: permisos, dueño, tamaño, fecha | `ls -l /etc` |
| `ls -r` | Orden alfabético inverso | `ls -r /etc` |
| `ls -R` | Recursivo: entra en todos los subdirectorios | `ls -R /usr` |
| `cd /ruta` | Cambia al directorio indicado | `cd /tmp` |
| `cd ~` | Va directamente a tu carpeta personal | `cd ~` |
| `cd -` | Vuelve al directorio anterior (muy útil) | `cd -` |
| `pwd` | Muestra la ruta completa donde estás | `pwd` |
| `date` | Fecha y hora del sistema | `date` |

> 💡 **Tip:** Combina opciones: `ls -la` muestra todos los archivos (incluso ocultos) con detalles completos.

### 🧪 Ejercicios

**1.** Lista todos los archivos del directorio `/bin`

**2.** Lista todos los archivos del directorio `/tmp`

**3.** Lista en **orden inverso** los archivos de `/etc` que empiecen por la letra `t`

**4.** Lista los archivos de `/dev` que empiecen por `tty` y tengan exactamente 5 caracteres
> Pista: el comodín `?` representa exactamente un carácter

**5.** Lista los archivos de `/dev` que empiecen por `tty` y terminen en 1, 2, 3 o 4
> Pista: usa corchetes `[1234]` para indicar una clase de caracteres

**6.** Lista los archivos de `/dev` que empiecen por `t` y terminen en `C1`

**7.** Lista **todos** los archivos del directorio raíz `/`, incluidos los ocultos

**8.** Lista los archivos de `/etc` que **NO** empiecen por la letra `t`
> Pista: la negación en comodines se hace con `[^t]*`

**9.** Lista **recursivamente** (entrando en subdirectorios) todos los archivos de `/usr`

**10.** Cambia al directorio `/tmp`, verifica que estás allí con `pwd`, y luego vuelve al directorio anterior de un solo comando

**11.** Muestra la fecha y hora en este formato exacto:
```
Hoy es lunes, 15 de enero de 2025 - 14:30:45
```
> Pista: consulta `man date` o `date --help` para ver los especificadores de formato

**12.** Muestra la ruta completa del directorio donde te encuentras ahora mismo

---

## 2 · Creación y organización de archivos

### Conceptos clave

En Linux, **todo es un archivo**: los directorios, los dispositivos, los procesos. Saber crear, copiar, mover y borrar es fundamental. A diferencia de Windows, los nombres son sensibles a mayúsculas: `Archivo.txt` y `archivo.txt` son dos ficheros distintos.

### 📌 Referencia de comandos

| Comando | Descripción | Ejemplo práctico |
|---------|-------------|-----------------|
| `mkdir nombre` | Crea un directorio | `mkdir proyecto` |
| `mkdir -p a/b/c` | Crea toda la cadena de directorios a la vez | `mkdir -p src/main/java` |
| `touch archivo` | Crea un archivo vacío (o actualiza su fecha) | `touch log.txt` |
| `cp origen destino` | Copia un archivo | `cp datos.csv backup/` |
| `cp -r dir1 dir2` | Copia un directorio entero (recursivo) | `cp -r proyecto proyecto_bak` |
| `mv viejo nuevo` | Mueve o renombra | `mv temp.txt definitivo.txt` |
| `rm archivo` | Borra un archivo | `rm borrame.txt` |
| `rm -r carpeta` | Borra un directorio y todo su contenido | `rm -r temporal/` |
| `rm -f archivo` | Fuerza el borrado sin preguntar | `rm -f *.tmp` |
| `head -n archivo` | Muestra las primeras N líneas | `head -5 config.txt` |
| `tail -n archivo` | Muestra las últimas N líneas | `tail -20 error.log` |
| `tail -f archivo` | Sigue el archivo en tiempo real (ideal para logs) | `tail -f app.log` |
| `wc archivo` | Cuenta líneas, palabras y caracteres | `wc /etc/passwd` |

> ⚠️ **Cuidado:** En Linux no hay papelera en la terminal. `rm` borra de forma permanente.

### 🧪 Ejercicios

**13.** Crea el directorio `practica` dentro de tu home (`~`)

**14.** Dentro de `practica`, crea tres directorios: `dir1`, `dir2`, `dir3`

**15.** Dentro de `dir1`, crea un subdirectorio llamado `subdir1`

**16.** Dentro de `dir3`, crea `subdir31`, y dentro de este crea `subdir311` y `subdir312`
> Pista: hazlo en un solo comando con `mkdir -p`

**17.** Copia el archivo /etc/os-release (información del sistema) a practica con el nombre mensaje.txt

**18.** Copia `mensaje.txt` dentro de `dir1`, `dir2` y `dir3` usando un bucle `for`:
```bash
for d in dir1 dir2 dir3; do cp mensaje.txt practica/$d/; done
```

**19.** Usa **un solo comando** para verificar que `mensaje.txt` está en los tres directorios

**20.** Crea un archivo vacío llamado `vacio.txt` dentro de `practica`

**21.** Crea un archivo `datos.txt` con tres líneas de texto usando `echo` y `>>`:
```bash
echo "Primera línea" >> datos.txt
echo "Segunda línea" >> datos.txt
echo "Tercera línea" >> datos.txt
```

**22.** Muestra las primeras 3 líneas de `/etc/passwd`

**23.** Muestra las últimas 5 líneas de /var/log/dpkg.log 

**24.** Cuenta cuántas líneas, palabras y caracteres tiene `/etc/passwd`

**25.** Borra el directorio `dir1` completo (incluyéndolo a él)

**26.** Crea un archivo `registro.log` y escribe la fecha actual dentro
> Pista: `date >> registro.log`

**27.** Añade una segunda línea `"Ejercicio completado"` al mismo archivo sin borrar la primera

**28.** Muestra el contenido de `registro.log` en pantalla con `cat`

**29.** Renombra `registro.log` a `historial.log`

**30.** Mueve `historial.log` dentro de `dir2`

---

## 3 · Enlaces duros y simbólicos

### Conceptos clave

Linux permite que un mismo contenido sea accesible desde múltiples rutas mediante **enlaces**. Hay dos tipos con comportamientos muy diferentes:

| | Enlace duro | Enlace simbólico |
|---|---|---|
| Comando | `ln original enlace` | `ln -s original enlace` |
| Funciona si se borra el original | ✅ Sí (mismo inodo) | ❌ No (queda "roto") |
| Puede cruzar sistemas de archivos | ❌ No | ✅ Sí |
| Puede apuntar a directorios | ❌ No (generalmente) | ✅ Sí |
| Se ve en `ls -l` | Sin indicador | Aparece con `->` |

> 🔑 **Analogía:** Un enlace duro es como tener dos puertas que abren la misma habitación. Un enlace simbólico es un cartel que dice "la habitación está allí" — si derribas la habitación, el cartel sigue ahí pero no lleva a nada.

### 🧪 Ejercicios

**31.** Crea `original.txt` dentro de `practica` con el texto `"Hola mundo"`:
```bash
echo "Hola mundo" > practica/original.txt
```

**32.** Crea un **enlace duro** llamado `duro.txt` que apunte a `original.txt`

**33.** Crea un **enlace simbólico** llamado `simbolico.txt` que apunte a `original.txt`

**34.** Borra `original.txt` y luego intenta leer `duro.txt` y `simbolico.txt` con `cat`. ¿Qué ocurre con cada uno y por qué?

**35.** Crea un enlace simbólico a un archivo que **no existe**:
```bash
ln -s /no/existo roto.txt
```

**36.** Intenta hacer `cat roto.txt`. ¿Qué mensaje de error muestra el sistema?

**37.** Crea un enlace simbólico al directorio `/etc` llamado `enlace_etc` dentro de `practica`

**38.** Usa ese enlace para listar el contenido de `/etc` (sin escribir `/etc`)

**39.** Encuentra todos los enlaces simbólicos dentro de `practica`:
```bash
find practica -type l
```

**40.** Borra todos los enlaces creados (`duro.txt`, `simbolico.txt`, `roto.txt`, `enlace_etc`)

---

## 4 · Permisos básicos

### Conceptos clave

Los permisos en Linux controlan quién puede hacer qué con cada archivo. Se aplican a tres niveles y con tres tipos de acceso:

#### Tipos de permiso

| Letra | Nombre | Valor octal | Sobre archivos | Sobre directorios |
|-------|--------|-------------|----------------|-------------------|
| `r` | lectura | 4 | Ver el contenido | Listar con `ls` |
| `w` | escritura | 2 | Modificar o borrar | Crear/borrar archivos dentro |
| `x` | ejecución | 1 | Ejecutarlo como programa | Entrar con `cd` |

#### Niveles de aplicación

| Símbolo | Nombre | Significa |
|---------|--------|-----------|
| `u` | user | El propietario del archivo |
| `g` | group | Usuarios del mismo grupo |
| `o` | others | El resto del mundo |
| `a` | all | Los tres a la vez |

#### Interpretando `ls -l`

```
-rwxr-xr--  1  nache  staff  1024  ene 15 10:00  script.sh
 ↑↑↑↑↑↑↑↑↑        ↑     ↑
 │└──┬──┘│        │     └── grupo propietario
 │   │   └── otros (r--)    └── propietario
 │   └── grupo (r-x)
 └── usuario (rwx)
```

#### Notación octal rápida

| Octal | Binario | Permisos | Lectura humana |
|-------|---------|----------|----------------|
| 7 | 111 | rwx | todo |
| 6 | 110 | rw- | lectura y escritura |
| 5 | 101 | r-x | lectura y ejecución |
| 4 | 100 | r-- | solo lectura |
| 0 | 000 | --- | nada |

#### La `umask`

La umask define los permisos que se **restan** al crear archivos o directorios:
- Base archivos: `666` → `666 - 022 = 644` (rw-r--r--)
- Base directorios: `777` → `777 - 022 = 755` (rwxr-xr-x)

### 🧪 Ejercicios

**41.** Crea un directorio `permisos_dir` dentro de `practica` y muestra sus permisos con `ls -ld`

**42.** Usando **notación simbólica**, quita todos los permisos de escritura de `permisos_dir`:
```bash
chmod a-w permisos_dir
```

**43.** Usando **notación octal**, quita el permiso de lectura a "otros" de `permisos_dir`

**44.** Intenta crear un archivo dentro de `permisos_dir` con `touch`. ¿Qué ocurre y por qué?

**45.** Date permiso de escritura solo a ti (usuario) y vuelve a intentar crear el archivo:
```bash
chmod u+w permisos_dir
```

**46.** Muestra la umask actual de tu sistema

**47.** Cambia la umask a `027`. Crea un archivo `test.txt` y un directorio `test_dir`. Verifica sus permisos con `ls -l`
> ¿Qué permisos esperarías? Archivo: 640, directorio: 750

**48.** Restaura la umask a su valor original (normalmente `022`)

**49.** Crea un script `hola.sh` con este contenido:
```bash
#!/bin/bash
echo "Hola mundo"
```

**50.** Dale permiso de ejecución **solo al propietario** y ejecútalo con `./hola.sh`

**51.** Cambia los permisos de `hola.sh` a `755` (rwxr-xr-x) con notación octal

**52.** Crea `secreto.txt` con permisos `600` (rw-------). ¿Quién puede leerlo?

**53.** Crea `publico.txt` con permisos `644` (rw-r--r--). ¿Qué diferencia hay con `secreto.txt`?

**54.** Cambia el propietario de `hola.sh` a otro usuario:
```bash
sudo chown otro_usuario hola.sh
```

**55.** Cambia el grupo de `hola.sh` al grupo `users`:
```bash
sudo chgrp users hola.sh
```

---

## 5 · Permisos avanzados

### Conceptos clave

Más allá de los permisos básicos, Linux tiene tres bits especiales con comportamientos únicos:

| Bit | Activar con | En archivos | En directorios | Se ve en `ls -l` |
|-----|-------------|-------------|----------------|-------------------|
| **SUID** | `chmod u+s` | Se ejecuta con los permisos del propietario | — | `rwsr-xr-x` (s en usuario) |
| **SGID** | `chmod g+s` | Se ejecuta con los permisos del grupo | Nuevos archivos heredan el grupo | `rwxr-sr-x` (s en grupo) |
| **Sticky** | `chmod +t` | — | Solo el dueño puede borrar sus propios archivos | `rwxrwxrwt` (t en otros) |

> 🔒 **Ejemplo real:** `/bin/passwd` tiene SUID porque cualquier usuario necesita modificar `/etc/shadow` (que pertenece a root) para cambiar su contraseña. El SUID permite ejecutarlo "como si fueras root" temporalmente.

> 📁 **Ejemplo real:** `/tmp` tiene sticky bit porque es compartido por todos los usuarios, pero nadie debe poder borrar los archivos de otro.

### 🧪 Ejercicios

**56.** Busca en `/bin` todos los archivos que tengan SUID activado:
```bash
find /bin -perm -4000
```

**57.** Busca en `/usr/bin` todos los archivos con SGID:
```bash
find /usr/bin -perm -2000
```

**58.** Crea un directorio `compartido` dentro de `practica` y asígnale SGID:
```bash
chmod g+s compartido
```

**59.** Dentro de `compartido`, crea un archivo `test.txt`. ¿De qué grupo es? Compruébalo con `ls -l`

**60.** Crea un directorio `temporal` con sticky bit:
```bash
mkdir temporal && chmod +t temporal
```

**61.** Cambia temporalmente al usuario `nobody` y crea un archivo dentro de `temporal`:
```bash
sudo -u nobody bash -c "touch temporal/archivo_nobody.txt"
```

**62.** Desde tu usuario normal, intenta borrar ese archivo. ¿Puedes? ¿Por qué?

**63.** Explica con tus palabras por qué `/tmp` tiene sticky bit y qué pasaría si no lo tuviera

**64.** Crea un script `privilegiado.sh` que muestre `whoami`. Ponle SUID y ejecútalo. ¿Qué usuario aparece?
> Nota: en la mayoría de sistemas modernos, el SUID en scripts de shell está deshabilitado por seguridad

**65.** Quita el SUID con `chmod u-s privilegiado.sh` y comprueba el resultado

---

## 6 · Búsqueda con find y grep

### Conceptos clave

Dos de las herramientas más potentes de Linux para encontrar lo que necesitas:

- **`find`** → busca **archivos** por sus características (nombre, tipo, tamaño, fecha, permisos...)
- **`grep`** → busca **texto** dentro del contenido de los archivos

### 📌 Referencia: find

| Opción | Descripción | Ejemplo |
|--------|-------------|---------|
| `-name "patrón"` | Busca por nombre (sensible a mayúsculas) | `find . -name "*.log"` |
| `-iname "patrón"` | Busca por nombre (ignora mayúsculas) | `find . -iname "readme*"` |
| `-type f` | Solo archivos regulares | `find /etc -type f` |
| `-type d` | Solo directorios | `find ~ -type d` |
| `-type l` | Solo enlaces simbólicos | `find . -type l` |
| `-size +10M` | Mayor de 10 MB | `find / -size +100M` |
| `-mtime -7` | Modificado en los últimos 7 días | `find . -mtime -1` |
| `-user nombre` | Perteneciente a ese usuario | `find / -user root` |
| `-empty` | Archivos o directorios vacíos | `find ~ -empty` |
| `-exec cmd {} \;` | Ejecuta un comando sobre cada resultado | `find . -name "*.tmp" -exec rm {} \;` |

### 📌 Referencia: grep

| Opción | Descripción | Ejemplo |
|--------|-------------|---------|
| `grep "texto" archivo` | Busca líneas que contienen el texto | `grep "error" app.log` |
| `-r` | Búsqueda recursiva en directorios | `grep -r "TODO" src/` |
| `-i` | Ignora mayúsculas/minúsculas | `grep -i "Error" log.txt` |
| `-v` | Invierte: muestra líneas que NO contienen | `grep -v "debug" log.txt` |
| `-c` | Cuenta el número de coincidencias | `grep -c "error" log.txt` |
| `-l` | Muestra solo el nombre del archivo | `grep -l "root" /etc/*` |
| `-n` | Muestra el número de línea | `grep -n "error" log.txt` |

### 🧪 Ejercicios

**66.** Busca en `/etc` todos los archivos que contengan la palabra `"root"`:
```bash
grep -r "root" /etc/ 2>/dev/null
```

**67.** Busca archivos en `/var/log` que hayan sido **modificados en los últimos 3 días**

**68.** Busca en tu home todos los archivos que te pertenezcan a ti

**69.** Busca todos los **directorios vacíos** dentro de `/usr`:
```bash
find /usr -type d -empty
```

**70.** Busca archivos en tu home que ocupen **más de 10 MB**

**71.** Usa `grep` para mostrar solo las líneas de `/etc/passwd` que contengan `/bin/bash`

**72.** Usa `grep -v` para mostrar las líneas de `/etc/passwd` que **NO** contengan `"nologin"`

**73.** Cuenta cuántos usuarios tienen bash como shell (usa `grep -c`)

**74.** Busca recursivamente la palabra `"error"` en `/var/log` y muestra **solo el nombre del archivo** (opción `-l`)

**75.** Usa `find` con `-exec` para renombrar todos los `.txt` en `practica` a `.bak`:
```bash
find practica -name "*.txt" -exec bash -c 'mv "$1" "${1%.txt}.bak"' _ {} \;
```

---

## 7 · Redirecciones y tuberías

### Conceptos clave

En Linux, los programas tienen tres flujos de datos estándar:

| Flujo | Número | Símbolo de redirección | Descripción |
|-------|--------|----------------------|-------------|
| stdin | 0 | `<` | Entrada estándar (teclado por defecto) |
| stdout | 1 | `>` o `>>` | Salida estándar (pantalla por defecto) |
| stderr | 2 | `2>` | Errores (pantalla por defecto) |

#### Operadores de redirección

| Símbolo | Comportamiento | Ejemplo |
|---------|---------------|---------|
| `>` | Redirige stdout (sobrescribe) | `ls > lista.txt` |
| `>>` | Redirige stdout (añade al final) | `echo "más" >> lista.txt` |
| `2>` | Redirige stderr | `cmd 2> errores.txt` |
| `2>&1` | Une stderr con stdout | `cmd > todo.txt 2>&1` |
| `/dev/null` | Descarta la salida (agujero negro) | `cmd 2>/dev/null` |
| `\|` | Tubería: stdout de uno → stdin del siguiente | `ls \| grep txt` |

#### Tuberías frecuentes

```bash
ls | wc -l                          # contar archivos
ps aux | grep bash                  # filtrar procesos
cut -d: -f1 /etc/passwd | sort      # extraer y ordenar
df -h | grep -v tmpfs               # disco sin sistemas temporales
```

### 🧪 Ejercicios

**76.** Guarda la salida de `ls -l /` en `listado.txt` y los errores en `errores.txt` (en el mismo comando)

**77.** Ejecuta `ls /ruta/inexistente` haciendo que los errores **desaparezcan** (redirigiéndolos a `/dev/null`)

**78.** Usa `ps aux` y una tubería para mostrar **solo los procesos de bash**

**79.** Cuenta cuántos archivos hay en `/bin` usando `ls` y `wc -l`

**80.** Ordena los usuarios de `/etc/passwd` por UID (tercer campo, separador `:`):
```bash
sort -t: -k3 -n /etc/passwd
```

**81.** Extrae solo los nombres de usuario de `/etc/passwd` (primer campo) y ordénalos alfabéticamente

**82.** Muestra solo el **nombre de usuario y su shell** (campos 1 y 7) de `/etc/passwd`:
```bash
cut -d: -f1,7 /etc/passwd
```

**83.** Muestra los 5 procesos que más CPU consumen:
```bash
ps aux --sort=-%cpu | head -6
```

**84.** Cuenta cuántas veces aparece la palabra "error" en /var/log/dpkg.log (usa grep -c)

**85.** Encuentra todos los archivos `.conf` en `/etc` y muestra sus detalles con `ls -l` usando una tubería

---

## 8 · Procesos y sistema

### Conceptos clave

En Linux, cada programa en ejecución es un **proceso** con un identificador único llamado **PID** (Process ID). El proceso raíz es `systemd` (o `init`) con PID 1, del que cuelgan todos los demás.

### 📌 Referencia de comandos

| Comando | Descripción | Tip |
|---------|-------------|-----|
| `ps aux` | Lista todos los procesos | Combinar con grep |
| `ps -ef` | Formato alternativo con PPID | Muestra jerarquía |
| `top` | Monitor interactivo (salir con `q`) | `M` ordena por mem, `P` por CPU |
| `htop` | Versión mejorada con colores | Puede no estar instalado |
| `kill PID` | Termina proceso (señal SIGTERM) | El proceso puede ignorarla |
| `kill -9 PID` | Mata proceso a la fuerza (SIGKILL) | El proceso no puede ignorarla |
| `jobs` | Muestra procesos en segundo plano | |
| `fg %1` | Trae proceso al primer plano | |
| `bg %1` | Envía proceso al segundo plano | |
| `comando &` | Lanza en segundo plano | |
| `Ctrl+Z` | Pausa un proceso en primer plano | Luego `bg` para continuar |
| `df -h` | Espacio en disco (formato legible) | `-h` = human readable |
| `who` | Usuarios conectados ahora | |
| `last reboot` | Historial de reinicios | |
| `time comando` | Mide el tiempo de ejecución | |

### 🧪 Ejercicios

**86.** Muestra todos los procesos del usuario `root`:
```bash
ps aux | grep "^root"
```

**87.** Muestra todos los procesos ordenados por uso de memoria:
```bash
ps aux --sort=-%mem | head -10
```

**88.** Lanza `sleep 100` en segundo plano, muéstralo con `jobs`, tráelo a primer plano con `fg` y mátalo con `Ctrl+C`

**89.** Muestra el árbol de procesos con `pstree` (instálalo si es necesario con `apt install psmisc`)

**90.** Mide el tiempo que tarda en ejecutarse:
```bash
time find / -name "*.conf" 2>/dev/null
```

**91.** Muestra el espacio en disco de todas las particiones en formato legible:
```bash
df -h
```

**92.** Muestra cuántos usuarios están conectados ahora mismo:
```bash
who | wc -l
```

**93.** Muestra los últimos 5 reinicios del sistema:
```bash
last reboot | head -5
```

**94.** Lanza un proceso que consuma CPU, encuéntralo con `top` y anota su PID:
```bash
yes > /dev/null &
```

**95.** Mata ese proceso usando su PID:
```bash
kill <PID>
```

---

## 9 · Procesamiento de texto con awk

### Conceptos clave

`awk` es un lenguaje de programación minimalista para procesar texto estructurado. Procesa el archivo **línea a línea**, dividiéndola en **campos** automáticamente.

#### Variables automáticas

| Variable | Significado |
|----------|-------------|
| `$0` | La línea completa |
| `$1`, `$2`... | Campo 1, campo 2... |
| `NF` | Número de campos de la línea actual |
| `NR` | Número de línea actual |
| `FS` | Separador de campos (espacio por defecto) |
| `OFS` | Separador de salida |

#### Estructura básica

```
awk 'BEGIN{inicio} condición{acción} END{final}' archivo
       ↑ ejecuta antes    ↑ por cada línea   ↑ ejecuta al final
```

#### Ejemplos de referencia

```bash
awk -F: '{print $1}' /etc/passwd              # campo 1, separador :
awk -F: '$3 > 1000 {print $1, $3}' /etc/passwd # filtro + impresión
awk '{suma += $1} END {print suma}' nums.txt   # suma acumulada
awk 'NR>=5 && NR<=10' archivo.txt             # rango de líneas
awk '{print NR, $0}' archivo.txt              # numerar líneas
```

### 🧪 Ejercicios

**96.** Muestra solo el primer campo (nombre de usuario) de `/etc/passwd` usando `:` como separador

**97.** Muestra el nombre de usuario y su shell (campo 1 y campo 7) de `/etc/passwd`

**98.** Muestra solo las líneas donde el shell sea `/bin/bash`

**99.** Muestra nombre de usuario y UID para usuarios con UID mayor a 1000

**100.** Cuenta cuántos usuarios tiene el sistema (usa la variable especial `NR` al final):
```bash
awk 'END {print NR}' /etc/passwd
```

**101.** Crea el archivo `notas.txt`:
```
Ana 85 90 78
Luis 70 88 92
Maria 95 85 89
```
Calcula el promedio de cada alumno y muestra:
```
Ana: 84.33
Luis: 83.33
Maria: 89.67
```

**102.** Crea `numeros.txt` con un número por línea (varios) y suma todos los números con `awk`

**103.** Muestra las líneas 5 a 10 de `/etc/passwd`

**104.** Imprime el último campo de cada línea de `/etc/passwd` (usa la variable `$NF`)

**105.** Usa `awk` con una condición `if` para mostrar `"Usuario root"` si el primer campo es `"root"`:
```bash
awk -F: '{if($1=="root") print "Usuario root:", $0}' /etc/passwd
```

---

## 10 · Edición de texto con sed

### Conceptos clave

`sed` (stream editor) aplica transformaciones al texto **sin abrir un editor**. Es ideal para modificar archivos de configuración, limpiar logs o transformar datos en pipelines.

#### Comandos principales

| Expresión | Qué hace | Ejemplo |
|-----------|----------|---------|
| `s/viejo/nuevo/` | Reemplaza la **primera** coincidencia en cada línea | `sed 's/error/ERROR/'` |
| `s/viejo/nuevo/g` | Reemplaza **todas** las coincidencias | `sed 's/a/o/g'` |
| `/patrón/d` | Borra las líneas que coinciden | `sed '/^#/d'` (borra comentarios) |
| `-n '/patrón/p'` | Imprime solo las líneas que coinciden | `sed -n '/error/p'` |
| `s/^/texto/` | Añade texto al **inicio** de cada línea | `sed 's/^/# /'` |
| `s/$/texto/` | Añade texto al **final** de cada línea | `sed 's/$/ EOF/'` |
| `Nd` | Borra la línea número N | `sed '3d'` |
| `-i` | Edita el archivo **en su lugar** (¡irreversible!) | `sed -i 's/foo/bar/g' config.txt` |

> ⚠️ **Precaución con `-i`:** Siempre prueba sin `-i` primero para ver el resultado antes de modificar el archivo real. Usa `-i.bak` para crear una copia de seguridad automática.

### 🧪 Ejercicios

**106.** Crea `texto.txt` con `"Hola mundo, hola a todos"` y reemplaza **todas** las `"a"` por `"o"`

**107.** Crea un archivo con líneas vacías intercaladas y elimínalas:
```bash
sed '/^$/d' archivo.txt
```

**108.** Muestra solo las líneas que contienen "error" de /var/log/dpkg.log:


**109.** Añade `">> "` al inicio de cada línea de un archivo:
```bash
sed 's/^/>> /' archivo.txt
```

**110.** Borra la primera palabra de cada línea de un archivo:
```bash
sed 's/^[^ ]* //' archivo.txt
```

**111.** En un archivo de log, reemplaza todas las IPs (`192.168.x.x`) por `[OCULTO]`:
```bash
sed 's/[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}/[OCULTO]/g' log.txt
```

**112.** Inserta una línea en blanco después de cada línea que contenga `"fatal"`:
```bash
sed '/fatal/a\\' log.txt
```

**113.** Prueba a cambiar `"localhost"` por `"servidor.local"` en `/etc/hosts` (sin `-i` primero para ver el resultado):
```bash
sed 's/localhost/servidor.local/g' /etc/hosts
```

**114.** Extrae solo los nombres de usuario de `/etc/passwd` usando únicamente `sed` (sin `cut` ni `awk`):
```bash
sed 's/:.*//' /etc/passwd
```

**115.** Crea `nombres.txt` con nombres en minúscula y conviértelos a mayúsculas:
```bash
sed 's/./\u&/g' nombres.txt
```

---

## 11 · Administración de servicios con systemd

### Conceptos clave

`systemd` es el sistema de inicio moderno de Linux. Gestiona los **servicios** (daemons): programas que se ejecutan en segundo plano. Un servicio puede estar habilitado (arranca automáticamente) o deshabilitado, y activo o inactivo.

```
Habilitado  ≠  Activo
    ↓               ↓
Arranca solo   Corriendo ahora
al reiniciar
```

### 📌 Referencia de comandos

| Comando | Descripción |
|---------|-------------|
| `systemctl status servicio` | Estado completo del servicio |
| `systemctl start servicio` | Arranca el servicio ahora |
| `systemctl stop servicio` | Detiene el servicio ahora |
| `systemctl restart servicio` | Reinicia (stop + start) |
| `systemctl reload servicio` | Recarga configuración sin reiniciar |
| `systemctl enable servicio` | Activa al inicio del sistema |
| `systemctl disable servicio` | Desactiva del inicio del sistema |
| `systemctl list-units --type=service` | Lista todos los servicios |
| `journalctl -u servicio` | Logs del servicio |
| `journalctl -u servicio -f` | Logs en tiempo real |
| `journalctl -u servicio -n 50` | Últimas 50 líneas de log |

### 🧪 Ejercicios

**116.** Lista todos los servicios **activos** en tu sistema:
```bash
systemctl list-units --type=service --state=running
```

**117.** Muestra el estado completo del servicio `cron`:
```bash
systemctl status cron
```
> Si no existe, prueba con `ssh` o `NetworkManager`

**118.** Detén el servicio `cron`, comprueba su estado, luego vuélvelo a arrancar:
```bash
sudo systemctl stop cron
systemctl status cron
sudo systemctl start cron
```

**119.** Deshabilita el servicio `bluetooth` para que no arranque al inicio (si no lo usas):
```bash
sudo systemctl disable bluetooth
```

**120.** Muestra los últimos 10 logs del servicio `systemd-journald`:
```bash
journalctl -u systemd-journald -n 10
```

---

## 12 · Mini-proyectos integradores

> Estos proyectos combinan múltiples herramientas. No hay una única solución correcta. El objetivo es pensar en cómo conectar los comandos aprendidos.

---

### P1 · Script monitor del sistema

Crea un script `monitor.sh` que **cada 5 segundos** guarde en `monitor.log`:
- La fecha y hora actual
- El porcentaje de CPU en uso
- Los 3 procesos que más CPU consumen

```bash
#!/bin/bash
while true; do
    echo "=== $(date) ===" >> monitor.log
    # Pista: usa ps aux --sort=-%cpu | head -4
    sleep 5
done
```

---

### P2 · Analizador de errores 404

Escribe un comando (o pipeline) que:
1. Busque en un log de Apache (o uno simulado) todas las líneas con código `404`
2. Cuente cuántas veces aparece cada URL solicitada
3. Muestre las 10 URLs más pedidas que no se encontraron

> Pista: `grep "404" access.log | awk '{print $7}' | sort | uniq -c | sort -rn | head -10`

---

### P3 · Script de backups con rotación

Crea un script que:
1. Comprima el directorio `practica` en `backup_YYYYMMDD.tar.gz`
2. Borre automáticamente los backups de más de 7 días

```bash
#!/bin/bash
tar -czf "backup_$(date +%Y%m%d).tar.gz" practica/
# Pista para borrar viejos: find . -name "backup_*.tar.gz" -mtime +7 -delete
```

---

### P4 · Reporte de usuarios del sistema

Usa `awk` para generar un reporte de `/etc/passwd` que muestre tres secciones:
1. Usuarios con bash como shell
2. Usuarios con UID mayor a 1000 (usuarios reales)
3. Usuarios con shell no estándar (ni bash ni sh ni nologin)

---

### P5 · Buscador de logs con colores

Crea un script que:
1. Reciba un patrón como argumento: `./buscar.sh "error"`
2. Busque en todos los `.log` de `/var/log`
3. Muestre las líneas con colores: **rojo** para `error`, **amarillo** para `warning`

```bash
#!/bin/bash
# Pista: usa grep con --color=always o códigos ANSI \033[31m
grep -r "$1" /var/log/*.log 2>/dev/null | \
    sed 's/error/\o033[31m&\o033[0m/gi'
```

---

## 📝 Notas para el estudiante

- **Practica en un entorno seguro:** Si tienes dudas sobre un comando destructivo, prueba primero sin `-f` o sin `-i`
- **El man es tu amigo:** `man comando` te da toda la documentación. `comando --help` suele dar un resumen rápido
- **Tab para autocompletar:** Nunca escribas rutas largas a mano si puedes completarlas con Tab
- **Historia de comandos:** `history` te muestra los últimos comandos. `Ctrl+R` busca en el historial
- **Nada es permanente salvo `rm`:** Ten cuidado con los comandos que modifican o borran archivos

---

-------------------------
Autor original/Referencia: @TodoEconometria
Profesor: Juan Marcelo Gutierrez Miranda
Metodologia: curso IFCD0112. Módulo: MF0223_3 — UF1465: Computadores para bases de datos
Hash ID de Certificacion: 4e8d9b1a5f6e7c3d2b1a0f9e8d7c6b5a4f3e2d1c0b9a8f7e6d5c4b3a2f1e0d9c
Repositorio: https://github.com/TodoEconometria/certificaciones
