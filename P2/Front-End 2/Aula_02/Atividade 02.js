const pessoas = [
  { altura: 1.75, genero: "Masculino" },
  { altura: 1.62, genero: "Feminino" },
  { altura: 1.80, genero: "Masculino" },
  { altura: 1.55, genero: "Feminino" },
  { altura: 1.68, genero: "Masculino" },
  { altura: 1.70, genero: "Feminino" },
  { altura: 1.85, genero: "Masculino" },
  { altura: 1.60, genero: "Feminino" },
  { altura: 1.77, genero: "Masculino" },
  { altura: 1.58, genero: "Feminino" },
  { altura: 1.72, genero: "Masculino" },
  { altura: 1.65, genero: "Feminino" },
  { altura: 1.90, genero: "Masculino" },
  { altura: 1.69, genero: "Feminino" },
  { altura: 1.82, genero: "Masculino" },
];


let maiorAltura = -Infinity;
let menorAltura = Infinity;

pessoas.forEach(pessoa => {
  if (pessoa.altura > maiorAltura) {
    maiorAltura = pessoa.altura;
  }
  if (pessoa.altura < menorAltura) {
    menorAltura = pessoa.altura;
  }
});


let somaAlturasMasculino = 0;
let contadorMasculino = 0;

pessoas.forEach(pessoa => {
  if (pessoa.genero === "Masculino") {
    somaAlturasMasculino += pessoa.altura;
    contadorMasculino++;
  }
});

let mediaAlturaMasculino = somaAlturasMasculino / contadorMasculino;

let contadorFeminino = 0;

pessoas.forEach(pessoa => {
  if (pessoa.genero === "Feminino") {
    contadorFeminino++;
  }
});

console.log("Maior altura:", maiorAltura);
console.log("Menor altura:", menorAltura);
console.log("Média de altura dos homens:", mediaAlturaMasculino.toFixed(2));
console.log("Número de mulheres:", contadorFeminino);

