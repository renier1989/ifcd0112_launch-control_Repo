#!/bin/bash
# ═══════════════════════════════════════════════════════════
# backup_launch_control.sh — Backup comprimido con fecha
# ═══════════════════════════════════════════════════════════

FECHA=$(date +%Y-%m-%d_%H%M)
ORIGEN="$HOME/curso_ifcd0112"
DESTINO="$HOME/backups"
NOMBRE="launch_control_$FECHA.tar.gz"

# Crear directorio de backups si no existe
mkdir -p "$DESTINO"

# Verificar que el origen existe
if [ ! -d "$ORIGEN" ]; then
    echo "ERROR: No existe $ORIGEN"
    echo "Crealo primero: mkdir -p $ORIGEN"
    exit 1
fi

# Crear el backup
echo "Creando backup..."
tar -czf "$DESTINO/$NOMBRE" -C "$HOME" "curso_ifcd0112"

# Verificar resultado
if [ $? -eq 0 ]; then
    TAMANO=$(du -sh "$DESTINO/$NOMBRE" | cut -f1)
    echo "✓ Backup creado: $DESTINO/$NOMBRE ($TAMANO)"
else
    echo "✗ ERROR al crear el backup"
    exit 1
fi

# Mostrar los últimos 5 backups
echo ""
echo "Últimos backups:"
ls -lht "$DESTINO"/launch_control_*.tar.gz 2>/dev/null | head -5
