def run(u: list, v: list) -> float | None:
    dprod = 0
    if len(u) != len(v):
        return None
    for pu,pv in zip(u,v):
        dprod += pu * pv
    return dprod


# DO NOT TOUCH THE CODE BELOW
if __name__ == '__main__':
    import vendor

    vendor.launch(run)
