import random

num_gates = 10

# creo la clase de puerta.
class Gate:

    def __init__(self, number: int):
        self.number = number
        self.frequency = random.randint(0, 3)
        self.beam_on = False

    def emmit_bean(self):
        self.beam_on = True

# inicializo las puertas con un numero
gates = [Gate(i) for i in range(num_gates)]

# las puertas que tengan una frecuencia mayor a 0 emito el rayo
for g in gates:
    if g.frequency > 0:
        g.emmit_bean()

# muestro la configuracion inicial
print("----- Original Config -----")
for g in gates:
    print(
        f"Gate N°{g.number+1} - Freq: {g.frequency} - Beam {'ON' if g.beam_on else 'OFF'}"
    )

# tomo el ultimo indice activo 
last_active_idx = None

# recorro las puertas iniciales y verificar su frecuencia
for gate_ini in range(len(gates)):
    freq = gates[gate_ini].frequency

    # si la frecuencia es 0 no hago nada
    if freq > 0:
        
        # si tienen un indice porque encontra una frecuenta mayor a 0 y la frecuencia anterior con la actual son iguales
        if (
            last_active_idx is not None and gates[last_active_idx].frequency == freq
        ):
            
            for gate_fin in range(last_active_idx + 1, gate_ini):
                gates[gate_fin].frequency = freq
                gates[gate_fin].emmit_bean()

        last_active_idx = gate_ini

print("\n----- Updated Config -----")
for g in gates:
    print(
        f"Gate N°{g.number+1} - Freq: {g.frequency} - Beam {'ON' if g.beam_on else 'OFF'}"
    )