def run(radius: float) -> float:
    import math
    PI = round(math.pi,2)
    # PI = 3.14
    volume = 4/3 * PI * radius ** 3
    return volume


# DO NOT TOUCH THE CODE BELOW
if __name__ == '__main__':
    import vendor

    vendor.launch(run)
