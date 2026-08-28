USE ecommerce_refinado;

CREATE TABLE IF NOT EXISTS cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    tipo_cliente ENUM('PF', 'PJ') NOT NULL,
    endereco VARCHAR(255) NOT NULL,
    contato VARCHAR(45) NOT NULL
);

-- ----------------------------------------------------------------------------
-- 1. TRIGGER DE REMOÇÃO (BEFORE DELETE): BACKUP DE USUÁRIOS EXCLUÍDOS
-- ----------------------------------------------------------------------------

-- Tabela de histórico/backup para persistência de dados de contas excluídas
CREATE TABLE IF NOT EXISTS cliente_removido_log (
    id_log INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    tipo_cliente VARCHAR(10),
    endereco VARCHAR(255),
    contato VARCHAR(45),
    data_exclusao DATETIME DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //

CREATE TRIGGER trg_before_delete_cliente
BEFORE DELETE ON cliente
FOR EACH ROW
BEGIN
    INSERT INTO cliente_removido_log (id_cliente, tipo_cliente, endereco, contato)
    VALUES (OLD.id_cliente, OLD.tipo_cliente, OLD.endereco, OLD.contato);
END //

DELIMITER ;


-- ----------------------------------------------------------------------------
-- 2. TRIGGER DE ATUALIZAÇÃO (BEFORE UPDATE): AUDITORIA E REGRA SALARIAL
-- ----------------------------------------------------------------------------

-- Tabela de auditoria para histórico de salários dos colaboradores
CREATE TABLE IF NOT EXISTS historico_salario_log (
    id_historico INT AUTO_INCREMENT PRIMARY KEY,
    id_empregado INT,
    salario_antigo DECIMAL(10,2),
    salario_novo DECIMAL(10,2),
    data_alteracao DATETIME DEFAULT CURRENT_TIMESTAMP,
    usuario_alteracao VARCHAR(50)
);

DELIMITER //

CREATE TRIGGER trg_before_update_salario
BEFORE UPDATE ON empregado
FOR EACH ROW
BEGIN
    -- Validação: impede a redução de salário base
    IF NEW.salario < OLD.salario THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Operação cancelada: O salário de um colaborador não pode ser reduzido.';
    END IF;

    -- Auditoria: registra alterações salariais no log de histórico
    IF OLD.salario <> NEW.salario THEN
        INSERT INTO historico_salario_log (id_empregado, salario_antigo, salario_novo, usuario_alteracao)
        VALUES (OLD.id_empregado, OLD.salario, NEW.salario, USER());
    END IF;
END //

DELIMITER ;