def run(target_number: int) -> None:
    intentos = 0
    while True:
        number = input('Introduzca número:')
        intentos+=1
        if(int(number) > target_number):
            print('Menor')
        elif(int(number) < target_number):
            print('Mayor')
        elif(int(number) == target_number):
            print(f'Enhorabuena has encontrado el número en {intentos} intentos')
            break


# DO NOT TOUCH THE CODE BELOW
if __name__ == '__main__':
    import vendor

    vendor.launch(run)
