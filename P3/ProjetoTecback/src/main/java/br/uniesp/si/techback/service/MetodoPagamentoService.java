package br.uniesp.si.techback.service;

import br.uniesp.si.techback.dto.metodo.MetodoPagamentoCreateDTO;
import br.uniesp.si.techback.dto.metodo.MetodoPagamentoResponseDTO;
import br.uniesp.si.techback.model.MetodoPagamento;
import br.uniesp.si.techback.repository.MetodoPagamentoRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MetodoPagamentoService {

    private final MetodoPagamentoRepository repository;

    public MetodoPagamentoService(MetodoPagamentoRepository repository) {
        this.repository = repository;
    }

    public MetodoPagamentoResponseDTO criar(MetodoPagamentoCreateDTO dto) {
        MetodoPagamento metodo = new MetodoPagamento(
                null,
                dto.tipo(),
                dto.detalhes()
        );
        repository.save(metodo);
        return toResponse(metodo);
    }

    public List<MetodoPagamentoResponseDTO> listar() {
        return repository.findAll()
                .stream()
                .map(this::toResponse)
                .toList();
    }

    public MetodoPagamentoResponseDTO buscar(Long id) {
        return repository.findById(id)
                .map(this::toResponse)
                .orElse(null);
    }

    public MetodoPagamentoResponseDTO atualizar(Long id, MetodoPagamentoCreateDTO dto) {
        MetodoPagamento metodo = repository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Método de pagamento não encontrado"));

        metodo.setTipo(dto.tipo());
        metodo.setDetalhes(dto.detalhes());

        repository.save(metodo);

        return toResponse(metodo);
    }

    public void deletar(Long id) {
        repository.deleteById(id);
    }

    private MetodoPagamentoResponseDTO toResponse(MetodoPagamento m) {
        return new MetodoPagamentoResponseDTO(
                m.getId(),
                m.getTipo(),
                m.getDetalhes()
        );
    }
}
