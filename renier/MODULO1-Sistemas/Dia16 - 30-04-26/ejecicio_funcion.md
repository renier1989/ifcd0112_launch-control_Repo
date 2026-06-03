creacion de una funcion 

````javascript
function hacerSandwich() {
  // indicamos las listas de los ingredientes disponibles
  const panes = ["Integral", "Normal"]
  const rellenos = ["Jamon", "Queso", "Pollo", "Carne"];
  const extras = ["Lechuga", "Tomate"];
  // esto es un mensaje de alerta
  alert("BIENVENIDOS A LA FABIRCA DE SANDWICH");
  // capturo una entra por pantalla del usuario
  let pan = prompt(`Panes disponibles : [ ${panes.join(',')} ], ingresa un valor: `);
  // valido que la opcion ingresada consida con la lista de ingredientes de panes
  while (!panes.includes(pan)) {
    pan = prompt(`pan no valido, los disponibles son, [${panes.join(',')}]`)
  }
  // capturo una entrada del usuario
  let proteina = prompt(`Rellenos disponibles : [ ${rellenos.join(',')} ], ingresa un valor: `);
  // valido que lo ingresado coincida con la lista de ingredientes de rellenos
  while (!rellenos.includes(proteina)) {
    proteina = prompt(`Relleno no valido, los disponibles son [ ${rellenos.join(',')}]`)
  }
  // capturo una entrada del usuario
  let extra = prompt(`(Opcional, puede dejar vacio) Extras disponibles : [ ${extras.join(',')} ] `);
  // muestro un mensaje de alerta
  alert("ESTAMOS PREPARANDO TU SANDWICH.");
  // valido si el usuario ha ingresado algo en extras
  let msgExtra = "";
  if (extras.includes(extra)) {
    msgExtra = `| EXTRA: ${extra}`
  } else if (extra) {
    msgExtra = `No disponemos de ${extra}`
  }
  // muestro el mensaje final de los del sandwich armado
  alert(`SandWich con PAN: ${pan}, | RELLENO: ${proteina}  ${msgExtra} `)
  console.log("SandWich Termiando");
}

hacerSandwich()

````