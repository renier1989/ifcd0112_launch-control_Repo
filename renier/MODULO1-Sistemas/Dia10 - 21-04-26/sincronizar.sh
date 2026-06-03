#!/bin/bash
# ═══════════════════════════════════════════════════════════
# sincronizar.sh — Sincronización de carpeta compartida
# Espejo unidireccional: VirtualBox shared folder → copia local
#
# QUÉ HACE:
#   1. Espera a que VirtualBox monte la carpeta compartida
#   2. Verifica que la fuente existe
#   3. Copia todo con rsync en modo espejo (--delete)
#   4. Registra el resultado en un log
#
# CONFIGURACIÓN:
#   Cambiar NOMBRE_COMPARTIDO por el nombre de la carpeta
#   compartida configurada en VirtualBox.
# ═══════════════════════════════════════════════════════════

# ─── CAMBIAR ESTE VALOR ────────────────────────────────────
NOMBRE_COMPARTIDO="curso_poo"
# ───────────────────────────────────────────────────────────

FUENTE="/media/sf_${NOMBRE_COMPARTIDO}/"
DESTINO="$HOME/sync_curso/${NOMBRE_COMPARTIDO}/"
LOG="$HOME/.sync_curso.log"

# Si se ejecuta al arranque, esperar a que VirtualBox monte
if [ ! -d "$FUENTE" ]; then
    echo "Esperando a que se monte la carpeta compartida..."
    sleep 5
fi

# Verificar que la fuente existe y está montada
if [ ! -d "$FUENTE" ]; then
    MSG="[$(date '+%Y-%m-%d %H:%M:%S')] ERROR: $FUENTE no está montada"
    echo "$MSG" >> "$LOG"
    echo "$MSG"
    echo ""
    echo "  Posibles causas:"
    echo "  - La carpeta compartida no está configurada en VirtualBox"
    echo "  - El disco donde está la carpeta no está conectado"
    echo "  - Verificar en VBox → Configuración → Carpetas compartidas"
    notify-send "Sincronización" "ERROR: carpeta compartida no montada" 2>/dev/null
    exit 1
fi

# Crear directorio destino si no existe
mkdir -p "$DESTINO"

# Sincronizar en modo espejo
rsync -a --delete "$FUENTE" "$DESTINO" >> "$LOG" 2>&1

# Registrar resultado
if [ $? -eq 0 ]; then
    ARCHIVOS=$(find "$DESTINO" -type f | wc -l)
    MSG="[$(date '+%Y-%m-%d %H:%M:%S')] Sincronización exitosa — $ARCHIVOS archivos"
    echo "$MSG" >> "$LOG"
    echo "$MSG"
    notify-send "Sincronización" "Completada: $ARCHIVOS archivos" 2>/dev/null
else
    MSG="[$(date '+%Y-%m-%d %H:%M:%S')] ERROR en sincronización"
    echo "$MSG" >> "$LOG"
    echo "$MSG"
    notify-send "Sincronización" "ERROR — revisar ~/.sync_curso.log" 2>/dev/null
    exit 1
fi
