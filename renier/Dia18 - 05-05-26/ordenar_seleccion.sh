#!/bin/bash

# 1. Extraer duraciones y limpiar caracteres raros
# Usamos tr -d para quitar cualquier residuo de Windows (\r)
duraciones=($(cut -d',' -f5 discos.csv | tail -n +2 | tr -d '\r'))
n=${#duraciones[@]}

echo "Ordenando por duración (Algoritmo de Selección)..."

for ((i=0; i<n-1; i++)); do
    min=$i
    for ((j=i+1; j<n; j++)); do
        # Comparación numérica pura
        if [[ ${duraciones[j]} -lt ${duraciones[min]} ]]; then
            min=$j
        fi
    done
    # Intercambio
    temp=${duraciones[i]}
    duraciones[i]=${duraciones[min]}
    duraciones[min]=$temp
done

echo "Lista ordenada (minutos):"
echo "${duraciones[*]}"
