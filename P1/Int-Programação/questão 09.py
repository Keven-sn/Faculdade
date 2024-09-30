def cast_feitico(feitico):

    match feitico:
        case 1:
            print('Bola de Fogo!')
        case 2:
            print('Bola de Água!')
        case 3:
            print('Bola de Ar!')


if __name__ == '__main__':
    print('1 - Fogo!')
    print('2 - Água!')
    print('3 - Ar!')
    escolha_feitico = int(input('Escolha seu feitiço:'))
    cast_feitico(escolha_feitico)
