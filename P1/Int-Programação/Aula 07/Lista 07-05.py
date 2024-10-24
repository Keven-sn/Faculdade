Numero = int(input("Digite o número de termos da sequência de Fibonacci que deseja gerar: "))

fibonacci = [0, 1]
 
for i in range(2, Numero):
    proximo_termo = fibonacci[i - 1] + fibonacci[i - 2]
    fibonacci.append(proximo_termo)

print(f"Os primeiros {Numero} termos da sequência de Fibonacci são:")
print(fibonacci[:Numero])
