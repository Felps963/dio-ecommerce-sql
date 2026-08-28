USE ecommerce_refinado;
-- ----------------------------------------------------------------------------
-- CRIAÇÃO DAS VIEWS
-- ----------------------------------------------------------------------------
-- View com informações completas e estratégicas (Exclusiva para Gerência)
CREATE OR REPLACE VIEW vw_gerencia_completa AS
SELECT 
    d.nome_departamento,
    e.id_empregado,
    e.nome AS empregado,
    e.cargo,
    e.salario,
    COALESCE(g.nome, 'Nenhum') AS gerente_direto
FROM departamento d
INNER JOIN empregado e ON d.id_departamento = e.id_departamento
LEFT JOIN empregado g ON d.id_gerente = g.id_empregado;

-- View restrita com dados públicos dos colaboradores (Acesso Geral)
CREATE OR REPLACE VIEW vw_empregado_resumo AS
SELECT 
    id_empregado,
    nome,
    cargo
FROM empregado;

-- ----------------------------------------------------------------------------
-- CRIAÇÃO DE USUÁRIOS E PERMISSÕES (DCL)
-- ----------------------------------------------------------------------------

-- Criar os perfis de usuário
CREATE USER IF NOT EXISTS 'user_gerente'@'localhost' IDENTIFIED BY 'SenhaGerente123!';
CREATE USER IF NOT EXISTS 'user_empregado'@'localhost' IDENTIFIED BY 'SenhaEmpregado123!';

-- Permissões para o usuário GERENTE
-- Acesso total às views de gestão e tabelas estruturais de departamento e funcionários
GRANT SELECT, INSERT, UPDATE, DELETE ON ecommerce_refinado.empregado TO 'user_gerente'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON ecommerce_refinado.departamento TO 'user_gerente'@'localhost';
GRANT SELECT ON ecommerce_refinado.vw_gerencia_completa TO 'user_gerente'@'localhost';

-- Permissões para o usuário EMPREGADO
-- Acesso restrito apenas à View pública de consulta sem informações salariais ou gerenciais
REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'user_empregado'@'localhost';
GRANT SELECT ON ecommerce_refinado.vw_empregado_resumo TO 'user_empregado'@'localhost';

-- Aplica as alterações de privilégios
FLUSH PRIVILEGES;