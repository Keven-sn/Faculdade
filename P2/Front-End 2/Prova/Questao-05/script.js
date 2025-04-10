function calcularCirculo() {
    let raio = parseFloat(prompt("Digite o raio do círculo:"));

    if (isNaN(raio) || raio <= 0) {
        alert("Por favor, insira um valor válido e positivo para o raio.");
        return;
    }

    const pi = Math.PI;
    const area = pi * raio * raio;
    const perimetro = 2 * pi * raio;

    document.getElementById("resultado").innerText =
        `Raio: ${raio}
Área: ${area.toFixed(2)}
Perímetro: ${perimetro.toFixed(2)}`;
}
