package PadroesProjeto.ProvaDePOO;

public class ContaPoupanca extends Conta {

    public ContaPoupanca(String agencia, int numero, double saldoInicial) {
        super(agencia, numero, saldoInicial);
    }

    @Override
    public boolean sacar(double valor) {
        return super.sacar(valor);
    }

    @Override
    public String toString() {
        return "Conta Poupança -> " + super.toString();
    }
}
