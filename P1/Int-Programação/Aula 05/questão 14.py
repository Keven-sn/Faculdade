ataque_guerreiro1 = float(input("Informe o ataque do Guerreiro 1: "))
defesa_guerreiro1 = float(input("Informe a defesa do Guerreiro 1: "))

ataque_guerreiro2 = float(input("Informe o ataque do Guerreiro 2: "))
defesa_guerreiro2 = float(input("Informe a defesa do Guerreiro 2: "))

soma_guerreiro1 = ataque_guerreiro1 + defesa_guerreiro1
soma_guerreiro2 = ataque_guerreiro2 + defesa_guerreiro2

if soma_guerreiro1 > soma_guerreiro2:
    print("O Guerreiro 1 é o vencedor!")
elif soma_guerreiro2 > soma_guerreiro1:
    print("O Guerreiro 2 é o vencedor!")
else:
    if defesa_guerreiro1 > defesa_guerreiro2:
        print("O Guerreiro 1 é o vencedor por defesa!")
    elif defesa_guerreiro2 > defesa_guerreiro1:
        print("O Guerreiro 2 é o vencedor por defesa!")
    else:
        print("Empate! Ambos os guerreiros têm habilidades iguais.")
