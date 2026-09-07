def run(text: str) -> tuple[int, int]:
    num_letters = 0
    num_digits = 0
    
    for letter in text:
        if(65 <= ord(letter) <= 90 or 97 <= ord(letter) <= 122):
            num_letters+=1
        elif(48 <= ord(letter) <= 57):
            num_digits+=1
    return num_letters, num_digits


# DO NOT TOUCH THE CODE BELOW
if __name__ == '__main__':
    import vendor

    vendor.launch(run)
