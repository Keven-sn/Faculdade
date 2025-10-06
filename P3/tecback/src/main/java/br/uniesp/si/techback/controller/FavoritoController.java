package br.uniesp.si.techback.controller;

import br.uniesp.si.techback.model.*;
import br.uniesp.si.techback.service.FavoritoService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/favoritos")
@RequiredArgsConstructor
public class FavoritoController {

    private final FavoritoService service;

    @PostMapping
    public ResponseEntity<Favorito> adicionar(@RequestParam UUID usuarioId, @RequestParam UUID conteudoId) {
        Usuario usuario = new Usuario();
        usuario.setId(usuarioId);
        Conteudo conteudo = new Conteudo();
        conteudo.setId(conteudoId);
        return ResponseEntity.ok(service.adicionar(usuario, conteudo));
    }

    @DeleteMapping
    public ResponseEntity<Void> remover(@RequestParam UUID usuarioId, @RequestParam UUID conteudoId) {
        service.remover(usuarioId, conteudoId);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/usuario/{usuarioId}")
    public ResponseEntity<List<Favorito>> listarPorUsuario(@PathVariable UUID usuarioId) {
        Usuario usuario = new Usuario();
        usuario.setId(usuarioId);
        return ResponseEntity.ok(service.listarPorUsuario(usuario));
    }
}
