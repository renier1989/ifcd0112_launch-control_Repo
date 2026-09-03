def run(text: str, target_word: str, replace_word: str) -> str:
    posicion = text.find(target_word)
    inicio = text[:posicion]
    final = text[posicion+len(target_word):]
    mtext = inicio+ replace_word + final
    return mtext


# DO NOT TOUCH THE CODE BELOW
if __name__ == '__main__':
    import vendor

    vendor.launch(run)
