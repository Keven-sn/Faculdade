posicao_exercito = input("Informe a posição do exército (dentro ou fora do castelo): ").strip().lower()

match posicao_exercito:
    case "dentro":
        print("Sistema de defesa: DESATIVADO. O exército está dentro do castelo.")
    case "fora":
        print("Sistema de defesa: ATIVADO. O exército está fora do castelo.")
    case _:
        print("Posição inválida! Por favor, informe 'dentro' ou 'fora'.")
