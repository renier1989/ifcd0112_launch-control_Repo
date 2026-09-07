def run(text):
    VOWEL_LIST = "aeiouáéíóú"
    num_vowels = 0
    for vowel in text:
        vowel = vowel.lower()
        if vowel in VOWEL_LIST:
            num_vowels += 1
    return num_vowels


# DO NOT TOUCH THE CODE BELOW
if __name__ == "__main__":
    import vendor

    vendor.launch(run)
