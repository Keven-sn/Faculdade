frase = input("Digite uma frase: ")

contagem_vogais = 0
contagem_consoantes = 0

# Converte a frase para minúsculas para facilitar a contagem
frase = frase.lower()

# Define as vogais
vogais = "aeiou"

# Loop para contar vogais e consoantes
for char in frase:
    if char.isalpha():  # Verifica se é uma letra
        if char in vogais:
            contagem_vogais += 1
        else:
            contagem_consoantes += 1

print(f"Número de vogais: {contagem_vogais}")
print(f"Número de consoantes: {contagem_consoantes}")
