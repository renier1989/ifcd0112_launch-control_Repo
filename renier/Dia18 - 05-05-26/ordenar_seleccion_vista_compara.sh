#!/bin/bash

# 1. Limpieza y preparación
sed -i 's/\r//' discos.csv
original=$(tail -n +2 discos.csv)

# Cargamos las duraciones Y las filas completas en dos arrays paralelos
duraciones=($(cut -d',' -f5 discos.csv | tail -n +2))
filas=()
while IFS= read -r line; do
    filas+=("$line")
done < <(tail -n +2 discos.csv)

n=${#duraciones[@]}

echo "========================================"
echo "LISTA ORIGINAL (Desordenada):"
echo "========================================"
echo "$original" | column -s',' -t
echo ""

echo "Ejecutando Algoritmo de Selección en paralelo..."

# --- ALGORITMO DE SELECCIÓN ---
for ((i=0; i<n-1; i++)); do
    min=$i
    for ((j=i+1; j<n; j++)); do
        if [[ ${duraciones[j]} -lt ${duraciones[min]} ]]; then
            min=$j
        fi
    done
    
    # ¡EL TRUCO! Intercambiamos los números...
    temp_dur=${duraciones[i]}
    duraciones[i]=${duraciones[min]}
    duraciones[min]=$temp_dur
    
    # ...Y TAMBIÉN intercambiamos las filas completas
    temp_fila="${filas[i]}"
    filas[i]="${filas[min]}"
    filas[min]="$temp_fila"
done

echo "========================================"
echo "LISTA FINAL ORDENADA POR DURACIÓN:"
echo "========================================"
# Convertimos el array de nuevo a formato tabla
printf "%s\n" "${filas[@]}" | column -s',' -t
echo "========================================"
