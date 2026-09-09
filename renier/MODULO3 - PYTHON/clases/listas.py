# items = [7, 4, 3, 8, 2, 3, 6, 1, 1, 5, 3]
# mitad = len(items)//2
# paso = items[mitad]
# itemsTroceados = items[::paso]
# result = itemsTroceados[::-1]
# print(itemsTroceados)
# print(result)


# # codigos de letras ascii MAYUS (65 AL 90) minus (97 al 122)
# letters = 'XvF cTaC'
# RANGO_MAYUS = [65,90]
# RANGO_MINUS = [97,122]
# ASCII_ESAPCIO = 32
# listaCompleta = list(letters)
# lista_mayus = []
# lista_minus = []
# for letra in listaCompleta:
#     if(ord(letra) == ASCII_ESAPCIO):
#         lista_mayus=[]
#         lista_minus=[]
#     if(RANGO_MAYUS[0] <= ord(letra) <= RANGO_MAYUS[1] ):
#         lista_mayus.append(letra)
#     elif(RANGO_MINUS[0] <= ord(letra) <= RANGO_MINUS[1] ):
#         lista_minus.append(letra)  

# queue = lista_mayus + lista_minus

# print(queue)





# text = 'six-year-old'
# lista = list(text.lower().replace('-',''))
# isogram = True

# for letra in lista:
#     indice = lista.index(letra)
#     del lista[indice]
#     if (letra in lista):
#         isogram= False
#         break

# print(isogram)

# # isogram = False
# # print(isogram)



# input_date = '12/31/23'
# base_year = 2000
# fecha_separada = input_date.split('/')
# year = int(fecha_separada[2]) + base_year
# output_date = f'{fecha_separada[1]:0>2s}-{fecha_separada[0]:0>2s}-{str(year):0>4s}'
    

# print(output_date)


print('Algo nuevo')