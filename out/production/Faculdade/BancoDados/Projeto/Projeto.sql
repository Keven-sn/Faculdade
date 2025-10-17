CREATE DATABASE bd_farmacia 
ON (
    NAME = farmacia_dat, 
    FILENAME = 'C:\SQLSV\farmacia_bd.mdf', 
    SIZE = 5MB, 
    MAXSIZE = 20MB, 
    FILEGROWTH = 5MB
) 
LOG ON (
    NAME = farmacia_log, 
    FILENAME = 'C:\SQLSV\farmacia_bd.ldf', 
    SIZE = 10MB, 
    MAXSIZE = 50MB, 
    FILEGROWTH = 10MB
);
GO

USE bd_farmacia;
GO


CREATE TABLE TblCargo (
    cod_cargo SMALLINT PRIMARY KEY IDENTITY(1,1),
    salario SMALLMONEY NOT NULL,
    funcao VARCHAR(30) NOT NULL
);

CREATE TABLE TblTipoProdutos (
    cod_tipo SMALLINT PRIMARY KEY IDENTITY(1,1),
    descricao VARCHAR(40) NOT NULL
);

CREATE TABLE TblParcelamento (
    cod_parcelamento SMALLINT PRIMARY KEY IDENTITY(1,1),
    valor FLOAT NOT NULL CHECK (valor >= 0),
    parcelas FLOAT NOT NULL
);

CREATE TABLE TblDescontos (
    cod_desconto SMALLINT PRIMARY KEY IDENTITY(1,1),
    valor FLOAT NOT NULL,
    descricao VARCHAR(50) NOT NULL
);

CREATE TABLE TblFormaPagamento (
    cod_formapagamento SMALLINT PRIMARY KEY IDENTITY(1,1),
    cod_parcelamento SMALLINT NULL,
    cod_desconto SMALLINT NULL,
    FOREIGN KEY (cod_parcelamento) REFERENCES TblParcelamento(cod_parcelamento),
    FOREIGN KEY (cod_desconto) REFERENCES TblDescontos(cod_desconto)
);

CREATE TABLE TblFornecedores (
    cod_fornecedores INT PRIMARY KEY IDENTITY(1,1),
    nomeFicticio VARCHAR(30) NOT NULL,
    cnpj CHAR(14) NOT NULL UNIQUE,
    telefone VARCHAR(18) NOT NULL
);

CREATE TABLE TblProdutos (
    cod_produto INT PRIMARY KEY IDENTITY(1,1),
    cod_tipo SMALLINT NOT NULL,
    quantidade INT NOT NULL CHECK (quantidade >= 0),
    preco MONEY NULL,
    FOREIGN KEY (cod_tipo) REFERENCES TblTipoProdutos(cod_tipo)
);

CREATE TABLE TblClientes (
    cod_cliente INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(40) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    email VARCHAR(40) NOT NULL
);

CREATE TABLE TblPedidos (
    cod_pedido INT PRIMARY KEY IDENTITY(1,1),
    cod_produto INT NOT NULL,
    cod_cliente INT NOT NULL,
    quantidade SMALLINT NOT NULL CHECK (quantidade >= 0),
    FOREIGN KEY (cod_produto) REFERENCES TblProdutos(cod_produto),
    FOREIGN KEY (cod_cliente) REFERENCES TblClientes(cod_cliente)
);

CREATE TABLE TblReceitaMedica (
    cod_receita SMALLINT PRIMARY KEY IDENTITY(1,1),
    medico VARCHAR(40) NOT NULL,
    crm CHAR(6) NOT NULL,
    emissao SMALLDATETIME NOT NULL
);

CREATE TABLE TblFuncionarios (
    cod_funcionarios SMALLINT PRIMARY KEY IDENTITY(1,1),
    cod_cargo SMALLINT NOT NULL,
    nome VARCHAR(255) NOT NULL,
    cpf CHAR(11) NOT NULL,
    endereco VARCHAR(255) NOT NULL,
    FOREIGN KEY (cod_cargo) REFERENCES TblCargo(cod_cargo)
);

CREATE TABLE TblVendas (
    cod_venda INT PRIMARY KEY IDENTITY(1,1),
    cod_pedido INT NOT NULL,
    cod_receita SMALLINT NULL,
    data_hora SMALLDATETIME NOT NULL,
    cod_formapagamento SMALLINT NOT NULL,
    FOREIGN KEY (cod_pedido) REFERENCES TblPedidos(cod_pedido),
    FOREIGN KEY (cod_receita) REFERENCES TblReceitaMedica(cod_receita),
    FOREIGN KEY (cod_formapagamento) REFERENCES TblFormaPagamento(cod_formapagamento)
);
