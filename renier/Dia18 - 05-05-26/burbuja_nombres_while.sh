#!/bin/bash
# ============================================================================
# PROGRAMA: mover_sin_for.sh
# DESCRIPCIÓN: 
#   Mueve un nombre a una posición específica SIN usar el comando 'for'
#   Solo usamos: while, if, arrays y operaciones básicas
# ============================================================================

# 1. LIMPIEZA DE DATOS (eliminar \r de Windows)
# ----------------------------------------------------------------------------
# sed -i: edita el archivo directamente
# s/\r//: sustituye el retorno de carro (Windows) por NADA
sed -i 's/\r//' estudiantes.txt

# 2. CARGAR NOMBRES EN UN ARRAY
# ----------------------------------------------------------------------------
# $(cat estudiantes.txt) → ejecuta cat y captura su salida
# Los paréntesis convierten cada línea en un elemento del array
# Se hace esto con  el archivo en el disco duro porque es como un LIBRO CERRADO.
# Para trabajar con su contenido, primero tenemos que ABRIRLO y TRAER SU CONTENIDO 
#a la memoria RAM
nombres=($(cat estudiantes.txt))

# ${#nombres[@]} → cuenta cuántos elementos tiene el array
# "Dame TODOS los NÚMEROS de POSICIÓN (índices) que existen en el array llamado 'nombres
n=${#nombres[@]}

# ============================================================================
# CONFIGURACIÓN: QUÉ MOVER Y DÓNDE
# ============================================================================

NOMBRE_A_MOVER="Dario"
POSICION_DESTINO=0  # 0 = principio, 1 = segunda posición, etc.

# ============================================================================
# 3. BUSCAR EL NOMBRE SIN USAR FOR (SOLO CON WHILE)
# ----------------------------------------------------------------------------
# En lugar de 'for i in "${!nombres[@]}"', usamos un contador manual
# OJO
# [[ ]] Es un COMANDO ESPECIAL de Bash que evalúa expresiones lógicas y devuelve
#  verdadero o falso. Los dobles corchetes son como un "preguntador inteligente"
#  que entiende el lenguaje humano mejor que el [ ] simple osea se lee [[ condición ]]
# pero solo en SÓLO Bash
# ============================================================================

encontrado=-1  # -1 = no encontrado aún (valor centinela)
i=0            # Contador manual, empieza en 0

# Mientras no hayamos llegado al final DEL ARRAY Y no hayamos encontrado el nombre
while [ $i -lt $n ] && [ $encontrado -eq -1 ]; do
    # COMPARACIÓN: ¿El nombre en esta posición es el que buscamos?
    # [[ ]] es la versión mejorada de test en Bash
    # == compara strings exactamente (incluye mayúsculas/minúsculas)
    if [[ "${nombres[i]}" == "$NOMBRE_A_MOVER" ]]; then
        encontrado=$i  # Guardamos la posición donde está
        # NO HACE FALTA 'break' porque la condición del while
        # [ $encontrado -eq -1 ] dejará de ser cierta
    fi
    i=$((i + 1))  # IMPORTANTE: incrementar el contador para no bucle infinito
done

# Verificar si encontramos el nombre
if [ $encontrado -eq -1 ]; then
    echo "ERROR: No se encontró '$NOMBRE_A_MOVER'"
    echo "Lista actual:"
    
    # Mostrar lista SIN usar for (con while)
    k=0
    while [ $k -lt $n ]; do
        echo "  - ${nombres[k]}"
        k=$((k + 1))
    done
    exit 1
fi

echo "✅ Encontrado '$NOMBRE_A_MOVER' en la posición $encontrado"

# ============================================================================
# 4. CREAR ARRAY RESTO (SIN EL NOMBRE MOVIDO) USANDO SOLO WHILE
# ----------------------------------------------------------------------------
# Vamos a copiar todos los nombres EXCEPTO el que queremos mover
# ============================================================================

resto=()       # Array vacío para los nombres que se quedan
i=0            # Reiniciamos contador a 0

# Mientras no hayamos recorrido todo el array original
while [ $i -lt $n ]; do
    # Si esta posición NO es donde está el nombre a mover
    if [ $i -ne $encontrado ]; then
        # Añadir este nombre al array 'resto'
        # Los paréntesis y += concatenan un nuevo elemento
        resto+=("${nombres[i]}")
    fi
    i=$((i + 1))
done

# Mostrar qué nombres quedan (solo para depuración didáctica)
echo "Nombres restantes (sin $NOMBRE_A_MOVER): ${#resto[@]} elementos"

# ============================================================================
# 5. ORDENAR EL ARRAY 'RESTO' CON ALGORITMO DE BURBUJA (SOLO WHILE)
# ----------------------------------------------------------------------------
# ============================================================================

m=${#resto[@]}  # m = número de elementos en 'resto'

# Si solo hay 0 o 1 elementos, ya está ordenado
if [ $m -gt 1 ]; then
    echo "Ordenando ${m} nombres con algoritmo de burbuja..."
    
    # BUCLE EXTERNO: controla las pasadas
    i=0
    while [ $i -lt $m ]; do
        
        # BUCLE INTERNO: compara pares adyacentes
        j=0
        # El límite es m - i - 1 (los últimos i elementos ya están ordenados)
        while [ $j -lt $((m - i - 1)) ]; do
            
            # COMPARACIÓN: ¿resto[j] es mayor alfabéticamente que resto[j+1]?
            # > en [[ ]] significa "mayor que" en orden lexicográfico
            if [[ "${resto[j]}" > "${resto[j+1]}" ]]; then
                
                # INTERCAMBIO (SWAP) con variable temporal
                # Paso 1: guardar el valor actual
                temp="${resto[j]}"
                # Paso 2: copiar el siguiente al actual
                resto[j]="${resto[j+1]}"
                # Paso 3: poner el valor guardado en el siguiente
                resto[j+1]="$temp"
                
                # Nota: No se necesita 'fi' hasta después del if
            fi
            
            j=$((j + 1))  # Incrementar contador interno
        done
        
        i=$((i + 1))  # Incrementar contador de pasadas
    done
fi

# ============================================================================
# 6. INSERTAR EL NOMBRE EN LA POSICIÓN DESTINO (SIN FOR, SOLO WHILE)
# ----------------------------------------------------------------------------
# Tenemos:
#   - nombre_movido = "Dario"
#   - resto = array ordenado
#   - POSICION_DESTINO = posición donde queremos insertar
# Vamos a construir 'final' usando solo while
# ============================================================================

final=()  # Array vacío para el resultado
r=${#resto[@]}  # Tamaño del array resto

# CASO 1: Insertar al PRINCIPIO (POSICION_DESTINO = 0)
# ----------------------------------------------------------------------------
if [ $POSICION_DESTINO -eq 0 ]; then
    
    # Primero: el nombre movido
    final+=("$NOMBRE_A_MOVER")
    
    # Segundo: copiar todos los elementos de 'resto' usando while
    i=0
    while [ $i -lt $r ]; do
        final+=("${resto[i]}")
        i=$((i + 1))
    done

# CASO 2: Insertar al FINAL (si destino es mayor o igual que el tamaño)
# ----------------------------------------------------------------------------
elif [ $POSICION_DESTINO -ge $r ]; then
    
    # Primero: copiar todos los de 'resto' usando while
    i=0
    while [ $i -lt $r ]; do
        final+=("${resto[i]}")
        i=$((i + 1))
    done
    
    # Segundo: el nombre movido al final
    final+=("$NOMBRE_A_MOVER")

# CASO 3: Insertar en MEDIO (entre dos elementos)
# ----------------------------------------------------------------------------
else
    
    # PARTE 1: Copiar los primeros 'POSICION_DESTINO' elementos de 'resto'
    i=0
    while [ $i -lt $POSICION_DESTINO ]; do
        final+=("${resto[i]}")
        i=$((i + 1))
    done
    
    # PARTE 2: Insertar el nombre movido
    final+=("$NOMBRE_A_MOVER")
    
    # PARTE 3: Copiar el resto de 'resto' (desde POSICION_DESTINO hasta el final)
    i=$POSICION_DESTINO
    while [ $i -lt $r ]; do
        final+=("${resto[i]}")
        i=$((i + 1))
    done
fi

# ============================================================================
# 7. MOSTRAR RESULTADOS (SIN FOR, SOLO CON WHILE)
# ----------------------------------------------------------------------------

echo "========================================"
echo "RESULTADO FINAL:"
echo "========================================"
echo "Nombre movido: $NOMBRE_A_MOVER"
echo "Posición destino: $POSICION_DESTINO"
echo ""
echo "Lista completa (${#final[@]} elementos):"

# Mostrar usando while en lugar de for
i=0
while [ $i -lt ${#final[@]} ]; do
    # Añadimos número de posición para claridad didáctica
    echo "  $i: ${final[i]}"
    i=$((i + 1))
done
echo "========================================"

# ============================================================================
# 8. COMPARATIVA DIDÁCTICA: FOR vs WHILE
# ============================================================================
#
# ¿POR QUÉ EVITAMOS 'for'?
# ----------------------------------------------------------------------------
# El 'for' en Bash es azúcar sintáctico. Todo lo que hace 'for' se puede
# hacer con 'while', pero 'while' requiere que manejemos manualmente:
#   - El contador (i=0, i++, etc.)
#   - La condición de salida ([ $i -lt $n ])
#   - El incremento (i=$((i + 1)))
#
# EJEMPLO DE LO MISMO CON FOR (COMENTADO):
# ----------------------------------------------------------------------------
# for elemento in "${resto[@]}"; do
#     final+=("$elemento")
# done
#
# EQUIVALE A (con while):
# ----------------------------------------------------------------------------
# i=0
# while [ $i -lt ${#resto[@]} ]; do
#     final+=("${resto[i]}")
#     i=$((i + 1))
# done
#
# VENTAJAS DEL WHILE (para enseñanza):
# ----------------------------------------------------------------------------
# 1. Muestra EXPLÍCITAMENTE cómo se recorre un array índice por índice
# 2. Permite modificar el índice durante la iteración (ej: saltarse elementos)
# 3. Más fácil de depurar porque todo está visible
# 4. Se parece más a lenguajes de bajo nivel (C, ensamblador)
#
# DESVENTAJAS DEL WHILE (para producción):
# ----------------------------------------------------------------------------
# 1. Más líneas de código
# 2. Más fácil cometer errores (olvidar incrementar el contador = bucle infinito)
# 3. Menos legible para tareas simples
#
# ============================================================================
# NOTA SOBRE "LISTAS" Y "DICCIONARIOS" EN BASH:
# ----------------------------------------------------------------------------
# Bash NO tiene listas enlazadas ni diccionarios nativos como Python.
# Lo más parecido son:
#   - Arrays indexados (${array[indice]}) → como usamos aquí
#   - Arrays asociativos (declare -A dicc) → son como diccionarios
#
# EJEMPLO DE DICCIONARIO EN BASH (NO LO USAMOS EN ESTE SCRIPT):
# ----------------------------------------------------------------------------
# declare -A edades
# edades["Ana"]=25
# edades["Carlos"]=30
# echo "${edades["Ana"]}"  # Muestra 25
#
# Pero para nuestro caso, un array simple es suficiente.
# ============================================================================

# ============================================================================
# EJEMPLO DE EJECUCIÓN COMPLETA:
# ============================================================================
# Si estudiantes.txt contiene:
#   Carlos
#   Ana
#   Dario
#   Zoe
#   Beatriz
#
# El script hará:
#   1. Busca "Dario" con while → encontrado en índice 2
#   2. Crea 'resto' sin Dario usando while → ["Carlos","Ana","Zoe","Beatriz"]
#   3. Ordena 'resto' con burbuja (while+if) → ["Ana","Beatriz","Carlos","Zoe"]
#   4. Inserta Dario en posición 0 con while → ["Dario","Ana","Beatriz","Carlos","Zoe"]
#   5. Muestra resultado con while
#
# ¡EN NINGÚN MOMENTO SE USA LA PALABRA 'for'!
# ============================================================================
