def run(input_date: str, base_year: int) -> str:
    fecha_separada = input_date.split('/')
    year = int(fecha_separada[2]) + base_year
    output_date = f'{fecha_separada[1]:0>2s}-{fecha_separada[0]:0>2s}-{str(year):0>4s}'
    return output_date


# DO NOT TOUCH THE CODE BELOW
if __name__ == '__main__':
    import vendor

    vendor.launch(run)
