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
-- Table structure for table `squadra`
--

DROP TABLE IF EXISTS `squadra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `squadra` (
  `nome` varchar(20) NOT NULL,
  `citta` varchar(30) NOT NULL,
  `stadio` varchar(30) NOT NULL,
  `anno_fondazione` int NOT NULL,
  `nazione` varchar(3) NOT NULL,
  PRIMARY KEY (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `squadra`
--

LOCK TABLES `squadra` WRITE;
/*!40000 ALTER TABLE `squadra` DISABLE KEYS */;
INSERT INTO `squadra` VALUES ('AC Milan','Milano','San Siro',1899,'ITA'),('Atalanta','Bergamo','Gewiss Stadium',1907,'ITA'),('Bologna','Bologna','Dall\'Ara',1909,'ITA'),('Cagliari','Cagliari','Sardegna Arena',1920,'ITA'),('Chievo','Verona','Bentegodi',1929,'ITA'),('Empoli','Empoli','Castellani',1920,'ITA'),('FC Inter','Milano','San Siro',1908,'ITA'),('Fiorentina','Firenze','Artemio Franchi',1926,'ITA'),('Frosinone','Frosinone','Benito Stirpe',1906,'ITA'),('Genoa','Genova','Marassi',1893,'ITA'),('Juventus','Torino','Allianz Stadium',1897,'ITA'),('Lazio','Roma','Olimpico',1900,'ITA'),('Parma','Parma','Tardini',1913,'ITA'),('Roma','Roma','Olimpico',1927,'ITA'),('Sampdoria','Genova','Marassi',1946,'ITA'),('Sassuolo','Sassuolo','Mapei Stadium',1920,'ITA'),('SPAL','Ferrara','Paolo Mazza',1907,'ITA'),('SSC Napoli','Napoli','San Paolo',1926,'ITA'),('Torino','Torino','Olimpico Grande Torino',1906,'ITA'),('Udinese','Udine','Dacia Stadium',1896,'ITA');
/*!40000 ALTER TABLE `squadra` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-03-11 17:05:11
