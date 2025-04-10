function calcularSalarioComEntrada() {
    let salarioInicial = parseFloat(prompt("Digite o salário inicial do funcionário (ex: 1000):"));
    let anoContratacao = parseInt(prompt("Digite o ano de contratação (ex: 1995):"));

    if (isNaN(salarioInicial) || salarioInicial <= 0 || isNaN(anoContratacao) || anoContratacao <= 0) {
        alert("Por favor, insira valores válidos.");
        return;
    }

    let salario = salarioInicial;
    let aumento = 0.0015;
    const anoAtual = new Date().getFullYear();
    let tabelaAumentos = '';

    for (let ano = anoContratacao + 1; ano <= anoAtual; ano++) {
        salario += salario * aumento;

        if (salario > 999999999999) {
            salario = 999999999999; 
        }

        tabelaAumentos += `
            <tr>
                <td>${ano}</td>
                <td>R$ ${salario.toFixed(2).replace('.', ',')}</td>
                <td>${(aumento * 100).toFixed(2)}%</td>
            </tr>
        `;
        
        if (ano >= 1997) {
            aumento *= 2;
        }
    }

    document.getElementById("resultado").innerText =
        `O salário atual em ${anoAtual} é R$ ${salario.toFixed(2).replace('.', ',')} (com base em salário inicial de R$ ${salarioInicial.toFixed(2).replace('.', ',')}).`;

    document.getElementById("tabelaAumentos").getElementsByTagName("tbody")[0].innerHTML = tabelaAumentos;
}
