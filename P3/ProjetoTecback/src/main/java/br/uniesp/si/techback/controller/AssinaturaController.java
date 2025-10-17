package br.uniesp.si.techback.controller;

import br.uniesp.si.techback.model.Assinatura;
import br.uniesp.si.techback.model.Plano;
import br.uniesp.si.techback.model.Usuario;
import br.uniesp.si.techback.service.AssinaturaService;
import br.uniesp.si.techback.service.PlanoService;
import br.uniesp.si.techback.repository.UsuarioRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/assinaturas")
public class AssinaturaController {

    private final AssinaturaService service;
    private final PlanoService planoService;
    private final UsuarioRepository usuarioRepository;

    public AssinaturaController(AssinaturaService service, PlanoService planoService, UsuarioRepository usuarioRepository) {
        this.service = service;
        this.planoService = planoService;
        this.usuarioRepository = usuarioRepository;
    }

    @PostMapping
    public ResponseEntity<Assinatura> criar(@RequestParam UUID usuarioId, @RequestParam String codigoPlano) {
        Usuario usuario = usuarioRepository.findById(usuarioId).orElseThrow(() -> new IllegalArgumentException("Usuário não encontrado"));
        Plano plano = planoService.buscarPorCodigo(codigoPlano);
        Assinatura criada = service.criar(usuario, plano);
        return ResponseEntity.ok(criada);
    }

    @PutMapping("/{id}/cancelar")
    public ResponseEntity<Assinatura> cancelar(@PathVariable UUID id) {
        return ResponseEntity.ok(service.cancelar(id));
    }

    @GetMapping
    public ResponseEntity<List<Assinatura>> listar(@RequestParam(required = false) String status) {
        if (status == null) return ResponseEntity.ok(service.listarPorStatus("ATIVA"));
        return ResponseEntity.ok(service.listarPorStatus(status));
    }

    @GetMapping("/count-ativas")
    public ResponseEntity<?> contarAtivasPorPlano() {
        return ResponseEntity.ok(service.contarAtivasPorPlano());
    }
}
