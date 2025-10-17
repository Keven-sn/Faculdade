package br.uniesp.si.techback.dto.conteudo;

import jakarta.validation.constraints.*;

public record ConteudoCreateDTO(
        @NotBlank @Size(max = 200) String titulo,
        @NotBlank String tipo,      // FILME | SERIE
        @Min(1888) @Max(2100) int ano,
        @Min(1) @Max(999) int duracaoMinutos,
        @DecimalMin("0.00") @DecimalMax("10.00") double relevancia,
        String sinopse,
        String trailerUrl,
        @NotBlank String genero
) {}
