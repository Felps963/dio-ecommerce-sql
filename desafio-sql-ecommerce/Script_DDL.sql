CREATE DATABASE IF NOT EXISTS ecommerce_refinado;
USE ecommerce_refinado;

-- 1. Tabela Base de Clientes
CREATE TABLE cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    tipo_cliente ENUM('PF', 'PJ') NOT NULL,
    endereco VARCHAR(255) NOT NULL,
    contato VARCHAR(45) NOT NULL
);

-- 2. Especialização Cliente PF
CREATE TABLE cliente_pf (
    id_cliente_pf INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT UNIQUE NOT NULL,
    cpf VARCHAR(11) NOT NULL UNIQUE,
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente) ON DELETE CASCADE
);

-- 3. Especialização Cliente PJ
CREATE TABLE cliente_pj (
    id_cliente_pj INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT UNIQUE NOT NULL,
    cnpj VARCHAR(14) NOT NULL UNIQUE,
    razao_social VARCHAR(100) NOT NULL,
    nome_fantasia VARCHAR(100),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente) ON DELETE CASCADE
);

-- 4. Cartões/Formas de Pagamento do Cliente (1:N)
CREATE TABLE forma_pagamento (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    tipo_pagamento ENUM('Cartao Credito', 'Cartao Debito', 'PIX', 'Boleto') NOT NULL,
    num_cartao_token VARCHAR(255),
    validade DATE,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente) ON DELETE CASCADE
);

-- 5. Entrega
CREATE TABLE entrega (
    id_entrega INT AUTO_INCREMENT PRIMARY KEY,
    status_entrega ENUM('Pendente', 'Em Transito', 'Entregue', 'Cancelado') DEFAULT 'Pendente',
    codigo_rastreio VARCHAR(50) UNIQUE NOT NULL,
    valor_frete DECIMAL(10,2) NOT NULL DEFAULT 0.00
);

-- 6. Pedido
CREATE TABLE pedido (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_entrega INT UNIQUE,
    status_pedido ENUM('Em Andamento', 'Processando', 'Enviado', 'Entregue') DEFAULT 'Em Andamento',
    descricao VARCHAR(255),
    data_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_entrega) REFERENCES entrega(id_entrega)
);

-- 7. Produto
CREATE TABLE produto (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    valor_unitario DECIMAL(10,2) NOT NULL
);

-- 8. Item de Pedido
CREATE TABLE item_pedido (
    id_pedido INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL DEFAULT 1,
    valor_aplicado DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id_pedido, id_produto),
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
);

-- 9. Fornecedor
CREATE TABLE fornecedor (
    id_fornecedor INT AUTO_INCREMENT PRIMARY KEY,
    razao_social VARCHAR(100) NOT NULL,
    cnpj VARCHAR(14) NOT NULL UNIQUE,
    contato VARCHAR(45) NOT NULL
);

-- 10. Vendedor (Terceirizado/Marketplace)
CREATE TABLE vendedor (
    id_vendedor INT AUTO_INCREMENT PRIMARY KEY,
    razao_social VARCHAR(100) NOT NULL,
    cnpj VARCHAR(14) UNIQUE,
    cpf VARCHAR(11) UNIQUE,
    nome_fantasia VARCHAR(100),
    contato VARCHAR(45) NOT NULL
);

-- 11. Estoque
CREATE TABLE estoque (
    id_estoque INT AUTO_INCREMENT PRIMARY KEY,
    localizacao VARCHAR(100) NOT NULL
);

-- 12. Relacionamento Produto x Estoque
CREATE TABLE produto_estoque (
    id_produto INT NOT NULL,
    id_estoque INT NOT NULL,
    quantidade INT NOT NULL DEFAULT 0,
    PRIMARY KEY (id_produto, id_estoque),
    FOREIGN KEY (id_produto) REFERENCES produto(id_produto),
    FOREIGN KEY (id_estoque) REFERENCES estoque(id_estoque)
);

-- 13. Relacionamento Produto x Fornecedor
CREATE TABLE produto_fornecedor (
    id_produto INT NOT NULL,
    id_fornecedor INT NOT NULL,
    PRIMARY KEY (id_produto, id_fornecedor),
    FOREIGN KEY (id_produto) REFERENCES produto(id_produto),
    FOREIGN KEY (id_fornecedor) REFERENCES fornecedor(id_fornecedor)
);