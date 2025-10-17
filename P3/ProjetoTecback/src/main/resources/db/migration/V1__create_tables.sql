-- ================================
-- TABELA: usuarios
-- ================================
CREATE TABLE usuarios (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    nome_completo VARCHAR(150) NOT NULL,
    data_nascimento DATE NOT NULL,
    email VARCHAR(254) NOT NULL UNIQUE,
    senha_hash VARCHAR(60) NOT NULL,
    cpf_cnpj VARCHAR(14) UNIQUE,
    perfil VARCHAR(20) NOT NULL,
    criado_em TIMESTAMP(3) NOT NULL,
    atualizado_em TIMESTAMP(3) NOT NULL,

    endereco_id UUID,
    CONSTRAINT fk_usuario_endereco
        FOREIGN KEY (endereco_id)
        REFERENCES enderecos(id)
);

CREATE TABLE enderecos (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    logradouro VARCHAR(150) NOT NULL,
    numero VARCHAR(20) NOT NULL,
    complemento VARCHAR(150),
    bairro VARCHAR(100) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    estado CHAR(2) NOT NULL,
    cep VARCHAR(9) NOT NULL
);

-- ================================
-- TABELA: conteudo
-- ================================
CREATE TABLE conteudo (
    id UUID PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    tipo VARCHAR(10) NOT NULL,
    ano SMALLINT NOT NULL CHECK (ano >= 1888 AND ano <= 2100),
    duracao_minutos SMALLINT NOT NULL CHECK (duracao_minutos >= 1 AND duracao_minutos <= 999),
    relevancia DECIMAL(4,2) NOT NULL,
    sinopse TEXT,
    trailer_url VARCHAR(500),
    genero VARCHAR(50),
    criado_em TIMESTAMP(3) NOT NULL,
    atualizado_em TIMESTAMP(3) NOT NULL
);

-- ================================
-- TABELA: planos
-- ================================
CREATE TABLE planos (
    id UUID PRIMARY KEY,
    codigo VARCHAR(20) UNIQUE NOT NULL,
    limite_diario SMALLINT NOT NULL CHECK (limite_diario >= 1),
    streams_simultaneos SMALLINT NOT NULL CHECK (streams_simultaneos >= 1)
);

-- ================================
-- TABELA: assinaturas
-- ================================
CREATE TABLE assinaturas (
    id UUID PRIMARY KEY,
    usuario_id UUID NOT NULL,
    plano_id UUID NOT NULL,
    status VARCHAR(20) NOT NULL,
    iniciada_em TIMESTAMP(3) NOT NULL,
    cancelada_em TIMESTAMP(3),

    CONSTRAINT fk_assinatura_usuario
        FOREIGN KEY (usuario_id)
        REFERENCES usuarios(id),

    CONSTRAINT fk_assinatura_plano
        FOREIGN KEY (plano_id)
        REFERENCES planos(id)
);

-- ================================
-- TABELA: metodo_pagamento
-- ================================
CREATE TABLE metodo_pagamento (
    id UUID PRIMARY KEY,
    usuario_id UUID NOT NULL,
    bandeira VARCHAR(20) NOT NULL,
    ultimos4 CHAR(4) NOT NULL,
    mes_exp SMALLINT NOT NULL CHECK (mes_exp BETWEEN 1 AND 12),
    ano_exp SMALLINT NOT NULL,
    nome_portador VARCHAR(150) NOT NULL,
    token_gateway VARCHAR(120) NOT NULL,
    criado_em TIMESTAMP(3) NOT NULL,

    CONSTRAINT fk_metodo_usuario
        FOREIGN KEY (usuario_id)
        REFERENCES usuarios(id)
        ON DELETE CASCADE
);

-- ================================
-- TABELA: favoritos (PK composta)
-- ================================
CREATE TABLE favoritos (
    usuario_id UUID NOT NULL,
    conteudo_id UUID NOT NULL,
    criado_em TIMESTAMP(3) NOT NULL,

    CONSTRAINT pk_favoritos PRIMARY KEY (usuario_id, conteudo_id),

    CONSTRAINT fk_favorito_usuario
        FOREIGN KEY (usuario_id)
        REFERENCES usuarios(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_favorito_conteudo
        FOREIGN KEY (conteudo_id)
        REFERENCES conteudo(id)
        ON DELETE CASCADE
);
