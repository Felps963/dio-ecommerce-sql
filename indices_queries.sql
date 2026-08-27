USE ecommerce_refinado;

-- Estrutura de apoio caso as tabelas de departamento não existam no esquema
CREATE TABLE IF NOT EXISTS departamento (
    id_departamento INT AUTO_INCREMENT PRIMARY KEY,
    nome_departamento VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS departamento_localizacao (
    id_departamento INT NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    PRIMARY KEY (id_departamento, cidade),
    FOREIGN KEY (id_departamento) REFERENCES departamento(id_departamento)
);

CREATE TABLE IF NOT EXISTS empregado (
    id_empregado INT AUTO_INCREMENT PRIMARY KEY,
    id_departamento INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    cargo VARCHAR(50),
    salario DECIMAL(10,2),
    FOREIGN KEY (id_departamento) REFERENCES departamento(id_departamento)
);


-- ============================================================================
-- CRIAÇÃO DOS ÍNDICES
-- ============================================================================

-- Índice 1: Otimização de junção e contagem de funcionários por departamento
-- Tipo: BTREE (Padrão) | Motivo: A chave estrangeira id_departamento é usada em JOINs e GROUP BY frequentes.
CREATE INDEX idx_empregado_departamento 
ON empregado(id_departamento) 
USING BTREE;

-- Índice 2: Otimização da busca e ordenação de departamentos por cidade
-- Tipo: BTREE | Motivo: Acelera filtros WHERE e ordenações ORDER BY pela coluna cidade na localização.
CREATE INDEX idx_localizacao_cidade 
ON departamento_localizacao(cidade) 
USING BTREE;

-- Índice 3: Otimização da ordenação de relatórios por nome do empregado
-- Tipo: BTREE | Motivo: Melhora a performance ao ordenar a listagem final de empregados.
CREATE INDEX idx_empregado_nome 
ON empregado(nome) 
USING BTREE;


-- ============================================================================
-- CONSULTAS SQL (QUERIES DE RESPOSTA)
-- ============================================================================

-- Pergunta 1: Qual o departamento com maior número de pessoas?
SELECT 
    d.id_departamento,
    d.nome_departamento,
    COUNT(e.id_empregado) AS total_empregados
FROM departamento d
INNER JOIN empregado e ON d.id_departamento = e.id_departamento
GROUP BY d.id_departamento, d.nome_departamento
ORDER BY total_empregados DESC
LIMIT 1;


-- Pergunta 2: Quais são os departamentos por cidade?
SELECT 
    dl.cidade,
    GROUP_CONCAT(d.nome_departamento SEPARATOR ', ') AS departamentos
FROM departamento_localizacao dl
INNER JOIN departamento d ON dl.id_departamento = d.id_departamento
GROUP BY dl.cidade
ORDER BY dl.cidade ASC;


-- Pergunta 3: Relação de empregados por departamento
SELECT 
    d.nome_departamento,
    e.nome AS nome_empregado,
    e.cargo
FROM departamento d
INNER JOIN empregado e ON d.id_departamento = e.id_departamento
ORDER BY d.nome_departamento ASC, e.nome ASC;