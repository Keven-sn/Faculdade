numero = int(input("Digite um número inteiro não negativo para calcular o fatorial: "))

if numero < 0:
    print("Fatorial não definido para números negativos.")
else:
    # Inicializa a variável para armazenar o fatorial
    fatorial = 1
    
    # Calcula o fatorial usando um loop
    for i in range(1, numero + 1):
        fatorial *= i  # Multiplica o fatorial pelo contador i
    
    print(f"O fatorial de {numero} é: {fatorial}")
