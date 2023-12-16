-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: crueltyforum
-- ------------------------------------------------------
-- Server version	8.2.0

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
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idtopic` int NOT NULL,
  `idcreator` int NOT NULL,
  `header` varchar(45) NOT NULL,
  `body` varchar(1000) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `iduser_idx` (`idcreator`),
  KEY `idtopic_idx` (`idtopic`),
  CONSTRAINT `idtopic` FOREIGN KEY (`idtopic`) REFERENCES `topics` (`idtopic`),
  CONSTRAINT `iduser` FOREIGN KEY (`idcreator`) REFERENCES `users` (`idusers`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf32;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (1,1,1,'Engorged Flesh','Help my security postulates has grown cancerous. Pus yield seems poor, I want to pop it now and bail. Should have diversified my bile. Take it from me this was a bad investment.'),(2,3,3,'I love basketball','BASKETBALL!!!'),(3,2,2,'Sacrifices are good this year','AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),(9,3,1,'koby','the bronze jade'),(10,1,4,'I think the world is ending','I don\'t think the markets are trying to pander to me anymore. That was all the craving I ever had in my life. Without these megacorps feeling like they need to appease me for their livelihoods, I am just another worthless maggot rolling around on this fetid Earth. Why bother at this point?'),(11,4,3,'Jimbo\'s Futility','I got this game last year and it kind of sucks ngl. Been playing it on and off but the core gameplay loop just doesn\'t hit after more than an hour. Ig the part where a ghost reaches through the screen to squeeze your heart for 3 seconds just gets old fast. Maybe if they added a permadeath system, it wouldn\'t feel so mundane.');
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `topics`
--

DROP TABLE IF EXISTS `topics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `topics` (
  `idtopic` int NOT NULL AUTO_INCREMENT,
  `title` varchar(20) NOT NULL,
  `description` varchar(1000) NOT NULL,
  PRIMARY KEY (`idtopic`),
  UNIQUE KEY `topicid_UNIQUE` (`idtopic`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `topics`
--

LOCK TABLES `topics` WRITE;
/*!40000 ALTER TABLE `topics` DISABLE KEYS */;
INSERT INTO `topics` VALUES (1,'Market gods','Worship the lords of finance. The great invisibles hands that move market and soul. Revel in the scales of which dominate and overshadow even those that profit from them.'),(2,'Primal horror','Engage the techniques of old. Gain power. Embrace divinity. Invest now.'),(3,'Basketball','Talk about basketball'),(4,'Computer Games','I heart Dopamine. I heart feelings.');
/*!40000 ALTER TABLE `topics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `idusers` int NOT NULL AUTO_INCREMENT,
  `username` varchar(10) NOT NULL,
  `password` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idusers`),
  UNIQUE KEY `username_UNIQUE` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf32;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'gary123','123'),(2,'james43','234'),(3,'pieman','36'),(4,'JohnSmith','1234');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_topics`
--

DROP TABLE IF EXISTS `users_topics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_topics` (
  `idusers` int NOT NULL,
  `idtopics` int NOT NULL,
  PRIMARY KEY (`idusers`,`idtopics`),
  KEY `iduser_idx` (`idusers`),
  KEY `idtopic_idx` (`idtopics`),
  CONSTRAINT `topics` FOREIGN KEY (`idtopics`) REFERENCES `topics` (`idtopic`),
  CONSTRAINT `users` FOREIGN KEY (`idusers`) REFERENCES `users` (`idusers`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_topics`
--

LOCK TABLES `users_topics` WRITE;
/*!40000 ALTER TABLE `users_topics` DISABLE KEYS */;
INSERT INTO `users_topics` VALUES (1,1),(1,2),(1,3),(2,2),(2,3),(3,3),(3,4),(4,1);
/*!40000 ALTER TABLE `users_topics` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-16 18:34:13
