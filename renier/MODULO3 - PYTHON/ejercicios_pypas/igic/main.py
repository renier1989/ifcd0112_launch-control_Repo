from inspect import cleandoc
from typing import clear_overloads
def run(price_with_igic: float, igic: float) -> float:
    clean_price = price_with_igic / ( 1 + (igic / 100) )
    return round(clean_price,2)


# DO NOT TOUCH THE CODE BELOW
if __name__ == '__main__':
    import vendor

    vendor.launch(run)
