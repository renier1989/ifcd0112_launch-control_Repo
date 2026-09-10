# https://pro.iesdonana.org/ejercicios/programacion-orientada-a-objetos-ejercicios.pdf
import random

class Cliente:
    def __init__(self, dni: str, nombre: str, apellidos: str):
        self.__dni = dni
        self.__nombre = nombre
        self.__apellidos = apellidos

    def nombre_completo_getter(self):
        return f"{self.__nombre}, {self.__apellidos}"

    def get_dni(self):
        return f"{self.__dni}"


class Movimiento:
    def __init__(self, concepto: str, cantidad: float):
        self.__concepto = concepto
        self.__cantidad = cantidad
    
    def get_concepto(self):
        return self.__concepto
        
    def get_cantidad(self):
        return self.__cantidad


class Cuenta:
    def __init__(self, titular:str):
        self.__numero = "".join([str(random.randint(0, 9)) for _ in range(10)]) 
        self.__titular = titular
        self.__movimientos = []
        self.__saldo = 0

    def get_saldo(self):
        return self.__saldo

    def get_titular(self):
        return self.__titular
        
    def set_movimiento(self,concepto,cantidad):
        self.__movimientos.append(Movimiento(concepto,cantidad))
        self.__saldo += cantidad


cliente1 = Cliente(dni="002232985", nombre="Renier Josue", apellidos="Vargas Mejias")
# print(cliente1.nombre_completo_getter(), " DNI: ", cliente1.get_dni())
# print(cliente1.__nombre) #no se puede llamar a la propiedad oculata
# print(cliente1._Cliente__nombre) #no se puede llamar a la propiedad oculata
cliente2 = Cliente(dni="98754123", nombre="Andrea Sara", apellidos="Ortiz Flanco")
# print(cliente2.nombre_completo_getter(), " DNI: ", cliente2.get_dni())

cuentaCliente1 = Cuenta(cliente1)
print(cuentaCliente1.get_titular())
print(cuentaCliente1.get_saldo())
cuentaCliente1.set_movimiento('Ingreso',300)
print(cuentaCliente1.get_saldo())

