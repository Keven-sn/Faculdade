def calcular_media(notas):
    return sum(notas) / len(notas)

notas_candidato1 = [float(input("Informe a nota 1 do Candidato 1: ")),
                     float(input("Informe a nota 2 do Candidato 1: ")),
                     float(input("Informe a nota 3 do Candidato 1: "))]

notas_candidato2 = [float(input("Informe a nota 1 do Candidato 2: ")),
                     float(input("Informe a nota 2 do Candidato 2: ")),
                     float(input("Informe a nota 3 do Candidato 2: "))]

notas_candidato3 = [float(input("Informe a nota 1 do Candidato 3: ")),
                     float(input("Informe a nota 2 do Candidato 3: ")),
                     float(input("Informe a nota 3 do Candidato 3: "))]

media_candidato1 = calcular_media(notas_candidato1)
media_candidato2 = calcular_media(notas_candidato2)
media_candidato3 = calcular_media(notas_candidato3)

if media_candidato1 > media_candidato2 and media_candidato1 > media_candidato3:
    print("Candidato 1 é o próximo governante com média:", media_candidato1)
elif media_candidato2 > media_candidato1 and media_candidato2 > media_candidato3:
    print("Candidato 2 é o próximo governante com média:", media_candidato2)
elif media_candidato3 > media_candidato1 and media_candidato3 > media_candidato2:
    print("Candidato 3 é o próximo governante com média:", media_candidato3)
else:
    print("Houve um empate entre os candidatos.")
