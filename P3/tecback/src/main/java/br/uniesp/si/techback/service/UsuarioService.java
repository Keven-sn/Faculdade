package br.uniesp.si.techback.service;

import br.uniesp.si.techback.model.Usuario;
import br.uniesp.si.techback.repository.UsuarioRepository;
import jakarta.persistence.EntityNotFoundException;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class UsuarioService {

    private final UsuarioRepository usuarioRepository;
    private final BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    public Usuario criar(Usuario usuario) {
        usuario.setSenhaHash(passwordEncoder.encode(usuario.getSenhaHash()));
        return usuarioRepository.save(usuario);
    }

    public Usuario atualizar(UUID id, Usuario dados) {
        Usuario existente = buscarPorId(id);
        existente.setNomeCompleto(dados.getNomeCompleto());
        existente.setEmail(dados.getEmail());
        existente.setDataNascimento(dados.getDataNascimento());
        existente.setCpfCnpj(dados.getCpfCnpj());
        existente.setPerfil(dados.getPerfil());
        existente.setEndereco(dados.getEndereco());
        return usuarioRepository.save(existente);
    }

    public Usuario buscarPorId(UUID id) {
        return usuarioRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Usuário não encontrado"));
    }

    public List<Usuario> listar() {
        return usuarioRepository.findAll();
    }

    public void excluir(UUID id) {
        usuarioRepository.deleteById(id);
    }

    private class BCryptPasswordEncoder {
        public @NotBlank @Size(min = 8, max = 60) String encode(@NotBlank @Size(min = 8, max = 60) String senhaHash) {
            return senhaHash;
        }
    }

}