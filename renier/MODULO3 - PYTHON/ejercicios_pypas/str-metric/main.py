def run(text: str) -> int:
    n_text = text.lower()
    count_a = n_text.count('a')
    count_e = n_text.count('e')
    count_i = n_text.count('i')
    count_o = n_text.count('o')
    count_u = n_text.count('u')
    sum_vocales = count_a + count_e + count_i + count_o + count_u
    metric = len(text) * sum_vocales
    return metric


# DO NOT TOUCH THE CODE BELOW
if __name__ == '__main__':
    import vendor

    vendor.launch(run)
