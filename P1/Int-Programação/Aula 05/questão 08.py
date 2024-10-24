def bonus_cavaleiro(missoes):

    if missoes > 10:
        print(f'Por{missoes}missões')
        print('Você recebeu 100 moedas de ouro')

    elif 5 <= missoes <= 10:
        print(f'Por{missoes}missões')
        print('Você recebeu 50 moedas de ouro')

    else:
        print(f'Por{missoes}missões')
        print('Você recebeu 10 moedas de ouro')


if __name__ == '__main__':

    quantidas_missoes = int(input('Digite a quantidade de missões:'))

    bonus_cavaleiro(quantidas_missoes)
