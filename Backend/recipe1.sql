-- MySQL dump 10.13  Distrib 9.1.0, for Linux (x86_64)
--
-- Host: localhost    Database: cooking_app
-- ------------------------------------------------------
-- Server version	9.1.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `category_recipe`
--

DROP TABLE IF EXISTS `category_recipe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category_recipe` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category_recipe`
--

LOCK TABLES `category_recipe` WRITE;
/*!40000 ALTER TABLE `category_recipe` DISABLE KEYS */;
INSERT INTO `category_recipe` VALUES (1,'Món chay'),(2,'Đồ uông'),(3,'Đồ hải san'),(4,'Món nhậu '),(5,'Món ăn sáng '),(6,'Bánh - xôi - chè ');
/*!40000 ALTER TABLE `category_recipe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favorite_recipe`
--

DROP TABLE IF EXISTS `favorite_recipe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favorite_recipe` (
  `is_favorite` bit(1) DEFAULT NULL,
  `recipe_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`recipe_id`,`user_id`),
  KEY `FKsfqq6wu5gf9n77i01msgccixp` (`user_id`),
  CONSTRAINT `FKkc0xeltectgqgjnuemidtyi4i` FOREIGN KEY (`recipe_id`) REFERENCES `recipe` (`recipe_id`),
  CONSTRAINT `FKsfqq6wu5gf9n77i01msgccixp` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorite_recipe`
--

LOCK TABLES `favorite_recipe` WRITE;
/*!40000 ALTER TABLE `favorite_recipe` DISABLE KEYS */;
INSERT INTO `favorite_recipe` VALUES (_binary '',2,2);
/*!40000 ALTER TABLE `favorite_recipe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forgot_password`
--

DROP TABLE IF EXISTS `forgot_password`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `forgot_password` (
  `fpid` int NOT NULL AUTO_INCREMENT,
  `otp` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `expiration_time` datetime(6) NOT NULL,
  PRIMARY KEY (`fpid`),
  UNIQUE KEY `UKss96nm4ed1jmllpxib14p1r7v` (`user_id`),
  CONSTRAINT `FK95rqabtnw8wouua80mbixrq4` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forgot_password`
--

LOCK TABLES `forgot_password` WRITE;
/*!40000 ALTER TABLE `forgot_password` DISABLE KEYS */;
/*!40000 ALTER TABLE `forgot_password` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingredient`
--

DROP TABLE IF EXISTS `ingredient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ingredient` (
  `ingredient_id` int NOT NULL AUTO_INCREMENT,
  `recipe_id` int DEFAULT NULL,
  `amount` varchar(255) DEFAULT NULL,
  `ingredient_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ingredient_id`),
  KEY `FKj0s4ywmqqqw4h5iommigh5yja` (`recipe_id`),
  CONSTRAINT `FKj0s4ywmqqqw4h5iommigh5yja` FOREIGN KEY (`recipe_id`) REFERENCES `recipe` (`recipe_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingredient`
--

LOCK TABLES `ingredient` WRITE;
/*!40000 ALTER TABLE `ingredient` DISABLE KEYS */;
INSERT INTO `ingredient` VALUES (2,2,'100g',' Bò lát chay (dùng loại từ lúa mạch ngon hơn) '),(3,2,'500g ',' Mướp non '),(4,2,'500g ',' Bánh phở tươi '),(5,2,'1 củ ',' hành tây nhỏ '),(6,2,' ',' Hạt nêm, muối, nước mắm chay, dầu ăn, tiêu, gừng tươi '),(7,2,' ','Rau mùi ta(ngò rí)');
/*!40000 ALTER TABLE `ingredient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instruction`
--

DROP TABLE IF EXISTS `instruction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `instruction` (
  `instruction_id` int NOT NULL AUTO_INCREMENT,
  `recipe_id` int DEFAULT NULL,
  `step_number` int DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`instruction_id`),
  KEY `FKcd28dqk4w4civw4jbswqhde2o` (`recipe_id`),
  CONSTRAINT `FKcd28dqk4w4civw4jbswqhde2o` FOREIGN KEY (`recipe_id`) REFERENCES `recipe` (`recipe_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instruction`
--

LOCK TABLES `instruction` WRITE;
/*!40000 ALTER TABLE `instruction` DISABLE KEYS */;
INSERT INTO `instruction` VALUES (1,2,NULL,'Bò lát chay ngâm mềm. Rửa sạch, vắt khô. Dùng chày đập dập.Ướp bò lát chay với nước mắm chay, tiêu và gừng + dầu ăn. Xào vài phút cho bò chay thấm gia vị.'),(2,2,NULL,'Nấu nước dùng: Dùng khoảng 3,5l nước. Phần gia vị nấu phở cho vào túi vải kèm theo trong gói gia vị, thả vào nồi nước.Mướp non cắt khúc + hành tây cắt làm 4, cho vào nồi nước.Nấu sôi khoảng 20’, vớt phần mướp và hành ra. Lược lại nước cho trong.'),(3,2,NULL,'Nêm thêm hạt nêm, muối, nước mắm chay và ít tiêu. Khi ăn: trụng bánh phở, cho vào tô, cho bò lát chay lên trên. Chan nước dùng. Bạn nào không kiêng ngũ vị tân có thể dùng hành lá. Còn kiêng ngũ vị tân thì thay bằng rau mùi ta.');
/*!40000 ALTER TABLE `instruction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invalidated_token`
--

DROP TABLE IF EXISTS `invalidated_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invalidated_token` (
  `expiry_time` datetime(6) DEFAULT NULL,
  `id` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invalidated_token`
--

LOCK TABLES `invalidated_token` WRITE;
/*!40000 ALTER TABLE `invalidated_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `invalidated_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permission`
--

DROP TABLE IF EXISTS `permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permission` (
  `description` varchar(255) DEFAULT NULL,
  `permission_name` varchar(255) NOT NULL,
  PRIMARY KEY (`permission_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permission`
--

LOCK TABLES `permission` WRITE;
/*!40000 ALTER TABLE `permission` DISABLE KEYS */;
INSERT INTO `permission` VALUES ('Read data permissions','READ_DATA');
/*!40000 ALTER TABLE `permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipe`
--

DROP TABLE IF EXISTS `recipe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recipe` (
  `category_id` int DEFAULT NULL,
  `created_at` date DEFAULT NULL,
  `recipe_id` int NOT NULL AUTO_INCREMENT,
  `updated_at` date DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `cook_time` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `prep_time` varchar(255) DEFAULT NULL,
  `recipe_name` varchar(255) NOT NULL,
  PRIMARY KEY (`recipe_id`),
  KEY `FK6u9rd73djcfhk1yjne1crvm84` (`category_id`),
  KEY `FKc8o8io8s0f7nqcd3429u6cxjs` (`user_id`),
  FULLTEXT KEY `idx_recipe_name` (`recipe_name`),
  CONSTRAINT `FK6u9rd73djcfhk1yjne1crvm84` FOREIGN KEY (`category_id`) REFERENCES `category_recipe` (`category_id`),
  CONSTRAINT `FKc8o8io8s0f7nqcd3429u6cxjs` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipe`
--

LOCK TABLES `recipe` WRITE;
/*!40000 ALTER TABLE `recipe` DISABLE KEYS */;
INSERT INTO `recipe` VALUES (1,'2024-11-21',1,'2024-11-21',2,'15p',' ',' 15p','Canh chay '),(1,'2024-11-21',2,'2024-11-21',2,'45p',' ',' 1h','Phở chay ');
/*!40000 ALTER TABLE `recipe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `rating` int DEFAULT NULL,
  `recipe_id` int NOT NULL,
  `user_id` int NOT NULL,
  `comment_content` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`recipe_id`,`user_id`),
  KEY `FKiyf57dy48lyiftdrf7y87rnxi` (`user_id`),
  CONSTRAINT `FK9dqw7ep5rnww1yuimutvg4nny` FOREIGN KEY (`recipe_id`) REFERENCES `recipe` (`recipe_id`),
  CONSTRAINT `FKiyf57dy48lyiftdrf7y87rnxi` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `description` varchar(255) DEFAULT NULL,
  `role_name` varchar(255) NOT NULL,
  PRIMARY KEY (`role_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES ('User role','USER');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_permission`
--

DROP TABLE IF EXISTS `role_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_permission` (
  `permission_name` varchar(255) NOT NULL,
  `role_name` varchar(255) NOT NULL,
  PRIMARY KEY (`permission_name`,`role_name`),
  KEY `FKng6lj87lo2uxina096lfjpdlp` (`role_name`),
  CONSTRAINT `FKldkc3yoh80x16gv94519otli4` FOREIGN KEY (`permission_name`) REFERENCES `permission` (`permission_name`),
  CONSTRAINT `FKng6lj87lo2uxina096lfjpdlp` FOREIGN KEY (`role_name`) REFERENCES `role` (`role_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_permission`
--

LOCK TABLES `role_permission` WRITE;
/*!40000 ALTER TABLE `role_permission` DISABLE KEYS */;
INSERT INTO `role_permission` VALUES ('READ_DATA','USER');
/*!40000 ALTER TABLE `role_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `created_at` date DEFAULT NULL,
  `updated_at` date DEFAULT NULL,
  `user_id` int NOT NULL AUTO_INCREMENT,
  `dob` datetime(6) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('2024-11-21','2024-11-21',1,NULL,'admin@gmail.com',NULL,NULL,'$2a$10$IJSDjop8lAq9GDIry6FejuvZ7G9AxxdKRUfnE3pUiiF/hbKr7nnR6'),('2024-11-21','2024-11-21',2,'2003-07-08 07:00:00.000000','chien.haui0807@gmail.com','Chien','Dang','$2a$10$UkwMh/qkLvyHX0h3phnb3Of/2AnxsAKgEdZzlUhPKHC66XjixD8Uu'),('2024-11-21','2024-11-21',3,'2003-07-08 07:00:00.000000','chien01@gmail.com','Chien','Dang','$2a$10$X8aT/IFja9y/PajP5rXAteiuCGhijZIx713lSjV5TFa43ubK8CJq2'),('2024-11-22','2024-11-22',4,'2003-07-08 07:00:00.000000','chien03@gmail.com','Chien','Dang','$2a$10$uR8E9Xp5NGKzU79h2.86neZmD7/Fov.mtr0vbA0IXyBj6ff9Mpw66'),('2024-11-24','2024-11-24',5,'2003-07-08 07:00:00.000000','chien04@gmail.com','Chien','Dang','$2a$10$maGAxlmv9otKHx5AI8ex6OIJ9nggXj1L7kAKBR5fXnoD.ByB6kRfq'),('2024-11-24','2024-11-24',6,'2003-07-08 07:00:00.000000','chien06@gmail.com','Chien','Dang','$2a$10$I19Upv6g.1dO8OySlEEvqOgzXVlkFh1QQrDQjNB84GwKqQPr435Z.'),('2024-11-25','2024-11-25',7,'2003-07-08 07:00:00.000000','chien07@gmail.com','Chien','Dang','$2a$10$70kfHneyMCbiDAgQSezAzuVnwi0BZmLzKWY8DH4BLVGlm9qOPGYoG');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_role`
--

DROP TABLE IF EXISTS `user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_role` (
  `user_id` int NOT NULL,
  `role_name` varchar(255) NOT NULL,
  PRIMARY KEY (`user_id`,`role_name`),
  KEY `FKn6r4465stkbdy93a9p8cw7u24` (`role_name`),
  CONSTRAINT `FK859n2jvi8ivhui0rl0esws6o` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `FKn6r4465stkbdy93a9p8cw7u24` FOREIGN KEY (`role_name`) REFERENCES `role` (`role_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_role`
--

LOCK TABLES `user_role` WRITE;
/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
INSERT INTO `user_role` VALUES (2,'USER'),(4,'USER'),(5,'USER'),(6,'USER'),(7,'USER');
/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-04  9:46:37
