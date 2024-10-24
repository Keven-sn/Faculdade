porta_escolhida = int(input("Escolha um número de porta (1 a 5): "))

if 1 <= porta_escolhida <= 5:
    match porta_escolhida:
        case 1:
            print("Desafio: Enfrente um dragão feroz!")
        case 2:
            print("Desafio: Resolva um enigma antigo!")
        case 3:
            print("Desafio: Atravessar uma ponte instável!")
        case 4:
            print("Desafio: Encontrar um tesouro escondido!")
        case 5:
            print("Desafio: Lutar contra um guerreiro fantasma!")
else:
    print("Número da porta inválido! Escolha um número entre 1 e 5.")
    
3
