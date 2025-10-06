package br.uniesp.si.techback.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.*;
import java.util.UUID;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(of = "id")
@Entity
@Table(name = "planos")
public class Plano {

    @Id
    @GeneratedValue
    private UUID id;

    @Column(nullable = false, unique = true, length = 20)
    @NotBlank
    private String codigo;

    @Column(name = "limite_diario", nullable = false)
    @Min(1)
    private int limiteDiario;

    @Column(name = "streams_simultaneos", nullable = false)
    @Min(1)
    private int streamsSimultaneos;
}
