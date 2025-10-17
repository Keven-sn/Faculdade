package br.uniesp.si.techback.dto.metodo;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public record MetodoPagamentoCreateDTO(
        @NotBlank @Size(max = 40) String tipo,
        @Size(max = 200) String detalhes
) {}
