def run(x: float) -> float:
    op = ( 180 - x ) 
    up = ( 4 * x ) * op
    down = 40500 - x * op
    sin = up / down 
    return sin


# DO NOT TOUCH THE CODE BELOW
if __name__ == '__main__':
    import vendor

    vendor.launch(run)
