package br.uniesp.si.techback.service;

import br.uniesp.si.techback.model.*;
import br.uniesp.si.techback.repository.AssinaturaRepository;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.*;

@Service
@Transactional
public class AssinaturaService {

    private final AssinaturaRepository repository;
    private final UsuarioRepositoryInjection usuarioRepo; // placeholder note

    public AssinaturaService(AssinaturaRepository repository) {
        this.repository = repository;
    }

    public Assinatura criar(Usuario usuario, Plano plano) {
        Assinatura a = Assinatura.builder()
                .usuario(usuario)
                .plano(plano)
                .status("ATIVA")
                .iniciadaEm(LocalDateTime.now())
                .build();
        return repository.save(a);
    }

    public Assinatura cancelar(UUID id) {
        Assinatura a = repository.findById(id).orElseThrow(() -> new EntityNotFoundException("Assinatura não encontrada"));
        a.setStatus("CANCELADA");
        a.setCanceladaEm(LocalDateTime.now());
        return repository.save(a);
    }

    public List<Assinatura> listarPorStatus(String status) {
        return repository.findByStatus(status);
    }

    public Map<String, Long> contarAtivasPorPlano() {
        List<Object[]> rows = repository.contarAtivasPorPlano();
        Map<String, Long> map = new HashMap<>();
        for (Object[] row : rows) {
            map.put((String) row[0], ((Number) row[1]).longValue());
        }
        return map;
    }
}
