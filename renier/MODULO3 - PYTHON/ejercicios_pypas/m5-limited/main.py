def run(limit: int) -> None:
    num= 1
    DIV = 5
    while  num < limit :    
        if(num%DIV == 0):
            print(f'{num}')
        num+=1


# DO NOT TOUCH THE CODE BELOW
if __name__ == '__main__':
    import vendor

    vendor.launch(run)
