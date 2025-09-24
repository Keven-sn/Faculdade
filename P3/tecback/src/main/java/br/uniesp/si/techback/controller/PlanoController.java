package br.uniesp.si.techback.controller;

import br.uniesp.si.techback.model.Plano;
import br.uniesp.si.techback.repository.PlanoRepository;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/planos")
public class PlanoController {

    private final PlanoRepository repository;

    public PlanoController(PlanoRepository repository) {
        this.repository = repository;
    }

    @GetMapping
    public List<Plano> listar() {
        return repository.findAll();
    }

    @GetMapping("/{id}")
    public Plano buscar(@PathVariable Long id) {
        return repository.findById(id).orElse(null);
    }

    @PostMapping
    public Plano criar(@RequestBody Plano plano) {
        return repository.save(plano);
    }

    @PutMapping("/{id}")
    public Plano atualizar(@PathVariable Long id, @RequestBody Plano plano) {
        plano.setId(id);
        return repository.save(plano);
    }

    @DeleteMapping("/{id}")
    public void deletar(@PathVariable Long id) {
        repository.deleteById(id);
    }
}
