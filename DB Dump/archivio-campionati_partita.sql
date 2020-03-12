-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: archivio-campionati
-- ------------------------------------------------------
-- Server version	8.0.19

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
-- Table structure for table `partita`
--

DROP TABLE IF EXISTS `partita`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `partita` (
  `cod_partita` int NOT NULL AUTO_INCREMENT,
  `campionato_partita` int NOT NULL,
  `giornata` int NOT NULL,
  `data` date NOT NULL,
  `squadra_casa` varchar(20) NOT NULL,
  `squadra_ospite` varchar(20) NOT NULL,
  `gol_casa` int NOT NULL,
  `gol_ospiti` int NOT NULL,
  PRIMARY KEY (`cod_partita`),
  KEY `compone` (`campionato_partita`),
  KEY `disputa_casa` (`squadra_casa`),
  KEY `disputa_ospite` (`squadra_ospite`),
  CONSTRAINT `compone` FOREIGN KEY (`campionato_partita`) REFERENCES `campionato` (`cod_campionato`),
  CONSTRAINT `disputa_casa` FOREIGN KEY (`squadra_casa`) REFERENCES `squadra` (`nome`),
  CONSTRAINT `disputa_ospite` FOREIGN KEY (`squadra_ospite`) REFERENCES `squadra` (`nome`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `partita`
--

LOCK TABLES `partita` WRITE;
/*!40000 ALTER TABLE `partita` DISABLE KEYS */;
INSERT INTO `partita` VALUES (1,1,1,'2018-08-20','Atalanta','Frosinone',4,0),(2,1,1,'2018-08-19','Bologna','SPAL',0,1),(3,1,1,'2018-08-18','Chievo','Juventus',0,3),(4,1,1,'2018-08-19','Empoli','Cagliari',2,2),(5,1,1,'2018-10-31','AC Milan','Genoa',2,0),(6,1,1,'2018-08-19','Parma','Udinese',2,1),(7,1,1,'2018-09-19','Sampdoria','Fiorentina',3,3),(8,1,1,'2018-08-19','Sassuolo','FC Inter',0,0),(9,1,1,'2018-08-19','Torino','Roma',2,3),(10,1,1,'2018-08-18','Lazio','SSC Napoli',1,2),(11,1,2,'2018-08-26','Cagliari','Sassuolo',2,2),(12,1,2,'2018-08-26','Fiorentina','Chievo',6,1),(13,1,2,'2018-08-26','Frosinone','Bologna',0,0),(14,1,2,'2018-08-26','Genoa','Empoli',2,1),(15,1,2,'2018-08-26','FC Inter','Torino',2,2),(16,1,2,'2018-08-25','Juventus','Lazio',2,0),(17,1,2,'2018-08-25','SSC Napoli','AC Milan',3,2),(18,1,2,'2018-08-27','Roma','Atalanta',3,3),(19,1,2,'2018-08-26','SPAL','Parma',1,0),(20,1,2,'2018-08-26','Udinese','Sampdoria',2,2);
/*!40000 ALTER TABLE `partita` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-03-11 17:05:10
