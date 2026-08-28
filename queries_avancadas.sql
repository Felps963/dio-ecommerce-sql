USE ecommerce_refinado;

-- ----------------------------------------------------------------------------
-- ESTRUTURA COMPLEMENTAR DE APOIO
-- ----------------------------------------------------------------------------

-- Adiciona a coluna id_gerente de forma direta no MySQL
ALTER TABLE departamento ADD COLUMN id_gerente INT UNIQUE;

-- Tabela de Projetos
CREATE TABLE IF NOT EXISTS projeto (
    id_projeto INT AUTO_INCREMENT PRIMARY KEY,
    nome_projeto VARCHAR(100) NOT NULL,
    id_departamento INT NOT NULL,
    FOREIGN KEY (id_departamento) REFERENCES departamento(id_departamento)
);

-- Tabela N:M entre Projetos e Empregados
CREATE TABLE IF NOT EXISTS projeto_empregado (
    id_projeto INT NOT NULL,
    id_empregado INT NOT NULL,
    horas_trabalhadas DECIMAL(5,2) DEFAULT 0.00,
    PRIMARY KEY (id_projeto, id_empregado),
    FOREIGN KEY (id_projeto) REFERENCES projeto(id_projeto),
    FOREIGN KEY (id_empregado) REFERENCES empregado(id_empregado)
);

-- Tabela de Dependentes
CREATE TABLE IF NOT EXISTS dependente (
    id_dependente INT AUTO_INCREMENT PRIMARY KEY,
    id_empregado INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    parentesco VARCHAR(50) NOT NULL,
    data_nascimento DATE,
    FOREIGN KEY (id_empregado) REFERENCES empregado(id_empregado) ON DELETE CASCADE
);

-- Adiciona constraint de FK para o Gerente do Departamento
ALTER TABLE departamento 
ADD CONSTRAINT fk_departamento_gerente 
FOREIGN KEY (id_gerente) REFERENCES empregado(id_empregado);
-- ----------------------------------------------------------------------------
-- CONSULTAS ANALÍTICAS (QUERIES)
-- ------------------------------------------------------
-- 1. Número de empregados por departamento e localidade
SELECT 
    d.nome_departamento,
    dl.cidade,
    COUNT(e.id_empregado) AS total_empregados
FROM departamento d
INNER JOIN departamento_localizacao dl ON d.id_departamento = dl.id_departamento
LEFT JOIN empregado e ON d.id_departamento = e.id_departamento
GROUP BY d.id_departamento, d.nome_departamento, dl.cidade
ORDER BY total_empregados DESC;

-- 2. Lista de departamentos e seus gerentes
SELECT 
    d.id_departamento,
    d.nome_departamento,
    COALESCE(e.nome, 'Sem Gerente Atribuído') AS gerente_responsavel
FROM departamento d
LEFT JOIN empregado e ON d.id_gerente = e.id_empregado;

-- 3. Projetos com maior número de empregados (Ordenação Descendente)
SELECT 
    p.id_projeto,
    p.nome_projeto,
    COUNT(pe.id_empregado) AS quantidade_empregados
FROM projeto p
LEFT JOIN projeto_empregado pe ON p.id_projeto = pe.id_projeto
GROUP BY p.id_projeto, p.nome_projeto
ORDER BY quantidade_empregados DESC;

-- 4. Lista de projetos, departamentos e gerentes
SELECT 
    p.nome_projeto,
    d.nome_departamento,
    COALESCE(e.nome, 'Sem Gerente') AS gerente_responsavel
FROM projeto p
INNER JOIN departamento d ON p.id_departamento = d.id_departamento
LEFT JOIN empregado e ON d.id_gerente = e.id_empregado;

-- 5. Quais empregados possuem dependentes e se são gerentes
SELECT DISTINCT 
    e.id_empregado,
    e.nome AS nome_empregado,
    COUNT(dep.id_dependente) AS total_dependentes,
    CASE 
        WHEN d.id_gerente IS NOT NULL THEN 'Sim'
        ELSE 'Não'
    END AS eh_gerente
FROM empregado e
INNER JOIN dependente dep ON e.id_empregado = dep.id_empregado
LEFT JOIN departamento d ON e.id_empregado = d.id_gerente
GROUP BY e.id_empregado, e.nome, d.id_gerente;