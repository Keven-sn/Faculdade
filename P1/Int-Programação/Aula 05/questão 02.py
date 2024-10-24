ferro = float(input("Digite a quantidade de ferro em kg: "))
ouro = float(input("Digite a quantidade de ouro em kg: "))

total = ferro + ouro

porcentagem_ferro = (ferro / total) * 100

if porcentagem_ferro >= 70:
    print('A liga metálica está adequada!')

else:
    print('A liga está insuficiente!')
