#!/bin/bash

# Definición de "arrays" (listas de búsqueda)
miPersona=("mochila" "abrigo" "bolsillos")
miCasa=("habitacion" "cocina" "baño" "puerta")
miCoche=("asiento" "guantera" "piso")
laOficina=("turno" "oficina" "comedor" "salon")

# Función para simular la probabilidad (findP en tu JS)
# Genera un número aleatorio entre 0 y 15. Si es 1, retorna éxito (0).
findP() {
    local valor=$(( RANDOM % 16 ))
    echo "[$valor]" # Para ver el número generado (opcional)
    if [ $valor -eq 1 ]; then
        return 0 # True en Bash
    else
        return 1 # False en Bash
    fi
}

buscarEnOficina() {
    # Verificar si "turno" está en la lista de la oficina
    if [[ " ${laOficina[@]} " =~ " turno " ]]; then
        echo "Hay alguien de turno..."
        
        if findP; then
            echo "Alguien busca en mi oficina..."
            echo "PENDRIVE ENCONTRADO. 👍"
            exit 0
        elif findP; then
            echo "Alguien busca en el comedor del trabajo..."
            echo "PENDRIVE ENCONTRADO. 👍"
            exit 0
        elif findP; then
            echo "Alguien busca en el salón de reuniones..."
            echo "PENDRIVE ENCONTRADO. 👍"
            exit 0
        else
            echo "NO SE HA ENCONTRADO EL PENDRIVE EN EL TRABAJO 🤷‍"
            return 1
        fi
    else
        echo "NO HABÍA NADIE DE TURNO, LO BUSCARÉ MAÑANA 🤞"
        return 1
    fi
}

buscarPendrive() {
    echo "--- INICIANDO BÚSQUEDA ---"

    # Búsqueda en uno mismo
    echo "Buscando sobre mí mismo..."
    if findP; then echo "Busco en el abrigo... PENDRIVE ENCONTRADO. 👍"; exit 0; fi
    if findP; then echo "Busco en la mochila... PENDRIVE ENCONTRADO. 👍"; exit 0; fi
    if findP; then echo "Busco en los bolsillos... PENDRIVE ENCONTRADO. 👍"; exit 0; fi
    echo "NO TENÍA EL PENDRIVE CONMIGO 🤷‍"

    # Búsqueda en casa
    echo "Buscando en casa..."
    if findP; then echo "Busco en la habitación... PENDRIVE ENCONTRADO. 👍"; exit 0; fi
    if findP; then echo "Busco en la cocina... PENDRIVE ENCONTRADO. 👍"; exit 0; fi
    if findP; then echo "Busco en el baño... PENDRIVE ENCONTRADO. 👍"; exit 0; fi
    if findP; then echo "Busco en la entrada... PENDRIVE ENCONTRADO. 👍"; exit 0; fi
    echo "EL PENDRIVE NO ESTABA EN MI CASA 🤷‍"

    # Búsqueda en coche
    echo "Buscando en el coche..."
    if findP; then echo "Busco en el asiento... PENDRIVE ENCONTRADO. 👍"; exit 0; fi
    if findP; then echo "Busco en la guantera... PENDRIVE ENCONTRADO. 👍"; exit 0; fi
    if findP; then echo "Busco en el piso... PENDRIVE ENCONTRADO. 👍"; exit 0; fi
    echo "EL PENDRIVE NO ESTABA EN MI COCHE 🤷‍"

    # Búsqueda en oficina
    buscarEnOficina

    echo "HE PERDIDO MI PENDRIVE. 😢"
}

# Ejecutar la función principal
buscarPendrive
