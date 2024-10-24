numero = int(input("Digite um número inteiro: "))

# Função para verificar se o número é primo
def eh_primo(n):
    if n <= 1:
        return False  
    for i in range(2, int(n**0.5) + 1):  # Testa divisibilidade até a raiz quadrada de n
        if n % i == 0:
            return False  # Se for divisível, não é primo
    return True  # Se não for divisível por nenhum, é primo

# Verifica se o número é primo e exibe o resultado
if eh_primo(numero):
    print(f"{numero} é um número primo.")
else:
    print(f"{numero} não é um número primo.")
