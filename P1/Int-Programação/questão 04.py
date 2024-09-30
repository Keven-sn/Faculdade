moedas_1_real = int(input('Quantidade de moedas de 1 real:'))
moedas_50_cents = int(input('Quantidade de moedas de 50 centavos:'))
moedas_25_cents = int(input('Quantidade de moedas de 25 centavos:'))

total = ('moedas_1_real * 1') + ('moedas_50_cents * 0.5') + \
    ('moedas_25_cents * 0.25')

print(f'O valor total de moedas é: R$ {total:.2f}')
