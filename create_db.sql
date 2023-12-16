# Create the database
CREATE DATABASE crueltyforum;
USE crueltyforum;
GRANT ALL PRIVILEGES ON crueltyforum.* TO 'appuser'@'localhost';

# Create the tables
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

INSERT INTO `posts` VALUES (1,1,1,'Engorged Flesh','Help my security postulates has grown cancerous. Pus yield seems poor, I want to pop it now and bail. Should have diversified my bile. Take it from me this was a bad investment.'),
(2,3,3,'I love basketball','BASKETBALL!!!'),
(3,2,2,'Sacrifices are good this year','AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),
(9,3,1,'koby','the bronze jade'),
(10,1,4,'I think the world is ending','I don\'t think the markets are trying to pander to me anymore. That was all the craving I ever had in my life. Without these megacorps feeling like they need to appease me for their livelihoods, I am just another worthless maggot rolling around on this fetid Earth. Why bother at this point?'),
(11,4,3,'Jimbo\'s Futility','I got this game last year and it kind of sucks ngl. Been playing it on and off but the core gameplay loop just doesn\'t hit after more than an hour. Ig the part where a ghost reaches through the screen to squeeze your heart for 3 seconds just gets old fast. Maybe if they added a permadeath system, it wouldn\'t feel so mundane.');

CREATE TABLE `topics` (
  `idtopic` int NOT NULL AUTO_INCREMENT,
  `title` varchar(20) NOT NULL,
  `description` varchar(1000) NOT NULL,
  PRIMARY KEY (`idtopic`),
  UNIQUE KEY `topicid_UNIQUE` (`idtopic`)
);

INSERT INTO `topics` VALUES (1,'Market gods','Worship the lords of finance. The great invisibles hands that move market and soul. Revel in the scales of which dominate and overshadow even those that profit from them.'),
(2,'Primal horror','Engage the techniques of old. Gain power. Embrace divinity. Invest now.'),
(3,'Basketball','Talk about basketball'),
(4,'Computer Games','I heart Dopamine. I heart feelings.');

CREATE TABLE `users` (
  `idusers` int NOT NULL AUTO_INCREMENT,
  `username` varchar(10) NOT NULL,
  `password` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idusers`),
  UNIQUE KEY `username_UNIQUE` (`username`)
);

INSERT INTO `users` VALUES (1,'gary123','123'),
(2,'james43','234'),
(3,'pieman','36'),
(4,'JohnSmith','1234');

CREATE TABLE `users_topics` (
  `idusers` int NOT NULL,
  `idtopics` int NOT NULL,
  PRIMARY KEY (`idusers`,`idtopics`),
  KEY `iduser_idx` (`idusers`),
  KEY `idtopic_idx` (`idtopics`),
  CONSTRAINT `topics` FOREIGN KEY (`idtopics`) REFERENCES `topics` (`idtopic`),
  CONSTRAINT `users` FOREIGN KEY (`idusers`) REFERENCES `users` (`idusers`)
);

INSERT INTO `users_topics` VALUES (1,1),
(1,2),
(1,3),
(2,2),
(2,3),
(3,3),
(3,4),
(4,1);


