function calcularInvestimento() {
    let capital = parseFloat(prompt("Digite o capital inicial (R$):"));
    let taxa = parseFloat(prompt("Digite a taxa de juros mensal (%):"));
    let tempo = parseInt(prompt("Digite o tempo do investimento (em meses):"));

    if (isNaN(capital) || isNaN(taxa) || isNaN(tempo) || capital <= 0 || taxa < 0 || tempo <= 0) {
        alert("Por favor, insira valores válidos.");
        return;
    }

    let i = taxa / 100; 
    let montante = capital * Math.pow((1 + i), tempo);

    document.getElementById("resultado").innerText =
        `Montante após ${tempo} meses: R$ ${montante.toFixed(2)}`;
}
