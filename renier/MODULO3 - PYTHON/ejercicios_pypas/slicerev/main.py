def run(items: list[int]) -> list[int]:
    if not items:
        return []
    mitad = len(items)//2
    paso = int(items[mitad])
    itemsTroceados = items[::paso]
    result = itemsTroceados[::-1]
    return result


# DO NOT TOUCH THE CODE BELOW
if __name__ == '__main__':
    import vendor

    vendor.launch(run)
