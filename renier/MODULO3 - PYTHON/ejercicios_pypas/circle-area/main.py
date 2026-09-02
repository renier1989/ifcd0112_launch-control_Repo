def run(radius) -> float:
    import math
    PI = round(math.pi,2)
    area =  PI  * radius ** 2
    return area


# DO NOT TOUCH THE CODE BELOW
if __name__ == '__main__':
    import vendor

    vendor.launch(run)
