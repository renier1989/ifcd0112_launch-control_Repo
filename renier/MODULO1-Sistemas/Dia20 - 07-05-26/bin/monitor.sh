#!/bin/bash
# ═══════════════════════════════════════════════════════════
# monitor.sh — Monitorizar un directorio
# Uso: monitor.sh /ruta/directorio [intervalo_segundos]
# ═══════════════════════════════════════════════════════════

DIRECTORIO="${1:-.}"          # primer argumento, o directorio actual
INTERVALO="${2:-5}"            # segundo argumento, o 5 segundos

if [ ! -d "$DIRECTORIO" ]; then
    echo "ERROR: $DIRECTORIO no es un directorio"
    exit 1
fi

echo "Monitorizando: $DIRECTORIO (cada ${INTERVALO}s)"
echo "Ctrl+C para detener"
echo ""

while true; do
    ARCHIVOS=$(find "$DIRECTORIO" -type f | wc -l)
    TAMANO=$(du -sh "$DIRECTORIO" 2>/dev/null | cut -f1)
    ULTIMO=$(find "$DIRECTORIO" -type f -printf '%T@ %p\n' 2>/dev/null | \
             sort -rn | head -1 | cut -d' ' -f2-)

    echo "[$(date '+%H:%M:%S')] Archivos: $ARCHIVOS | Tamaño: $TAMANO | Último: $(basename "$ULTIMO" 2>/dev/null)"
    sleep "$INTERVALO"
done
