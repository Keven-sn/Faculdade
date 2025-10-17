package br.uniesp.si.techback.service;

import br.uniesp.si.techback.dto.favorito.FavoritoCreateDTO;
import br.uniesp.si.techback.dto.favorito.FavoritoResponseDTO;
import br.uniesp.si.techback.model.Favorito;
import br.uniesp.si.techback.model.FavoritoId;
import br.uniesp.si.techback.repository.FavoritoRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
public class FavoritoService {

    private final FavoritoRepository repository;

    public FavoritoService(FavoritoRepository repository) {
        this.repository = repository;
    }

    public FavoritoResponseDTO adicionar(FavoritoCreateDTO dto) {
        Favorito favorito = new Favorito(
                new FavoritoId(dto.usuarioId(), dto.conteudoId()),
                null
        );
        repository.save(favorito);
        return toResponse(favorito);
    }

    public void remover(FavoritoCreateDTO dto) {
        FavoritoId id = new FavoritoId(dto.usuarioId(), dto.conteudoId());
        repository.deleteById(id);
    }

    public List<FavoritoResponseDTO> listarPorUsuario() {
        UUID usuarioId;
        return repository.findByIdUsuarioIdOrderByCriadoEmDesc()
                .stream()
                .map(this::toResponse)
                .toList();
    }

    private FavoritoResponseDTO toResponse(Favorito f) {
        return new FavoritoResponseDTO(
                f.getId().getUsuarioId(),
                f.getId().getConteudoId(),
                f.getCriadoEm()
        );
    }
}
