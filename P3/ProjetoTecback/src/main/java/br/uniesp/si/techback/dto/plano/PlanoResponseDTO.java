package br.uniesp.si.techback.dto.plano;

import java.math.BigDecimal;

public record PlanoResponseDTO(
        Long id,
        String nome,
        BigDecimal precoMensal,
        Integer resolucaoMax,
        Integer telasSimultaneas
) {}
