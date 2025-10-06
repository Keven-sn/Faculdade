package br.uniesp.si.techback.controller;

import br.uniesp.si.techback.model.*;
import br.uniesp.si.techback.service.AssinaturaService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/assinaturas")
@RequiredArgsConstructor
public class AssinaturaController {

    private final AssinaturaService service;

    @PostMapping
    public ResponseEntity<Assinatura> criar(@RequestParam UUID usuarioId, @RequestParam UUID planoId) {
        Usuario usuario = new Usuario();
        usuario.setId(usuarioId);
        Plano plano = new Plano();
        plano.setId(planoId);
        return ResponseEntity.ok(service.criar(usuario, plano));
    }

    @PutMapping("/{id}/cancelar")
    public ResponseEntity<Assinatura> cancelar(@PathVariable UUID id) {
        return ResponseEntity.ok(service.cancelar(id));
    }

    @GetMapping
    public ResponseEntity<List<Assinatura>> listar(@RequestParam String status) {
        return ResponseEntity.ok(service.listarPorStatus(status));
    }
}
