numero_decimal = int(input("Digite um número decimal não negativo: "))

if numero_decimal < 0:
    print("Por favor, insira um número decimal não negativo.")
else:
    # Inicializa uma lista para armazenar os restos
    restos = []
    
    # Realiza as divisões sucessivas por 2
    while numero_decimal > 0:
        resto = numero_decimal % 2  # Obtém o resto da divisão por 2
        restos.append(resto)         # Armazena o resto
        numero_decimal //= 2         # Divide o número por 2

    # Os restos estão na contraria, então invertemos
    restos.reverse()

    # Converte a lista de restos para uma string
    binario = ''.join(str(bit) for bit in restos)

    print(f"A representação binária é: {binario}")
