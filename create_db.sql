# Create the database
CREATE DATABASE crueltyforum;
USE crueltyforum;
GRANT ALL PRIVILEGES ON crueltyforum.* TO 'appuser'@'localhost';


# Create the tables
CREATE TABLE `topics` (
  `idtopic` int NOT NULL AUTO_INCREMENT,
  `title` varchar(20) NOT NULL,
  `description` varchar(1000) NOT NULL,
  PRIMARY KEY (`idtopic`),
  UNIQUE KEY `topicid_UNIQUE` (`idtopic`)
);

CREATE TABLE `users` (
  `idusers` int NOT NULL AUTO_INCREMENT,
  `username` varchar(10) NOT NULL,
  `password` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idusers`),
  UNIQUE KEY `username_UNIQUE` (`username`)
);

CREATE TABLE `users_topics` (
  `idusers` int NOT NULL,
  `idtopics` int NOT NULL,
  PRIMARY KEY (`idusers`,`idtopics`),
  KEY `iduser_idx` (`idusers`),
  KEY `idtopic_idx` (`idtopics`),
  CONSTRAINT `topics` FOREIGN KEY (`idtopics`) REFERENCES `topics` (`idtopic`),
  CONSTRAINT `users` FOREIGN KEY (`idusers`) REFERENCES `users` (`idusers`)
);

CREATE TABLE posts (
  id int NOT NULL AUTO_INCREMENT,
  idtopic int NOT NULL,
  idcreator int NOT NULL,
  header varchar(45) NOT NULL,
  body varchar(1000) NOT NULL,
  PRIMARY KEY (id),
  KEY iduser_idx (idcreator),
  KEY idtopic_idx (idtopic),
  CONSTRAINT idtopic FOREIGN KEY (idtopic) REFERENCES topics (idtopic),
  CONSTRAINT iduser FOREIGN KEY (idcreator) REFERENCES users (idusers)
);