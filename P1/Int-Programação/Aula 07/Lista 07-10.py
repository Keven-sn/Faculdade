import random

num_lancamentos = int(input("Digite o número de lançamentos do dado: "))

resultados = []

for _ in range(num_lancamentos):
    lancamento = random.randint(1, 6)  # Lança o dado (número entre 1 e 6)
    resultados.append(lancamento)        # Armazena o resultado

print("Resultados dos lançamentos:")
for i, resultado in enumerate(resultados, start=1):
    print(f"Lançamento {i}: {resultado}")
