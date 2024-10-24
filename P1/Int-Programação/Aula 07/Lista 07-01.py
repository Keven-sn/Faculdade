notas = []
nota = 0

while True:
    nota = float(input("Digite uma nota (ou -1 para encerrar): "))
    
    if nota == -1:
        break
    
    if 0 <= nota <= 10: 
        notas.append(nota)
    else:
        print("Nota inválida. Por favor, insira uma nota entre 0 e 10.")

if notas:
    media = sum(notas) / len(notas)
    print(f"A média das notas é: {media:.2f}")
else:
    print("Nenhuma nota foi inserida.")
