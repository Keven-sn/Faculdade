function analisarNumeros() {
    let n = parseInt(prompt("Quantos números você quer digitar?"));

    if (isNaN(n) || n <= 0) {
        alert("Por favor, insira um número válido maior que zero.");
        return;
    }

    let numeros = [];
    for (let i = 1; i <= n; i++) {
        let num = parseFloat(prompt(`Digite o ${i}º número:`));

        if (isNaN(num)) {
            alert("Entrada inválida. Por favor, digite um número.");
            i--; 
        } else {
            numeros.push(num);
        }
    }

    let menor = Math.min(...numeros);
    let maior = Math.max(...numeros);
    let soma = numeros.reduce((acc, val) => acc + val, 0);

    document.getElementById("resultado").innerText =
        `Menor valor: ${menor}\nMaior valor: ${maior}\nSoma dos valores: ${soma}`;
}
