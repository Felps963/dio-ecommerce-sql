CREATE DATABASE IF NOT EXISTS ecommerce_refinado;
USE ecommerce_refinado;

-- Tabela de Produto (necessária para a procedure)
CREATE TABLE IF NOT EXISTS produto (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    valor_unitario DECIMAL(10,2) NOT NULL
);
DELIMITER //

CREATE PROCEDURE sp_manter_produto(
    IN p_opcao INT,                -- 1: SELECT, 2: INSERT, 3: UPDATE, 4: DELETE
    IN p_id_produto INT,
    IN p_nome VARCHAR(100),
    IN p_categoria VARCHAR(50),
    IN p_valor DECIMAL(10,2)
)
BEGIN
    CASE p_opcao
        -- Opção 1: Consulta (SELECT)
        WHEN 1 THEN
            IF p_id_produto IS NOT NULL THEN
                SELECT * FROM produto WHERE id_produto = p_id_produto;
            ELSE
                SELECT * FROM produto ORDER BY nome;
            END IF;

        -- Opção 2: Inserção (INSERT)
        WHEN 2 THEN
            IF p_nome IS NULL OR p_valor IS NULL THEN
                SIGNAL SQLSTATE '45000' 
                SET MESSAGE_TEXT = 'Erro: Nome e Valor são obrigatórios para inserção.';
            ELSE
                INSERT INTO produto (nome, categoria, valor_unitario)
                VALUES (p_nome, p_categoria, p_valor);
                SELECT LAST_INSERT_ID() AS id_produto_criado, 'Produto inserido com sucesso!' AS mensagem;
            END IF;

        -- Opção 3: Atualização (UPDATE)
        WHEN 3 THEN
            IF p_id_produto IS NULL THEN
                SIGNAL SQLSTATE '45000' 
                SET MESSAGE_TEXT = 'Erro: ID do produto é obrigatório para atualização.';
            ELSE
                UPDATE produto
                SET nome = COALESCE(p_nome, nome),
                    categoria = COALESCE(p_categoria, categoria),
                    valor_unitario = COALESCE(p_valor, valor_unitario)
                WHERE id_produto = p_id_produto;
                
                SELECT p_id_produto AS id_produto, 'Produto atualizado com sucesso!' AS mensagem;
            END IF;

        -- Opção 4: Remoção (DELETE)
        WHEN 4 THEN
            IF p_id_produto IS NULL THEN
                SIGNAL SQLSTATE '45000' 
                SET MESSAGE_TEXT = 'Erro: ID do produto é obrigatório para exclusão.';
            ELSE
                DELETE FROM produto WHERE id_produto = p_id_produto;
                SELECT p_id_produto AS id_produto_removido, 'Produto removido com sucesso!' AS mensagem;
            END IF;

        ELSE
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Opção inválida! Utilize: 1 (SELECT), 2 (INSERT), 3 (UPDATE), 4 (DELETE).';
    END CASE;
END //

DELIMITER ;

-- ============================================================================
-- EXEMPLOS DE EXECUÇÃO / TESTES DA PROCEDURE
-- ============================================================================

-- 1. Inserir um novo produto (Opção 2)
CALL sp_manter_produto(2, NULL, 'Headset Gamer 7.1', 'Perifericos', 350.00);

-- 2. Listar todos os produtos (Opção 1)
CALL sp_manter_produto(1, NULL, NULL, NULL, NULL);

-- 3. Atualizar o preço do produto de ID 1 (Opção 3)
CALL sp_manter_produto(3, 1, NULL, NULL, 89.90);

-- 4. Buscar apenas o produto de ID 1 (Opção 1)
CALL sp_manter_produto(1, 1, NULL, NULL, NULL);

-- 5. Excluir o produto recém-criado (Opção 4 - Exemplo assumindo ID 4)
CALL sp_manter_produto(4, 4, NULL, NULL, NULL);