package br.uniesp.si.techback.service;

import br.uniesp.si.techback.model.MetodoPagamento;
import br.uniesp.si.techback.model.Usuario;
import br.uniesp.si.techback.repository.MetodoPagamentoRepository;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class MetodoPagamentoService {

    private final MetodoPagamentoRepository repository;

    public MetodoPagamento criar(MetodoPagamento metodoPagamento) {
        return repository.save(metodoPagamento);
    }

    public void remover(UUID id) {
        repository.deleteById(id);
    }

    public List<MetodoPagamento> listarPorUsuario(Usuario usuario) {
        return repository.findByUsuario(usuario);
    }

    public MetodoPagamento buscarPorId(UUID id) {
        return repository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Método de pagamento não encontrado"));
    }
}
