import random

numero_secreto = random.randint(1, 100)

print("Bem-vindo ao jogo de adivinhação!")
print("Tente adivinhar o número entre 1 e 100.")

# Inicializa a variável para armazenar a tentativa do usuário
tentativa = 0
contador_tentativas = 0

# Loop para permitir várias tentativas
while tentativa != numero_secreto:
    tentativa = int(input("Digite sua tentativa: "))
    contador_tentativas += 1
    
    if tentativa < numero_secreto:
        print("Muito baixo! Tente novamente.")
    elif tentativa > numero_secreto:
        print("Muito alto! Tente novamente.")
    else:
        print(f"Parabéns! Você acertou o número {numero_secreto} em {contador_tentativas} tentativas.")
