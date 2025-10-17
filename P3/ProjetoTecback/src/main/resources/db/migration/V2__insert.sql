INSERT INTO planos (id, codigo, limite_diario, streams_simultaneos)
VALUES
    (gen_random_uuid(), 'BASICO', 3, 1),
    (gen_random_uuid(), 'PADRAO', 5, 2),
    (gen_random_uuid(), 'PREMIUM', 10, 4);


INSERT INTO planos (id, codigo, limite_diario, streams_simultaneos)
VALUES
    (uuid_generate_v4(), 'BASICO', 2, 1),
    (uuid_generate_v4(), 'PADRAO', 4, 2),
    (uuid_generate_v4(), 'PREMIUM', 999, 4);


INSERT INTO conteudo (id, titulo, tipo, ano, duracao_minutos, relevancia, sinopse, trailer_url, genero)
VALUES
    (uuid_generate_v4(), 'Interestelar', 'FILME', 2014, 169, 9.8,
        'Um grupo de astronautas viaja através de um buraco de minhoca.',
        'https://youtube.com/trailer/interestelar', 'FICÇÃO'),

    (uuid_generate_v4(), 'Breaking Bad', 'SERIE', 2008, 50, 9.9,
        'Professor vira fabricante de drogas.',
        'https://youtube.com/trailer/breakingbad', 'DRAMA'),

    (uuid_generate_v4(), 'Avatar', 'FILME', 2009, 180, 9.4,
        'Humano se conecta com nativos de Pandora.',
        'https://youtube.com/trailer/avatar', 'FANTASIA');



INSERT INTO usuarios (
    id, nome_completo, data_nascimento, email, senha_hash, cpf_cnpj, perfil, criado_em, atualizado_em
) VALUES (
    uuid_generate_v4(),
    'Usuário de Teste',
    '1990-01-01',
    'teste@example.com',
    '$2a$10$EzSeuHashAqui123456789012345678901234567890123456789012',
    '12345678900',
    'USER',
    now(),
    now()
);


INSERT INTO metodo_pagamento (
    id, usuario_id, bandeira, ultimos4, mes_exp, ano_exp, nome_portador, token_gateway
)
SELECT
    uuid_generate_v4(),
    id,
    'VISA',
    '4242',
    9,
    2030,
    'Usuário Teste',
    'tok_fake_123456789'
FROM usuarios
WHERE email = 'teste@example.com';

INSERT INTO metodos_pagamento (tipo, detalhes) VALUES
('PIX', 'Pagamento via chave pix'),
('CARTAO_CREDITO', 'Cartão de crédito internacional'),
('CARTAO_DEBITO', 'Cartão de débito'),
('BOLETO', 'Pagamento via boleto bancário');

INSERT INTO favoritos (usuario_id, conteudo_id, criado_em)
SELECT
    u.id,
    c.id,
    now()
FROM usuarios u
CROSS JOIN conteudo c
LIMIT 1;