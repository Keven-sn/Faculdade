lista_de_compras = []


def adicionar_item(lista_de_compras: list) -> list:
    novo_item = (input('Digite o novo item desejado:'))
    lista_de_compras = lista_de_compras + [novo_item]

    return lista_de_compras


def deletar_item(lista_de_compras: list) -> list:

    item_remover = int(input('Digite o código do item:')) - 1
    del lista_de_compras[item_remover]

    return lista_de_compras


def exibir_lista(lista_de_compras: list):
    for i in range(len(lista_de_compras)):
        print(f'{i+1} - {lista_de_compras}')


opcao = 1000
while opcao != 0:
    print('\n ================')
    print('1 - Adicionar novo item ')
    print('2 - Remover item')
    print('3 - Exibir lista completa')
    print('4 - Sair')
    opcao = int(input('Digite a opção desejada:'))

    if opcao == 1:
        print("\n ====> ADICIONAR ITEM <====\n ")
        adicionar_item(lista_de_compras=lista_de_compras)

    elif opcao == 2:
        print("n ====>  REMOVER ITEM <====\n  ")

        exibir_lista(lista_de_compras=lista_de_compras)

        print('\n ===')
        deletar_item(lista_de_compras=lista_de_compras)

    elif opcao == 3:
        print("\n ====> LISTA COMPLETA <====\n ")

        exibir_lista(lista_de_compras=lista_de_compras)
