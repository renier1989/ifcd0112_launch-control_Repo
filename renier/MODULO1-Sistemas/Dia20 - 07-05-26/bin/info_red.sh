#!/bin/bash
# ═══════════════════════════════════════════════════════════
# info_red.sh — Mostrar información de red de la máquina
# ═══════════════════════════════════════════════════════════

echo "═══════════════════════════════════════════"
echo "  INFO RED — $(hostname)"
echo "═══════════════════════════════════════════"
echo ""

# Interfaces y sus IPs
echo "INTERFACES DE RED:"
ip -4 addr show | grep -E "inet |^[0-9]" | while read -r linea; do
    if echo "$linea" | grep -q "^[0-9]"; then
        IFACE=$(echo "$linea" | awk -F: '{print $2}' | tr -d ' ')
        echo ""
        echo "  Interfaz: $IFACE"
    fi
    if echo "$linea" | grep -q "inet "; then
        IP=$(echo "$linea" | awk '{print $2}')
        echo "    IP: $IP"
    fi
done
echo ""

# Gateway
echo "GATEWAY:"
ip route | grep default | awk '{printf "   %s vía %s\n", $5, $3}'
echo ""

# DNS
echo "DNS:"
if [ -f /etc/resolv.conf ]; then
    grep "^nameserver" /etc/resolv.conf | awk '{printf "   %s\n", $2}'
fi
echo ""

# ¿Hay conexión a internet?
echo "CONECTIVIDAD:"
if ping -c 1 -W 2 8.8.8.8 &>/dev/null; then
    echo "   Internet: ✓ OK"
else
    echo "   Internet: ✗ Sin conexión"
fi

# ¿Puertos escuchando?
echo ""
echo "PUERTOS ESCUCHANDO:"
ss -tlnp 2>/dev/null | grep LISTEN | awk '{printf "   %s (%s)\n", $4, $NF}' | head -10

echo ""
echo "═══════════════════════════════════════════"
