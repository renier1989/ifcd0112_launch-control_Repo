# Encargado del proyecto :

### Renier Josué Vargas Mejias

*Curso IFCD0112 — Ejercicio de consolidación, Semana 1*
-

# MISIÓN 1 — DEMOLICIÓN Y RECONOCIMIENTO

### lo que he aprendido :


## Paso 1 :  Verificar el estado actual
Verifico que estoy en el direcctorio de mi usuario

```bash
pwd
```
![alt text](image-1.png)

ejecuto el siguiente comando para verificar si existe el direccotio "launch-control"

```bash
ls -la ~/launch-control 2>/dev/null && echo "EXISTE - hay que limpiarlo" || echo "NO EXISTE - no hay nada anterior"
```

![alt text](image.png)

## Paso 2 : Si existe, inspeccionar antes de borrar

> No existe el directorio "launch-control", asi que no hay nada que limpiar o revisar

## Paso 3 : Demolición controlada

> No existe el directorio "launch-control", asi que no hay nada que limpiar o revisar

## Paso 4 : Limpiar también restos de ejercicios anteriores

> No hay restos de ejercicios anteriores

### Verificacion de Mision 1:

Se ejecuta el siguiente comando para validar que no hayan quedado remanentes del encargado anterior, de misiones anteriores o de ejercicios anteriores:

````bash
ls ~ | grep -E "launch|mision|artemis|diagnostico"
````

![alt text](image-2.png)

# MISIÓN 2 — CONSTRUIR LA ESTRUCTURA

## Paso 1 : Crear todos los directorios de una vez

Primero creo la carpeta principal de "launch-control", ya que no existia y verifico que se haya creado correctamente con el comando:

````bash
mkdir ~/launch-control
ls -l ~/launch-control/
````

![alt text](image-3.png)

Para crear todos los directorios necesarios con un solo comando, se ejecuta los siguiente: 

 ````bash
 mkdir -p ~/launch-control/{config/secrets,data/{vehicles,crews,missions},logs,scripts,docs/architecture,tmp}
 ````

 y para verificar la estructura de los directorios recien creados se usa el comando:

 ````bash
 tree ~/launch-control
 ````

![alt text](image-4.png)

## Paso 2: Crear archivos de configuración

Me muevo hacia el directorio del proyecto con el comdando: 

````bash
cd ~/launch-control
````

y ejecuto los siguientes comandos para la creacion de los archivos de configuracion:

````bash
cat > config/database.conf << 'EOF'
> # Launch Control — Configuración de Base de Datos
# Entorno: desarrollo
# Última modificación: abril 2026

DB_HOST=localhost
DB_PORT=5432
DB_NAME=launch_control
DB_USER=lc_admin
DB_POOL_SIZE=10
DB_TIMEOUT=30
EOF
````

````bash
cat > config/api.conf << 'EOF'
> # Launch Control — Configuración de API REST
# Entorno: desarrollo

API_HOST=0.0.0.0
API_PORT=8080
API_VERSION=v1
API_RATE_LIMIT=100
API_CORS_ORIGINS=http://localhost:3000
DEBUG=true
EOF
````

![alt text](image-5.png)

Luego se ejecuta el siguiente comando para verificar que los archivos de confitracion se han creado:

````bash
tree ~/launch-control/config/
````

![alt text](image-6.png)

se puede ejecutar el siguiente comando para validar el contenido de los archivos de configuracion:

````bash
cat api.conf database.conf
````

![alt text](image-7.png)

## Paso 3: Crear archivos secretos

ejecutamos los siguientes comandos para la creacion de los archivos secretos:

````bash
echo "sk-launch-control-api-dev-x8k2m9n4" > config/secrets/api_keys.txt
echo "sk-launch-control-api-dev-x8k2m9n4" > config/secrets/api_keys.txt
````

![alt text](image-8.png)

validamos que se hayan creado los archivos con el siguiente comando:

````bash
tree config/secrets/
````

![alt text](image-9.png)

nos movemos al directorio de secretos con el comando:

````bash
cd config/secrets
````

y verificamos el contenido de los archivos con el comando:

````bash
cat api_keys.txt db_password.txt
````

![alt text](image-10.png)

## Paso 4: Crear datos de vehículos

ejecutamos los siguientes comandos para la creacion de los archivos con los datos de vehiculos:

````bash
cat > data/vehicles/falcon9.dat << 'EOF'
VEHICLE_ID=VH-001
NAME=Falcon 9
MANUFACTURER=SpaceX
PAYLOAD_LEO_KG=22800
PAYLOAD_GTO_KG=8300
HEIGHT_M=70
STATUS=operational
FIRST_FLIGHT=2010-06-04
TOTAL_LAUNCHES=300
EOF

cat > data/vehicles/starship.dat << 'EOF'
VEHICLE_ID=VH-002
NAME=Starship
MANUFACTURER=SpaceX
PAYLOAD_LEO_KG=150000
PAYLOAD_GTO_KG=21000
HEIGHT_M=121
STATUS=testing
FIRST_FLIGHT=2023-04-20
TOTAL_LAUNCHES=12
EOF

cat > data/vehicles/electron.dat << 'EOF'
VEHICLE_ID=VH-003
NAME=Electron
MANUFACTURER=Rocket Lab
PAYLOAD_LEO_KG=300
PAYLOAD_GTO_KG=0
HEIGHT_M=18
STATUS=operational
FIRST_FLIGHT=2017-05-25
TOTAL_LAUNCHES=45
EOF
````

![alt text](image-11.png)

verificamos que los archivos se hayan creado correctamente con el comando:

````bash
tree ~/launch-control/data/vehicles/
````

![alt text](image-12.png)

luego verificamos el contenido de los archivos con los siguientes comandos: 

> Nos movemos hacia el directorio de los datos de los vehiculos ~/launch-control/data/vehicles/ 

````bash
cd ~/launch-control/data/vehicles/
````

````bash
cat electron.dat falcon9.dat starship.dat
````

![alt text](image-13.png)

## Paso 5: Crear datos de tripulaciones

Ejecutamos los siguientes comandos para la creacion de los datos de los tripulantes:

````bash
cat > data/crews/crew_alpha.dat << 'EOF'
CREW_ID=CR-001
NAME=Alpha
COMMANDER=María Torres
PILOT=Ahmed Nazari
SPECIALIST_1=Kenji Watanabe
SPECIALIST_2=Lucía Mendoza
STATUS=active
MISSION_ASSIGNED=MS-001
CLEARANCE_LEVEL=top_secret
EOF

at > data/crews/crew_beta.dat << 'EOF'
CREW_ID=CR-002
NAME=Beta
COMMANDER=David Kim
PILOT=Elena Volkov
SPECIALIST_1=Carlos Reyes
SPECIALIST_2=Priya Sharma
STATUS=standby
MISSION_ASSIGNED=none
CLEARANCE_LEVEL=secret
EOF
````

![alt text](image-14.png)

verificamos que los archivos de la informacion de los tripulantes este creada con el siguiente comando:

````bash
tree ~/launch-control/data/crews/
````

![alt text](image-15.png)

comprobamos el contenido de los archivos con el siguiente comando:

> nos movemos al directorio /data/crews y verficamos el contenido

````bash
cd data/crews/

cat crew_alpha.dat crew_beta.dat
````

![alt text](image-16.png)

## Paso 6: Crear logs de misiones

Ejecutamos los siguientes comandos:

````bash
    cat > data/missions/mission_001.log << 'EOF'
[2026-03-15 06:00:00] MISSION MS-001 INITIALIZED
[2026-03-15 06:15:00] VEHICLE VH-001 ASSIGNED
[2026-03-15 06:30:00] CREW CR-001 BOARDED
[2026-03-15 07:00:00] PREFLIGHT CHECK: PASSED
[2026-03-15 07:30:00] LAUNCH AUTHORIZED
[2026-03-15 07:31:00] IGNITION SEQUENCE STARTED
[2026-03-15 07:31:05] LIFTOFF CONFIRMED
[2026-03-15 07:33:00] MAX-Q PASSED
[2026-03-15 07:40:00] STAGE SEPARATION CONFIRMED
[2026-03-15 08:15:00] ORBIT INSERTION CONFIRMED
[2026-03-15 08:20:00] MISSION STATUS: NOMINAL
EOF

cat > data/missions/mission_002.log << 'EOF'
[2026-04-01 08:00:00] MISSION MS-002 INITIALIZED
[2026-04-01 08:15:00] VEHICLE VH-002 ASSIGNED
[2026-04-01 08:30:00] CREW: UNMANNED
[2026-04-01 09:00:00] PREFLIGHT CHECK: PASSED
[2026-04-01 09:30:00] LAUNCH AUTHORIZED
[2026-04-01 09:31:00] IGNITION SEQUENCE STARTED
[2026-04-01 09:31:05] LIFTOFF CONFIRMED
[2026-04-01 09:33:00] MAX-Q PASSED
[2026-04-01 09:35:22] ANOMALY DETECTED: HYDRAULIC PRESSURE DROP
[2026-04-01 09:35:30] FLIGHT TERMINATION SYSTEM ACTIVATED
[2026-04-01 09:35:35] MISSION STATUS: ABORTED
EOF

cat > data/missions/mission_003.log << 'EOF'
[2026-04-10 14:00:00] MISSION MS-003 INITIALIZED
[2026-04-10 14:15:00] VEHICLE VH-003 ASSIGNED
[2026-04-10 14:30:00] CREW: UNMANNED
[2026-04-10 14:45:00] PREFLIGHT CHECK: WARNING — WIND SPEED HIGH
[2026-04-10 15:00:00] LAUNCH DELAYED: WEATHER HOLD
[2026-04-10 16:30:00] WEATHER CLEARED
[2026-04-10 17:00:00] LAUNCH AUTHORIZED
[2026-04-10 17:01:00] IGNITION SEQUENCE STARTED
[2026-04-10 17:01:05] LIFTOFF CONFIRMED
[2026-04-10 17:15:00] ORBIT INSERTION CONFIRMED
[2026-04-10 17:20:00] PAYLOAD DEPLOYED
[2026-04-10 17:25:00] MISSION STATUS: SUCCESS
EOF
````

![alt text](image-17.png)

verificamos que los archivos con la información de las misiones se hayan creado con el siguiente comando:

````bash
ree data/missions/
````

![alt text](image-18.png)

comprobamos el contenido de los archivos con el siguiente comando:

````bash
cd data/missions/

cat mission_001.log mission_002.log mission_003.log
````

![alt text](image-19.png)

## Paso 7: Crear logs del sistema

Ejecutamos los siguientes comandos para la creacion de los logs del sistema

````bash
cat > logs/system.log << 'EOF'
[2026-04-15 00:00:01] SYSTEM BOOT SEQUENCE INITIATED
[2026-04-15 00:00:05] LOADING KERNEL MODULES
[2026-04-15 00:00:12] NETWORK INTERFACES UP
[2026-04-15 00:00:15] DATABASE SERVICE STARTED
[2026-04-15 00:00:18] API SERVICE STARTED ON PORT 8080
[2026-04-15 00:00:20] MONITORING AGENT ACTIVE
[2026-04-15 00:01:00] HEALTH CHECK: ALL SYSTEMS NOMINAL
EOF

cat > logs/access.log << 'EOF'
[2026-04-15 08:30:15] GET /api/v1/vehicles 200 — user:admin — 45ms
[2026-04-15 08:30:22] GET /api/v1/missions 200 — user:admin — 38ms
[2026-04-15 08:31:05] POST /api/v1/missions 201 — user:admin — 120ms
[2026-04-15 08:35:10] GET /api/v1/crews 200 — user:operator — 42ms
[2026-04-15 08:40:00] DELETE /api/v1/missions/999 404 — user:guest — 5ms
[2026-04-15 08:41:15] POST /api/v1/auth/login 401 — user:unknown — 3ms
[2026-04-15 08:41:16] POST /api/v1/auth/login 401 — user:unknown — 2ms
[2026-04-15 08:41:17] POST /api/v1/auth/login 401 — user:unknown — 2ms
EOF

cat > logs/errors.log << 'EOF'
[2026-04-15 08:40:00] ERROR: Resource not found — DELETE /api/v1/missions/999
[2026-04-15 08:41:15] WARN: Failed login attempt from 192.168.1.100
[2026-04-15 08:41:16] WARN: Failed login attempt from 192.168.1.100
[2026-04-15 08:41:17] CRITICAL: Brute force detected from 192.168.1.100 — IP blocked
EOF
````

![alt text](image-20.png)

verificamos la creacion de los logs con el siguiente comando:

````bash
tree logs/
````

![alt text](image-21.png)

verificamos el contendio de los logs con el siguiente comando:

````bash
cd logs/

cat system.log access.log errors.log
````

![alt text](image-22.png)

## Paso 8: Crear documentación

Ejecutamos los siguientes comandos para la creacion de documentacion:

````bash
cat > docs/README.md << 'EOF'
# Amtigravity Launch Control

Plataforma centralizada de gestión de lanzamientos espaciales.

## Componentes
- **API REST** — interfaz de comunicación (puerto 8080)
- **Base de datos** — PostgreSQL 16 (puerto 5432)
- **Sistema de logs** — registro de eventos y auditoría
- **Scripts de operaciones** — automatización de tareas

## Estructura del proyecto
Ejecutar `tree ~/launch-control` para ver la estructura completa.

## Equipo
Proyecto del curso IFCD0112 — Programación con Lenguajes OO y BBDD Relacionales
EOF

cat > docs/CHANGELOG.md << 'EOF'
# Changelog — Launch Control

## [0.1.0] — 2026-04-15
### Creado
- Estructura inicial del proyecto
- Archivos de configuración (database.conf, api.conf)
- Datos de vehículos (Falcon 9, Starship, Electron)
- Datos de tripulaciones (Alpha, Beta)
- Logs de misiones (001, 002, 003)
- Scripts de operaciones (backup, deploy, health_check, cleanup)
- Documentación base (README, CHANGELOG)
EOF

cat > docs/architecture/system_overview.txt << 'EOF'
LAUNCH CONTROL — VISTA GENERAL DEL SISTEMA

  ┌─────────────┐     ┌─────────────┐     ┌─────────────┐
  │   CLIENTE    │────→│   API REST  │────→│  BASE DATOS │
  │  (frontend)  │←────│  (port 8080)│←────│ (PostgreSQL) │
  └─────────────┘     └──────┬──────┘     └─────────────┘
                             │
                     ┌───────┴───────┐
                     │  LOGS / AUDIT │
                     │  (filesystem) │
                     └───────────────┘

Flujo de datos:
1. El cliente envía peticiones HTTP al API
2. El API valida, procesa y consulta la base de datos
3. Cada operación queda registrada en los logs
4. Los scripts de operaciones mantienen el sistema saludable
EOF
````

![alt text](image-23.png)

verficamos la creacion de la documentacion con el siguiente comando:

````bash
tree docs/
````

![alt text](image-24.png)

verificamos el contenido de los archivos con el siguiente comando:

````bash
cd docs/

cat README.md CHANGELOG.md architecture/system_overview.txt
````

![alt text](image-25.png)

## Paso 9: Crear el archivo de entorno y el placeholder de tmp

Ejecutamos los siguientes comandos para la creacion del archivo de entorno y el placeholder de tmp:

````bash
cat > .env << 'EOF'
# Variables de entorno — Launch Control
# ESTE ARCHIVO NUNCA SE SUBE A GIT
NODE_ENV=development
DATABASE_URL=postgresql://lc_admin:lc_db_password_2026_dev@localhost:5432/launch_control
API_SECRET=jwt-secret-dev-only-change-in-production
LOG_LEVEL=debug
EOF

# .gitkeep es una convención para que Git rastree directorios vacíos
touch tmp/.gitkeep
````

![alt text](image-26.png)

varificamos la creacion de los archivos creados con el siguiente comando:

> aqui no usamos el tree porque los archivos .env y tmp/ son archivos ocultos

````bash
ls -la .env tmp/
````

![alt text](image-27.png)

verificamos el contendio de los archivos creados con el siguiente comando:

````bash
cat .env tmp/.gitkeep
````

![alt text](image-28.png)

## Paso 10: Crear los scripts

ejecutar los siguientes comandos para la creacion de archivos scripts vacios

````bash
touch scripts/backup.sh scripts/deploy.sh scripts/health_check.sh scripts/cleanup.sh
````

verificamos que se hayan creado los archivos con el siguiente comando:

````bash
tree scripts/
````

![alt text](image-29.png)

## Verificación de Misión 2

se ejecuta el siguiente comando para verificar que la estructura del proyecto sea la correcta:

````bash
tree ~/launch-control
````

![alt text](image-30.png)

contamos todo lo que esta contenido en el directorio de /launch-control con el siguiente comando:

````bash
find ~/launch-control -type f | wc -l
````

> el resultado debe ser 22 archivos, pero da 24 porque esta contando los archvios .env y tmp/.gitkeep que son ocultos

![alt text](image-31.png)

# MISIÓN 3 — OPERACIONES DE DATOS

## Tarea 3.1: Backup de datos críticos

Crear una copia o backup de la carpeta data con el siguiente comando:

````bash
cp -r data/ data_backup/
````

![alt text](image-32.png)

verificamos que la copia de seguridad o backup y la carpeta original tengan la misma cantidad de informacion con el siguiente comando:

````bash
diff <(tree data/) <(tree data_backup/)
````

> si no muestra nada es porque la copia de seguridad o backup es correcta, y son identicos

![alt text](image-33.png)

## Tarea 3.2: Reorganizar misiones por estado

ejecutar el siguiente comando para crear la carpeta de misiones por estado:

````bash
mkdir -p data/missions/{completed,failed,delayed}
````

![alt text](image-34.png)

verificamos que se hayan creado las carpetas con el siguiente comando:

````bash
tree data/missions/
````

![alt text](image-35.png)

ahora debemos mover los archivos de las misiones a sus carpetas correspondientes segun su estado, ejecutamos el siguiente comando:

> Antes para conocer el estado de cada mision revisamos el final de cada archivo y veremos el estado con el siguiente comando

````bash
tail -1 data/missions/mission_001.log
tail -1 data/missions/mission_002.log
tail -1 data/missions/mission_003.log
````

![alt text](image-36.png)

ahora que conocemos los estados de cada mision podemos moverlos a sus carpetas con el siguiente comando:

````bash
# NOMINAL -> COMPLETED
mv data/missions/mission_001.log data/missions/completed/mission_001.log
# ABORTED -> FAILED
mv data/missions/mission_002.log data/missions/failed/mission_002.log
# SUCCESS -> COMPLETED
mv data/missions/mission_003.log data/missions/completed/mission_003.log
````

![alt text](image-37.png)
![alt text](image-38.png)
![alt text](image-39.png)

verificamos que los archivos se hayan movido a sus carpetas correspondientes con el siguiente comando:

````bash
tree data/missions/
````

![alt text](image-40.png)

## Tarea 3.3: Buscar información con grep

### Pregunta 1: ¿Qué vehículo tiene más capacidad de carga?

ejecutamos el siguiente comando para buscar la informacion en todos los archvivos .dat

````bash
grep "PAYLOAD_LEO_KG" data/vehicles/*.dat
````

![alt text](image-41.png)

> ## Respuesta : Starship: 150000 kg

### Pregunta 2: ¿Cuántos intentos de login fallidos hubo?

ejecutamos el siguiente comando para buscar la informacion en todos los archvivos .log

````bash
grep -c "Failed login" logs/errors.log
````

![alt text](image-42.png)

> ## Pregunta 3: ¿Desde qué IP atacaron?

ejecutamos el siguiente comando: 

````bash
grep "Brute force" logs/errors.log
````

![alt text](image-43.png)

> ## Respuesta : [192.168.1.100]

## Pregunta 4: ¿Qué misiones tuvieron anomalías?

ejecutamos el siguiente comando: 

````bash
grep -rl "ANOMALY\|ABORT\|CRITICAL\|WARNING" data/missions/
````

![alt text](image-44.png)

> ## Respuesta : mission_002.log y mission_003.log

## Pregunta 5: ¿Quién es el comandante de la tripulación Alpha?

ejecutamos el siguiente comando : 

````bash
grep "COMMANDER" data/crews/crew_alpha.dat
````

![alt text](image-45.png)

> ## Respuesta : Commander: María Torres

## Tarea 3.4: Operaciones con wildcards

Cambios las extensiones de los archivos .dat en data/vehicles/ a .cfg con el siguiente comando:

````bash
for f in data/vehicles/*.dat; do
    mv "$f" "${f%.dat}.cfg"
done
````

![alt text](image-46.png)

verificamos que los archivos .dat ahora esten con la extension .cfg con el siguiente comando:

````bash
tree data/vehicles/
````

![alt text](image-47.png)

ahora revertimos la operacion regresando la extension de los archivos a .dat con el siguiente comando:

````bash
for f in data/vehicles/*.cfg; do
    mv "$f" "${f%.cfg}.dat"
done
````

![alt text](image-48.png)

verificamos que los archivos .cfg ahora esten con la extension .dat con el siguiente comando:

````bash
tree data/vehicles/
````

![alt text](image-49.png)

## Tarea 3.5: Generar un inventario

Creamos un archivo que tenga toda la informacion de los directorios del proyecto llamado inventroy.txt con el siguiente comando:

````bash
find . -type f | sort > docs/inventory.txt
````

![alt text](image-50.png)

verificamos el contenido del archivo inventory.txt con el siguiente comando:

````bash
cat docs/inventory.txt 
````

![alt text](image-51.png)


verificamos la cantidad de archivos con el siguiente comando:

````bash
 wc -l docs/inventory.txt
````

![alt text](image-52.png)

## Verificación de Misión 3

ejecutamos los siguientes comandos para verificar que la estructura del proyecto sea la correcta:

````bash
# Las misiones están reorganizadas
ls data/missions/completed/ data/missions/failed/
````

![alt text](image-53.png)

````bash
# El inventario existe
test -f docs/inventory.txt && echo "INVENTARIO OK" || echo "FALTA INVENTARIO"
````

![alt text](image-54.png)

````bash
# El backup existe
test -d data_backup && echo "BACKUP OK" || echo "FALTA BACKUP"
````

![alt text](image-55.png)


# MISIÓN 4 — SEGURIDAD Y PERMISOS

verificamos los permisos actuales de los archivos de seguridad con el siguiente comando:

````bash
s -la config/secrets/
````

> los permisos actuales de estos archivos con 644 y otros usuarios puedes ingresar y modificarlos.

![alt text](image-56.png)


## Paso 2: Asegurar archivos secretos

modificamos los permisos para que los archviso de segurdad solo puedan ser accedidos por el dueño, ejecutamos los siguientes comandos:

````bash
chmod 600 config/secrets/*.txt
````

![alt text](image-57.png)

verificamos los permisos actuales de los archivos de seguridad con el siguiente comando:

````bash
ls -la config/secrets/*.txt
````

![alt text](image-58.png)

hacemos los mismo con el archivo .env modificamos y verificamos los permisos para que solo el dueño pueda accederlo con los siguientes comandos:

````bash
chmod 600 .env && ls -la .env
````

![alt text](image-59.png)

## Paso 3: Proteger el directorio de secretos

ejecutamos el siguiente comando: 

````bash
chmod 700 config/secrets/
ls -la config/
````

![alt text](image-60.png)


## Paso 4: Configurar permisos correctos para todo el proyecto

ejecutamos los siguientes comandos : 

````bash
# Configuración: legible por grupo, no por otros
chmod 640 config/database.conf
chmod 640 config/api.conf

# Tripulaciones: datos sensibles, solo dueño y grupo
chmod 640 data/crews/crew_alpha.dat
chmod 640 data/crews/crew_beta.dat

# Vehículos: datos públicos
chmod 644 data/vehicles/*.dat

# Logs del sistema: sensibles
chmod 640 logs/system.log
chmod 640 logs/access.log
chmod 640 logs/errors.log

# Logs de misiones: públicos
find data/missions/ -name "*.log" -exec chmod 644 {} \;

# Documentación: pública
chmod 644 docs/README.md
chmod 644 docs/CHANGELOG.md
chmod 644 docs/architecture/system_overview.txt
chmod 644 docs/inventory.txt

# Scripts: ejecutables
chmod 755 scripts/*.sh
````

## Paso 5: Verificar la auditoría completa

verificamos los permisos con el siguiente comando: 

````bash
tree -p
````

![alt text](image-61.png)

## Verificación de Misión 4

ejecutamos los siguientes comandos :

````bash
# Secretos protegidos
stat -c "%a %n" config/secrets/* .env 2>/dev/null

# Scripts ejecutables
stat -c "%a %n" scripts/*.sh

# Configuración correcta
stat -c "%a %n" config/*.conf
````

![alt text](image-62.png)

# MISIÓN 5 — AUTOMATIZACIÓN

## Script 1: health_check.sh

creamos un script con el siguiente comando:

````bash
cat > ~/launch-control/scripts/health_check.sh << 'SCRIPT'
#!/bin/bash
# ═══════════════════════════════════════════
# Launch Control — Health Check
# Verifica la integridad del proyecto
# ═══════════════════════════════════════════

PROJECT_DIR="$HOME/launch-control"
ERRORS=0
CHECKS=0

echo "╔═══════════════════════════════════════╗"
echo "║   LAUNCH CONTROL — HEALTH CHECK       ║"
echo "║   $(date '+%Y-%m-%d %H:%M:%S')        ║"
echo "╚═══════════════════════════════════════╝"
echo ""

# --- Verificar directorios críticos ---
echo ">> Verificando directorios..."
for DIR in config data logs scripts docs tmp config/secrets data/vehicles data/crews data/missions; do
    CHECKS=$((CHECKS + 1))
    if [ -d "$PROJECT_DIR/$DIR" ]; then
        echo "   [OK] $DIR"
    else
        echo "   [FALLO] $DIR NO EXISTE"
        ERRORS=$((ERRORS + 1))
    fi
done
echo ""

# --- Verificar archivos críticos ---
echo ">> Verificando archivos de configuración..."
for FILE in config/database.conf config/api.conf .env; do
    CHECKS=$((CHECKS + 1))
    if [ -f "$PROJECT_DIR/$FILE" ]; then
        echo "   [OK] $FILE"
    else
        echo "   [FALLO] $FILE NO EXISTE"
        ERRORS=$((ERRORS + 1))
    fi
done
echo ""

# --- Verificar permisos de secretos ---
echo ">> Verificando seguridad de archivos secretos..."
for SECRET in config/secrets/db_password.txt config/secrets/api_keys.txt .env; do
    CHECKS=$((CHECKS + 1))
    if [ -f "$PROJECT_DIR/$SECRET" ]; then
        PERMS=$(stat -c "%a" "$PROJECT_DIR/$SECRET" 2>/dev/null || stat -f "%Lp" "$PROJECT_DIR/$SECRET" 2>/dev/null)
        if [ "$PERMS" = "600" ]; then
            echo "   [OK] $SECRET (permisos: $PERMS)"
        else
            echo "   [ALERTA] $SECRET tiene permisos $PERMS — debería ser 600"
            ERRORS=$((ERRORS + 1))
        fi
    fi
done
echo ""

# --- Verificar que los scripts son ejecutables ---
echo ">> Verificando scripts ejecutables..."
for SCRIPT_FILE in scripts/backup.sh scripts/deploy.sh scripts/health_check.sh scripts/cleanup.sh; do
    CHECKS=$((CHECKS + 1))
    if [ -x "$PROJECT_DIR/$SCRIPT_FILE" ]; then
        echo "   [OK] $SCRIPT_FILE es ejecutable"
    else
        echo "   [ALERTA] $SCRIPT_FILE NO es ejecutable"
        ERRORS=$((ERRORS + 1))
    fi
done
echo ""

# --- Resumen ---
echo "═══════════════════════════════════════"
echo "RESULTADO: $CHECKS verificaciones, $ERRORS errores"
if [ $ERRORS -eq 0 ]; then
    echo "ESTADO: TODOS LOS SISTEMAS OPERATIVOS"
else
    echo "ESTADO: $ERRORS PROBLEMAS DETECTADOS"
fi
echo "═══════════════════════════════════════"
SCRIPT
````

luego modificamos los permisos del archivo con el siguiente comando : 

````bash
chmod 755 ~/launch-control/scripts/health_check.sh
````

y finalmente los ejecutamos con el comando:

````bash
sh ~/launch-control/scripts/health_check.sh
````

![alt text](image-63.png)

## Script 2: backup.sh

ejecturar el siguiente comando : 

````bash
cat > ~/launch-control/scripts/backup.sh << 'SCRIPT'
#!/bin/bash
# ═══════════════════════════════════════════
# Launch Control — Backup automático
# ═══════════════════════════════════════════

PROJECT_DIR="$HOME/launch-control"
BACKUP_NAME="launch-control-backup-$(date '+%Y%m%d_%H%M%S')"
BACKUP_DIR="$HOME/$BACKUP_NAME"

echo "Iniciando backup de Launch Control..."
echo "Origen:  $PROJECT_DIR"
echo "Destino: $BACKUP_DIR"
echo ""

cp -r "$PROJECT_DIR" "$BACKUP_DIR"

if [ $? -eq 0 ]; then
    TOTAL_FILES=$(find "$BACKUP_DIR" -type f | wc -l)
    TOTAL_DIRS=$(find "$BACKUP_DIR" -type d | wc -l)
    echo "Backup completado."
    echo "  Archivos copiados: $TOTAL_FILES"
    echo "  Directorios: $TOTAL_DIRS"
    echo "  Ubicación: $BACKUP_DIR"
else
    echo "ERROR: el backup falló."
    exit 1
fi
SCRIPT
````

luego modificamos los permisos del archivo con el siguiente comando : 

````bash
chmod 755 ~/launch-control/scripts/backup.sh
````

luego ejecuatamos el script con el comando:

````bash
sh ~/launch-control/scripts/backup.sh
````

![alt text](image-64.png)

verificamos que el backup exista con el siguiente comando

````bash
ls -l ~/launch-control-backup-*
````

![alt text](image-65.png)

## Script 3: cleanup.sh

ejecutamos el siguiente comando : 

````bash
cat > ~/launch-control/scripts/cleanup.sh << 'SCRIPT'
#!/bin/bash
# ═══════════════════════════════════════════
# Launch Control — Limpieza de temporales
# ═══════════════════════════════════════════

PROJECT_DIR="$HOME/launch-control"

echo "Iniciando limpieza de Launch Control..."
echo ""

# Contar archivos en tmp/
TMP_COUNT=$(find "$PROJECT_DIR/tmp" -type f ! -name ".gitkeep" | wc -l)
echo "Archivos temporales encontrados: $TMP_COUNT"

if [ $TMP_COUNT -gt 0 ]; then
    find "$PROJECT_DIR/tmp" -type f ! -name ".gitkeep" -delete
    echo "Temporales eliminados."
else
    echo "No hay temporales que limpiar."
fi

# Mostrar tamaño de logs
echo ""
echo "Tamaño de archivos de log:"
du -sh "$PROJECT_DIR/logs/"* 2>/dev/null
echo ""

TOTAL_SIZE=$(du -sh "$PROJECT_DIR" | awk '{print $1}')
echo "Tamaño total del proyecto: $TOTAL_SIZE"
echo "Limpieza completada."
SCRIPT
````

cambiamos los permisos del archivo con el siguiente comando : 

````bash
chmod 755 ~/launch-control/scripts/cleanup.sh
````

![alt text](image-66.png)

## Script 4: deploy.sh

ejectuamos el siguiente comando : 

````bash
cat > ~/launch-control/scripts/deploy.sh << 'SCRIPT'
#!/bin/bash
# ═══════════════════════════════════════════
# Launch Control — Deploy (simulación)
# ═══════════════════════════════════════════

PROJECT_DIR="$HOME/launch-control"
DEPLOY_OK=true

echo "╔═══════════════════════════════════════╗"
echo "║   LAUNCH CONTROL — DEPLOY            ║"
echo "║   $(date '+%Y-%m-%d %H:%M:%S')              ║"
echo "╚═══════════════════════════════════════╝"
echo ""

# Pre-flight checks
echo ">> Pre-flight checks..."

# 1. Verificar que existe la configuración
if [ ! -f "$PROJECT_DIR/config/database.conf" ]; then
    echo "   [FALLO] Falta config/database.conf"
    DEPLOY_OK=false
else
    echo "   [OK] Configuración de base de datos"
fi

if [ ! -f "$PROJECT_DIR/config/api.conf" ]; then
    echo "   [FALLO] Falta config/api.conf"
    DEPLOY_OK=false
else
    echo "   [OK] Configuración de API"
fi

# 2. Verificar que .env existe y es seguro
if [ ! -f "$PROJECT_DIR/.env" ]; then
    echo "   [FALLO] Falta .env"
    DEPLOY_OK=false
else
    PERMS=$(stat -c "%a" "$PROJECT_DIR/.env" 2>/dev/null || stat -f "%Lp" "$PROJECT_DIR/.env" 2>/dev/null)
    if [ "$PERMS" = "600" ]; then
        echo "   [OK] .env existe y tiene permisos seguros ($PERMS)"
    else
        echo "   [ALERTA] .env tiene permisos $PERMS — debería ser 600"
        DEPLOY_OK=false
    fi
fi

# 3. Verificar que hay al menos un vehículo registrado
VEHICLES=$(find "$PROJECT_DIR/data/vehicles" -name "*.dat" | wc -l)
if [ "$VEHICLES" -eq 0 ]; then
    echo "   [FALLO] No hay vehículos registrados"
    DEPLOY_OK=false
else
    echo "   [OK] $VEHICLES vehículos registrados"
fi

echo ""

# Decisión de deploy
if [ "$DEPLOY_OK" = true ]; then
    echo ">> Todos los checks pasaron."
    echo ">> Simulando deploy..."
    echo "   Cargando configuración..."
    echo "   Conectando a base de datos..."
    echo "   Iniciando API en puerto 8080..."
    echo "   Registrando en logs..."
    echo "$(date '+[%Y-%m-%d %H:%M:%S]') DEPLOY: Despliegue exitoso" >> "$PROJECT_DIR/logs/system.log"
    echo ""
    echo "DEPLOY COMPLETADO — Launch Control operativo"
else
    echo ">> DEPLOY ABORTADO — corrijan los errores antes de desplegar"
    exit 1
fi
SCRIPT
````

cambiamos los permisos del archivo con el siguiente comando : 

````bash
chmod 755 ~/launch-control/scripts/deploy.sh
````

![alt text](image-67.png)

luego hacemos la ejecucion de todos los scripts en un solo comando:

````bash
echo "=== HEALTH CHECK ===" && ~/launch-control/scripts/health_check.sh
echo ""
echo "=== CLEANUP ===" && ~/launch-control/scripts/cleanup.sh
echo ""
echo "=== BACKUP ===" && ~/launch-control/scripts/backup.sh
echo ""
echo "=== DEPLOY ===" && ~/launch-control/scripts/deploy.sh
````

![alt text](image-68.png)

# Verificación de Misión 5

verificamos la ejecucion de todos los comandos : 

````bash
# Verificar que todos los scripts son ejecutables y tienen contenido
for s in ~/launch-control/scripts/*.sh; do
    LINES=$(wc -l < "$s")
    echo "$(basename $s): $LINES líneas, $(test -x "$s" && echo 'ejecutable' || echo 'NO ejecutable')"
done
````

![alt text](image-69.png)

# MISIÓN 6 — INSPECCIÓN FINAL

ejectuamos el siguiente comando : 

 ````bash
 cat > ~/launch-control/scripts/generate_report.sh << 'SCRIPT'
#!/bin/bash
# ═══════════════════════════════════════════
# Launch Control — Generador de informe
# ═══════════════════════════════════════════

PROJECT_DIR="$HOME/launch-control"
REPORT="$PROJECT_DIR/docs/status_report.txt"

{
echo "═══════════════════════════════════════════════════════"
echo "  LAUNCH CONTROL — INFORME DE ESTADO"
echo "  Generado: $(date '+%Y-%m-%d %H:%M:%S')"
echo "  Generado por: $(whoami)@$(hostname)"
echo "═══════════════════════════════════════════════════════"
echo ""

echo ">> ESTRUCTURA DEL PROYECTO"
tree "$PROJECT_DIR" 2>/dev/null || find "$PROJECT_DIR" -print | sort
echo ""

echo ">> ESTADÍSTICAS"
echo "   Total archivos: $(find "$PROJECT_DIR" -type f | wc -l)"
echo "   Total directorios: $(find "$PROJECT_DIR" -type d | wc -l)"
echo "   Tamaño total: $(du -sh "$PROJECT_DIR" | awk '{print $1}')"
echo ""

echo ">> VEHÍCULOS REGISTRADOS"
for v in "$PROJECT_DIR"/data/vehicles/*.dat; do
    NAME=$(grep "^NAME=" "$v" | cut -d= -f2)
    STATUS=$(grep "^STATUS=" "$v" | cut -d= -f2)
    echo "   - $NAME ($STATUS)"
done
echo ""

echo ">> TRIPULACIONES"
for c in "$PROJECT_DIR"/data/crews/*.dat; do
    NAME=$(grep "^NAME=" "$c" | cut -d= -f2)
    COMMANDER=$(grep "^COMMANDER=" "$c" | cut -d= -f2)
    STATUS=$(grep "^STATUS=" "$c" | cut -d= -f2)
    echo "   - Tripulación $NAME: Comandante $COMMANDER ($STATUS)"
done
echo ""

echo ">> MISIONES"
echo "   Completadas: $(find "$PROJECT_DIR/data/missions/completed" -name "*.log" 2>/dev/null | wc -l)"
echo "   Fallidas: $(find "$PROJECT_DIR/data/missions/failed" -name "*.log" 2>/dev/null | wc -l)"
echo "   Demoradas: $(find "$PROJECT_DIR/data/missions/delayed" -name "*.log" 2>/dev/null | wc -l)"
echo ""

echo ">> SEGURIDAD"
echo "   Archivos con permiso 600 (solo dueño):"
find "$PROJECT_DIR" -type f -perm 600 -exec echo "   - {}" \;
echo ""
echo "   Scripts ejecutables:"
find "$PROJECT_DIR/scripts" -type f -executable -exec echo "   - {}" \;
echo ""

echo ">> ÚLTIMAS ENTRADAS DE LOG"
echo "   System log (últimas 3 líneas):"
tail -3 "$PROJECT_DIR/logs/system.log" | sed 's/^/   /'
echo ""
echo "   Error log (últimas 3 líneas):"
tail -3 "$PROJECT_DIR/logs/errors.log" | sed 's/^/   /'
echo ""

echo "═══════════════════════════════════════════════════════"
echo "  FIN DEL INFORME"
echo "═══════════════════════════════════════════════════════"
} > "$REPORT"

echo "Informe generado en: $REPORT"
echo "Líneas del informe: $(wc -l < "$REPORT")"
SCRIPT
 ````


ejecutamos el script para generar el reporte con el siguiente comando : 

````bash
sh ~/launch-control/scripts/generate_report.sh
````

![alt text](image-70.png)

revisamos el contenido del reporte generado con el comando:

````bash
cat docs/status_report.txt
````

![alt text](image-72.png)


## Paso 2: Verificación final completa

ejecutamos el siguiente comando : 

````bash
echo "=== VERIFICACIÓN FINAL ==="
echo ""

# 1. Estructura
echo "1. ESTRUCTURA"
tree ~/launch-control | tail -1
echo ""

# 2. Archivos totales
echo "2. ARCHIVOS"
find ~/launch-control -type f | wc -l
echo ""

# 3. Permisos de secretos
echo "3. PERMISOS SECRETOS"
stat -c "%a %n" ~/launch-control/config/secrets/* ~/launch-control/.env
echo ""

# 4. Scripts ejecutables
echo "4. SCRIPTS"
ls -la ~/launch-control/scripts/*.sh | awk '{print $1, $NF}'
echo ""

# 5. Misiones organizadas
echo "5. MISIONES ORGANIZADAS"
tree ~/launch-control/data/missions/
echo ""

# 6. Health check final
echo "6. HEALTH CHECK"
sh ~/launch-control/scripts/health_check.sh
````

![alt text](image-73.png)


# RETOS EXTRA (para quienes terminen antes)

Escriban un script scripts/monitor.sh que:

Muestre las últimas 5 líneas de cada archivo .log en logs/
Muestre la hora actual
Se ejecute en bucle cada 5 segundos (pista: while true + sleep)
Se pueda detener con Ctrl+C


se crea un archivo en scripts con el nombre de monitor.sh
y se le inserte el siguiente codigo:

````bash
#!/bin/bash
while true; do
    echo "=== $(date) log ACCESS ===" 
    tail -5 ~/launch-control/logs/access.log
    echo "=== $(date) log ERRORS ===" 
    tail -5 ~/launch-control/logs/errors.log
    echo "=== $(date) log SYSTEM ===" 
    tail -5 ~/launch-control/logs/system.log
    echo "======" 
    sleep 5
done
````
![alt text](image-74.png)

se ejectua el script con el siguiente comando : 

````bash
sh ~/launch-control/scripts/monitor.sh
````

![alt text](image-75.png)

> para terminar la ejecucion del scripts se presiona la combinacion de teclas Ctrl + C

## Reto 2: Búsqueda inteligente
Sin abrir ningún archivo manualmente, respondan estas preguntas usando solamente grep, find, wc, sort y pipes:

¿Cuántos archivos .dat tiene el proyecto?

> Respuesta : ````bash find ~/launch-control -type f | grep "\.dat$" | wc -l ````
![alt text](image-76.png)

¿Qué archivo contiene la palabra "CRITICAL"?
> Respuesta : ````bash grep -rl "CRITICAL" ~/launch-control ````
![alt text](image-77.png)

¿Cuál es el vehículo con menos lanzamientos?
> Respuesta : ````bash  grep "TOTAL_LAUNCHES" ~/launch-control/data/vehicles/*.dat | sort -t '=' -k 2 -n ````
![alt text](image-78.png)

¿Cuántas líneas tiene el archivo más largo del proyecto?
f> Respuesta : ````find ~/launch-control -type f -exec wc -l {} + | grep -v "total" | sort -rn | head -n 1 ````
![alt text](image-79.png)

¿Qué archivos fueron modificados en los últimos 10 minutos?
> Respuesta : ````bash find ~/launch-control -type f -mmin -10 ````
![alt text](image-80.png)


## Reto 3: Script de nuevo vehículo
Escriban un script scripts/add_vehicle.sh que reciba como parámetros el nombre del vehículo y la carga útil, y cree automáticamente el archivo .dat con el formato correcto.


````bash 
cat > ~/launch-control/scripts/add_vehicle.sh << 'SCRIPT'
#!/bin/bash

if [ $# -lt 2 ]; then
    echo "ERROR: Parametros insuficientes. Uso: $0 [nombre] [carga]"
    exit 1
fi

echo "Creo un archivo con el nombre $1"

touch ~/launch-control/data/vehicles/$1.dat

echo "NAME=$1" >> ~/launch-control/data/vehicles/$1.dat
echo "PAYLOAD_LEO_KG=$2" >> ~/launch-control/data/vehicles/$1.dat


echo "ARCHIVO CREADO CORRECTAMENTE."
'SCRIPT'
````

se ejecuta el comando para la crecion de nuevo arvhivos para vehiculos : 

````bash 
sh ~/launch-control/scripts/add_vehicles.sh RENIER 123
````

![alt text](image-81.png)

verificamos el directorio de vehiculos: 

````bash 
tree ~/launch-control/data/vehicles/
````

![alt text](image-82.png)

## Reto 4: Auditoría de seguridad
Escriban un script scripts/security_audit.sh que:

ejecutamos los siguientes comandos : 
````bash
touch security_audit.sh
chmod 755 security_audit.sh
````

![alt text](image-83.png)

Busque todos los archivos con permisos 777 (peligroso) y los reporte


Busque archivos que contengan la palabra "password" y verifique que tienen permiso 600
Busque intentos de login fallidos en los logs
Genere un informe de seguridad en docs/security_audit.txt

ejecutamos el siguiente comando :

````bash
#!/bin/bash

# Configuración de rutas
BASE_DIR="$HOME/launch-control"
REPORT_FILE="$BASE_DIR/docs/security_audit.txt"

# Crear el directorio de docs si no existe
mkdir -p "$BASE_DIR/docs"

echo "--- INFORME DE AUDITORÍA DE SEGURIDAD ---" > "$REPORT_FILE"
echo "Fecha: $(date)" >> "$REPORT_FILE"
echo "---------------------------------------" >> "$REPORT_FILE"

# 1. Buscar archivos con permisos 777
echo -e "\n[1] Archivos con permisos peligrosos (777):" >> "$REPORT_FILE"
find "$BASE_DIR" -type f -perm 777 >> "$REPORT_FILE"

# 2. Buscar archivos con la palabra "password" y verificar permisos 600
echo -e "\n[2] Archivos con la palabra 'password' que NO tienen permiso 600:" >> "$REPORT_FILE"
# Buscamos archivos que contienen la palabra, luego filtramos los que NO tienen permisos 600
find "$BASE_DIR" -type f -exec grep -l "password" {} + | while read -r file; do
    perms=$(stat -c "%a" "$file")
    if [ "$perms" != "600" ]; then
        echo "ALERTA: $file tiene permisos $perms (se recomienda 600)" >> "$REPORT_FILE"
    fi
done

# 3. Buscar intentos de login fallidos
echo -e "\n[3] Resumen de intentos de login fallidos:" >> "$REPORT_FILE"
# Nota: En sistemas basados en Debian/Ubuntu se usa /var/log/auth.log
# En RHEL/CentOS se suele usar /var/log/secure
if [ -f /var/log/auth.log ]; then
    grep "Failed password" /var/log/auth.log | tail -n 20 >> "$REPORT_FILE"
elif [ -f /var/log/secure ]; then
    grep "Failed" /var/log/secure | tail -n 20 >> "$REPORT_FILE"
else
    echo "No se pudo acceder a los logs de autenticación (¿permisos de root?)." >> "$REPORT_FILE"
fi

echo -e "\nAuditoría finalizada. Informe generado en: $REPORT_FILE"
````

y ejecutamos el comando

````bash
sh ~/launch-control/scripts/security_audit.sh
````

![alt text](image-85.png)

