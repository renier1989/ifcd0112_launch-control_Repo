def run():
    val1 = input ('Ingrese valor 1: ')
    val2 = input ('Ingrese valor 2: ')
    val1 = int(val1)
    val2 = int(val2)
    res_sum = val1 + val2
    res_resta = val1 - val2
    res_mult = val1 * val2
    res_div = val1 * val2

    print(val1,'+',val2,'=', res_sum,'\n',
        val1,'-',val2,'=',res_resta,'\n',
        val1,'*',val2,'=',res_mult,'\n',
        val1,'/',val2,'=',res_div,'\n'
    )

# DO NOT TOUCH THE CODE BELOW
if __name__ == '__main__':
    import vendor

    vendor.launch(run)
