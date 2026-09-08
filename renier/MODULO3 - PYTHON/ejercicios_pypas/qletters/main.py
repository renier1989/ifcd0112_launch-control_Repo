def run(letters: str) -> list[str]:
    RANGO_MAYUS = [65,90]
    RANGO_MINUS = [97,122]
    ASCII_ESAPCIO = 32
    listaCompleta = list(letters)
    lista_mayus = []
    lista_minus = []
    for letra in listaCompleta:
        if(ord(letra) == ASCII_ESAPCIO):
            lista_mayus=[]
            lista_minus=[]
        if(RANGO_MAYUS[0] <= ord(letra) <= RANGO_MAYUS[1] ):
            lista_mayus.append(letra)
        elif(RANGO_MINUS[0] <= ord(letra) <= RANGO_MINUS[1] ):
            lista_minus.append(letra)  

    queue = lista_mayus + lista_minus
    return queue


# DO NOT TOUCH THE CODE BELOW
if __name__ == '__main__':
    import vendor

    vendor.launch(run)
