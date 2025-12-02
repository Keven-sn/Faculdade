IF DB_ID('bd_farmacia') IS NULL
BEGIN
    CREATE DATABASE bd_farmacia 
    ON (
        NAME = farmacia_dat, 
        FILENAME = 'C:\SQLSV\farmacia_bd.mdf', 
        SIZE = 10MB, 
        MAXSIZE = 500MB, 
        FILEGROWTH = 5MB
    ) 
    LOG ON (
        NAME = farmacia_log, 
        FILENAME = 'C:\SQLSV\farmacia_bd.ldf', 
        SIZE = 10MB, 
        MAXSIZE = 1000MB, 
        FILEGROWTH = 10MB
    );
END
GO

USE bd_farmacia;
GO

IF OBJECT_ID('trg_AfterInsert_TblVendas_Auditoria','TR') IS NOT NULL DROP TRIGGER trg_AfterInsert_TblVendas_Auditoria;
IF OBJECT_ID('trg_VerificaEstoque_AposVenda','TR') IS NOT NULL DROP TRIGGER trg_VerificaEstoque_AposVenda;
IF OBJECT_ID('trg_AfterUpdate_TblEstoque_Auditoria','TR') IS NOT NULL DROP TRIGGER trg_AfterUpdate_TblEstoque_Auditoria;
IF OBJECT_ID('trg_ValidaReceitaObrigatoria','TR') IS NOT NULL DROP TRIGGER trg_ValidaReceitaObrigatoria;
GO

IF OBJECT_ID('sp_BuscarClientePorCPF','P') IS NOT NULL DROP PROCEDURE sp_BuscarClientePorCPF;
IF OBJECT_ID('sp_InserirVenda','P') IS NOT NULL DROP PROCEDURE sp_InserirVenda;
GO

IF OBJECT_ID('vw_VendasDetalhadas','V') IS NOT NULL DROP VIEW vw_VendasDetalhadas;
IF OBJECT_ID('vw_EstoqueBaixo','V') IS NOT NULL DROP VIEW vw_EstoqueBaixo;
IF OBJECT_ID('vw_ProdutosFornecedores','V') IS NOT NULL DROP VIEW vw_ProdutosFornecedores;
IF OBJECT_ID('vw_VendasPorCliente','V') IS NOT NULL DROP VIEW vw_VendasPorCliente;
IF OBJECT_ID('vw_ProdutosComEstoque','V') IS NOT NULL DROP VIEW vw_ProdutosComEstoque;
IF OBJECT_ID('vw_PedidosClientes','V') IS NOT NULL DROP VIEW vw_PedidosClientes;
IF OBJECT_ID('vw_Receitas','V') IS NOT NULL DROP VIEW vw_Receitas;
GO

IF OBJECT_ID('TblAuditoria','U') IS NOT NULL DROP TABLE TblAuditoria;
IF OBJECT_ID('TblVendas','U') IS NOT NULL DROP TABLE TblVendas;
IF OBJECT_ID('TblPedidos','U') IS NOT NULL DROP TABLE TblPedidos;
IF OBJECT_ID('TblFuncionarios','U') IS NOT NULL DROP TABLE TblFuncionarios;
IF OBJECT_ID('TblReceitaMedica','U') IS NOT NULL DROP TABLE TblReceitaMedica;
IF OBJECT_ID('TblClientes','U') IS NOT NULL DROP TABLE TblClientes;
IF OBJECT_ID('TblEstoque','U') IS NOT NULL DROP TABLE TblEstoque;
IF OBJECT_ID('TblFornecedor_Produto','U') IS NOT NULL DROP TABLE TblFornecedor_Produto;
IF OBJECT_ID('TblProdutos','U') IS NOT NULL DROP TABLE TblProdutos;
IF OBJECT_ID('TblFornecedores','U') IS NOT NULL DROP TABLE TblFornecedores;
IF OBJECT_ID('TblFormaPagamento','U') IS NOT NULL DROP TABLE TblFormaPagamento;
IF OBJECT_ID('TblDescontos','U') IS NOT NULL DROP TABLE TblDescontos;
IF OBJECT_ID('TblParcelamento','U') IS NOT NULL DROP TABLE TblParcelamento;
IF OBJECT_ID('TblTipoProdutos','U') IS NOT NULL DROP TABLE TblTipoProdutos;
IF OBJECT_ID('TblCargo','U') IS NOT NULL DROP TABLE TblCargo;
GO

CREATE TABLE TblCargo (
    cod_cargo SMALLINT IDENTITY(1,1) PRIMARY KEY,
    salario SMALLMONEY NOT NULL CHECK (salario >= 0),
    funcao VARCHAR(50) NOT NULL
);
GO

CREATE TABLE TblTipoProdutos (
    cod_tipo SMALLINT IDENTITY(1,1) PRIMARY KEY,
    descricao VARCHAR(60) NOT NULL
);
GO

CREATE TABLE TblParcelamento (
    cod_parcelamento SMALLINT IDENTITY(1,1) PRIMARY KEY,
    valor DECIMAL(10,2) NOT NULL CHECK (valor >= 0),
    parcelas TINYINT NOT NULL CHECK (parcelas BETWEEN 1 AND 36)
);
GO

CREATE TABLE TblDescontos (
    cod_desconto SMALLINT IDENTITY(1,1) PRIMARY KEY,
    valor DECIMAL(5,2) NOT NULL CHECK (valor >= 0 AND valor <= 100),
    descricao VARCHAR(80) NOT NULL
);
GO

CREATE TABLE TblFormaPagamento (
    cod_formapagamento SMALLINT IDENTITY(1,1) PRIMARY KEY,
    descricao VARCHAR(60) NOT NULL,
    cod_parcelamento SMALLINT NULL,
    cod_desconto SMALLINT NULL,
    CONSTRAINT FK_FormaPagamento_Parcelamento FOREIGN KEY (cod_parcelamento) REFERENCES TblParcelamento(cod_parcelamento),
    CONSTRAINT FK_FormaPagamento_Desconto FOREIGN KEY (cod_desconto) REFERENCES TblDescontos(cod_desconto)
);
GO

CREATE TABLE TblFornecedores (
    cod_fornecedores INT IDENTITY(1,1) PRIMARY KEY,
    nomeFicticio VARCHAR(100) NOT NULL,
    cnpj CHAR(14) NOT NULL UNIQUE,
    telefone VARCHAR(18) NULL
);
GO

CREATE TABLE TblProdutos (
    cod_produto INT IDENTITY(1,1) PRIMARY KEY,
    cod_tipo SMALLINT NOT NULL,
    nome_produto VARCHAR(120) NOT NULL,
    descricao VARCHAR(255) NULL,
    quantidade INT NOT NULL CHECK (quantidade >= 0),
    preco MONEY NULL CHECK (preco >= 0),
    exige_receita BIT NOT NULL CONSTRAINT DF_TblProdutos_ExigeReceita DEFAULT(0),
    CONSTRAINT FK_Produtos_Tipo FOREIGN KEY (cod_tipo) REFERENCES TblTipoProdutos(cod_tipo)
);
GO

CREATE TABLE TblFornecedor_Produto (
    cod_fornecedor_produto INT IDENTITY(1,1) PRIMARY KEY,
    cod_fornecedores INT NOT NULL,
    cod_produto INT NOT NULL,
    preco_fornecedor MONEY NULL CHECK (preco_fornecedor >= 0),
    prazo_entrega_dias TINYINT NULL,
    CONSTRAINT FK_FP_Fornecedor FOREIGN KEY (cod_fornecedores) REFERENCES TblFornecedores(cod_fornecedores),
    CONSTRAINT FK_FP_Produto FOREIGN KEY (cod_produto) REFERENCES TblProdutos(cod_produto)
);
GO

CREATE TABLE TblEstoque (
    cod_estoque INT IDENTITY(1,1) PRIMARY KEY,
    cod_produto INT NOT NULL,
    quantidade_disponivel INT NOT NULL CHECK (quantidade_disponivel >= 0),
    localizacao VARCHAR(60) NULL,
    data_ultima_atualizacao DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Estoque_Produto FOREIGN KEY (cod_produto) REFERENCES TblProdutos(cod_produto)
);
GO

CREATE TABLE TblClientes (
    cod_cliente INT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(120) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    email VARCHAR(80) NULL,
    telefone VARCHAR(18) NULL,
    data_nascimento DATE NULL
);
GO

CREATE TABLE TblReceitaMedica (
    cod_receita SMALLINT IDENTITY(1,1) PRIMARY KEY,
    medico VARCHAR(80) NOT NULL,
    crm VARCHAR(20) NOT NULL,
    emissao DATETIME NOT NULL,
    observacoes VARCHAR(255) NULL
);
GO

CREATE TABLE TblFuncionarios (
    cod_funcionarios SMALLINT IDENTITY(1,1) PRIMARY KEY,
    cod_cargo SMALLINT NOT NULL,
    nome VARCHAR(120) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    endereco VARCHAR(255) NULL,
    telefone VARCHAR(18) NULL,
    data_admissao DATE NULL,
    CONSTRAINT FK_Funcionarios_Cargo FOREIGN KEY (cod_cargo) REFERENCES TblCargo(cod_cargo)
);
GO

CREATE TABLE TblPedidos (
    cod_pedido INT IDENTITY(1,1) PRIMARY KEY,
    cod_produto INT NOT NULL,
    cod_cliente INT NOT NULL,
    quantidade SMALLINT NOT NULL CHECK (quantidade > 0),
    data_pedido DATETIME NOT NULL DEFAULT GETDATE(),
    status VARCHAR(20) NOT NULL DEFAULT 'PENDENTE',
    CONSTRAINT FK_Pedidos_Produto FOREIGN KEY (cod_produto) REFERENCES TblProdutos(cod_produto),
    CONSTRAINT FK_Pedidos_Cliente FOREIGN KEY (cod_cliente) REFERENCES TblClientes(cod_cliente)
);
GO

CREATE TABLE TblVendas (
    cod_venda INT IDENTITY(1,1) PRIMARY KEY,
    cod_pedido INT NOT NULL,
    cod_receita SMALLINT NULL,
    data_hora DATETIME NOT NULL DEFAULT GETDATE(),
    cod_formapagamento SMALLINT NOT NULL,
    valor_total MONEY NOT NULL CHECK (valor_total >= 0),
    cod_funcionario SMALLINT NULL,
    CONSTRAINT FK_Vendas_Pedido FOREIGN KEY (cod_pedido) REFERENCES TblPedidos(cod_pedido),
    CONSTRAINT FK_Vendas_Receita FOREIGN KEY (cod_receita) REFERENCES TblReceitaMedica(cod_receita) ON DELETE SET NULL,
    CONSTRAINT FK_Vendas_FormaPag FOREIGN KEY (cod_formapagamento) REFERENCES TblFormaPagamento(cod_formapagamento),
    CONSTRAINT FK_Vendas_Funcionario FOREIGN KEY (cod_funcionario) REFERENCES TblFuncionarios(cod_funcionarios)
);
GO

CREATE TABLE TblAuditoria (
    cod_auditoria INT IDENTITY(1,1) PRIMARY KEY,
    tabela_afetada VARCHAR(80) NOT NULL,
    operacao VARCHAR(20) NOT NULL, 
    registro_id VARCHAR(100) NULL,
    usuario VARCHAR(80) NULL,
    data_hora DATETIME NOT NULL DEFAULT GETDATE(),
    detalhes VARCHAR(400) NULL
);
GO

INSERT INTO TblCargo (salario, funcao) VALUES
(1500.00,'Caixa'),
(2000.00,'Atendente'),
(3500.00,'Farmac�utico'),
(1800.00,'Estoquista'),
(2200.00,'Supervisor'),
(1200.00,'Servi�o Geral'),
(4500.00,'Gerente'),
(1600.00,'Balconista'),
(2100.00,'Entregador'),
(2800.00,'Assistente T�cnico');
GO

INSERT INTO TblTipoProdutos (descricao) VALUES
('Medicamento Gen�rico'),
('Medicamento Tarja Vermelha'),
('Medicamento Tarja Preta'),
('Suplemento'),
('Cosm�tico'),
('Higiene Pessoal'),
('Vitam�nicos'),
('Produtos de Beb�'),
('Material de Curativo'),
('Alimentos Especiais');
GO

INSERT INTO TblParcelamento (valor, parcelas) VALUES
(0.00,1),(100.00,2),(200.00,3),(300.00,6),(500.00,10),
(1000.00,12),(50.00,1),(150.00,2),(250.00,4),(400.00,8);
GO

INSERT INTO TblDescontos (valor, descricao) VALUES
(5.00,'Desconto fidelidade 5%'),
(10.00,'Promo��o mensal 10%'),
(15.00,'Desconto idoso 15%'),
(20.00,'Queima de estoque 20%'),
(2.50,'Microdesconto'),
(7.50,'Campanha sazonal 7.5%'),
(12.00,'Cart�o parceiro 12%'),
(3.00,'Cupom 3%'),
(25.00,'Desconto especial 25%'),
(30.00,'Grande promo��o 30%');
GO

INSERT INTO TblFormaPagamento (descricao, cod_parcelamento, cod_desconto) VALUES
('Dinheiro', NULL, NULL),
('Cart�o D�bito', NULL, NULL),
('Cart�o Cr�dito - 1x', 1, NULL),
('Cart�o Cr�dito - 3x', 3, NULL),
('Cart�o Cr�dito - 6x', 4, NULL),
('Parcelado Loja', 6, NULL),
('PIX', NULL, 1),
('Vale Sa�de', NULL, 2),
('Cart�o Parceiro', NULL, 7),
('Boleto', NULL, NULL);
GO

INSERT INTO TblFornecedores (nomeFicticio, cnpj, telefone) VALUES
('FarmacoDistribuidora','12345678000101','(11)9999-0001'),
('MedSupplies Ltda','23456789000102','(11)9999-0002'),
('SaudeAtiva','34567890000103','(11)9999-0003'),
('DistribuiFarma','45678901234567','(11)9999-0004'),
('HigieneBrasil','56789012000105','(11)9999-0005'),
('VitaSuplementos','67890123000106','(11)9999-0006'),
('BebeCare','78901234000107','(11)9999-0007'),
('CurativosPro','89012345000108','(11)9999-0008'),
('CosmeticosBR','90123456000109','(11)9999-0009'),
('AlimentosEspeciais','01234567000110','(11)9999-0010');
GO

INSERT INTO TblProdutos (cod_tipo, nome_produto, descricao, quantidade, preco, exige_receita) VALUES
(1,'Paracetamol 500mg','Analg�sico e antipir�tico',100,5.50,0),
(2,'Amoxicilina 500mg','Antibi�tico',50,12.00,0),
(3,'Rivotril 2mg','Ansiol�tico tarja preta',20,18.00,1),
(4,'Vitamina C 500mg','Suplemento',200,8.00,0),
(5,'Shampoo Anticaspa 200ml','Higiene',80,15.00,0),
(6,'Sabonete Neutro','Higiene',150,3.50,0),
(7,'�leo de F�gado de Bacalhau','Vitam�nico',30,25.00,0),
(8,'Fralda tamanho M','Produtos de Beb�',120,45.00,0),
(9,'Gaze 10x10cm','Curativo',300,0.80,0),
(10,'Leite em P� 400g','Alimento especial',40,22.50,0);
GO

INSERT INTO TblFornecedor_Produto (cod_fornecedores, cod_produto, preco_fornecedor, prazo_entrega_dias) VALUES
(1,1,4.00,2),(1,2,9.00,3),(2,3,16.00,5),(3,4,10.00,4),(4,5,2.50,2),
(5,6,1.50,3),(6,7,20.00,7),(7,8,30.00,5),(8,9,0.60,2),(9,10,18.00,6);
GO

INSERT INTO TblEstoque (cod_produto, quantidade_disponivel, localizacao) VALUES
(1,100,'Prateleira A1'),(2,50,'Prateleira A2'),
(3,20,'Prateleira B1'),(4,200,'Prateleira B2'),
(5,80,'Prateleira C1'),(6,150,'Prateleira C2'),
(7,30,'Prateleira D1'),(8,120,'Prateleira D2'),
(9,300,'Estoquebaixo'),(10,40,'Geladeira');
GO

INSERT INTO TblClientes (nome, cpf, email, telefone, data_nascimento) VALUES
('Ana Silva','11122233344','ana.silva@example.com','(11)99999-0001','1985-03-10'),
('Bruno Costa','22233344455','bruno.costa@example.com','(11)99999-0002','1990-07-25'),
('Carla Souza','33344455566','carla.souza@example.com','(11)99999-0003','1978-01-03'),
('Daniel Rocha','44455566677','daniel.rocha@example.com','(11)99999-0004','2000-12-12'),
('Elisa Martins','55566677788','elisa.martins@example.com','(11)99999-0005','1995-05-15'),
('Fabio Lima','66677788899','fabio.lima@example.com','(11)99999-0006','1988-09-09'),
('Gabriela Alves','77788899900','gabriela.alves@example.com','(11)99999-0007','1992-11-11'),
('Hugo Pereira','88899900011','hugo.pereira@example.com','(11)99999-0008','1975-02-20'),
('Iara Mendes','99900011122','iara.mendes@example.com','(11)99999-0009','1982-06-30'),
('Joao Neto','00011122233','joao.neto@example.com','(11)99999-0010','1965-08-08');
GO

SET IDENTITY_INSERT TblReceitaMedica ON;
INSERT INTO TblReceitaMedica (cod_receita, medico, crm, emissao, observacoes) VALUES
(1,'Dr. Paulo','CRM12345','20250110 10:00:00','Uso cont�nuo'),
(2,'Dra. Maria','CRM23456','20250212 11:30:00','Controle mensal'),
(3,'Dr. Carlos','CRM34567','20250305 09:15:00','Anotar alergia'),
(4,'Dra. Luiza','CRM45678','20250422 14:00:00',NULL),
(5,'Dr. Rodrigo','CRM56789','20250511 16:30:00','Dose �nica'),
(6,'Dra. Helena','CRM67890','20250601 08:00:00',NULL),
(7,'Dr. Felipe','CRM78901','20250709 12:00:00','Renovar em 30 dias'),
(8,'Dra. Aline','CRM89012','20250819 15:00:00',NULL),
(9,'Dr. Ricardo','CRM90123','20250923 13:00:00',NULL),
(10,'Dra. Teresa','CRM01234','20251030 10:30:00','Aten��o hipersensibilidade');
SET IDENTITY_INSERT TblReceitaMedica OFF;
GO

INSERT INTO TblFuncionarios (cod_cargo, nome, cpf, endereco, telefone, data_admissao) VALUES
(1,'Marcos Silva','12121212121','Rua A, 10','(11)98888-0001','2020-01-15'),
(2,'Paula Souza','13131313131','Rua B, 20','(11)98888-0002','2021-03-22'),
(3,'Fernando Lima','14141414141','Rua C, 30','(11)98888-0003','2019-07-01'),
(4,'Renata Alves','15151515151','Rua D, 40','(11)98888-0004','2022-02-10'),
(5,'Lucas Pereira','16161616161','Rua E, 50','(11)98888-0005','2018-11-11'),
(6,'Bruna Rocha','17171717171','Rua F, 60','(11)98888-0006','2024-01-05'),
(7,'Carlos Mendes','18181818181','Rua G, 70','(11)98888-0007','2017-06-18'),
(8,'Sofia Torres','19191919191','Rua H, 80','(11)98888-0008','2023-04-25'),
(9,'Eduardo Ramos','20202020202','Rua I, 90','(11)98888-0009','2016-09-09'),
(10,'Patricia Gomes','21212121212','Rua J, 100','(11)98888-0010','2015-12-01');
GO

INSERT INTO TblPedidos (cod_produto, cod_cliente, quantidade, data_pedido, status) VALUES
(1,1,2,'2025-11-01 09:00','CONCLUIDO'),
(2,2,1,'2025-11-02 10:15','PENDENTE'),
(3,3,5,'2025-11-03 11:20','CONCLUIDO'),
(4,4,3,'2025-11-04 12:30','CONCLUIDO'),
(5,5,2,'2025-11-05 13:40','PENDENTE'),
(6,6,1,'2025-11-06 14:50','CONCLUIDO'),
(7,7,10,'2025-11-07 15:55','CONCLUIDO'),
(8,8,4,'2025-11-08 16:10','PENDENTE'),
(9,9,2,'2025-11-09 17:00','CONCLUIDO'),
(10,10,1,'2025-11-10 18:20','CONCLUIDO');
GO

INSERT INTO TblVendas (cod_pedido, cod_receita, data_hora, cod_formapagamento, valor_total, cod_funcionario) VALUES
(1,1,'2025-11-01 09:10:00',1,11.00,1),
(2,2,'2025-11-02 10:30:00',2,12.00,2),     
(3,2,'2025-11-03 11:40:00',3,40.00,3),
(4,NULL,'2025-11-04 12:45:00',4,45.00,4),
(5,3,'2025-11-05 13:55:00',5,7.00,5),
(6,NULL,'2025-11-06 15:00:00',6,25.00,6),
(7,4,'2025-11-07 16:05:00',7,450.00,7),
(8,NULL,'2025-11-08 16:20:00',8,3.20,8),
(9,5,'2025-11-09 17:10:00',9,36.00,9),
(10,NULL,'2025-11-10 18:30:00',10,22.50,10);
GO


INSERT INTO TblAuditoria (tabela_afetada, operacao, registro_id, usuario, detalhes) VALUES
('TblProdutos','INSERT','1','system','Carga inicial de produtos'),
('TblClientes','INSERT','1','system','Carga inicial de clientes'),
('TblFuncionarios','INSERT','1','system','Carga inicial de funcionarios'),
('TblEstoque','UPDATE','1','system','Ajuste inicial de estoque'),
('TblVendas','INSERT','1','system','Venda inicial registrada'),
('TblPedidos','INSERT','1','system','Pedido inicial registrado'),
('TblFornecedores','INSERT','1','system','Carga inicial fornecedores'),
('TblFormaPagamento','INSERT','1','system','Formas pagamento carregadas'),
('TblReceitaMedica','INSERT','1','system','Receita inicial carregada'),
('TblAuditoria','INSERT','1','system','Registro de auditoria inicial');
GO

CREATE VIEW vw_VendasDetalhadas AS
SELECT v.cod_venda, v.data_hora, c.nome AS cliente, p.nome_produto, pe.quantidade, v.valor_total, 
       f.descricao AS forma_pagto, fn.nome AS vendedor
FROM TblVendas v
JOIN TblPedidos pe ON v.cod_pedido = pe.cod_pedido
JOIN TblClientes c ON pe.cod_cliente = c.cod_cliente
JOIN TblProdutos p ON pe.cod_produto = p.cod_produto
JOIN TblFormaPagamento f ON v.cod_formapagamento = f.cod_formapagamento
LEFT JOIN TblFuncionarios fn ON v.cod_funcionario = fn.cod_funcionarios;
GO

CREATE VIEW vw_EstoqueBaixo AS
SELECT p.cod_produto, p.nome_produto, e.quantidade_disponivel, e.localizacao
FROM TblProdutos p
JOIN TblEstoque e ON p.cod_produto = e.cod_produto
WHERE e.quantidade_disponivel < 50;
GO

CREATE VIEW vw_ProdutosFornecedores AS
SELECT p.cod_produto, p.nome_produto, f.cod_fornecedores, f.nomeFicticio, fp.preco_fornecedor, fp.prazo_entrega_dias
FROM TblProdutos p
JOIN TblFornecedor_Produto fp ON p.cod_produto = fp.cod_produto
JOIN TblFornecedores f ON fp.cod_fornecedores = f.cod_fornecedores;
GO

CREATE VIEW vw_VendasPorCliente AS
SELECT c.cod_cliente, c.nome, COUNT(v.cod_venda) AS qtd_vendas, SUM(v.valor_total) AS total_gasto
FROM TblClientes c
JOIN TblPedidos pe ON pe.cod_cliente = c.cod_cliente
JOIN TblVendas v ON v.cod_pedido = pe.cod_pedido
GROUP BY c.cod_cliente, c.nome;
GO

CREATE VIEW vw_ProdutosComEstoque AS
SELECT p.cod_produto, p.nome_produto, p.preco, e.quantidade_disponivel
FROM TblProdutos p
JOIN TblEstoque e ON p.cod_produto = e.cod_produto;
GO

CREATE VIEW vw_PedidosClientes AS
SELECT pe.cod_pedido, c.nome, c.email, pe.status
FROM TblPedidos pe
JOIN TblClientes c ON pe.cod_cliente = c.cod_cliente;
GO

CREATE VIEW vw_Receitas AS
SELECT cod_receita, medico, crm, emissao
FROM TblReceitaMedica;
GO

CREATE PROCEDURE sp_BuscarClientePorCPF
    @cpf CHAR(11)
AS
BEGIN
    SET NOCOUNT ON;
    SELECT cod_cliente, nome, cpf, email, telefone, data_nascimento
    FROM TblClientes
    WHERE cpf = @cpf;
END;
GO

CREATE PROCEDURE sp_InserirVenda
    @cod_pedido INT,
    @cod_formapagamento SMALLINT,
    @cod_funcionario SMALLINT = NULL,
    @cod_receita SMALLINT = NULL,
    @cod_venda_saida INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        DECLARE @valor_total MONEY;
        DECLARE @cod_produto INT, @qtd SMALLINT, @qtd_estoque INT, @produto_exige BIT;
        SELECT @cod_produto = pe.cod_produto, @qtd = pe.quantidade
        FROM TblPedidos pe
        WHERE pe.cod_pedido = @cod_pedido;
        IF @cod_produto IS NULL
        BEGIN
            RAISERROR('Pedido n�o encontrado.',16,1);
            ROLLBACK TRANSACTION;
            RETURN;
        END
        SELECT @valor_total = @qtd * p.preco, @produto_exige = p.exige_receita
        FROM TblProdutos p
        WHERE p.cod_produto = @cod_produto;
        IF @valor_total IS NULL
        BEGIN
            RAISERROR('Produto sem pre�o definido.',16,1);
            ROLLBACK TRANSACTION;
            RETURN;
        END
        SELECT @qtd_estoque = quantidade_disponivel FROM TblEstoque WHERE cod_produto = @cod_produto;
        IF @qtd_estoque IS NULL OR @qtd_estoque < @qtd
        BEGIN
            RAISERROR('Estoque insuficiente para realizar a venda.',16,1);
            ROLLBACK TRANSACTION;
            RETURN;
        END
        IF @produto_exige = 1
        BEGIN
            IF @cod_receita IS NULL
            BEGIN
                RAISERROR('Venda inv�lida: produto exige receita m�dica.',16,1);
                ROLLBACK TRANSACTION;
                RETURN;
            END
            IF NOT EXISTS (SELECT 1 FROM TblReceitaMedica r WHERE r.cod_receita = @cod_receita)
            BEGIN
                RAISERROR('Venda inv�lida: receita informada n�o existe.',16,1);
                ROLLBACK TRANSACTION;
                RETURN;
            END
        END
        ELSE
        BEGIN
            SET @cod_receita = NULL;
        END
        INSERT INTO TblVendas (cod_pedido, cod_receita, data_hora, cod_formapagamento, valor_total, cod_funcionario)
        VALUES (@cod_pedido, @cod_receita, GETDATE(), @cod_formapagamento, @valor_total, @cod_funcionario);
        SET @cod_venda_saida = SCOPE_IDENTITY();
        UPDATE TblEstoque
        SET quantidade_disponivel = quantidade_disponivel - @qtd,
            data_ultima_atualizacao = GETDATE()
        WHERE cod_produto = @cod_produto;
        UPDATE TblPedidos SET status = 'CONCLUIDO' WHERE cod_pedido = @cod_pedido;
        INSERT INTO TblAuditoria (tabela_afetada, operacao, registro_id, usuario, detalhes)
        VALUES ('TblVendas','INSERT', CONVERT(VARCHAR(50), @cod_venda_saida), SUSER_SNAME(), 'Venda inserida via sp_InserirVenda');
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;
        DECLARE @ErrMsg NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR('Erro em sp_InserirVenda: %s',16,1,@ErrMsg);
        RETURN;
    END CATCH
END;
GO

CREATE TRIGGER trg_AfterInsert_TblVendas_Auditoria
ON TblVendas
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO TblAuditoria (tabela_afetada, operacao, registro_id, usuario, detalhes)
    SELECT 'TblVendas','INSERT', CONVERT(VARCHAR(50), i.cod_venda), SUSER_SNAME(), 'Venda inserida (trigger auditoria)'
    FROM inserted i;
END;
GO

CREATE TRIGGER trg_VerificaEstoque_AposVenda
ON TblVendas
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN TblPedidos pe ON i.cod_pedido = pe.cod_pedido
        JOIN TblEstoque e ON pe.cod_produto = e.cod_produto
        WHERE e.quantidade_disponivel < pe.quantidade
    )
    BEGIN
        INSERT INTO TblAuditoria (tabela_afetada, operacao, registro_id, usuario, detalhes)
        SELECT 'TblVendas','ESTOQUE_INSUFICIENTE', CONVERT(VARCHAR(50), i.cod_venda), SUSER_SNAME(),
               'Estoque insuficiente detectado ap�s inser��o. Verificar manualmente.'
        FROM inserted i
        WHERE EXISTS (
            SELECT 1
            FROM TblPedidos pe
            JOIN TblEstoque e ON pe.cod_produto = e.cod_produto
            WHERE pe.cod_pedido = i.cod_pedido AND e.quantidade_disponivel < pe.quantidade
        );
        RAISERROR('Aviso: Alguns itens podem ter estoque insuficiente. Verifique TblAuditoria.',10,1);
    END
END;
GO

CREATE TRIGGER trg_ValidaReceitaObrigatoria
ON TblVendas
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN TblPedidos p ON p.cod_pedido = i.cod_pedido
        JOIN TblProdutos pr ON pr.cod_produto = p.cod_produto
        WHERE pr.exige_receita = 1
          AND (i.cod_receita IS NULL OR NOT EXISTS (SELECT 1 FROM TblReceitaMedica r WHERE r.cod_receita = i.cod_receita))
    )
    BEGIN
        ROLLBACK TRANSACTION;
        RAISERROR('Erro: Venda exige receita v�lida. Opera��o cancelada.',16,1);
        RETURN;
    END
    ;WITH VendasParaCorrigir AS (
        SELECT i.cod_venda
        FROM inserted i
        JOIN TblPedidos p ON p.cod_pedido = i.cod_pedido
        JOIN TblProdutos pr ON pr.cod_produto = p.cod_produto
        WHERE pr.exige_receita = 0 AND i.cod_receita IS NOT NULL
    )
    UPDATE v
    SET cod_receita = NULL
    FROM TblVendas v
    JOIN VendasParaCorrigir c ON v.cod_venda = c.cod_venda;
END;
GO

CREATE TRIGGER trg_AfterUpdate_TblEstoque_Auditoria
ON TblEstoque
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO TblAuditoria (tabela_afetada, operacao, registro_id, usuario, detalhes)
    SELECT 
        'TblEstoque',
        'UPDATE',
        CONVERT(VARCHAR(50), i.cod_estoque),
        SUSER_SNAME(),
        'Quantidade anterior: ' + CONVERT(VARCHAR(20), d.quantidade_disponivel) +
        ' -> nova: ' + CONVERT(VARCHAR(20), i.quantidade_disponivel)
    FROM inserted i
    JOIN deleted d ON i.cod_estoque = d.cod_estoque;
END;
GO

UPDATE TblProdutos SET exige_receita = 1 WHERE cod_tipo IN (
    SELECT cod_tipo FROM TblTipoProdutos WHERE descricao IN ('Medicamento Tarja Vermelha','Medicamento Tarja Preta')
);
GO

SELECT v.cod_venda, v.cod_pedido, pe.cod_produto, p.nome_produto, p.exige_receita, v.cod_receita
FROM TblVendas v
JOIN TblPedidos pe ON v.cod_pedido = pe.cod_pedido
JOIN TblProdutos p ON pe.cod_produto = p.cod_produto
WHERE p.exige_receita = 1 AND (v.cod_receita IS NULL OR NOT EXISTS (SELECT 1 FROM TblReceitaMedica r WHERE r.cod_receita = v.cod_receita));
GO