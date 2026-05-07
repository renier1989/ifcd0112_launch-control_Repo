#!/bin/bash
set -euo pipefail
#===============================
# validarArtemis.sh - realizar acciones sobre el servidor de artemis
# Renier Vargas - Curso Poo Madrid
#===============================


# --------------- VARIALBLES/ CONFIGURACION  ---------------
LOG="$HOME/estudios/diagnostico_$(date +%Y%m%d_%H%m)".log


# --------------- COLORES ---------------
VERDE="\033[0;32m"
ROJO="\033[0;31m"
AMARILLO="\033[1;33m"
RESET="\033[0m"

# --------------- FUNCIONES ---------------

#funciones para mostrar colores en las funciones
ok() { echo -e " ${VERDE}[OK]${RESET} $1 "; }
error() { echo -e " ${ROJO}[ERROR]${RESET} $1 "; }
warning() { echo -e " ${AMARILLO}[WARNING]${RESET} $1 "; }

# funcion para hacer ping al servidor de artemis
verificar_red_artemis() {
	while true; do
		read -t 60 -p "Cual es la IP: formato(x.x.x.x):" IP
		if verificar_ip_valida "$IP"; then
			break
		fi
	done
	echo "Haciendo ping a $IP..."

	if ping -c 1 -W 2 "$IP" &>/dev/null; then
		ok "$IP - Responde"
	else
		error "$IP - No Response"
	fi
}

# funcion para realizar una conexion ssh a un server
conectar_artemis(){
	read -t 60 -p "Cual es usuario?:" USER
	while true; do
		read -t 60 -p "A que server quieres ingresar?: " IP
		if verificar_ip_valida "$IP"; then
			break
		fi
	done

	if ping -c 1 -W 2 "$IP" &>/dev/null; then
		ok "$IP - Responde"
		echo "CONECTANDO A $USER@$IP..."
		sleep 4
		ssh "$USER@$IP"
	else
		error "$IP - No Response"
	fi

}

# funcion para realizar verficacion de ips
verificar_ip_valida(){
	IP=$1
	if [[ $IP =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
		return 0
	else
	        warning "Formato incorrecto. Ejemplo: 192.168.56.20"
		return 1
	fi
}

# funcion para revisar estado de servicios en otro server
comprobar_servicios(){
	read -n 1 -t 60 -p "Desea realizar una comprobacion Remota? (s/n) :" RESPUESTA
	echo ""

	if [[ "$RESPUESTA" = "s" ]]; then
		read -t 60 -p "Cual es usuario?:" USER
		while true; do
			read -t 60 -p "A que server quieres ingresar?: " IP
			if verificar_ip_valida "$IP"; then
				break
			fi
		done

		read -t 60 -p "Que servicios desea comprobar | [ej: curl ssh git etc.]: " SERVICIOS

		if ping -c 1 -W 2 "$IP" &>/dev/null; then
			ok "$IP - Responde"
			echo "CONECTANDO A $USER@$IP..."
			sleep 3
			ssh "$USER@$IP" "systemctl status $SERVICIOS"
		else
			error "$IP - No Response"
		fi

	else
		read -t 60 -p "Que servicios desea comprobar | [ej: curl ssh git etc.]: " SERVICIOS
		systemctl status $SERVICIOS
	fi
	#ssh control@192.168.62.20 "systemctl status $SERVICIOS "
}

herramientas(){
	echo "Modo de uso: ${0} [opciones]"
	echo ""
	echo "Opciones:"
	echo "-h, --help 	Muesta la guia de uso"
	echo "-p, --ping	Hacer ping a una IP en particular"
	echo "-c, --conn	Conectar a un servidor"
	echo "-s, --serv	Comprueba el estado de los Servicios Local/Remoto"
	echo ""
}

# --------------- VALIDACION DE ARGUMENTOS ---------------
case "${1:-}" in 
	-h|--help)	herramientas; exit 0 ;;
	-p|--ping)	verificar_red_artemis; exit 0 ;;
	-c|--conn)	conectar_artemis; exit 0 ;;
	-s|--serv)	comprobar_servicios; exit 0 ;;
	"")	;; #no se le pasan argumentos
	*) 	echo "Opcion no valida: $1"; exit 1 ;;
esac


# --------------- EJECUCION ---------------

# llamado de funciones
echo "═══════════════════════════════════════"
echo "  DIAGNÓSTICO DE ARTEMIS — $(hostname)"
echo "  $(date '+%d/%m/%Y %H:%M:%S')"
echo "═══════════════════════════════════════"
echo ""
herramientas
