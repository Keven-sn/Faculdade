agua_disponivel = float(input("Informe a quantidade de água disponível (em litros): "))

distancia_ate_oasis = float(input("Informe a distância até o oásis (em quilômetros): "))

agua_necessaria = distancia_ate_oasis * 2

if agua_disponivel >= agua_necessaria:
    print("A água é suficiente para chegar ao oásis.")
else:
    print("A água não é suficiente para chegar ao oásis.")
