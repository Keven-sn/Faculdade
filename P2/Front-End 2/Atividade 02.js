// Função para gerar um número aleatório entre um intervalo (min e max)
function gerarAlturaAleatoria(min, max) {
  return (Math.random() * (max - min) + min).toFixed(2); // Retorna a altura com 2 casas decimais
}

// Função para gerar o gênero aleatório
function gerarGeneroAleatorio() {
  return Math.random() > 0.5 ? "Masculino" : "Feminino"; // 50% de chance para cada gênero
}

// Gerando 15 pessoas com dados aleatórios
const pessoas = [];
for (let i = 0; i < 15; i++) {
  pessoas.push({
    altura: parseFloat(gerarAlturaAleatoria(1.50, 1.95)), // Converte para número e garante 2 casas decimais
    genero: gerarGeneroAleatorio(),
  });
}

// Maior e menor altura
let maiorAltura = Math.max(...pessoas.map(pessoa => pessoa.altura));
let menorAltura = Math.min(...pessoas.map(pessoa => pessoa.altura));

// Média de altura dos homens
let alturaHomens = pessoas.filter(pessoa => pessoa.genero === "Masculino");
let mediaHomens = alturaHomens.reduce((acc, pessoa) => acc + pessoa.altura, 0) / alturaHomens.length;

// Número de mulheres
let numMulheres = pessoas.filter(pessoa => pessoa.genero === "Feminino").length;

// Exibindo os resultados
console.log("Pessoas geradas:", pessoas);
console.log("Maior altura:", maiorAltura.toFixed(2)); // Formata a maior altura com 2 casas decimais
console.log("Menor altura:", menorAltura.toFixed(2)); // Formata a menor altura com 2 casas decimais
console.log("Média de altura dos homens:", mediaHomens.toFixed(2)); // Formata a média com 2 casas decimais
console.log("Número de mulheres:", numMulheres);
