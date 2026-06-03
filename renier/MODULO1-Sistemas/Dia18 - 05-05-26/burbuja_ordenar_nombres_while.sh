#!/bin/bash
# ============================================================================
# PROGRAMA: ordenar_estudiantes.sh
# DESCRIPCIÓN: Ordena alfabéticamente una lista de nombres usando algoritmo de burbuja
# AUTOR: (tu nombre)
# FECHA: (fecha actual)
# ============================================================================

# 1. LIMPIEZA DE DATOS (eliminar caracteres ocultos de Windows)
# ----------------------------------------------------------------------------
# El comando 'sed -i' modifica el archivo directamente (sin crear copia de seguridad)
# La expresión 's/\r//' significa:
#   - s/   → comando de sustitución (substitute)
#   - \r   → busca el carácter "retorno de carro" (código ASCII 13, CR)
#   - //   → reemplázalo por NADA (lo elimina)
#   - /    → cierra la expresión
# ¿Por qué? Los archivos creados en Windows terminan cada línea con \r\n (CR+LF)
# En Linux solo debe haber \n (LF). El \r sobrante puede causar errores al comparar strings.
# EJEMPLO: "Ana\r\n" → después del sed → "Ana\n"
sed -i 's/\r//' estudiantes.txt

# 2. CARGAR ARCHIVO EN UN ARRAY
# ----------------------------------------------------------------------------
# $(cat estudiantes.txt)  → ejecuta 'cat' y usa su salida como texto
# Los paréntesis $(...) ejecutan un comando y capturan su salida
# Los corchetes (...) alrededor convierten esa salida en un array
# CADA LÍNEA del archivo se convierte en UN ELEMENTO del array
nombres=($(cat estudiantes.txt))

# n = número total de elementos del array
# ${#nombres[@]}   → el # delante indica "longitud", [@] significa "todos los elementos"
n=${#nombres[@]}

# 3. MOSTRAR LISTA ORIGINAL
# ----------------------------------------------------------------------------
# echo con muchos '=' → solo decoración visual para separar secciones
echo "========================================"
echo "LISTA ORIGINAL (Desordenada):"
echo "========================================"

# printf "%s\n" "${nombres[@]}" → imprime cada elemento en una línea
#   %s   → formato: string (cadena de texto)
#   \n   → salto de línea después de cada string
#   "${nombres[@]}" → todos los elementos del array, preservando espacios
printf "%s\n" "${nombres[@]}"
echo ""  # línea en blanco para separar visualmente

echo "Iniciando Algoritmo de Burbuja (while + if)..."

# 4. ALGORITMO DE BURBUJA
# ----------------------------------------------------------------------------
# Algoritmo de ordenamiento: compara elementos adyacentes y los intercambia
# si están en el orden incorrecto. Tras cada pasada, el elemento más grande
# "burbujea" hasta su posición correcta al final.

# i = contador de pasadas completadas
i=0

# BUCLE EXTERNO: controla cuántas pasadas hacemos
# Necesitamos n-1 pasadas en el peor caso (todo al revés)
while [ $i -lt $n ]; do
    
    # j = índice que recorre el array en cada pasada
    j=0
    
    # BUCLE INTERNO: compara pares adyacentes
    # La condición: mientras j sea menor que (n - i - 1)
    # EXPLICACIÓN: después de cada pasada, el último elemento ya está ordenado
    #   - Si i=0 (primera pasada): j va de 0 a n-2  (última comparación: n-2 con n-1)
    #   - Si i=1 (segunda pasada): j va de 0 a n-3  (n-1 ya está en su sitio)
    #   - Si i=2: j va de 0 a n-4, etc.
    while [ $j -lt $((n - i - 1)) ]; do
        
        # COMPARACIÓN ALFABÉTICA
        # [[ "${nombres[j]}" > "${nombres[j+1]}" ]]
        #   [[ ]] → construcción mejorada de Bash para comparaciones
        #   >     → operador de comparación alfabética (lexicográfica)
        #   ¿Qué significa "mayor"? En orden alfabético:
        #     "Carlos" > "Ana" porque C viene después de A en ASCII/Unicode
        #     "Ana"   > "Ana"  → falso (son iguales)
        #     "Ana"   > "Zoe"  → falso (A antes que Z)
        if [[ "${nombres[j]}" > "${nombres[j+1]}" ]]; then
            
            # INTERCAMBIO (SWAP) de dos elementos
            # Paso 1: guardar temporalmente el valor de nombres[j] en una variable
            temp=${nombres[j]}
            
            # Paso 2: sobrescribir nombres[j] con nombres[j+1]
            nombres[j]=${nombres[j+1]}
            
            # Paso 3: poner el valor guardado (temp) en nombres[j+1]
            nombres[j+1]=$temp
            
            # EJEMPLO: si nombres[0]="Carlos" y nombres[1]="Ana"
            #   temp="Carlos"
            #   nombres[0]="Ana"
            #   nombres[1]="Carlos"
            # Resultado: ["Ana", "Carlos"]  → ahora están ordenados
        fi
        
        # INCREMENTAMOS j para pasar al siguiente par
        # j=$((j + 1))  → $(( )) es para operaciones aritméticas en Bash
        # Esto equivale a j++ en otros lenguajes
        j=$((j + 1))
    done
    
    # INCREMENTAMOS i (una pasada más completada)
    i=$((i + 1))
done

# 5. MOSTRAR LISTA FINAL ORDENADA
# ----------------------------------------------------------------------------
echo "========================================"
echo "LISTA FINAL (Ordenada Alfabéticamente):"
echo "========================================"

# Mismo printf que antes, pero ahora el array ya está ordenado
printf "%s\n" "${nombres[@]}"
echo "========================================"

# ============================================================================
# EJEMPLO DE EJECUCIÓN:
# Si estudiantes.txt contiene:
#   Carlos
#   Ana
#   Zoe
#   Beatriz
#
# El array comienza como: ["Carlos", "Ana", "Zoe", "Beatriz"]
# 
# Primera pasada (i=0):
#   Compara "Carlos" > "Ana"? Sí → intercambia → ["Ana", "Carlos", "Zoe", "Beatriz"]
#   Compara "Carlos" > "Zoe"? No
#   Compara "Zoe" > "Beatriz"? Sí → intercambia → ["Ana", "Carlos", "Beatriz", "Zoe"]
# 
# Segunda pasada (i=1):
#   Compara "Ana" > "Carlos"? No
#   Compara "Carlos" > "Beatriz"? Sí → intercambia → ["Ana", "Beatriz", "Carlos", "Zoe"]
#
# Tercera pasada (i=2):
#   Compara "Ana" > "Beatriz"? No
#
# Resultado final: ["Ana", "Beatriz", "Carlos", "Zoe"]
# ============================================================================
