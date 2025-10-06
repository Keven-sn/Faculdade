package br.uniesp.si.techback.service;

import br.uniesp.si.techback.model.*;
import br.uniesp.si.techback.repository.AssinaturaRepository;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class AssinaturaService {

    private final AssinaturaRepository repository;

    public Assinatura criar(Usuario usuario, Plano plano) {
        Assinatura assinatura = Assinatura.builder()
                .usuario(usuario)
                .plano(plano)
                .status("ATIVA")
                .iniciadaEm(LocalDateTime.now())
                .build();
        return repository.save(assinatura);
    }

    public Assinatura cancelar(UUID id) {
        Assinatura assinatura = repository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Assinatura não encontrada"));
        assinatura.setStatus("CANCELADA");
        assinatura.setCanceladaEm(LocalDateTime.now());
        return repository.save(assinatura);
    }

    public List<Assinatura> listarPorStatus(String status) {
        return repository.findByStatus(status);
    }
}
