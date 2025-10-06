package br.uniesp.si.techback.controller;

import br.uniesp.si.techback.model.Conteudo;
import br.uniesp.si.techback.service.ConteudoService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.*;

@RestController
@RequestMapping("/api/conteudos")
@RequiredArgsConstructor
public class ConteudoController {

    private final ConteudoService service;

    @PostMapping
    public ResponseEntity<Conteudo> criar(@RequestBody Conteudo conteudo) {
        return ResponseEntity.ok(service.criar(conteudo));
    }

    @PutMapping("/{id}")
    public ResponseEntity<Conteudo> atualizar(@PathVariable UUID id, @RequestBody Conteudo conteudo) {
        return ResponseEntity.ok(service.atualizar(id, conteudo));
    }

    @GetMapping("/{id}")
    public ResponseEntity<Conteudo> buscar(@PathVariable UUID id) {
        return ResponseEntity.ok(service.buscarPorId(id));
    }

    @GetMapping
    public ResponseEntity<List<Conteudo>> listar() {
        return ResponseEntity.ok(service.listar());
    }

    @GetMapping("/genero/{genero}")
    public ResponseEntity<List<Conteudo>> filtrarPorGenero(@PathVariable String genero) {
        return ResponseEntity.ok(service.filtrarPorGenero(genero));
    }

    @GetMapping("/busca")
    public ResponseEntity<List<Conteudo>> buscarPorPalavraChave(@RequestParam String q) {
        return ResponseEntity.ok(service.buscarPorPalavraChave(q));
    }

    @GetMapping("/lancados")
    public ResponseEntity<List<Conteudo>> lancadosApos(@RequestParam int ano) {
        return ResponseEntity.ok(service.lancadosApos(ano));
    }

    @GetMapping("/com-trailer")
    public ResponseEntity<List<Conteudo>> comTrailer() {
        return ResponseEntity.ok(service.comTrailer());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> excluir(@PathVariable UUID id) {
        service.excluir(id);
        return ResponseEntity.noContent().build();
    }
}
