package PadroesProjeto.ProvaDePOO;

public class CalculadorDeImpostos {
    public void calcular(Tributavel t) {
        double imposto = t.getValorImposto();
        System.out.printf("Imposto devido: R$%.2f%n", imposto);
    }
}
