def run(limit: int) -> None:
    sum = 0
    valores = ''
    for i in range(limit):
        if i % 3 == 0:
            sum+=i
            valores = f'{valores} {i}'
            if sum >= limit:
                break
    print(valores)

# DO NOT TOUCH THE CODE BELOW
if __name__ == '__main__':
    import vendor

    vendor.launch(run)
