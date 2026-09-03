def run(intcolor: int) -> str:
    # hexa = hex(intcolor)
    # index = hexa.find('x')
    # valor = hexa[index+1:]
    # color = f'{valor:06}'
    # hexcolor = '#'+color
    hexcolor = f'#{intcolor:06X}'
    return hexcolor


# DO NOT TOUCH THE CODE BELOW
if __name__ == '__main__':
    import vendor

    vendor.launch(run)
