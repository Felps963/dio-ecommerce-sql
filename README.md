# 🛒 E-Commerce SQL & Database Optimization Project

Este repositório contém o projeto de banco de dados relacional para um sistema de **E-Commerce**, cobrindo desde o esquema DDL/DML básico até otimizações avançadas com **Índices (Indexing)**, **Queries Analíticas (DQL)** e **Stored Procedures** para manipulação condicional de dados.

---

## 📌 Visão Geral da Arquitetura

O modelo foi projetado para suportar operações essenciais de e-commerce e gestão corporativa, incluindo:
- **Modelagem de Clientes (PF e PJ):** Especialização exclusiva para manipulação adequada de CPF e CNPJ.
- **Gestão de Pedidos e Entregas:** Rastreamento de pedidos, valores de frete e múltiplos status.
- **Formas de Pagamento:** Suporte a 1:N para múltiplos métodos por cliente.
- **Estrutura Organizacional:** Suporte a colaboradores, departamentos e localizações.

---

## 📁 Estrutura do Repositório

```text
├── 1_schema.sql             # Scripts DDL (Criação de Banco, Tabelas e Constraints)
├── 2_data.sql               # Scripts DML (Carga de dados iniciais para testes)
├── 3_queries.sql            # Queries analíticas (Filtros, Agrupamentos, HAVING, JOINS)
├── 4_indices_queries.sql    # Criação dos Índices e Consultas de RH/Departamentos
├── 5_procedures.sql         # Stored Procedure condicional para CRUD de Produtos
└── README.md                # Documentação do projeto
