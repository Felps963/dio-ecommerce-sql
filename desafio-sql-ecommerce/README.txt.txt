# Projeto Lógico de Banco de Dados: E-commerce Refinado

Este repositório contém o modelo e as consultas SQL para um sistema de E-commerce, atendendo aos requisitos do desafio da DIO.

## 📌 Funcionalidades Mapeadas
- **Clientes (PF e PJ):** Separação em tabelas de especialização exclusivas para CPF e CNPJ.
- **Formas de Pagamento:** Suporte a múltiplos cartões e métodos por cliente.
- **Entrega:** Controle de status e código de rastreio para cada pedido.
- **Terceiros:** Identificação de fornecedores e vendedores.

## 📁 Estrutura dos Arquivos
- `script_DDL.sql`: Script DDL com criação de tabelas, chaves primárias, estrangeiras e constraints.
- `script_DML.sql`: Script DML com dados fictícios para testes.
- `3_queries.sql`: Consultas SQL atendendo aos cenários propostos (Filtros, Agrupamentos, Atributos Derivados, Joins e HAVING).

## 🚀 Como Executar
1. Execute `script_DDL.sql` em seu SGBD (ex: MySQL Workbench / DBeaver).
2. Execute `script_DML.sql` para popular o banco.
3. Rode as consultas presentes no arquivo `3_queries.sql`.