package br.uniesp.si.techback.service;

import br.uniesp.si.techback.dto.plano.PlanoCreateDTO;
import br.uniesp.si.techback.dto.plano.PlanoResponseDTO;
import br.uniesp.si.techback.model.Plano;
import br.uniesp.si.techback.repository.PlanoRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PlanoService {

    private final PlanoRepository repository;

    public PlanoService(PlanoRepository repository) {
        this.repository = repository;
    }

    public PlanoResponseDTO criar(PlanoCreateDTO dto) {
        Plano plano = new Plano(
                null,
                dto.nome(),
                dto.precoMensal(),
                dto.resolucaoMax(),
                dto.telasSimultaneas()
        );

        repository.save(plano);

        return toResponse(plano);
    }

    public List<PlanoResponseDTO> listar() {
        return repository.findAll().stream()
                .map(this::toResponse)
                .toList();
    }

    public PlanoResponseDTO buscar(Long id) {
        return repository.findById(id)
                .map(this::toResponse)
                .orElse(null);
    }

    public PlanoResponseDTO atualizar(Long id, PlanoCreateDTO dto) {
        Plano plano = repository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Plano não encontrado"));

        plano.setNome(dto.nome());
        plano.setPrecoMensal(dto.precoMensal());
        plano.setResolucaoMax(dto.resolucaoMax());
        plano.setTelasSimultaneas(dto.telasSimultaneas());

        repository.save(plano);
        return toResponse(plano);
    }

    public void deletar(Long id) {
        repository.deleteById(id);
    }

    private PlanoResponseDTO toResponse(Plano plano) {
        return new PlanoResponseDTO(
                plano.getId(),
                plano.getNome(),
                plano.getPrecoMensal(),
                plano.getResolucaoMax(),
                plano.getTelasSimultaneas()
        );
    }
}