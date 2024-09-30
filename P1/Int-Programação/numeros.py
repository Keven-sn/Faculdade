def calcula_resto():

    for i in range(1000, 2101, 1):
        if i % 11 == 5:
            print(f'O número é:{i}')


if __name__ == '__main__':
    print('---- Iniciando o programa ----')

    calcula_resto()

    print('---- Finalizando o programa ----')
