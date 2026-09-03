def run(source_char: str, offset: int) -> str:
    char = ord(source_char)
    target_char = chr(char + offset)
    return target_char


# DO NOT TOUCH THE CODE BELOW
if __name__ == '__main__':
    import vendor

    vendor.launch(run)
