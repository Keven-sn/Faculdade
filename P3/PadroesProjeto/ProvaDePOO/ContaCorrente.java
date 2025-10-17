package PadroesProjeto.ProvaDePOO;

public class ContaCorrente extends Conta implements Tributavel {

    public ContaCorrente(String agencia, int numero, double saldoInicial) {
        super(agencia, numero, saldoInicial);
    }

    @Override
    public boolean sacar(double valor) {
        double taxa = 0.10;
        return super.sacar(valor + taxa);
    }

    @Override
    public double getValorImposto() {
        return this.saldo * 0.01;
    }

    @Override
    public String toString() {
        return "Conta Corrente -> " + super.toString();
    }
}
