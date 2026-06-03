#!/bin/bash
nombre=$1
posicion=$2
if [[ -z ${nombre} ]]; then
	echo "No hay nombre,"
	echo "valor esperado $0 <arg1:nombre> <arg2:posicion>"
	exit 1
fi

if [[ -z ${posicion} ]]; then
	echo "No hay posicion"
	echo "valor esperado $0 <arg1:nombre> <arg2:posicion>"
	exit 1
fi

nombres=()
while IFS= read -r linea; do
	nombres+=("$linea")
done < estudiantes.txt

existe=false
for nombre_lista in "${nombres[@]}"; do
	if [[ "$nombre_lista" == "$nombre" ]]; then
		existe=true
		break
	fi
done

if [[ "$existe" == true ]]; then
	echo "existe!!!!"
else
	echo "El nombre: [$nombre], no existe!"
	exit 1
fi


desordenado=true
while [ "$desordenado" = true ]; do
	desordenado=false
	for ((i=0; i< ${#nombres[@]} - 1; i++)); do
		if [[ "{$nombres[i]}" > "${nombres[$((i+1))]}" ]]; then
			temp="${nombres[i]}"
			nombres[i]="${nombres[$((i+1))]}"
			nombres[$((i+1))]="$temp"
			desordenado=true
			#echo "primero : ${nombres[i]}"
			#echo "segundo: ${nombres[$((i+1))]}"
		fi
	done
done


for nombre_ordenado in "${nombres[@]}"; do
	echo "$nombre_ordenado"
done

#echo "$nombres"
#echo "Nombre: $1, posicion: $2"
