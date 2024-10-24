# Função para desenhar um triângulo
def desenhar_triangulo(n):
    for i in range(1, n + 1):
        print('*' * i)

# Função para desenhar um quadrado
def desenhar_quadrado(n):
    for i in range(n):
        print('*' * n)

# Função para desenhar um losango
def desenhar_losango(n):
    # Parte superior do losango
    for i in range(n):
        print(' ' * (n - i - 1) + '*' * (2 * i + 1))
    # Parte inferior do losango
    for i in range(n - 2, -1, -1):
        print(' ' * (n - i - 1) + '*' * (2 * i + 1))

print("Escolha um padrão para desenhar:")
print("1. Triângulo")
print("2. Quadrado")
print("3. Losango")

opcao = int(input("Digite o número da opção desejada: "))
tamanho = int(input("Digite o tamanho do padrão: "))

# Desenha o padrão escolhido
if opcao == 1:
    desenhar_triangulo(tamanho)
elif opcao == 2:
    desenhar_quadrado(tamanho)
elif opcao == 3:
    desenhar_losango(tamanho)
else:
    print("Opção inválida!")
