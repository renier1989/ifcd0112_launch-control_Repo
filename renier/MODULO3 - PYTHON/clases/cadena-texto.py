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




# smb_path = '//192.168.24.77/scratch/data'
# # clean = smb_path.strip('//')
# # print(clean.find('/'))
# posi = smb_path.find('/',3)
# host = smb_path[2:posi]
# path = smb_path[posi:]
# print(host, path)




# nif = 12345678
# control = ['T', 'R', 'W', 'A', 'G', 'M', 'Y', 'F', 'P', 'D', 'X', 'B', 'N', 'J', 'Z', 'S', 'Q', 'V', 'H', 'L', 'C', 'K', 'E']
# calculo = nif % 23
# wnif = f'{nif}{control[calculo]}'
# print(wnif)



# n = 5
# n2 = int(str(n)*2)
# n3 = int(str(n)*3)
# result = n + n2 + n3
# print(result)




# text = 'ordenador'
# n_text = text.lower()
# count_a = n_text.count('a')
# count_e = n_text.count('e')
# count_i = n_text.count('i')
# count_o = n_text.count('o')
# count_u = n_text.count('u')
# sum_vocales = count_a + count_e + count_i + count_o + count_u
# metric = len(text) * sum_vocales
# print(metric)



# html =  '<h2>Test</h2>'
# corte1 = html.find('>')
# corte2 = html.find('<',1)
# corte3 = html.find('h')
# mark = '#'
# numero = html[corte3+1:corte1]
# text = html[corte1+1:corte2]
# markdown = f'{mark*int(numero)} {text}'
# print(markdown)



# num_sheeps = 4
# text = 'sheep'
# multi = f'{text:.<9s}'*num_sheeps
# print(multi)



# can_fly= True
# is_human= False 
# has_mask= False

# if can_fly and is_human and has_mask:
#     character = 'Ironman'
# elif can_fly and is_human and not has_mask:
#     character = 'Capitan Marvel'
# elif can_fly and not is_human and has_mask:
#     character = 'Ronnan Accuser'
# elif can_fly and not is_human and not has_mask:
#     character = 'Vision'
# elif not can_fly and is_human and has_mask:
#     character = 'Spiderman'
# elif not can_fly and is_human and not has_mask:
#     character = 'Hulk'
# elif not can_fly and not is_human and has_mask:
#     character = 'Black Bolt'
# else:
#     character = 'Thanos'

# character = 'Ironman' if (can_fly and is_human and has_mask) else 'Capitan Marvel' if (can_fly and is_human and not has_mask) else 'Ronnan Accuser' if (can_fly and not is_human and has_mask) else 'Vision' if (can_fly and not is_human and not has_mask) else 'Spiderman' if (not can_fly and is_human and has_mask) else 'Hulk' if (not can_fly and is_human and not has_mask) else 'Black Bolt' if (not can_fly and not is_human and has_mask) else 'Thanos'

# print(character)


# winner = 0
# jugador1 = 'rock'
# jugador2 = 'paper'


# if (jugador1.lower() == 'paper' and jugador2.lower() == 'scissors'):
#     winner = 2
# elif (jugador1.lower() == 'paper' and jugador2.lower() == 'rock'):
#     winner = 1
# elif (jugador1.lower() == 'scissors' and jugador2.lower() == 'paper'):
#     winner = 1
# elif (jugador1.lower() == 'scissors' and jugador2.lower() == 'rock'):
#     winner = 2
# elif (jugador1.lower() == 'rock' and jugador2.lower() == 'paper'):
#     winner = 2
# elif (jugador1.lower() == 'rock' and jugador2.lower() == 'scissors'):
#     winner = 1

# player1 = player1.lower()
# player2 = player2.lower()

# # Mapea cada opción con la jugada a la que vence
# beats = {'paper': 'rock', 'rock': 'scissors', 'scissors': 'paper'}

# winner = 0 if player1 == player2 else (1 if beats[player1] == player2 else 2)

# print(winner)



