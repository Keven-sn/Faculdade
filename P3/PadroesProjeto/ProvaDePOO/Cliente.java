package PadroesProjeto.ProvaDePOO;

import java.util.ArrayList;
import java.util.List;

public class Cliente {
    private String nome;
    private String cpf;
    private List<Conta> contas = new ArrayList<>();

    public Cliente(String nome, String cpf) {
        this.nome = nome;
        this.cpf = cpf;
    }

    public void adicionarConta(Conta conta) {
        contas.add(conta);
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("Nome: ").append(nome)
                .append("\nCPF: ").append(cpf)
                .append("\nContas do cliente:\n");
        for (Conta c : contas) {
            sb.append("  - ").append(c.toString()).append("\n");
        }
        return sb.toString();
    }
}
