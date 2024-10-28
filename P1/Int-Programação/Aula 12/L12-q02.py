import numpy as np

def main():
    A = np.random.randint(0, 101, size=(10, 10))

    print("Matriz A:")
    print(A)

    soma_A = np.sum(A)
    print(f"\nSoma de todos os valores da matriz A: {soma_A}")

    B = A * 3

    print("\nMatriz B (A * 3):")
    print(B)

if __name__ == "__main__":
    main()