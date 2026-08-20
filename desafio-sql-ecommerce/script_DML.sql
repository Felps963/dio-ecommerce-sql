INSERT INTO cliente (tipo_cliente, endereco, contato) VALUES
('PF', 'Rua das Flores, 123 - SP', '11999990001'),
('PJ', 'Av. Central, 500 - RJ', '21988880002'),
('PF', 'Praça da Sé, 10 - SP', '11977770003');

INSERT INTO cliente_pf (id_cliente, cpf, nome, data_nascimento) VALUES
(1, '12345678901', 'Ana Silva', '1990-05-15'),
(3, '98765432100', 'Carlos Eduardo', '1985-10-20');

INSERT INTO cliente_pj (id_cliente, cnpj, razao_social, nome_fantasia) VALUES
(2, '12345678000195', 'Tech Corp LTDA', 'TechCorp');

INSERT INTO forma_pagamento (id_cliente, tipo_pagamento, num_cartao_token) VALUES
(1, 'Cartao Credito', 'TOKEN_1234'),
(1, 'PIX', NULL),
(2, 'Boleto', NULL);

INSERT INTO entrega (status_entrega, codigo_rastreio, valor_frete) VALUES
('Em Transito', 'BR123456789', 25.00),
('Entregue', 'BR987654321', 15.00);

INSERT INTO pedido (id_cliente, id_entrega, status_pedido, descricao) VALUES
(1, 1, 'Processando', 'Compra de eletrônicos'),
(1, 2, 'Entregue', 'Compra de periféricos'),
(2, NULL, 'Em Andamento', 'Suprimentos de escritório');

INSERT INTO produto (nome, categoria, valor_unitario) VALUES
('Mouse Sem Fio', 'Perifericos', 80.00),
('Teclado Mecanico', 'Perifericos', 250.00),
('Monitor 27"', 'Monitores', 1200.00);

INSERT INTO item_pedido (id_pedido, id_produto, quantidade, valor_aplicado) VALUES
(1, 1, 2, 80.00),
(1, 3, 1, 1200.00),
(2, 2, 1, 250.00);

INSERT INTO fornecedor (razao_social, cnpj, contato) VALUES
('Logitech Brasil', '11111111000111', 'contato@logitech.com'),
('Dell Computadores', '12345678000195', 'vendas@dell.com');

INSERT INTO vendedor (razao_social, cnpj, cpf, nome_fantasia, contato) VALUES
('TechCorp Distribuidora', '12345678000195', NULL, 'TechCorp Market', 'vendas@techcorp.com'),
('Loja do Zé', NULL, '11122233344', 'Zé Tech', 'ze@email.com');

INSERT INTO estoque (localizacao) VALUES
('Depósito Central - SP'),
('Depósito Sul - RS');

INSERT INTO produto_estoque (id_produto, id_estoque, quantidade) VALUES
(1, 1, 100),
(2, 1, 50),
(3, 2, 15);

INSERT INTO produto_fornecedor (id_produto, id_fornecedor) VALUES
(1, 1),
(2, 1),
(3, 2);