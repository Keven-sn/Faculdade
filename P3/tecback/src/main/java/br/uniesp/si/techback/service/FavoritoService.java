package br.uniesp.si.techback.service;

import br.uniesp.si.techback.model.*;
import br.uniesp.si.techback.repository.FavoritoRepository;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class FavoritoService {

    private final FavoritoRepository repository;

    public Favorito adicionar(Usuario usuario, Conteudo conteudo) {
        FavoritoId id = new FavoritoId(usuario.getId(), conteudo.getId());
        Favorito favorito = Favorito.builder().id(id).usuario(usuario).conteudo(conteudo).build();
        return repository.save(favorito);
    }

    public void remover(UUID usuarioId, UUID conteudoId) {
        FavoritoId id = new FavoritoId(usuarioId, conteudoId);
        repository.deleteById(id);
    }

    public List<Favorito> listarPorUsuario(Usuario usuario) {
        return repository.findByUsuarioOrderByCriadoEmDesc(usuario);
    }
}
