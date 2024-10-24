def classfica_planta_magicas(altura_planta):

    if altura_planta < 1:
        print('Planta pequena')

    elif 1 <= altura_planta <= 3:
        print('Planta média')

    else:
        print('Planta Grande')


if __name__ == '__main__':

    tamanho_planta = int(input('Digite a altura da sua planta em mt:'))

    classfica_planta_magicas(tamanho_planta)
