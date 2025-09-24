package br.uniesp.si.techback.controller;

import br.uniesp.si.techback.model.Favorito;
import br.uniesp.si.techback.repository.FavoritoRepository;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/favoritos")
public class FavoritoController {

    private final FavoritoRepository repository;

    public FavoritoController(FavoritoRepository repository) {
        this.repository = repository;
    }

    @GetMapping
    public List<Favorito> listar() {
        return repository.findAll();
    }

    @GetMapping("/{id}")
    public Favorito buscar(@PathVariable Long id) {
        return repository.findById(id).orElse(null);
    }

    @PostMapping
    public Favorito criar(@RequestBody Favorito favorito) {
        return repository.save(favorito);
    }

    @PutMapping("/{id}")
    public Favorito atualizar(@PathVariable Long id, @RequestBody Favorito favorito) {
        favorito.setId(id);
        return repository.save(favorito);
    }

    @DeleteMapping("/{id}")
    public void deletar(@PathVariable Long id) {
        repository.deleteById(id);
    }
}
