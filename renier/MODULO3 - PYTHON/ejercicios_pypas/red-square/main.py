def run(arc_A: float) -> float:
    import math
    PI = round(math.pi,2)
    radio = (arc_A * 4) / (2 * PI)
    area = radio ** 2
    
    return round(area,10)


# DO NOT TOUCH THE CODE BELOW
if __name__ == '__main__':
    import vendor

    vendor.launch(run)
