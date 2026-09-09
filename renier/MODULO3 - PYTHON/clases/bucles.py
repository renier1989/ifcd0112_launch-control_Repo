# limit = 46
# num= 1
# div = 5
# while  num <= limit :
#     if(num%div == 0):
#         print(f'{num}')
#     num+=1


# text = "Ayer empec ́e a programar"
# num_vowels = 0
# VOWEL_LIST = "aeiouáéíóú"
# for vowel in text:
#     vowel = vowel.lower()

#     if vowel in VOWEL_LIST:
#         num_vowels += 1

# print(num_vowels)


# n = 2
# is_prime = True
# if n < 2:
#     is_prime = False
# else:
#     for i in range(2,n):
#         if n % i == 0:
#             is_prime = False
#             break

# print(is_prime)


# # text = '1.21 gigawatios'
# text = 'Michael Jordan: 23'
# num_letters = 0
# num_digits = 0

# for letter in text:
#     if(65 <= ord(letter) <= 90 or 97 <= ord(letter) <= 122):
#         num_letters+=1
#     elif(48 <= ord(letter) <= 57):
#         num_digits+=1

# print(f'{num_letters} letras')
# print(f'{num_digits} digitos')


# limit = 45
# sum = 0
# valores = ''
# for i in range(limit):
#     if i % 3 == 0:
#         sum+=i
#         valores = f'{valores} {i}'
#         if sum >= limit:
#             break
# print(valores)
# # print(12%3)


# target_number = 50
# intentos = 0
# while True:
#     number = input('Introduzca número:')
#     intentos+=1
#     if(int(number) > target_number):
#         print('Menor')
#         continue
#     elif(int(number) < target_number):
#         print('Mayor')
#         continue
#     else:
#         print(f'Enhorabuena has encontrado el número en {intentos} intentos')
#         break


# def ham():
#     text1 = 'blanca'
#     text2 = 'flanco'
#     dhamming = 0
#     if(len(text1) != len(text2)):
#         dhamming = -1
#         return dhamming

#     for i in range(len(text1)):
#         if(text1[i] != text2[i]):
#             dhamming=dhamming + 1
#     return dhamming

# print(ham())


# text1='ab'
# text2='xy'
# cartesian = ''
# for p1 in text1:
#     # print(p1)
#     for p2 in text2:
#         cartesian = f'{cartesian}{p1}{p2}'
# print(cartesian)


# def palindromo():
#     text = input('ingese palabra: ')
#     reemplazos = (
#         ("á", "a"), ("é", "e"), ("í", "i"), ("ó", "o"), ("ú", "u"),
#         ("Á", "A"), ("É", "E"), ("Í", "I"), ("Ó", "O"), ("Ú", "U")
#     )
#     for con_tilde, sin_tilde in reemplazos:
#         text = text.replace(con_tilde, sin_tilde)
#     invertida =text[::-1].replace(' ','').lower()
#     text = text.replace(' ','').lower()
#     msg = 'Es palindromo' if text == invertida else 'No es palindromo'
#     return msg, text

# print(palindromo())


# nota1 = 10
# nota2 = 2
# nota3 = 3
# prom = (nota1 + nota2 + nota3) / 3
# print(prom)
# match prom:
#     case n if prom >= 7:
#         print("Promocionado")
#     case n if prom >= 4:
#         print("Regular")
#     case _:
#         print("Reprobado")


# cant_par = 0
# cant_impar = 0
# while True:
#     n_numeros = input("Ingresa cantidad de números a contar [MAX:10 - MIN:2]: ")
#     if n_numeros.isdigit():
#         n_numeros = int(n_numeros)
#         if 2 <= n_numeros <= 10:
#             break

#     print("Error: Ingrese un número dentro del rango indicado [MAX:10 - MIN:2]\n")


# for i in range(n_numeros):
#     numero = int(input(f"Ingrese el número {i + 1}: "))
#     if numero % 2 == 0:
#         cant_par += 1
#     else:
#         cant_impar += 1

# print(f"\nNúmeros Pares: {cant_par} - Números Impares: {cant_impar}")


# contar cantidad de vocales en una frase
cant_a = 0
cant_e = 0
cant_i = 0
cant_o = 0
cant_u = 0
frase = input('Ingrese una una frase: ')
letras = 0

for letra in frase.lower():
    if(letra == 'a'):
        cant_a += 1
    if(letra == 'e'):
        cant_e += 1
    if(letra == 'i'):
        cant_i += 1
    if(letra == 'o'):
        cant_o += 1
    if(letra == 'u'):
        cant_u += 1
print(f'\n Cantidad de vocales por tipo \n a: {cant_a} \n e: {cant_e} \n i: {cant_i} \n o: {cant_o} \n u: {cant_u}')



# # opcion elegante
# frase = input('Ingrese una frase: ').lower()
# vocales = {'a': 0, 'e': 0, 'i': 0, 'o': 0, 'u': 0}

# for letra in frase:
#     if letra in vocales:
#         vocales[letra] += 1

# print('\nCantidad de vocales por tipo:')
# for vocal, cantidad in vocales.items():
#     print(f'{vocal}: {cantidad}')