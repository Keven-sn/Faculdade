energia = float(input("Informe o nível de energia (em %): "))
coordenadas_destino = input("As coordenadas de destino estão corretas? (sim/não): ").strip().lower()
tempo_ajustado = input("O tempo está ajustado corretamente? (sim/não): ").strip().lower()

if energia > 80 and coordenadas_destino == "sim" and tempo_ajustado == "sim":
    print("O portal de viagem no tempo pode ser ativado!")
else:
    # Verifica qual parâmetro está incorreto
    if energia <= 80:
        print("Problema: A energia deve estar acima de 80%.")
    if coordenadas_destino != "sim":
        print("Problema: As coordenadas de destino precisam estar corretas.")
    if tempo_ajustado != "sim":
        print("Problema: O tempo precisa estar ajustado corretamente.")
