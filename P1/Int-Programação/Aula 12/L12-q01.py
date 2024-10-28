def main():
    VET = []

    for i in range(10):
        num = int(input(f"Digite o número {i + 1}: "))
        VET.append(num)

    posicoes = {}

    for indice, numero in enumerate(VET):
        if numero in posicoes:
            posicoes[numero].append(indice)
        else:
            posicoes[numero] = [indice]

    repetidos = {num: pos for num, pos in posicoes.items() if len(pos) > 1}
    
    if repetidos:
        print("Números repetidos e suas posições:")
        for numero, pos in repetidos.items():
            print(f"Número {numero} encontrado nas posições: {pos}")
    else:
        print("Não existem números repetidos.")

if __name__ == "__main__":
    main()
