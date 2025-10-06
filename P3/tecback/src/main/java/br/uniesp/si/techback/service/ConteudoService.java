package br.uniesp.si.techback.service;

import br.uniesp.si.techback.model.Conteudo;
import br.uniesp.si.techback.repository.ConteudoRepository;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.*;

@Service
@RequiredArgsConstructor
public class ConteudoService {

    private final ConteudoRepository repository;

    public Conteudo criar(Conteudo conteudo) {
        return repository.save(conteudo);
    }

    public Conteudo atualizar(UUID id, Conteudo dados) {
        Conteudo existente = buscarPorId(id);
        existente.setTitulo(dados.getTitulo());
        existente.setTipo(dados.getTipo());
        existente.setAno(dados.getAno());
        existente.setDuracaoMinutos(dados.getDuracaoMinutos());
        existente.setRelevancia(dados.getRelevancia());
        existente.setSinopse(dados.getSinopse());
        existente.setTrailerUrl(dados.getTrailerUrl());
        existente.setGenero(dados.getGenero());
        return repository.save(existente);
    }

    public Conteudo buscarPorId(UUID id) {
        return repository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Conteúdo não encontrado"));
    }

    public List<Conteudo> listar() {
        return repository.findAll();
    }

    public List<Conteudo> filtrarPorGenero(String genero) {
        return repository.findByGeneroIgnoreCaseOrderByTituloAsc(genero);
    }

    public List<Conteudo> buscarPorPalavraChave(String keyword) {
        return repository.buscarPorPalavraChave(keyword);
    }

    public List<Conteudo> lancadosApos(int ano) {
        return repository.lancadosApos(ano);
    }

    public List<Conteudo> comTrailer() {
        return repository.comTrailer();
    }

    public void excluir(UUID id) {
        repository.deleteById(id);
    }
}
