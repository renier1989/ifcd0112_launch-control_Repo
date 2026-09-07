def run(text1: str, text2: str) -> str:
    cartesian = ''
    for p1 in text1:
        for p2 in text2:
            cartesian = f'{cartesian}{p1}{p2}'
    return cartesian


# DO NOT TOUCH THE CODE BELOW
if __name__ == '__main__':
    import vendor

    vendor.launch(run)
