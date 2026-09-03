# inputT = input('ingrese algo: ')
# print(inputT, type(inputT))

# print(type(1))
# val1 = input ('Ingrese valor 1: ')
# val2 = input ('Ingrese valor 2: ')
# val1 = int(val1)
# val2 = int(val2)
# res_sum = val1 + val2
# res_resta = val1 - val2
# res_mult = val1 * val2
# res_div = val1 * val2

# print(val1,'+',val2,'=', res_sum,'\n',
#         val1,'-',val2,'=',res_resta,'\n',
#         val1,'*',val2,'=',res_mult,'\n',
#         val1,'/',val2,'=',res_div,'\n'
    # )

# word1 = 'renier'
# word2 = 'lata'

# long_w1 =len(word1)
# div_w1= long_w1 // 2
# long_w2 =len(word2)
# div_w2= long_w2 // 2

# print(div_w1)
# mitad_ini = word1[:div_w1]
# print(mitad_ini)
# mitad_fin = word2[div_w2:]
# print(mitad_fin)

# print(mitad_ini+mitad_fin)



# text = 'El almuerzo esta espectacular'
# target_word = 'almuerzo'
# replace_word = 'desayuno'
# pos1 = text.find('almuerzo')
# inicio = text[:pos1]
# final = text[pos1+len(target_word):]

# print(inicio+ replace_word + final)


# print(len(text))
# print(len(target_word))
# print(text.find('almuerzo'))



# number = 2.71828

# print(f'{number:.3f}')
# print(f'{number:f}')
# print(f'{number:8.2f}')
# print(f'{number:e}')
# print(f'{number:010.4f}')
# print(f'{number:19.5f}')



# rocket_char = '🚀'
# print(ord(rocket_char))
# print(hex(ord(rocket_char)))

# rocket_code = 0x1f680
# print(chr(rocket_code))

# print('\N{ROCKET}')

# source_char = chr(0x03BC)
# offset = 4

# print(ord(source_char) + offset)
# variable = (ord(source_char) + offset)
# print(chr(variable))





# intcolor = 33
# hexa = hex(intcolor)
# index = hexa.find('x')
# valor = hexa[index+1:]
# color = f'{valor:06}'
# hexcolor = '#'+color
# print(hexcolor)




smb_path = '//192.168.24.77/scratch/data'
clean = smb_path.strip('//')
# print(clean.find('/'))
posi = clean.find('/')
host = clean[:posi]
path = clean[posi:]
print(host, path)



