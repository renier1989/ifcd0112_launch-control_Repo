def run(amount: float, rate: float, years: int) -> float:
    future_amount = amount * ( 1 + ( rate / 100 ) ) ** years
    return future_amount


# DO NOT TOUCH THE CODE BELOW
if __name__ == '__main__':
    import vendor

    vendor.launch(run)
