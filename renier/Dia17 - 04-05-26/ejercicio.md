#### Definicion del ejercicio
> Busqueda de mi Pendrive

#### 1- Inicio definiendo los sitios en los que podria buscar

- Buscar en mi mismo (Bolsillos, abrigo, mochila)
- Buscar en mi Casa
- Buscar en el coche
- Buscar en la oficina (Llamar a la oficina)

#### 2- Indico las acciones que podria hacer en casa sitio que estoy buscando

- Buscar sobre mi mismo:
- - Llevarme las manos a los bolsillos
- - Revisar en el abrigo que tenia pusto
- - buscar en el morral que llevaba

- Buscar en mi Casa:
- - Ver en mi escritorio de trabajo
- - Revisar en mi habitacion
- - Revisar en la cocina
- - Revisar en la entrada
- - revisar en el baño

- Buscar en mi coche:
- - Revisar en el asiento del conductor
- - Revisar en el guantera
- - Revisar debajo de los asientos
- - Revisar en los porta vasos

- Buscar en la oficina: (Delegarlo como una funcion externa, pedir ayuda a un compañero)
- - llamar la persona de turno
- - pedir que busque en mi sitio de trabajo
- - pedir que busque en el comendor
- - pedir que busque en el ultimo sitio de reunion 

#### 3- determinar los condicionales inteligentes para hacer busquedas mas eficientes y descartando opciones

- Buscar en mi mismo (Bolsillos, abrigo, mochila)
- - tenia abrigo puesto?
- - llevaba mochila? 

- Buscar en mi Casa
- - estaba en la cocina ?
- - fui al baño ?

- Buscar en el coche
- - use el coche ?

- Buscar en la oficina (Llamar a la oficina)
- - hay alguien de turno ? 
- - fui al comedor hoy ? 
- - hubo reunion hoy ?


````javascript

let miPersona = ['mochila', 'abrigo', 'bolsillos'];
let miCasa = ['habitacion', 'cocina', 'baño', 'puerta'];
let miCoche = ['asiento', 'guantera', 'piso'];
let laOficina = ['turno', 'oficina', 'comedor', 'salon'];
let encontrado = 1

function buscarPendrive() {

    // busco primero sobre mi mismo
    if (miPersona.includes('abrigo') && findP()) {
        console.log('busco en el abrigo')
        console.log('PENDRIVE ENCONTRADO. 👍 ')
        return
    } else if (miPersona.includes('mochila') && findP()) {
        console.log('busco en la mochila')
        console.log('PENDRIVE ENCONTRADO. 👍')
        return
    } else if (miPersona.includes('bolsillo') && findP()) {
        console.log('busco en los bolsillos')
        console.log('PENDRIVE ENCONTRADO. 👍')
        return
    } else {
        console.log("NO TENIA EL PENDRIA CONMIGO 🤷‍")

    }


    // busco luego en mi casa
    if (miCasa.includes('habitacion') && findP()) {
        console.log('busco en la habitacion de mi casa')
        console.log('PENDRIVE ENCONTRADO. 👍')
        return
    } else if (miCasa.includes('cocina') && findP()) {
        console.log('busco en la cocina de mi casa')
        console.log('PENDRIVE ENCONTRADO. 👍')
        return
    } else if (miCasa.includes('baño') && findP()) {
        console.log('busco en el baño de mi casa')
        console.log('PENDRIVE ENCONTRADO. 👍')
        return
    } else if (miCasa.includes('puerta') && findP()) {
        console.log('busco en la entrada de mi casa')
        console.log('PENDRIVE ENCONTRADO. 👍')
        return
    } else {
        console.log('EL PENDRIVE NO ESTABA EN MI CASA 🤷‍')
    }

    // busco luego en mi coche
    if (miCoche.includes('asiento') && findP()) {
        console.log('busco en el asiento de mi coche')
        console.log('PENDRIVE ENCONTRADO. 👍')
        return
    } else if (miCoche.includes('guantera') && findP()) {
        console.log('busco en la guantera de mi coche')
        console.log('PENDRIVE ENCONTRADO. 👍')
        return
    } else if (miCoche.includes('piso') && findP()) {
        console.log('busco en el piso de mi coche')
        console.log('PENDRIVE ENCONTRADO. 👍')
        return
    } else {
        console.log('EL PENDRIVE NO ESTABA EN MI COCHE 🤷‍')
    }

    buscarEnOficina()

    console.log('HE PERDIDO MI PENDRIVE. 😢')


}

function buscarEnOficina() {
    // busco luego en la oficina
    if (laOficina.includes('turno')) {
        console.log('Hay alguien de turno')

        if (laOficina.includes('oficina') && findP()) {
            console.log('alguien busca en mi oficina')
            console.log('PENDRIVE ENCONTRADO. 👍')
            return true;
        } else if (laOficina.includes('comedor') && findP()) {
            console.log('alguien busca en el comedor del trabajo')
            console.log('PENDRIVE ENCONTRADO. 👍')
            return true
        } else if (laOficina.includes('salon') && findP()) {
            console.log('alguien busca en el salon de reuniones')
            console.log('PENDRIVE ENCONTRADO. 👍')
            return true
        } else {
            console.log('NO SE HA ENCONTRADO EL PENDRIVE EN EL TRABAJO 🤷‍')
            return false
        }
    } else {
        console.log('NO HABIA NADIE DE TURNO, LO BUSCARE MAÑANA 🤞')
        return false
    }
}

function findP() {
    let valor = Math.floor(Math.random() * (15 - 0 + 1)) + 0;
    console.log(valor)
    if (valor === 1) {
        return true
    } else {
        return false
    }
}

buscarPendrive()

````

#### INTERPRETACION DEL CODIGO EN LENGUAJE NATURAL

> El problema es que se me ha perdido el pendrive

##### Inicio buscando el pendrive en mi mismo
````
Hago memoria si tenia abrigo puesto
- Si : Busco en el abrigo.
-- Encontre el pendrive?
-- Si : Termino
-- No : Continuo buscando
- No : Paso a la siguiente accion
Hago memoria si llevaba mochila
- Si : Busco en la mochil
-- Encontre el pendrive?
-- Si : Termino
-- No : Continuo buscando
- No: Paso a la siguiente accion
Solo me queda buscar en mis bolsillo
-- Encontre el pendrive?
-- Si : Termino
-- No : Continuo buscando

Hago memoria si entre en mi habitacion
- Si : Busco en mi habitacion
-- Encontre el pendrive?
-- Si : Termino
-- No : Continuo buscando
- No: Paso a la siguiente accion
Hago memoria si entre en la cocina
- Si : Busco en la cocina
-- Encontre el pendrive?
-- Si : Termino
-- No : Continuo buscando
- No: Paso a la siguiente accion
Hago memoria si entre en el baño
- Si : Busco en el baño
-- Encontre el pendrive?
-- Si : Termino
-- No : Continuo buscando
- No: Paso a la siguiente accion
Solo me queda buscar en la entra de la puerta
-- Encontre el pendrive?
-- Si : Termino
-- No : Continuo buscando

Voy hacia mi coche
- Busco en el asiento del conductor
- Encontre el pendrive?
-- Si : Termino
-- No : Continuo buscando
- Busco en la guantera de mi coche
- Encontre el pendrive?
-- Si : Termino
-- No : Continuo buscando
- Busco en el piso de mi coche
- Encontre el pendrive?
-- Si : Termino
-- No : Continuo buscando

Estoy lejos de la oficina, pregunta si hay alguien de turno en el trabajo
- Si : Llamo a la persona que esta de turno
-- Alguien busca en mi oficina 
--- Encontre el pendrive?
--- Si : Termino
--- No : Continuo buscando
-- Alguien busca en el comedor del trabajo
--- Encontre el pendrive?
--- Si : Termino
--- No : Continuo buscando
-- Alguien busca en el salon de reuniones del trabajo
--- Encontre el pendrive?
--- Si : Termino
--- No : Continuo buscando
- No : Buscare el siguiente dia en el trabajo



````

````

graph TD
    Start((Inicio)) --> MemAbrigo{¿Tenía abrigo puesto?}
    
    %% Búsqueda en uno mismo
    MemAbrigo -- Sí --> BusAbrigo[Busco en el abrigo]
    BusAbrigo --> Found1{¿Encontrado?}
    Found1 -- Sí --> End((Fin))
    
    MemAbrigo -- No --> MemMochi{¿Llevaba mochila?}
    Found1 -- No --> MemMochi
    
    MemMochi -- Sí --> BusMochi[Busco en la mochila]
    BusMochi --> Found2{¿Encontrado?}
    Found2 -- Sí --> End
    
    MemMochi -- No --> BusBolsillos[Busco en los bolsillos]
    Found2 -- No --> BusBolsillos
    
    BusBolsillos --> Found3{¿Encontrado?}
    Found3 -- Sí --> End
    
    %% Búsqueda en la casa
    Found3 -- No --> MemHab{¿Entré en mi habitación?}
    
    MemHab -- Sí --> BusHab[Busco en la habitación]
    BusHab --> Found4{¿Encontrado?}
    Found4 -- Sí --> End
    
    MemHab -- No --> MemCocina{¿Entré en la cocina?}
    Found4 -- No --> MemCocina
    
    MemCocina -- Sí --> BusCocina[Busco en la cocina]
    BusCocina --> Found5{¿Encontrado?}
    Found5 -- Sí --> End
    
    MemCocina -- No --> MemBano{¿Entré en el baño?}
    Found5 -- No --> MemBano
    
    MemBano -- Sí --> BusBano[Busco en el baño]
    BusBano --> Found6{¿Encontrado?}
    Found6 -- Sí --> End
    
    MemBano -- No --> BusEntrada[Busco en la entrada]
    Found6 -- No --> BusEntrada
    
    BusEntrada --> Found7{¿Encontrado?}
    Found7 -- Sí --> End
    
    %% Búsqueda en el coche
    Found7 -- No --> BusCond[Busco asiento conductor]
    
    BusCond --> Found8{¿Encontrado?}
    Found8 -- Sí --> End
    
    Found8 -- No --> BusGuantera[Busco en la guantera]
    BusGuantera --> Found9{¿Encontrado?}
    Found9 -- Sí --> End
    
    Found9 -- No --> BusSuelo[Busco en el piso del coche]
    BusSuelo --> Found10{¿Encontrado?}
    Found10 -- Sí --> End
    
    %% Búsqueda en la oficina
    Found10 -- No --> Turno{¿Hay alguien de turno?}
    
    Turno -- No --> Manana[Buscaré el siguiente día]
    Manana --> End
    
    Turno -- Sí --> Llamar[Llamo a la persona]
    Llamar --> BusOfi[Buscan en mi oficina]
    
    BusOfi --> Found11{¿Encontrado?}
    Found11 -- Sí --> End
    
    Found11 -- No --> BusComedor[Buscan en el comedor]
    BusComedor --> Found12{¿Encontrado?}
    Found12 -- Sí --> End
    
    Found12 -- No --> BusReunion[Buscan en sala reuniones]
    BusReunion --> Found13{¿Encontrado?}
    Found13 -- Sí --> End
    Found13 -- No --> Manana
````