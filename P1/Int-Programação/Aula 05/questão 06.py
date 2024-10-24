def calcular_velocidade(distancia, tempo):
    return distancia / tempo

distancia_dragao1 = float(input("Informe a distância percorrida pelo Dragão 1 (em metros): "))
tempo_dragao1 = float(input("Informe o tempo gasto pelo Dragão 1 (em segundos): "))

distancia_dragao2 = float(input("Informe a distância percorrida pelo Dragão 2 (em metros): "))
tempo_dragao2 = float(input("Informe o tempo gasto pelo Dragão 2 (em segundos): "))

velocidade_dragao1 = calcular_velocidade(distancia_dragao1, tempo_dragao1)
velocidade_dragao2 = calcular_velocidade(distancia_dragao2, tempo_dragao2)

if velocidade_dragao1 > velocidade_dragao2:
    print("O Dragão 1 é mais rápido.")
elif velocidade_dragao1 < velocidade_dragao2:
    print("O Dragão 2 é mais rápido.")
else:
    print("Ambos os dragões têm a mesma velocidade.")
