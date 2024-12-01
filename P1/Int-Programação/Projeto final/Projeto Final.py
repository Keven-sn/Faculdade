import requests 
from deep_translator import GoogleTranslator
import time

#Função para obter um conselho da API
def obter_conselho():
    url = 'https://api.adviceslip.com/advice'
    response = requests.get(url)
    if response.status_code == 200:
        return response.json()['slip']['advice']
    return "Erro ao acessar a API."

#Função para salvar conselhos no arquivo
def salvar_conselho(conselho):
    with open('conselhos.txt', 'a') as c:
        c.write(conselho + '\n')

#Função para traduzir o conselho
def traduzir_conselho(conselho):
    return GoogleTranslator(source='en', target='pt').translate(conselho)

def traduzir_conselho_en(conselho):
    return GoogleTranslator(source='pt', target='en').translate(conselho)
    

#Função principal de interação
def menu():
    while True:
        print("\nEscolha uma opção:")
        print("1. Quantos conselhos você quer receber? ")
        print("2. Mostrar conselhos salvos")
        print("3. Traduzir um conselho para o português")
        print("4. Traduzir um conselho para o inglês")
        print("5. Sair")
        
        opcao = input("Digite a opção desejada: ")
        
        if opcao == '1':
            #Pergunta quantos conselhos o usuário quer
            num_conselhos = int(input("Quantos conselhos você quer receber? "))
            
            for i in range(num_conselhos):
                print(f"\nConselho {i+1}:")
                conselho = obter_conselho()  
                print(f"Conselho: {conselho}")

                time.sleep(1)
                
                #Pergunta se o usuário quer traduzir o conselho
                traduzir = input("Você deseja traduzir este conselho para o português? (s/n): ")

                time.sleep(1)

                if traduzir.lower() == 's':
                    conselho_traduzido = traduzir_conselho(conselho)  #Traduz o conselho
                    print(f"Conselho traduzido: {conselho_traduzido}")
                
                    conselho = conselho_traduzido  #Atualiza o conselho para o traduzido
                else:
                    print("Conselho não traduzido.")

                time.sleep(1)
                
                salvar = input("Deseja salvar este conselho? (s/n): ")
                if salvar.lower() == 's':
                    salvar_conselho(conselho)  
                    print("Conselho salvo com sucesso!")

                time.sleep(1)
        
        elif opcao == '2':
            try:
                 with open('conselhos.txt', 'r') as c:
                    print("\nConselhos salvos:")
                    print(c.read())
            except FileNotFoundError:
                print("Nenhum conselho salvo ainda.")

                time.sleep(1)
        
        elif opcao == '3':
            conselho = input("Digite o conselho para traduzir: ")
            print("Traduzindo...")
            print(f"Conselho traduzido: {traduzir_conselho(conselho)}")

            time.sleep(1)
        
        elif opcao == '4':
            conselho = input("Digite o conselho para traduzir: ")
            print("Traduzindo...")
            print(f"Conselho traduzido: {traduzir_conselho_en(conselho)}")

            time.sleep(1)

        elif opcao == '5':
            print("Saindo...")
            break
        else:
            print("Opção inválida! Tente novamente.")

        time.sleep(1)

#Chama a função do menu
menu()
