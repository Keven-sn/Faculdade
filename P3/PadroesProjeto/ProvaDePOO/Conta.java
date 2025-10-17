package PadroesProjeto.ProvaDePOO;

public abstract class Conta {
    private String agencia;
    private int numero;
    protected double saldo;

    public Conta(String agencia, int numero, double saldoInicial) {
        this.agencia = agencia;
        this.numero = numero;
        this.saldo = saldoInicial;
    }

    public void depositar(double valor) {
        if (valor > 0) {
            saldo += valor;
        }
    }

    public boolean sacar(double valor) {
        if (valor <= saldo) {
            saldo -= valor;
            return true;
        }
        return false;
    }

    public void transferir(double valor, Conta destino) {
        if (this.sacar(valor)) {
            destino.depositar(valor);
        }
    }

    public double getSaldo() {
        return saldo;
    }

    public String getAgencia() {
        return agencia;
    }

    public int getNumero() {
        return numero;
    }

    @Override
    public String toString() {
        return String.format("Agência: %s, Número: %d, Saldo: R$%.1f", agencia, numero, saldo);
    }
}
