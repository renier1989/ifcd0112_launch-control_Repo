#!/bin/bash

nombres=()
while IFS= read -r linea; do
	nombres+=("$linea")
done < "estudiantes.txt"

desordenado=true

while [ "$desordenado" = true ]; do
	desordenado=false
	for((i=0; i< ${#nombres[@]} - 1; i++)); do
		if [[ "${nombres[i]}" > "${nombres[$((i+1))]}"  ]]; then
			#echo "Par desordenado"
			temp=${nombres[i]}
			nombres[i]="${nombres[$((i+1))]}"
			nombres[$((i+1))]="$temp"
			desordenado=true
			#echo "primero : ${nombres[i]}"
			#echo "segundo : ${nombres[$((i+1))]}"
		fi
	done
done

for nombre in "${nombres[@]}"; do
	echo "$nombre"
done

#echo ${nombres}
