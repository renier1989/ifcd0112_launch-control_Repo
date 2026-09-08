def run(text: str) -> bool:
    lista = list(text.lower().replace('-',''))
    isogram = True
    for letra in lista:
        indice = lista.index(letra)
        del lista[indice]
        if (letra in lista):
            isogram= False
            break
    return isogram


# DO NOT TOUCH THE CODE BELOW
if __name__ == '__main__':
    import vendor

    vendor.launch(run)
