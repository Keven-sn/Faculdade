package br.uniesp.si.techback.dto.metodo;

public record MetodoPagamentoResponseDTO(
        Long id,
        String tipo,
        String detalhes
) {}
