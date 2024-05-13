-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: cs336project
-- ------------------------------------------------------
-- Server version	8.0.36

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
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `admin_username` varchar(20) NOT NULL,
  `admin_password` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`admin_username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES ('admin123','pass123');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alert`
--

DROP TABLE IF EXISTS `alert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alert` (
  `end_user_username` varchar(20) NOT NULL,
  `alert_date` datetime DEFAULT NULL,
  `alert_text` varchar(500) NOT NULL,
  PRIMARY KEY (`end_user_username`,`alert_text`),
  CONSTRAINT `alert_ibfk_1` FOREIGN KEY (`end_user_username`) REFERENCES `end_user` (`end_user_username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alert`
--

LOCK TABLES `alert` WRITE;
/*!40000 ALTER TABLE `alert` DISABLE KEYS */;
INSERT INTO `alert` VALUES ('alex123','2024-05-04 21:13:22','Message From Customer Representative: custrep123 Message: hello alex'),('alex123','2024-05-03 11:34:23','You have won auction: user1237 With Your Bid Of 115.0'),('alex123','2024-05-04 15:55:19','Your Limit For You Auto Bid Has Been Exceeded For Aution: hi12310'),('hi123','2024-05-04 22:38:14','A bid has been placed above your bid for Auction: newuser15'),('hi123','2024-05-04 15:48:46','A bid has been placed above your bid for Auction: user12311'),('hi123','2024-05-02 21:56:10','You have won auction: \" + \n    			auctionId + \" With Your Bid Of \" + auctionWinnerRS.getFloat(1)'),('hi123','2024-05-03 11:46:37','You have won auction: user1239 With Your Bid Of 130.0'),('hi123','2024-05-03 11:30:20','You have won auction: woah With Your Bid Of 510.01'),('matt123','2024-05-04 22:55:59','A bid has been placed above your bid for Auction: newuser18'),('matt123','2024-05-04 23:15:14','You have won auction: newuser23 With Your Bid Of 270.0'),('newuser','2024-05-04 23:20:07','Alert for available PC Part of Type: hdd and of Brand: Intel'),('newuser','2024-05-04 23:21:22','Message From Customer Representative: newrep123 Message: I have received your message'),('newuser','2024-05-04 23:18:54','Your Limit For You Auto Bid Has Been Exceeded For Aution: user12313'),('test','2024-05-04 22:55:51','A bid has been placed above your bid for Auction: newuser18'),('test','2024-05-04 23:14:29','A bid has been placed above your bid for Auction: newuser23'),('user123','2024-05-04 15:55:19','A bid has been placed above your bid for Auction: hi12310'),('user123','2024-05-04 15:40:59','A bid has been placed above your bid for Auction: hi1233'),('user123','2024-05-02 21:50:20','Alert for available PC Part of Type: cpu and of Brand: AMD'),('user123','2024-05-02 20:07:43','Alert for available PC Part of Type: cpuand of Brand: AMD'),('user123','2024-05-04 23:07:21','You have won auction: hi12321 With Your Bid Of 270.0');
/*!40000 ALTER TABLE `alert` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auction`
--

DROP TABLE IF EXISTS `auction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auction` (
  `auction_id` varchar(10) NOT NULL,
  `initial_price` float DEFAULT NULL,
  `bidding_increment` float DEFAULT NULL,
  `closing_date_time` datetime DEFAULT NULL,
  `end_user_username` varchar(20) DEFAULT NULL,
  `minimum_price` float DEFAULT NULL,
  `pc_part` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`auction_id`),
  KEY `end_user_username` (`end_user_username`),
  KEY `fk_auction_pc_part` (`pc_part`),
  CONSTRAINT `auction_ibfk_1` FOREIGN KEY (`end_user_username`) REFERENCES `end_user` (`end_user_username`),
  CONSTRAINT `fk_auction_pc_part` FOREIGN KEY (`pc_part`) REFERENCES `pc_part` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auction`
--

LOCK TABLES `auction` WRITE;
/*!40000 ALTER TABLE `auction` DISABLE KEYS */;
INSERT INTO `auction` VALUES ('1',1,1,'2024-04-26 14:30:00','alex123',1,'1'),('alex1232',100,5,'2024-08-23 13:30:30','alex123',200,'alex1235'),('alex1236',500,5,'2024-05-02 21:52:04','alex123',600,'alex1239'),('alex1238',300,5,'2024-05-03 11:45:13','alex123',350,'alex12311'),('hi12310',100,5,'2024-05-10 11:34:18','hi123',120,'hi12313'),('hi12321',200,3,'2024-05-04 23:07:17','hi123',250,'hi12324'),('hi1233',500,1,'2025-03-15 02:30:30','hi123',600,'hi1236'),('hi1234',300,5,'2024-05-23 14:30:00','hi123',400,'hi1237'),('matt12325',500,3,'2024-06-20 10:00:00','matt123',600,'matt12328'),('newuser14',200,2,'2024-05-04 22:31:30','newuser',250,'newuser17'),('newuser15',200,2,'2024-05-04 22:38:56','newuser',250,'newuser18'),('newuser16',300,3,'2024-08-03 14:30:00','newuser',50,'newuser19'),('newuser17',300,30,'2024-08-23 13:30:30','newuser',30,'newuser20'),('newuser18',200,3,'2024-05-04 22:55:53','newuser',250,'newuser21'),('newuser20',200,3,'2024-05-04 22:56:46','newuser',250,'newuser23'),('newuser22',200,3,'2024-05-04 23:13:00','newuser',250,'newuser25'),('newuser23',200,3,'2024-05-04 23:15:13','newuser',250,'newuser26'),('newuser24',200,5,'2024-05-04 23:15:13','newuser',250,'newuser27'),('user1231',5,6,'2024-05-23 14:30:00','user123',1,'user1234'),('user12311',100,2,'2024-06-03 10:10:10','user123',120,'user12314'),('user12312',100,2,'2024-08-15 10:04:30','user123',150,'user12315'),('user12313',100,5,'2024-06-20 10:00:00','user123',120,'user12316'),('user1235',100,2,'2024-05-02 21:44:10','user123',400,'user1238'),('user1237',100,5,'2024-05-03 11:34:18','user123',200,'user12310'),('user1239',100,10,'2024-05-03 11:46:19','user123',120,'user12312');
/*!40000 ALTER TABLE `auction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auto_bid`
--

DROP TABLE IF EXISTS `auto_bid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auto_bid` (
  `end_user_username` varchar(20) NOT NULL,
  `auction_id` varchar(10) NOT NULL,
  `upper_limit` float DEFAULT NULL,
  PRIMARY KEY (`end_user_username`,`auction_id`),
  KEY `auction_id` (`auction_id`),
  CONSTRAINT `auto_bid_ibfk_1` FOREIGN KEY (`end_user_username`) REFERENCES `end_user` (`end_user_username`),
  CONSTRAINT `auto_bid_ibfk_2` FOREIGN KEY (`auction_id`) REFERENCES `auction` (`auction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auto_bid`
--

LOCK TABLES `auto_bid` WRITE;
/*!40000 ALTER TABLE `auto_bid` DISABLE KEYS */;
INSERT INTO `auto_bid` VALUES ('alex123','hi12310',150),('alex123','hi1233',400),('hi123','alex1232',400),('newuser','user12312',250),('newuser','user12313',130),('user123','alex1232',400);
/*!40000 ALTER TABLE `auto_bid` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bid`
--

DROP TABLE IF EXISTS `bid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bid` (
  `end_user_username` varchar(20) NOT NULL,
  `auction_id` varchar(10) NOT NULL,
  `bid_amount` float DEFAULT NULL,
  `bid_date_time` datetime NOT NULL,
  PRIMARY KEY (`end_user_username`,`auction_id`,`bid_date_time`),
  KEY `auction_id` (`auction_id`),
  CONSTRAINT `bid_ibfk_1` FOREIGN KEY (`end_user_username`) REFERENCES `end_user` (`end_user_username`),
  CONSTRAINT `bid_ibfk_2` FOREIGN KEY (`auction_id`) REFERENCES `auction` (`auction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bid`
--

LOCK TABLES `bid` WRITE;
/*!40000 ALTER TABLE `bid` DISABLE KEYS */;
INSERT INTO `bid` VALUES ('alex123','hi1233',502,'2024-05-04 15:40:59'),('alex123','hi1234',305,'2024-05-04 15:43:44'),('alex123','user12311',104.01,'2024-05-04 15:48:46'),('alex123','user1235',102,'2024-05-02 21:42:49'),('alex123','user1237',105,'2024-05-03 11:32:52'),('hi123','alex1232',110,'2024-05-03 18:23:42'),('hi123','alex1236',510.01,'2024-05-02 21:51:06'),('hi123','newuser15',202,'2024-05-04 22:37:56'),('hi123','user12311',102,'2024-05-04 15:48:31'),('hi123','user1235',105,'2024-05-02 21:43:14'),('hi123','user1237',110,'2024-05-03 11:33:02'),('hi123','user1239',130,'2024-05-03 11:44:56'),('matt123','alex1236',505,'2024-05-02 21:50:51'),('matt123','newuser15',204,'2024-05-04 22:38:14'),('matt123','newuser18',206,'2024-05-04 22:55:51'),('matt123','newuser18',270,'2024-05-04 22:55:59'),('matt123','newuser23',270,'2024-05-04 23:14:29'),('matt123','user12312',120,'2024-05-04 23:18:17'),('matt123','user12313',150,'2024-05-04 23:18:54'),('newuser','user12312',122,'2024-05-04 23:18:17'),('test','newuser18',203,'2024-05-04 22:55:37'),('test','newuser20',230,'2024-05-04 22:56:33'),('test','newuser23',260,'2024-05-04 23:14:08'),('user123','1',2,'2024-04-29 19:40:40'),('user123','alex1232',105,'2024-05-03 18:23:42'),('user123','alex1238',305,'2024-05-03 11:43:44'),('user123','hi12310',105,'2024-05-04 15:45:40'),('user123','hi12310',160,'2024-05-04 15:55:19'),('user123','hi12321',270,'2024-05-04 23:05:49'),('user123','hi1233',501,'2024-05-04 15:40:11'),('user123','user1231',11,'2024-04-28 23:42:34'),('user123','user1231',17,'2024-04-28 23:47:45'),('user123','user1231',23,'2024-04-28 23:53:33');
/*!40000 ALTER TABLE `bid` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_representative`
--

DROP TABLE IF EXISTS `customer_representative`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_representative` (
  `customer_rep_username` varchar(20) NOT NULL,
  `admin_username` varchar(20) DEFAULT NULL,
  `customer_rep_password` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`customer_rep_username`),
  KEY `admin_username` (`admin_username`),
  CONSTRAINT `customer_representative_ibfk_1` FOREIGN KEY (`admin_username`) REFERENCES `admin` (`admin_username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_representative`
--

LOCK TABLES `customer_representative` WRITE;
/*!40000 ALTER TABLE `customer_representative` DISABLE KEYS */;
INSERT INTO `customer_representative` VALUES ('bungus','admin123','pass'),('custrep123','admin123','pass123'),('newrep123','admin123','pass123');
/*!40000 ALTER TABLE `customer_representative` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `end_user`
--

DROP TABLE IF EXISTS `end_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `end_user` (
  `end_user_username` varchar(20) NOT NULL,
  `end_user_password` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`end_user_username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `end_user`
--

LOCK TABLES `end_user` WRITE;
/*!40000 ALTER TABLE `end_user` DISABLE KEYS */;
INSERT INTO `end_user` VALUES ('alex123','pass123'),('hi123','pass123'),('matt123','pass123'),('newuser','pass123'),('test','pass123'),('user123','pass123');
/*!40000 ALTER TABLE `end_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_alert`
--

DROP TABLE IF EXISTS `item_alert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item_alert` (
  `end_user_username` varchar(20) NOT NULL,
  `pc_part_type` varchar(15) NOT NULL,
  `pc_part_brand` varchar(10) NOT NULL,
  PRIMARY KEY (`end_user_username`,`pc_part_type`,`pc_part_brand`),
  CONSTRAINT `item_alert_ibfk_1` FOREIGN KEY (`end_user_username`) REFERENCES `end_user` (`end_user_username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_alert`
--

LOCK TABLES `item_alert` WRITE;
/*!40000 ALTER TABLE `item_alert` DISABLE KEYS */;
INSERT INTO `item_alert` VALUES ('newuser','hdd','Intel'),('user123','',''),('user123','cpu','AMD');
/*!40000 ALTER TABLE `item_alert` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pc_part`
--

DROP TABLE IF EXISTS `pc_part`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pc_part` (
  `item_id` varchar(20) NOT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `brand` enum('Intel','AMD','Nvidia','AMD Radeon','Other') DEFAULT NULL,
  `cpu_clock_speed` float DEFAULT NULL,
  `cpu_cores` int DEFAULT NULL,
  `cpu_threads` int DEFAULT NULL,
  `ram_ddr` int DEFAULT NULL,
  `ram_size` int DEFAULT NULL,
  `motherboard_socket` varchar(20) DEFAULT NULL,
  `gpu_vram` int DEFAULT NULL,
  `gpu_clockspeed` float DEFAULT NULL,
  `psu_certification` varchar(20) DEFAULT NULL,
  `psu_watts` int DEFAULT NULL,
  `hdd_rpm` int DEFAULT NULL,
  `hdd_size` int DEFAULT NULL,
  `ssd_size` int DEFAULT NULL,
  `ssd_speed` int DEFAULT NULL,
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pc_part`
--

LOCK TABLES `pc_part` WRITE;
/*!40000 ALTER TABLE `pc_part` DISABLE KEYS */;
INSERT INTO `pc_part` VALUES ('1',1,'AMD',1,1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('2',0,'AMD',1,1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('alex12311',1,'Nvidia',5,5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('alex1235',0,'AMD',NULL,NULL,NULL,NULL,NULL,NULL,100,100,NULL,NULL,NULL,NULL,NULL,NULL),('alex1239',1,'AMD',500,500,500,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('hi12313',0,'AMD',NULL,NULL,NULL,5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('hi12324',1,'Intel',500,500,500,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('hi1236',0,'Nvidia',NULL,NULL,NULL,NULL,NULL,NULL,100,100,NULL,NULL,NULL,NULL,NULL,NULL),('hi1237',0,'AMD',100,200,300,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('matt12328',0,'Intel',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,30,30,NULL,NULL),('newuser17',1,'AMD',500,500,500,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('newuser18',1,'Intel',500,500,500,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('newuser19',0,'Intel',300,300,300,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('newuser20',0,'AMD',NULL,NULL,NULL,NULL,NULL,NULL,30,30,NULL,NULL,NULL,NULL,NULL,NULL),('newuser21',1,'Intel',500,500,500,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('newuser22',0,'AMD',NULL,NULL,NULL,NULL,NULL,NULL,200,200,NULL,NULL,NULL,NULL,NULL,NULL),('newuser23',1,'AMD',NULL,NULL,NULL,200,3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('newuser25',1,'Intel',500,500,500,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('newuser26',1,'Intel',500,500,500,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('newuser27',1,'AMD',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,30,50,NULL,NULL),('user12310',1,'Intel',NULL,NULL,NULL,500,32,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('user12312',1,'AMD',NULL,NULL,NULL,NULL,NULL,NULL,100,100,NULL,NULL,NULL,NULL,NULL,NULL),('user12314',0,'AMD',NULL,NULL,NULL,NULL,NULL,'idk',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('user12315',0,'AMD',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,20,30),('user12316',0,'Intel',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,30,40,NULL,NULL),('user1232',0,'AMD',5,5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('user1233',0,'AMD',5,5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('user1234',0,'AMD',5,5,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('user1238',1,'Intel',100,100,100,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `pc_part` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rep_message`
--

DROP TABLE IF EXISTS `rep_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rep_message` (
  `message_id` varchar(10) NOT NULL,
  `end_user_username` varchar(20) DEFAULT NULL,
  `customer_rep_username` varchar(20) DEFAULT NULL,
  `message_text` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`message_id`),
  KEY `end_user_username` (`end_user_username`),
  KEY `customer_rep_username` (`customer_rep_username`),
  CONSTRAINT `rep_message_ibfk_1` FOREIGN KEY (`end_user_username`) REFERENCES `end_user` (`end_user_username`),
  CONSTRAINT `rep_message_ibfk_2` FOREIGN KEY (`customer_rep_username`) REFERENCES `customer_representative` (`customer_rep_username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rep_message`
--

LOCK TABLES `rep_message` WRITE;
/*!40000 ALTER TABLE `rep_message` DISABLE KEYS */;
INSERT INTO `rep_message` VALUES ('alex1231','alex123','custrep123','hello'),('hi1232','hi123','newrep123','work pls'),('newuser3','newuser','newrep123','This is a new message'),('user1230','user123','custrep123','hi');
/*!40000 ALTER TABLE `rep_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salesreport`
--

DROP TABLE IF EXISTS `salesreport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salesreport` (
  `admin_username` varchar(20) DEFAULT NULL,
  `report_id` varchar(10) NOT NULL,
  `total_earnings` float DEFAULT NULL,
  PRIMARY KEY (`report_id`),
  KEY `admin_username` (`admin_username`),
  CONSTRAINT `salesreport_ibfk_1` FOREIGN KEY (`admin_username`) REFERENCES `admin` (`admin_username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salesreport`
--

LOCK TABLES `salesreport` WRITE;
/*!40000 ALTER TABLE `salesreport` DISABLE KEYS */;
/*!40000 ALTER TABLE `salesreport` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-05  1:38:27
