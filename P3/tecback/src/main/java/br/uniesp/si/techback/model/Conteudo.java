package br.uniesp.si.techback.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import java.time.LocalDateTime;
import java.util.UUID;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(of = "id")
@Entity
@Table(name = "conteudo")
public class Conteudo {

    @Id
    @GeneratedValue
    private UUID id;

    @NotBlank
    @Size(max = 200)
    private String titulo;

    @NotBlank
    @Size(max = 10)
    private String tipo;

    @Min(1888)
    @Max(2100)
    private int ano;

    @Column(name = "duracao_minutos")
    @Min(1)
    @Max(999)
    private int duracaoMinutos;

    @DecimalMin("0.00")
    @DecimalMax("99.99")
    private double relevancia;

    @Lob
    private String sinopse;

    @Column(name = "trailer_url", length = 500)
    private String trailerUrl;

    @Size(max = 50)
    private String genero;

    @CreationTimestamp
    @Column(name = "criado_em", nullable = false, updatable = false)
    private LocalDateTime criadoEm;

    @UpdateTimestamp
    @Column(name = "atualizado_em", nullable = false)
    private LocalDateTime atualizadoEm;
}
