package br.uniesp.si.techback.controller;

import br.uniesp.si.techback.dto.metodo.MetodoPagamentoCreateDTO;
import br.uniesp.si.techback.dto.metodo.MetodoPagamentoResponseDTO;
import br.uniesp.si.techback.service.MetodoPagamentoService;
import jakarta.validation.Valid;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/metodos-pagamento")
public class MetodoPagamentoController {

    private final MetodoPagamentoService service;

    public MetodoPagamentoController(MetodoPagamentoService service) {
        this.service = service;
    }

    @PostMapping
    public MetodoPagamentoResponseDTO criar(@Valid @RequestBody MetodoPagamentoCreateDTO dto) {
        return service.criar(dto);
    }

    @GetMapping
    public List<MetodoPagamentoResponseDTO> listar() {
        return service.listar();
    }

    @GetMapping("/{id}")
    public MetodoPagamentoResponseDTO buscar(@PathVariable Long id) {
        return service.buscar(id);
    }

    @PutMapping("/{id}")
    public MetodoPagamentoResponseDTO atualizar(@PathVariable Long id,
                                                @Valid @RequestBody MetodoPagamentoCreateDTO dto) {
        return service.atualizar(id, dto);
    }

    @DeleteMapping("/{id}")
    public void deletar(@PathVariable Long id) {
        service.deletar(id);
    }
}
