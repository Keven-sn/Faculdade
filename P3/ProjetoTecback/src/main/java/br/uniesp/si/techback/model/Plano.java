package br.uniesp.si.techback.model;

import jakarta.persistence.*;
import lombok.*;

import java.math.BigDecimal;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "planos")
public class Plano {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 80)
    private String nome;

    @Column(nullable = false)
    private BigDecimal precoMensal;

    @Column(nullable = false)
    private Integer resolucaoMax; // ex: 1080, 2160

    @Column(nullable = false)
    private Integer telasSimultaneas;
}
