def run(text: str) -> int:
    separadas = text.split()
    num_words = len(separadas)
    return num_words


# DO NOT TOUCH THE CODE BELOW
if __name__ == '__main__':
    import vendor

    vendor.launch(run)
