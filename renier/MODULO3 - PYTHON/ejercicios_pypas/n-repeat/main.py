def run(n: int) -> int:
    n2 = int(str(n)*2)
    n3 = int(str(n)*3)
    result = n + n2 + n3
    return result


# DO NOT TOUCH THE CODE BELOW
if __name__ == '__main__':
    import vendor

    vendor.launch(run)
