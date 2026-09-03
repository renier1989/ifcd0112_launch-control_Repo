def run(name: str, surname: str) -> str:
    fullname  = f'{surname}, {name}'
    return fullname


# DO NOT TOUCH THE CODE BELOW
if __name__ == '__main__':
    import vendor

    vendor.launch(run)
