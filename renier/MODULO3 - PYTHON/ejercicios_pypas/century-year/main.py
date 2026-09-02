def run(year: int) -> int:
    century = ( year - 1 ) // 100 + 1
    return century


# DO NOT TOUCH THE CODE BELOW
if __name__ == '__main__':
    import vendor

    vendor.launch(run)
