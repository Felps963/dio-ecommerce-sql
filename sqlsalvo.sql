-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: ecommerce_refinado
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `id_cliente` int NOT NULL AUTO_INCREMENT,
  `tipo_cliente` enum('PF','PJ') NOT NULL,
  `endereco` varchar(255) NOT NULL,
  `contato` varchar(45) NOT NULL,
  PRIMARY KEY (`id_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_before_delete_cliente` BEFORE DELETE ON `cliente` FOR EACH ROW BEGIN
    INSERT INTO cliente_removido_log (id_cliente, tipo_cliente, endereco, contato)
    VALUES (OLD.id_cliente, OLD.tipo_cliente, OLD.endereco, OLD.contato);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `cliente_removido_log`
--

DROP TABLE IF EXISTS `cliente_removido_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente_removido_log` (
  `id_log` int NOT NULL AUTO_INCREMENT,
  `id_cliente` int DEFAULT NULL,
  `tipo_cliente` varchar(10) DEFAULT NULL,
  `endereco` varchar(255) DEFAULT NULL,
  `contato` varchar(45) DEFAULT NULL,
  `data_exclusao` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_log`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente_removido_log`
--

LOCK TABLES `cliente_removido_log` WRITE;
/*!40000 ALTER TABLE `cliente_removido_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `cliente_removido_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departamento`
--

DROP TABLE IF EXISTS `departamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departamento` (
  `id_departamento` int NOT NULL AUTO_INCREMENT,
  `nome_departamento` varchar(100) NOT NULL,
  `id_gerente` int DEFAULT NULL,
  PRIMARY KEY (`id_departamento`),
  UNIQUE KEY `id_gerente` (`id_gerente`),
  CONSTRAINT `fk_departamento_gerente` FOREIGN KEY (`id_gerente`) REFERENCES `empregado` (`id_empregado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departamento`
--

LOCK TABLES `departamento` WRITE;
/*!40000 ALTER TABLE `departamento` DISABLE KEYS */;
/*!40000 ALTER TABLE `departamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departamento_localizacao`
--

DROP TABLE IF EXISTS `departamento_localizacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departamento_localizacao` (
  `id_departamento` int NOT NULL,
  `cidade` varchar(100) NOT NULL,
  PRIMARY KEY (`id_departamento`,`cidade`),
  KEY `idx_localizacao_cidade` (`cidade`) USING BTREE,
  CONSTRAINT `departamento_localizacao_ibfk_1` FOREIGN KEY (`id_departamento`) REFERENCES `departamento` (`id_departamento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departamento_localizacao`
--

LOCK TABLES `departamento_localizacao` WRITE;
/*!40000 ALTER TABLE `departamento_localizacao` DISABLE KEYS */;
/*!40000 ALTER TABLE `departamento_localizacao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dependente`
--

DROP TABLE IF EXISTS `dependente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dependente` (
  `id_dependente` int NOT NULL AUTO_INCREMENT,
  `id_empregado` int NOT NULL,
  `nome` varchar(100) NOT NULL,
  `parentesco` varchar(50) NOT NULL,
  `data_nascimento` date DEFAULT NULL,
  PRIMARY KEY (`id_dependente`),
  KEY `id_empregado` (`id_empregado`),
  CONSTRAINT `dependente_ibfk_1` FOREIGN KEY (`id_empregado`) REFERENCES `empregado` (`id_empregado`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dependente`
--

LOCK TABLES `dependente` WRITE;
/*!40000 ALTER TABLE `dependente` DISABLE KEYS */;
/*!40000 ALTER TABLE `dependente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empregado`
--

DROP TABLE IF EXISTS `empregado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empregado` (
  `id_empregado` int NOT NULL AUTO_INCREMENT,
  `id_departamento` int NOT NULL,
  `nome` varchar(100) NOT NULL,
  `cargo` varchar(50) DEFAULT NULL,
  `salario` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_empregado`),
  KEY `idx_empregado_departamento` (`id_departamento`) USING BTREE,
  KEY `idx_empregado_nome` (`nome`) USING BTREE,
  CONSTRAINT `empregado_ibfk_1` FOREIGN KEY (`id_departamento`) REFERENCES `departamento` (`id_departamento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empregado`
--

LOCK TABLES `empregado` WRITE;
/*!40000 ALTER TABLE `empregado` DISABLE KEYS */;
/*!40000 ALTER TABLE `empregado` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_before_update_salario` BEFORE UPDATE ON `empregado` FOR EACH ROW BEGIN
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
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `historico_salario_log`
--

DROP TABLE IF EXISTS `historico_salario_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `historico_salario_log` (
  `id_historico` int NOT NULL AUTO_INCREMENT,
  `id_empregado` int DEFAULT NULL,
  `salario_antigo` decimal(10,2) DEFAULT NULL,
  `salario_novo` decimal(10,2) DEFAULT NULL,
  `data_alteracao` datetime DEFAULT CURRENT_TIMESTAMP,
  `usuario_alteracao` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_historico`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historico_salario_log`
--

LOCK TABLES `historico_salario_log` WRITE;
/*!40000 ALTER TABLE `historico_salario_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `historico_salario_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produto`
--

DROP TABLE IF EXISTS `produto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produto` (
  `id_produto` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `categoria` varchar(50) NOT NULL,
  `valor_unitario` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_produto`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produto`
--

LOCK TABLES `produto` WRITE;
/*!40000 ALTER TABLE `produto` DISABLE KEYS */;
INSERT INTO `produto` VALUES (1,'Headset Gamer 7.1','Perifericos',89.90),(2,'Headset Gamer 7.1','Perifericos',350.00);
/*!40000 ALTER TABLE `produto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projeto`
--

DROP TABLE IF EXISTS `projeto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projeto` (
  `id_projeto` int NOT NULL AUTO_INCREMENT,
  `nome_projeto` varchar(100) NOT NULL,
  `id_departamento` int NOT NULL,
  PRIMARY KEY (`id_projeto`),
  KEY `id_departamento` (`id_departamento`),
  CONSTRAINT `projeto_ibfk_1` FOREIGN KEY (`id_departamento`) REFERENCES `departamento` (`id_departamento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projeto`
--

LOCK TABLES `projeto` WRITE;
/*!40000 ALTER TABLE `projeto` DISABLE KEYS */;
/*!40000 ALTER TABLE `projeto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projeto_empregado`
--

DROP TABLE IF EXISTS `projeto_empregado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projeto_empregado` (
  `id_projeto` int NOT NULL,
  `id_empregado` int NOT NULL,
  `horas_trabalhadas` decimal(5,2) DEFAULT '0.00',
  PRIMARY KEY (`id_projeto`,`id_empregado`),
  KEY `id_empregado` (`id_empregado`),
  CONSTRAINT `projeto_empregado_ibfk_1` FOREIGN KEY (`id_projeto`) REFERENCES `projeto` (`id_projeto`),
  CONSTRAINT `projeto_empregado_ibfk_2` FOREIGN KEY (`id_empregado`) REFERENCES `empregado` (`id_empregado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projeto_empregado`
--

LOCK TABLES `projeto_empregado` WRITE;
/*!40000 ALTER TABLE `projeto_empregado` DISABLE KEYS */;
/*!40000 ALTER TABLE `projeto_empregado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_empregado_resumo`
--

DROP TABLE IF EXISTS `vw_empregado_resumo`;
/*!50001 DROP VIEW IF EXISTS `vw_empregado_resumo`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_empregado_resumo` AS SELECT 
 1 AS `id_empregado`,
 1 AS `nome`,
 1 AS `cargo`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_gerencia_completa`
--

DROP TABLE IF EXISTS `vw_gerencia_completa`;
/*!50001 DROP VIEW IF EXISTS `vw_gerencia_completa`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_gerencia_completa` AS SELECT 
 1 AS `nome_departamento`,
 1 AS `id_empregado`,
 1 AS `empregado`,
 1 AS `cargo`,
 1 AS `salario`,
 1 AS `gerente_direto`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'ecommerce_refinado'
--

--
-- Dumping routines for database 'ecommerce_refinado'
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_manter_produto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_manter_produto`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `vw_empregado_resumo`
--

/*!50001 DROP VIEW IF EXISTS `vw_empregado_resumo`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_empregado_resumo` AS select `empregado`.`id_empregado` AS `id_empregado`,`empregado`.`nome` AS `nome`,`empregado`.`cargo` AS `cargo` from `empregado` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_gerencia_completa`
--

/*!50001 DROP VIEW IF EXISTS `vw_gerencia_completa`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_gerencia_completa` AS select `d`.`nome_departamento` AS `nome_departamento`,`e`.`id_empregado` AS `id_empregado`,`e`.`nome` AS `empregado`,`e`.`cargo` AS `cargo`,`e`.`salario` AS `salario`,coalesce(`g`.`nome`,'Nenhum') AS `gerente_direto` from ((`departamento` `d` join `empregado` `e` on((`d`.`id_departamento` = `e`.`id_departamento`))) left join `empregado` `g` on((`d`.`id_gerente` = `g`.`id_empregado`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-09-21 15:41:46
-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: oficina_mecanica
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `id_cliente` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `cpf_cnpj` varchar(18) NOT NULL,
  `telefone` varchar(20) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `endereco` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_cliente`),
  UNIQUE KEY `cpf_cnpj` (`cpf_cnpj`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,'Carlos Roberto','111.222.333-44','(19) 98111-2233','carlos@email.com','Rua A, 100 - Americana'),(2,'Mariana Lima','555.666.777-88','(19) 98222-4455','mariana@email.com','Av. Brasil, 500 - Campinas'),(3,'Empresa de Transportes Silva','12.345.678/0001-90','(19) 3400-1122','contato@transilva.com','Rua Industrial, 50 - Sumaré');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `equipe`
--

DROP TABLE IF EXISTS `equipe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipe` (
  `id_equipe` int NOT NULL AUTO_INCREMENT,
  `nome_equipe` varchar(50) NOT NULL,
  PRIMARY KEY (`id_equipe`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipe`
--

LOCK TABLES `equipe` WRITE;
/*!40000 ALTER TABLE `equipe` DISABLE KEYS */;
INSERT INTO `equipe` VALUES (1,'Equipe Motor & Câmbio'),(2,'Equipe Suspensão & Freios');
/*!40000 ALTER TABLE `equipe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mecanico`
--

DROP TABLE IF EXISTS `mecanico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mecanico` (
  `id_mecanico` int NOT NULL AUTO_INCREMENT,
  `id_equipe` int NOT NULL,
  `nome` varchar(100) NOT NULL,
  `endereco` varchar(255) DEFAULT NULL,
  `especialidade` varchar(50) NOT NULL,
  PRIMARY KEY (`id_mecanico`),
  KEY `id_equipe` (`id_equipe`),
  CONSTRAINT `mecanico_ibfk_1` FOREIGN KEY (`id_equipe`) REFERENCES `equipe` (`id_equipe`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mecanico`
--

LOCK TABLES `mecanico` WRITE;
/*!40000 ALTER TABLE `mecanico` DISABLE KEYS */;
INSERT INTO `mecanico` VALUES (1,1,'João Pedro','Rua 1, Americana','Motoristas / Mecânica Pesada'),(2,1,'Lucas Martins','Rua 2, Santa Bárbara','Injeção Eletrônica'),(3,2,'Marcos Vinicius','Rua 3, Americana','Freios e Suspensão');
/*!40000 ALTER TABLE `mecanico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordem_servico`
--

DROP TABLE IF EXISTS `ordem_servico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordem_servico` (
  `id_ordem_servico` int NOT NULL AUTO_INCREMENT,
  `id_veiculo` int NOT NULL,
  `id_equipe` int NOT NULL,
  `numero_os` varchar(20) NOT NULL,
  `data_emissao` date NOT NULL,
  `data_conclusao_prevista` date DEFAULT NULL,
  `valor_total` decimal(10,2) DEFAULT '0.00',
  `status` enum('Em Avaliacao','Aguardando Aprovacao','Em Execucao','Concluido','Cancelado') DEFAULT 'Em Avaliacao',
  `autorizado` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id_ordem_servico`),
  UNIQUE KEY `numero_os` (`numero_os`),
  KEY `id_veiculo` (`id_veiculo`),
  KEY `id_equipe` (`id_equipe`),
  CONSTRAINT `ordem_servico_ibfk_1` FOREIGN KEY (`id_veiculo`) REFERENCES `veiculo` (`id_veiculo`),
  CONSTRAINT `ordem_servico_ibfk_2` FOREIGN KEY (`id_equipe`) REFERENCES `equipe` (`id_equipe`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordem_servico`
--

LOCK TABLES `ordem_servico` WRITE;
/*!40000 ALTER TABLE `ordem_servico` DISABLE KEYS */;
INSERT INTO `ordem_servico` VALUES (1,1,1,'OS-2026-001','2026-08-10','2026-08-12',0.00,'Concluido',1),(2,2,2,'OS-2026-002','2026-08-18','2026-08-22',0.00,'Em Execucao',1),(3,3,2,'OS-2026-003','2026-08-20','2026-08-25',0.00,'Aguardando Aprovacao',0);
/*!40000 ALTER TABLE `ordem_servico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `os_peca`
--

DROP TABLE IF EXISTS `os_peca`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `os_peca` (
  `id_ordem_servico` int NOT NULL,
  `id_peca` int NOT NULL,
  `quantidade` int NOT NULL DEFAULT '1',
  `valor_unitario` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_ordem_servico`,`id_peca`),
  KEY `id_peca` (`id_peca`),
  CONSTRAINT `os_peca_ibfk_1` FOREIGN KEY (`id_ordem_servico`) REFERENCES `ordem_servico` (`id_ordem_servico`) ON DELETE CASCADE,
  CONSTRAINT `os_peca_ibfk_2` FOREIGN KEY (`id_peca`) REFERENCES `peca` (`id_peca`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `os_peca`
--

LOCK TABLES `os_peca` WRITE;
/*!40000 ALTER TABLE `os_peca` DISABLE KEYS */;
INSERT INTO `os_peca` VALUES (1,1,1,45.00),(1,2,4,60.00),(2,3,1,180.00),(2,4,2,250.00);
/*!40000 ALTER TABLE `os_peca` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `os_servico`
--

DROP TABLE IF EXISTS `os_servico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `os_servico` (
  `id_ordem_servico` int NOT NULL,
  `id_servico` int NOT NULL,
  `quantidade` int NOT NULL DEFAULT '1',
  `valor_unitario` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_ordem_servico`,`id_servico`),
  KEY `id_servico` (`id_servico`),
  CONSTRAINT `os_servico_ibfk_1` FOREIGN KEY (`id_ordem_servico`) REFERENCES `ordem_servico` (`id_ordem_servico`) ON DELETE CASCADE,
  CONSTRAINT `os_servico_ibfk_2` FOREIGN KEY (`id_servico`) REFERENCES `servico` (`id_servico`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `os_servico`
--

LOCK TABLES `os_servico` WRITE;
/*!40000 ALTER TABLE `os_servico` DISABLE KEYS */;
INSERT INTO `os_servico` VALUES (1,1,1,80.00),(2,2,1,120.00),(2,3,1,150.00);
/*!40000 ALTER TABLE `os_servico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `peca`
--

DROP TABLE IF EXISTS `peca`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `peca` (
  `id_peca` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(100) NOT NULL,
  `valor_unitario` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_peca`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `peca`
--

LOCK TABLES `peca` WRITE;
/*!40000 ALTER TABLE `peca` DISABLE KEYS */;
INSERT INTO `peca` VALUES (1,'Filtro de Óleo',45.00),(2,'Óleo Sintético 5W30 (Litro)',60.00),(3,'Jogo de Pastilhas de Freio Frontal',180.00),(4,'Disco de Freio Ventilado',250.00);
/*!40000 ALTER TABLE `peca` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servico`
--

DROP TABLE IF EXISTS `servico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `servico` (
  `id_servico` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(100) NOT NULL,
  `valor_mao_de_obra` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_servico`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servico`
--

LOCK TABLES `servico` WRITE;
/*!40000 ALTER TABLE `servico` DISABLE KEYS */;
INSERT INTO `servico` VALUES (1,'Troca de Óleo e Filtro',80.00),(2,'Alinhamento e Balanceamento',120.00),(3,'Troca de Pastilhas de Freio',150.00),(4,'Retífica de Motor',1500.00);
/*!40000 ALTER TABLE `servico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `veiculo`
--

DROP TABLE IF EXISTS `veiculo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `veiculo` (
  `id_veiculo` int NOT NULL AUTO_INCREMENT,
  `id_cliente` int NOT NULL,
  `placa` varchar(8) NOT NULL,
  `modelo` varchar(50) NOT NULL,
  `marca` varchar(50) NOT NULL,
  `ano` int NOT NULL,
  PRIMARY KEY (`id_veiculo`),
  UNIQUE KEY `placa` (`placa`),
  KEY `id_cliente` (`id_cliente`),
  CONSTRAINT `veiculo_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `veiculo`
--

LOCK TABLES `veiculo` WRITE;
/*!40000 ALTER TABLE `veiculo` DISABLE KEYS */;
INSERT INTO `veiculo` VALUES (1,1,'ABC-1234','Civic 2.0','Honda',2018),(2,1,'XYZ-9876','Fit 1.5','Honda',2015),(3,2,'JKL-5678','Onix 1.0','Chevrolet',2021),(4,3,'MNO-3344','Cargo 816','Ford',2019);
/*!40000 ALTER TABLE `veiculo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'oficina_mecanica'
--

--
-- Dumping routines for database 'oficina_mecanica'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-09-21 15:41:46
