package br.uniesp.si.techback.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.UUID;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(of = "id")
@Entity
@Table(name = "usuarios")
public class Usuario {

    @Id
    @GeneratedValue
    private UUID id;

    @Column(name = "nome_completo", nullable = false, length = 150)
    @NotBlank
    @Size(max = 150)
    private String nomeCompleto;

    @Column(name = "data_nascimento", nullable = false)
    @NotNull
    private LocalDate dataNascimento;

    @Column(nullable = false, unique = true, length = 254)
    @Email
    @NotBlank
    @Size(max = 254)
    private String email;

    @Column(name = "senha_hash", nullable = false, length = 60)
    @NotBlank
    @Size(min = 8, max = 60)
    private String senhaHash;

    @Column(name = "cpf_cnpj", unique = true, length = 14)
    private String cpfCnpj;

    @Column(nullable = false, length = 20)
    @NotBlank
    private String perfil;

    @CreationTimestamp
    @Column(name = "criado_em", nullable = false, updatable = false)
    private LocalDateTime criadoEm;

    @UpdateTimestamp
    @Column(name = "atualizado_em", nullable = false)
    private LocalDateTime atualizadoEm;

    @Embedded
    private Endereco endereco;
}
