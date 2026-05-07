#!/bin/bash
# ═══════════════════════════════════════════════════════════
# estado_cluster.sh — Diagnóstico del cluster y sistema local
# IFCD0112 — Amtigravity Launch Control
# ═══════════════════════════════════════════════════════════

ARTEMIS="192.168.62.20"
DESKTOP="192.168.62.10"
USUARIO="control"

echo "═══════════════════════════════════════════"
echo "  ESTADO DEL CLUSTER — $(hostname)"
echo "  $(date '+%A %d de %B de %Y, %H:%M')"
echo "═══════════════════════════════════════════"
echo ""

# ─── Conectividad del cluster ─────────────────────────
echo "[CLUSTER]"

# Verificar Artemis
if ping -c 1 -W 2 "$ARTEMIS" &>/dev/null; then
    echo "  Artemis ($ARTEMIS):  OK"

    # Intentar SSH para obtener uptime
    UPTIME=$(ssh -o ConnectTimeout=3 -o BatchMode=yes "$USUARIO"@"$ARTEMIS" uptime -p 2>/dev/null)
    if [ $? -eq 0 ]; then
        echo "  Artemis SSH:         OK — $UPTIME"
    else
        echo "  Artemis SSH:         sin acceso (¿clave SSH configurada?) $USUARIO@$ARTEMIS  "
    fi
else
    echo "  Artemis ($ARTEMIS):  SIN RESPUESTA"
fi

# Verificar Desktop
if ping -c 1 -W 2 "$DESKTOP" &>/dev/null; then
    echo "  Desktop ($DESKTOP):  OK"
else
    echo "  Desktop ($DESKTOP):  sin respuesta"
fi
echo ""

# ─── Sistema local ────────────────────────────────────
echo "[SISTEMA LOCAL]"
echo "  Usuario: $USER@$(hostname)"
echo "  Disco:   $(df -h / | awk 'NR==2 {printf "%s de %s (%s)", $3, $2, $5}')"
echo "  Memoria: $(free -h | awk '/Mem:/ {printf "%s de %s", $3, $2}')"
echo "  Procs:   $(ps aux | wc -l) totales"
echo ""

# ─── Red local ────────────────────────────────────────
echo "[RED]"
ip -4 addr show | grep "inet " | grep -v "127.0.0.1" | awk '{printf "  %s → %s\n", $NF, $2}'
echo ""

# ─── Proyecto ─────────────────────────────────────────
if [ -d "$HOME/curso_ifcd0112" ]; then
    echo "[PROYECTO LAUNCH CONTROL]"
    ARCHIVOS=$(find "$HOME/curso_ifcd0112" -type f | wc -l)
    TAMANO=$(du -sh "$HOME/curso_ifcd0112" 2>/dev/null | cut -f1)
    echo "  Archivos: $ARCHIVOS | Tamaño: $TAMANO"
fi

echo ""
echo "═══════════════════════════════════════════"
