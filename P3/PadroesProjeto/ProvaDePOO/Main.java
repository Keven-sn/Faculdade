package PadroesProjeto.ProvaDePOO;

public class Main {
    public static void main(String[] args) {
        Cliente cliente1 = new Cliente("Keven Douglas", "123.456.789-00");

        ContaCorrente cc = new ContaCorrente("0001", 1001, 1000.0);
        ContaPoupanca cp = new ContaPoupanca("0001", 2001, 500.0);

        cliente1.adicionarConta(cc);
        cliente1.adicionarConta(cp);

        System.out.println("=== CLIENTE CRIADO ===");
        System.out.println(cliente1);
        System.out.println();

        cc.depositar(200);
        cp.depositar(300);
        cc.sacar(100);
        cp.sacar(50);
        cc.transferir(200, cp);

        System.out.println("\n=== SALDOS ATUAIS ===");
        System.out.println("Conta Corrente: " + String.format("%.2f", cc.getSaldo()));
        System.out.println("Conta Poupança: " + String.format("%.2f", cp.getSaldo()));

        CalculadorDeImpostos calc = new CalculadorDeImpostos();
        System.out.println("\n=== IMPOSTOS ===");
        calc.calcular(cc);
    }
}
