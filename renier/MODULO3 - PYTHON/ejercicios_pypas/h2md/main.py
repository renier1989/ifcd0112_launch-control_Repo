def run(html: str) -> str:
    corte1 = html.find('>')
    corte2 = html.find('<',1)
    corte3 = html.find('h')
    mark = '#'
    numero = html[corte3+1:corte1]
    text = html[corte1+1:corte2]
    markdown = f'{mark*int(numero)} {text}'
    return markdown


# DO NOT TOUCH THE CODE BELOW
if __name__ == '__main__':
    import vendor

    vendor.launch(run)
