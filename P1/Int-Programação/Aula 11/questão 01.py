# Lista de clubes
clubes = ["Flamengo", "Vasco", "Palmeiras", "Botafogo", "Santos"]

# Leitura do nome do clube a ser procurado
clube_verificador = input("Digite o nome do clube a ser procurado: ")

# Inicialização da variável de confirmação
confirmacao_de_busca = False

# Verificação se o clube procurado está na lista
for clube in clubes:
    if clube.upper() == clube_verificador.upper():
        confirmacao_de_busca = True
         # Encerra o loop se o clube for encontrado

# Exibição do resultado
if confirmacao_de_busca:
    print("ACHEI")
else:
    print("NÃO ACHEI")
