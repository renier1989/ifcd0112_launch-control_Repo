def run(year: int) -> bool:
    is_leap_year = True if (year % 4 == 0 and year % 100 != 0) or year % 400 == 0 else False
    return is_leap_year


# DO NOT TOUCH THE CODE BELOW
if __name__ == '__main__':
    import vendor

    vendor.launch(run)
