

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

