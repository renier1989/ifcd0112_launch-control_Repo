#!/bin/bash

# 1. Limpieza de datos (por si acaso hay restos de Windows)
sed -i 's/\r//' discos.csv

# 2. Capturamos la vista original ANTES de tocar nada
original=$(tail -n +2 discos.csv)

# 3. Cargamos los datos en arrays (listas)
duraciones=($(cut -d',' -f5 discos.csv | tail -n +2))
filas=()
while IFS= read -r line; do
    filas+=("$line")
done < <(tail -n +2 discos.csv)

n=${#duraciones[@]}

# --- MOSTRAR EL "ANTES" ---
echo "========================================"
echo "LISTA ORIGINAL (Desordenada):"
echo "========================================"
echo "$original" | column -s',' -t
echo ""

echo "Iniciando ordenamiento (Motor: while + if)..."

# --- ALGORITMO DE SELECCIÓN CON WHILE ---
i=0
while [ $i -lt $((n - 1)) ]; do
    min=$i
    
    j=$((i + 1))
    while [ $j -lt $n ]; do
        # Comparamos si el disco actual es más corto que el mínimo guardado
        if [ ${duraciones[j]} -lt ${duraciones[min]} ]; then
            min=$j
        fi
        j=$((j + 1)) # Incremento manual del bucle interno
    done
    
    # Si encontramos un disco más pequeño, intercambiamos la posición[cite: 2]
    if [ $min -ne $i ]; then
        # Intercambio de la llave (duración)
        temp_dur=${duraciones[i]}
        duraciones[i]=${duraciones[min]}
        duraciones[min]=$temp_dur
        
        # Intercambio de la información completa (fila)[cite: 2]
        temp_fila="${filas[i]}"
        filas[i]="${filas[min]}"
        filas[min]="$temp_fila"
    fi

    i=$((i + 1)) # Incremento manual del bucle externo[cite: 2]
done

# --- MOSTRAR EL "DESPUÉS" ---
echo "========================================"
echo "LISTA FINAL (Ordenada por Duración):"
echo "========================================"
printf "%s\n" "${filas[@]}" | column -s',' -t
echo "========================================"
