def run(word1: str, word2: str) -> str:
    long_w1 =len(word1)
    div_w1= long_w1 // 2
    long_w2 =len(word2)
    div_w2= long_w2 // 2
    mitad_ini = word1[:div_w1]
    mitad_fin = word2[div_w2:]
    turn = mitad_ini+mitad_fin
    return turn


# DO NOT TOUCH THE CODE BELOW
if __name__ == '__main__':
    import vendor

    vendor.launch(run)
