dados = [
    (170, 'Masculino'),
    (180, 'Masculino'),
    (145, 'Masculino'),
    (185, 'Masculino'),
    (190, 'Masculino'),
    (200, 'Masculino'),
    (169, 'Masculino'),
    (178, 'Masculino'),
    (163, 'Feminino'),
    (172, 'Feminino'),
    (162, 'Feminino'),
    (168, 'Feminino'),
    (150, 'Feminino'),
    (175, 'Feminino'),
    (155, 'Feminino'),
]

alturas = [item[0] for item in dados]
generos = [item[1] for item in dados]

maior_altura = max(alturas)
menor_altura = min(alturas)

alturas_masculinas = [altura for altura, genero in zip(alturas, generos) if genero == 'Masculino']
media_altura_masculina = sum(alturas_masculinas) / len(alturas_masculinas) if alturas_masculinas else 0

num_feminino = generos.count('Feminino')

print(f"A maior altura do grupo é: {maior_altura} cm")
print(f"A menor altura do grupo é: {menor_altura} cm")
print(f"A média de altura do gênero Masculino é: {media_altura_masculina:.2f} cm")
print(f"O número de pessoas do gênero Feminino é: {num_feminino}")
