#!/bin/bash
# ============================================================================
# PROGRAMA: mover_y_ordenar.sh
# DESCRIPCIÓN: 
#   1. Mueve un nombre específico (ej: "Dario") a una posición concreta (ej: principio)
#   2. Ordena alfabéticamente el resto de los nombres
#   3. Mantiene el nombre movido en su posición fija
# ============================================================================

# 1. LIMPIEZA DE DATOS (eliminar \r de Windows)
# ----------------------------------------------------------------------------
# El comando 'sed -i' modifica el archivo directamente
# 's/\r//' busca y elimina el carácter retorno de carro (Windows)
sed -i 's/\r//' estudiantes.txt

# 2. CARGAR NOMBRES EN UN ARRAY
# ----------------------------------------------------------------------------
# $(cat estudiantes.txt) ejecuta cat y captura su salida
# Los paréntesis convierten esa salida en un array (una línea = un elemento)
nombres=($(cat estudiantes.txt))

# ${#nombres[@]} devuelve la longitud del array (número de elementos)
n=${#nombres[@]}

# ============================================================================
# CONFIGURACIÓN: QUÉ NOMBRE MOVER Y DÓNDE
# ============================================================================

# NOMBRE_A_MOVER: el nombre que queremos reubicar
# EJEMPLO: "Dario" (con mayúscula exactamente como aparece en la lista)
NOMBRE_A_MOVER="Dario"

# POSICION_DESTINO: índice donde queremos ponerlo (0 = primera posición)
# 0 = principio, 1 = segunda posición, 2 = tercera, etc.
POSICION_DESTINO=0

# ============================================================================
# 3. VERIFICAR QUE EL NOMBRE EXISTE (ejemplo de validación)
# ============================================================================

# Variable para saber si encontramos el nombre
encontrado=-1  # -1 significa "no encontrado aún"
# El -1 es un valor centinela (marcador temporal)
# Podríamos usar cualquier valor negativo, pero 0 es una posición válida

# Bucle para buscar el nombre en el array
for i in "${!nombres[@]}"; do
    # ${!nombres[@]}  → el ! significa "índices" (0,1,2,3...)
    # "${nombres[i]}" → el valor en esa posición
    if [[ "${nombres[i]}" == "$NOMBRE_A_MOVER" ]]; then
        encontrado=$i  # Guardamos la posición donde está
        break          # Salir del bucle (ya lo encontramos)
    fi
done

# EXLPLICACIÓN DEL break:
# Sin 'break', seguiría buscando aunque ya lo hubiera encontrado
# Es más eficiente salir inmediatamente

# NOTA DIDÁCTICA: Podríamos usar un 'while' en lugar de 'for'
# while [ $i -lt $n ]; do
#     if [ "${nombres[i]}" = "$NOMBRE_A_MOVER" ]; then
#         encontrado=$i
#         break
#     fi
#     i=$((i+1))
# done
# PERO el 'for' con índices es más elegante en Bash

# Verificar si encontramos el nombre
if [ $encontrado -eq -1 ]; then
    echo "ERROR: No se encontró '$NOMBRE_A_MOVER' en la lista"
    echo "Los nombres disponibles son:"
    printf "  - %s\n" "${nombres[@]}"
    exit 1  # Salir con código de error (1 indica fallo)
fi

# ============================================================================
# 4. EXTRAER EL NOMBRE DE SU POSICIÓN ORIGINAL
# ============================================================================

# Guardamos el nombre en una variable (por si necesitamos manipularlo)
nombre_movido="${nombres[encontrado]}"

# ============================================================================
# 5. CREAR NUEVO ARRAY SIN EL NOMBRE MOVIDO
# ----------------------------------------------------------------------------
# Explicación: Vamos a crear un array 'resto' que contiene todos los nombres
# EXCEPTO el que queremos mover. Hay varias formas de hacerlo:
# ============================================================================

# FORMA 1: Usando un bucle (MÁS DIDÁCTICA, fácil de entender)
# ----------------------------------------------------------------------------
resto=()  # Array vacío para los nombres que se quedan
for i in "${!nombres[@]}"; do
    # Si este índice NO es donde está el nombre a mover
    if [ $i -ne $encontrado ]; then
        # Añadir este nombre al array 'resto'
        resto+=("${nombres[i]}")
        # += es el operador de concatenación para arrays en Bash
        # Los paréntesis con la string convierten el nombre en un elemento nuevo
    fi
done

# FORMA 2: Usando slicing de arrays (menos didáctico pero más compacto)
# ----------------------------------------------------------------------------
# Esto sería: resto=(${nombres[@]:0:encontrado} ${nombres[@]:encontrado+1})
# PERO NO LO USAMOS para que los alumnos entiendan el bucle
# Por eso está comentado:
# resto=("${nombres[@]:0:$encontrado}" "${nombres[@]:$((encontrado+1))}")

# FORMA 3: Usando unset y reasignando (también válido)
# ----------------------------------------------------------------------------
# unset 'nombres[encontrado]'  # Eliminar el elemento (deja hueco)
# resto=("${nombres[@]}")      # Reasignar sin el hueco
# PERO NO LO USAMOS porque unset deja un índice vacío que luego da problemas

# ============================================================================
# 6. ORDENAR ALFABÉTICAMENTE EL ARRAY 'resto'
# ----------------------------------------------------------------------------
# Aquí aplicamos el MISMO algoritmo de burbuja que en el script anterior
# Pero ahora SOLO sobre los nombres que quedan (sin Dario)
# ============================================================================

echo "Ordenando los ${#resto[@]} nombres restantes..."

m=${#resto[@]}  # m = tamaño del array resto

# ALGORITMO DE BURBUJA (igual que antes)
i=0
while [ $i -lt $m ]; do
    j=0
    while [ $j -lt $((m - i - 1)) ]; do
        # Comparación alfabética (string > string)
        if [[ "${resto[j]}" > "${resto[j+1]}" ]]; then
            # Intercambio (swap)
            temp=${resto[j]}
            resto[j]=${resto[j+1]}
            resto[j+1]=$temp
        fi
        j=$((j + 1))
    done
    i=$((i + 1))
done

# ============================================================================
# 7. INSERTAR EL NOMBRE MOVIDO EN LA POSICIÓN DESTINO
# ----------------------------------------------------------------------------
# Ahora tenemos:
#   - nombre_movido = "Dario"
#   - resto = ["Ana", "Beatriz", "Carlos", "Zoe"] (ordenado)
#   - POSICION_DESTINO = 0 (principio)
# Vamos a construir el array final
# ============================================================================

# Inicializar array final vacío
final=()

# CASO 1: Insertar al PRINCIPIO (POSICION_DESTINO = 0)
# ----------------------------------------------------------------------------
if [ $POSICION_DESTINO -eq 0 ]; then
    # Primero va el nombre movido
    final+=("$nombre_movido")
    # Luego todos los del array resto
    final+=("${resto[@]}")
    
# CASO 2: Insertar al FINAL (POSICION_DESTINO = cantidad de elementos)
# ----------------------------------------------------------------------------
elif [ $POSICION_DESTINO -ge ${#resto[@]} ]; then
    # Si el destino es mayor o igual que el tamaño, va al final
    # Primero todos los de resto
    final+=("${resto[@]}")
    # Luego el nombre movido
    final+=("$nombre_movido")
    
# CASO 3: Insertar en MEDIO (entre dos elementos)
# ----------------------------------------------------------------------------
else
    # PARTE 1: Elementos antes de la posición destino
    # ${resto[@]:0:POSICION_DESTINO}  → desde índice 0, tomar POSICION_DESTINO elementos
    final+=("${resto[@]:0:$POSICION_DESTINO}")
    
    # PARTE 2: El nombre movido
    final+=("$nombre_movido")
    
    # PARTE 3: Elementos después de la posición destino
    # ${resto[@]:POSICION_DESTINO}  → desde índice POSICION_DESTINO hasta el final
    final+=("${resto[@]:$POSICION_DESTINO}")
fi

# EXPLICACIÓN DEL SLICING (rebanado de arrays):
# ----------------------------------------------------------------------------
# Si resto = ["Ana", "Beatriz", "Carlos", "Zoe"] y queremos poner Dario en posición 2:
#   ${resto[@]:0:2}  → ["Ana", "Beatriz"]  (los 2 primeros)
#   Luego añadimos "Dario"
#   ${resto[@]:2}    → ["Carlos", "Zoe"]   (desde índice 2 hasta final)
# Resultado: ["Ana", "Beatriz", "Dario", "Carlos", "Zoe"]

# ============================================================================
# 8. MOSTRAR RESULTADOS
# ============================================================================

echo "========================================"
echo "RESULTADO FINAL:"
echo "========================================"
echo "Nombre movido: $NOMBRE_A_MOVER"
echo "Posición destino: $POSICION_DESTINO (0 = primera posición)"
echo ""
echo "Lista modificada:"
printf "%s\n" "${final[@]}"
echo "========================================"

# ============================================================================
# NOTAS DIDÁCTICAS ADICIONALES:
# ============================================================================
# 
# ¿QUÉ PASARÍA SI QUEREMOS MOVER UN NOMBRE QUE APARECE MÚLTIPLES VECES?
# El script actual solo mueve la PRIMERA aparición (por el 'break')
# Para mover TODAS las apariciones, habría que:
#   - Eliminar el 'break' y recolectar todos los índices en otro array
#   - O usar un bucle while que vaya moviendo uno por uno
#
# ¿QUÉ PASARÍA SI EL NOMBRE NO EXISTE?
# El script lo detecta y muestra error (líneas 56-62)
#
# ¿CÓMO MODIFICAR PARA MOVER A OTRA POSICIÓN?
# Solo cambiar POSICION_DESTINO:
#   POSICION_DESTINO=0  → al principio
#   POSICION_DESTINO=3  → después del tercer elemento
#   POSICION_DESTINO=999 → al final (automático por el 'elif')
#
# ¿POR QUÉ USAMOS DOS ARRAYS DIFERENTES (resto y final)?
# Por claridad didáctica. Podríamos modificar el array original,
# pero es más fácil de entender paso a paso con arrays separados.
#
# COMPLEJIDAD DEL ALGORITMO:
# - Búsqueda del nombre: O(n)
# - Creación de 'resto': O(n)
# - Ordenamiento burbuja: O(m²) donde m = n-1
# - Inserción final: O(n)
# Total: O(n²) (dominado por la burbuja)
#
# POSIBLE MEJORA DIDÁCTICA:
# Para listas muy grandes, podríamos usar 'sort' de Linux:
#   resto_ordenado=($(printf "%s\n" "${resto[@]}" | sort))
# Pero usamos burbuja para aprender el algoritmo.
# ============================================================================
