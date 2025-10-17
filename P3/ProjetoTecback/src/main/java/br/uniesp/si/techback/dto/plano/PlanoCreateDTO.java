package br.uniesp.si.techback.dto.plano;

import jakarta.validation.constraints.*;
import java.math.BigDecimal;

public record PlanoCreateDTO(
        @NotBlank @Size(max = 80) String nome,
        @NotNull @DecimalMin("0.0") BigDecimal precoMensal,
        @NotNull @Min(144) Integer resolucaoMax,
        @NotNull @Min(1) Integer telasSimultaneas
) {}
