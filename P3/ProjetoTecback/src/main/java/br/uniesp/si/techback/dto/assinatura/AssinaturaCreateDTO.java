package br.uniesp.si.techback.dto.assinatura;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import java.util.UUID;

public record AssinaturaCreateDTO(
        @NotNull UUID usuarioId,
        @NotBlank String codigoPlano
) {}
