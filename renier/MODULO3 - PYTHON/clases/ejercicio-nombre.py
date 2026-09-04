# Ejercicio 3.6 Los alumnos de un curso se han dividido en dos grupos A y B de acuerdo al sexo y el nombre. El grupo A esta formado por las mujeres con un nombre anterior a la M y los hombres con un nombre posterior a la N y el grupo B por el resto. Escribir un programa que pregunte al usuario su nombre y sexo, y muestre por pantalla el grupo que le corresponde. 
def run() -> str:
    nombre = input('Igrese su Nombre: ')
    genero = input('Ingrese su Genero [M: Masculino ,F: Femenino]: ')

    nombre = nombre.lower()
    genero = genero.lower()

    letra_nombre= nombre[0]
    grupo = 'Grupo A' if ((letra_nombre < 'm' and genero == 'f') or (letra_nombre > 'n' and genero == 'm')) else 'Grupo B'

    return grupo
    

print(run())