function gerarAlturaAleatoria(min, max) {
    return (Math.random() * (max - min) + min).toFixed(2); 
  }
  function gerarGeneroAleatorio() {
    return Math.random() > 0.5 ? "Masculino" : "Feminino"; 
  }
  const pessoas = [];
  for (let i = 0; i < 15; i++) {
    pessoas.push({
      altura: gerarAlturaAleatoria(1.50, 1.95), 
      genero: gerarGeneroAleatorio(),
    });
  }
  
  let maiorAltura = Math.max(...pessoas.map(pessoa => pessoa.altura));
  let menorAltura = Math.min(...pessoas.map(pessoa => pessoa.altura));
  
  let alturaHomens = pessoas.filter(pessoa => pessoa.genero === "Masculino");
  let mediaHomens = alturaHomens.reduce((acc, pessoa) => acc + pessoa.altura, 0) / alturaHomens.length;
  
  let numMulheres = pessoas.filter(pessoa => pessoa.genero === "Feminino").length;
  
  console.log("Pessoas geradas:", pessoas);
  console.log("Maior altura:", maiorAltura);
  console.log("Menor altura:", menorAltura);
  console.log("Média de altura dos homens:", mediaHomens.toFixed(2));
  console.log("Número de mulheres:", numMulheres);
  