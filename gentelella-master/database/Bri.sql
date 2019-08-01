CREATE DATABASE  IF NOT EXISTS `capstone` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */;
USE `capstone`;
-- MySQL dump 10.13  Distrib 8.0.13, for Win64 (x86_64)
--
-- Host: localhost    Database: capstone
-- ------------------------------------------------------
-- Server version	8.0.13

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `activity_evidences`
--

DROP TABLE IF EXISTS `activity_evidences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `activity_evidences` (
  `activityID` int(11) NOT NULL,
  `documentID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity_evidences`
--

LOCK TABLES `activity_evidences` WRITE;
/*!40000 ALTER TABLE `activity_evidences` DISABLE KEYS */;
INSERT INTO `activity_evidences` VALUES (1,1),(1,4),(1,3),(1,5),(1,2),(2,6),(1,7),(1,13),(1,20),(1,18),(1,10),(1,11),(1,16),(1,21),(1,17),(1,15),(1,14),(1,12),(1,22),(1,19),(1,9),(1,8),(2,27),(2,23),(2,38),(2,26),(2,31),(2,36),(2,24),(2,30),(2,29),(2,45),(2,28),(2,40),(2,25),(2,35),(2,34),(2,42),(2,46),(2,44),(2,41),(2,43),(2,32),(2,37),(2,39),(2,33),(3,47),(3,50),(3,48),(3,49),(3,53),(3,71),(3,54),(3,63),(3,51),(3,73),(3,52),(3,55),(3,74),(3,64),(3,61),(3,66),(3,60),(3,76),(3,79),(3,82),(3,62),(3,67),(3,80),(3,58),(3,93),(3,83),(3,78),(3,90),(3,84),(3,65),(3,97),(3,92),(3,88),(3,94),(3,68),(3,87),(3,75),(3,89),(3,57),(3,70),(3,91),(3,85),(3,86),(3,103),(3,98),(3,96),(3,102),(3,105),(3,99),(3,69),(3,110),(3,56),(3,77),(3,112),(3,109),(3,81),(3,95),(3,104),(3,114),(3,72),(3,59),(3,117),(3,101),(3,111),(3,123),(3,121),(3,115),(3,133),(3,125),(3,126),(3,107),(3,124),(3,127),(3,122),(3,106),(3,134),(3,113),(3,132),(3,128),(3,118),(3,119),(3,142),(3,144),(3,120),(3,143),(3,136),(3,116),(3,131),(3,138),(3,135),(3,140),(3,139),(3,159),(3,137),(3,130),(3,129),(3,141),(3,145),(3,149),(3,155),(3,156),(3,100),(3,146),(3,108),(3,151),(3,161),(3,158),(3,148),(3,147),(3,160),(3,157),(3,152),(3,163),(3,153),(3,162),(3,150),(3,164),(3,171),(3,154),(3,166),(3,165),(3,174),(3,168),(3,176),(3,178),(3,170),(3,175),(3,172),(3,192),(3,177),(3,173),(3,188),(3,169),(3,194),(3,167),(3,182),(3,186),(3,183),(3,198),(3,187),(3,189),(3,181),(3,184),(3,180),(3,193),(3,196),(3,199),(3,179),(3,191),(3,190),(3,200),(3,197),(3,185),(3,195);
/*!40000 ALTER TABLE `activity_evidences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `approved_activities`
--

DROP TABLE IF EXISTS `approved_activities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `approved_activities` (
  `activity_ID` int(11) NOT NULL AUTO_INCREMENT,
  `activity_name` varchar(45) NOT NULL,
  `target` int(11) NOT NULL,
  `code` tinyint(1) NOT NULL,
  `description` mediumtext,
  `measurement_ID` int(11) NOT NULL,
  `current_Score` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`activity_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `approved_activities`
--

LOCK TABLES `approved_activities` WRITE;
/*!40000 ALTER TABLE `approved_activities` DISABLE KEYS */;
INSERT INTO `approved_activities` VALUES (1,'123',23,1,'test count',1,12),(2,'123',100,0,'test check',1,100),(3,'123',100,0,'234',1,0),(4,'123',12,1,'234',1,0),(5,'123',100,0,'234',1,0),(6,'123',12,1,'234',1,0),(7,'test',10,1,'test description',2,5),(8,'test 2',15,0,'test description number 2',2,7),(9,'Atesting new measure',50,1,'testing new measure',3,25),(10,'testing new measure part two',60,1,'testing new measure part 2',4,33);
/*!40000 ALTER TABLE `approved_activities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `area`
--

DROP TABLE IF EXISTS `area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `area` (
  `Area_ID` int(11) NOT NULL,
  `Area_Name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Area_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `area`
--

LOCK TABLES `area` WRITE;
/*!40000 ALTER TABLE `area` DISABLE KEYS */;
INSERT INTO `area` VALUES (1,'Purposes and Objectives'),(2,'Faculty'),(3,'Instruction'),(4,'Library'),(5,'Laboratories'),(6,'Physial Plan'),(7,'Student Services'),(8,'Administration'),(9,'School and Community');
/*!40000 ALTER TABLE `area` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `audit_activities`
--

DROP TABLE IF EXISTS `audit_activities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `audit_activities` (
  `audit_ID` int(11) NOT NULL AUTO_INCREMENT,
  `activity_ID` int(11) NOT NULL,
  `activity_name` varchar(45) NOT NULL,
  `target` int(11) NOT NULL,
  `code` tinyint(1) NOT NULL,
  `description` mediumtext,
  `measurement_ID` int(11) NOT NULL,
  `current_Score` int(11) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`audit_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit_activities`
--

LOCK TABLES `audit_activities` WRITE;
/*!40000 ALTER TABLE `audit_activities` DISABLE KEYS */;
INSERT INTO `audit_activities` VALUES (1,2,'123',100,0,'test check',7,100,1),(2,1,'123',23,1,'test count',7,12,1);
/*!40000 ALTER TABLE `audit_activities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cycle`
--

DROP TABLE IF EXISTS `cycle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `cycle` (
  `cycle_ID` int(11) NOT NULL AUTO_INCREMENT,
  `cycle_Name` varchar(45) NOT NULL,
  `start_Date` date NOT NULL,
  `end_Date` date NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`cycle_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cycle`
--

LOCK TABLES `cycle` WRITE;
/*!40000 ALTER TABLE `cycle` DISABLE KEYS */;
INSERT INTO `cycle` VALUES (0,'No Assigned ','0000-00-00','0000-00-00',3),(10,'TEST CYCLE INSERT','2019-09-05','2019-10-17',1);
/*!40000 ALTER TABLE `cycle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documents`
--

DROP TABLE IF EXISTS `documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `documents` (
  `Document_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Document_Name` varchar(45) NOT NULL,
  `Document_Route` text NOT NULL,
  `Document_Desc` varchar(300) DEFAULT 'No Description Given.',
  `Document_Ext` varchar(45) NOT NULL,
  `InDrive` tinyint(1) NOT NULL DEFAULT '0',
  `DriveID` varchar(40) DEFAULT '0',
  PRIMARY KEY (`Document_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=201 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documents`
--

LOCK TABLES `documents` WRITE;
/*!40000 ALTER TABLE `documents` DISABLE KEYS */;
INSERT INTO `documents` VALUES (1,'07-01-01-03-33-2019.jpg','uploads/07-01-01-03-33-2019.jpg',NULL,'.jpg',1,'1YIPnIt9uKFkxmV2tgL2NqkWUfpTFQw_I'),(2,'07-01-01-04-22-2019.jpg','uploads/07-01-01-04-22-2019.jpg',NULL,'.jpg',1,'1bL7GqpbGe2tdvVA6P5JNOslcTH4b7Ffw'),(3,'05-23-00-49-53-2019.jpg','uploads/05-23-00-49-53-2019.jpg',NULL,'.jpg',1,'1sP80l4w_zuSoMlq6i_saVVrG46xOEwqn'),(4,'07-01-01-04-34-2019.jpg','uploads/07-01-01-04-34-2019.jpg',NULL,'.jpg',1,'1UsXVtBHlgoWmCmepX13G8N1vfKhHVDaj'),(5,'07-01-01-03-39-2019.jpg','uploads/07-01-01-03-39-2019.jpg',NULL,'.jpg',1,'1oacWnyrF9RZK-n3thdfsAyNgCXZrEUKr'),(6,'07-06-22-30-12-2019.png','uploads/07-06-22-30-12-2019.png',NULL,'.png',1,'1Xd5nyM2qPQbyJp_Mjs8VDpuuviQWPBYz'),(7,'05-01-16-25-11-2019.png','uploads/05-01-16-25-11-2019.png',NULL,'.png',1,'1gV_wfjWypP9gc-c_tGOvJ4FCEcW7-bcv'),(8,'05-01-15-11-30-2019.jpg','uploads/05-01-15-11-30-2019.jpg',NULL,'.jpg',1,'1n2-OPOHWL1sX_pm4_H7-Cw-3X8j9Xh2m'),(9,'05-01-15-13-07-2019.png','uploads/05-01-15-13-07-2019.png',NULL,'.png',1,'1eootI3jz0jVbATM-R_YDLU_CuBqGQcqB'),(10,'05-01-14-13-49-2019.jpg','uploads/05-01-14-13-49-2019.jpg',NULL,'.jpg',1,'1rt3hJfMvu0H0j5x72tZeVJ-Md6AGg45L'),(11,'05-01-16-12-29-2019.png','uploads/05-01-16-12-29-2019.png',NULL,'.png',1,'1njUqReSWhY6abr2PZeBvCE3mGVFcZnQA'),(12,'05-01-15-12-11-2019.jpg','uploads/05-01-15-12-11-2019.jpg',NULL,'.jpg',1,'1B50DOPS55iilAYwYzDLsrCPXQlkynq-n'),(13,'05-01-15-31-10-2019.png','uploads/05-01-15-31-10-2019.png',NULL,'.png',1,'19LGw2Mm2i9TCvPcOYptjwC45VqTGRmXD'),(14,'05-01-14-32-34-2019.jpg','uploads/05-01-14-32-34-2019.jpg',NULL,'.jpg',1,'10BHjuVlW6q5Vgf_YkNuH9btuXB0y2tJC'),(15,'05-01-16-11-23-2019.png','uploads/05-01-16-11-23-2019.png',NULL,'.png',1,'1WYq2R_AYQu53Mkh29I9oNjoOpe5zZI93'),(16,'05-01-14-31-07-2019.png','uploads/05-01-14-31-07-2019.png',NULL,'.png',1,'1ilwbPCID-HoQxeXMTbs0P_OBOCWF69rV'),(17,'05-01-16-13-16-2019.png','uploads/05-01-16-13-16-2019.png',NULL,'.png',1,'1TEUWSrdyTQcKwuS_insRTpxtz_YiVOZO'),(18,'05-01-14-12-35-2019.png','uploads/05-01-14-12-35-2019.png',NULL,'.png',1,'1pMjGThbpx4srphaqYTbnN-2gQrZNbG4_'),(19,'05-01-15-19-33-2019.png','uploads/05-01-15-19-33-2019.png',NULL,'.png',1,'19eIkr4poKYN9TMGagUmhZxn2Uu9q8ze7'),(20,'05-01-14-22-22-2019.jpg','uploads/05-01-14-22-22-2019.jpg',NULL,'.jpg',1,'1Hu0KA3mW6m0wZgGzmPGPOR_SWOx4AXaN'),(21,'05-01-16-04-08-2019.png','uploads/05-01-16-04-08-2019.png',NULL,'.png',1,'1R82TQBeIEisrghOMkIWP5HSybpnToSnv'),(22,'05-01-14-13-46-2019.jpg','uploads/05-01-14-13-46-2019.jpg',NULL,'.jpg',1,'1KFdUx-UQKJIE2IeH9nFzgV4UDzcDhXmm'),(23,'05-05-16-05-37-2019.jpg','uploads/05-05-16-05-37-2019.jpg',NULL,'.jpg',1,'1lMraIYAl_zFU2lzHjGNK9ATphxL4Rqsy'),(24,'05-05-16-07-39-2019.jpg','uploads/05-05-16-07-39-2019.jpg',NULL,'.jpg',1,'1vdeaaRmpQ_ZVPjsisCWmxyz4_Vqi8nLC'),(25,'05-05-16-07-38-2019.jpg','uploads/05-05-16-07-38-2019.jpg',NULL,'.jpg',1,'1kKpEB_ifZnMZ-Ym-STF3Y9eX6Vg8OhhT'),(26,'05-05-16-07-42-2019.jpg','uploads/05-05-16-07-42-2019.jpg',NULL,'.jpg',1,'1_-a46D5ziqFv-C1M5iB96hCjQSnMtdEZ'),(27,'05-05-16-07-46-2019.jpg','uploads/05-05-16-07-46-2019.jpg',NULL,'.jpg',1,'14-TTe_v_zM68MY2FO-IrPQ6rMf2w3WBv'),(28,'05-05-16-15-40-2019.png','uploads/05-05-16-15-40-2019.png',NULL,'.png',1,'1Zrul2AXHaW4dmJ3h6ExhZjI3nBT15TMm'),(29,'05-05-16-19-03-2019.jpg','uploads/05-05-16-19-03-2019.jpg',NULL,'.jpg',1,'1PegulItFNPepB2A0wiH9Kwnh1sKdsku4'),(30,'05-05-16-19-09-2019.jpg','uploads/05-05-16-19-09-2019.jpg',NULL,'.jpg',1,'1_TgeWgAr7NlQinwrY3bylO_ZVRLgFbR3'),(31,'05-05-16-20-47-2019.jpg','uploads/05-05-16-20-47-2019.jpg',NULL,'.jpg',1,'118AIjVpa4ZQvy0o1ER6uW7K0IzMh5TzT'),(32,'05-05-16-20-44-2019.jpg','uploads/05-05-16-20-44-2019.jpg',NULL,'.jpg',1,'1up_I9MeO3rkiQ4vR-X0Z5DW84OJrQ6y1'),(33,'05-05-16-20-49-2019.jpg','uploads/05-05-16-20-49-2019.jpg',NULL,'.jpg',1,'1fWU-hsIpd4NDpxMsE9m5TFsc0jkA51Hu'),(34,'05-05-16-20-53-2019.jpg','uploads/05-05-16-20-53-2019.jpg',NULL,'.jpg',1,'1EU_hi42sf_2VPlYgIxqq0K_StgIRiReX'),(35,'05-05-16-21-38-2019.jpg','uploads/05-05-16-21-38-2019.jpg',NULL,'.jpg',1,'1PfPdcofmIi1hcEciiIOzuipB_dJVVAGF'),(36,'05-05-16-21-33-2019.jpg','uploads/05-05-16-21-33-2019.jpg',NULL,'.jpg',1,'1tSUQhIUG35sdqUaQl0m7AJDzXTQiy26E'),(37,'05-05-16-21-40-2019.jpg','uploads/05-05-16-21-40-2019.jpg',NULL,'.jpg',1,'1Dz60J6tX6-RHr6FHRNGVGv06GStQjOzi'),(38,'05-05-16-21-42-2019.jpg','uploads/05-05-16-21-42-2019.jpg',NULL,'.jpg',1,'1OZE2b9w0LTJQgNTej28lEz3t1robLKm9'),(39,'05-05-16-29-13-2019.png','uploads/05-05-16-29-13-2019.png',NULL,'.png',1,'13NwNeB4AdKhomVYQAH91MoRx0CAo9PyB'),(40,'05-05-16-29-31-2019.png','uploads/05-05-16-29-31-2019.png',NULL,'.png',1,'1xvlXe2UkNUMPY-rePhydpKfSExYuO3xi'),(41,'05-05-16-30-57-2019.png','uploads/05-05-16-30-57-2019.png',NULL,'.png',1,'1SbqySE6B7U5xqOZRyP_zdmGMl2fBvzDC'),(42,'05-05-16-31-01-2019.jpg','uploads/05-05-16-31-01-2019.jpg',NULL,'.jpg',1,'1kFHGkI6PX28BcsL-7lZAfSKGZJBy-dKZ'),(43,'05-05-20-06-21-2019.png','uploads/05-05-20-06-21-2019.png',NULL,'.png',1,'1712FP5bQLL6UylmJCLqYglrBGBFkNE93'),(44,'05-05-21-06-39-2019.jpg','uploads/05-05-21-06-39-2019.jpg',NULL,'.jpg',1,'11ZUpUifDx1udGSPD02LC5fB4mDRUfqEI'),(45,'05-05-21-49-02-2019.png','uploads/05-05-21-49-02-2019.png',NULL,'.png',1,'1zVxLRcmPC0O5rj5_OH4UJuCvhajtMONi'),(46,'05-05-21-09-05-2019.jpg','uploads/05-05-21-09-05-2019.jpg',NULL,'.jpg',1,'1E0nOu500Yrww0462hSmvTCA5U0Bd7LhW'),(47,'04-19-04-35-15-2019.jpg','uploads/04-19-04-35-15-2019.jpg',NULL,'.jpg',1,'1_DMbY4-ISu0FcdatwDbAQ33TZgoELTcL'),(48,'04-19-04-39-33-2019.png','uploads/04-19-04-39-33-2019.png',NULL,'.png',1,'1KyDWn7zSaNoEXFTkoX0fr3kBkysAauJs'),(49,'04-19-04-40-40-2019.png','uploads/04-19-04-40-40-2019.png',NULL,'.png',1,'1Vl-Jwp056I6tK_4TiKQ375JqdTd7cp8J'),(50,'04-19-04-46-11-2019.png','uploads/04-19-04-46-11-2019.png',NULL,'.png',1,'1hWTd7bhX5v-7N_b4yHwoTCaOQjiFlXGW'),(51,'04-19-04-46-21-2019.png','uploads/04-19-04-46-21-2019.png',NULL,'.png',1,'1czAzUHK2Ht-5qSEC52tGho5khCJtNttb'),(52,'04-19-04-47-42-2019.png','uploads/04-19-04-47-42-2019.png',NULL,'.png',1,'1oJZNkheNKh_bs44XCkAYy4ybE71uu44U'),(53,'04-19-05-08-09-2019.jpg','uploads/04-19-05-08-09-2019.jpg',NULL,'.jpg',1,'1DmmidLKsbBiCODOu8DshY2RITVcqK7tY'),(54,'04-19-05-20-00-2019.png','uploads/04-19-05-20-00-2019.png',NULL,'.png',1,'1JZ0N3qWpfUbfv82tlfD_SMBoEF7TVRhM'),(55,'04-19-05-25-11-2019.png','uploads/04-19-05-25-11-2019.png',NULL,'.png',1,'13TtdLBES_VvwSVqhz0b-PYfLRLrklR5R'),(56,'04-19-05-29-45-2019.jpg','uploads/04-19-05-29-45-2019.jpg',NULL,'.jpg',1,'1PzYmYn3C1OwI5O40XGdl8-ilrCA_TqVN'),(57,'04-19-05-32-38-2019.png','uploads/04-19-05-32-38-2019.png',NULL,'.png',1,'1fPFuPbcohA5jK4RrHS1oGu-U0dlLnl0d'),(58,'04-19-06-06-47-2019.jpg','uploads/04-19-06-06-47-2019.jpg',NULL,'.jpg',1,'1yeRZm1koFQKuC2VR4gct9ruTrVVTVWbU'),(59,'04-19-06-10-58-2019.png','uploads/04-19-06-10-58-2019.png',NULL,'.png',1,'1yaqsyJ5kbGibPeIRwX50d0cQurURMcKR'),(60,'04-19-06-19-39-2019.jpg','uploads/04-19-06-19-39-2019.jpg',NULL,'.jpg',1,'1pv85w_M5GIKsMWQPo64IQ--4FvAn_riZ'),(61,'04-19-06-31-58-2019.png','uploads/04-19-06-31-58-2019.png',NULL,'.png',1,'1mI7JwQ9j84cid8P73dpvJ8aKu_WDkrGK'),(62,'04-19-06-34-46-2019.jpg','uploads/04-19-06-34-46-2019.jpg',NULL,'.jpg',1,'16P9f-kWq9nPYFgRNao8OHQ44_iRJhpU8'),(63,'04-19-06-36-49-2019.png','uploads/04-19-06-36-49-2019.png',NULL,'.png',1,'1_4tqAzy-Ks8hBDDhW_fW43WzOsOibhvk'),(64,'04-20-05-50-55-2019.png','uploads/04-20-05-50-55-2019.png',NULL,'.png',1,'12FbZqQ02rO6TXa1iLcamHV426QWuN62C'),(65,'04-20-05-54-29-2019.png','uploads/04-20-05-54-29-2019.png',NULL,'.png',1,'18LCckSm-2XD0RXtMwcN6NaTjCkAs0xQt'),(66,'04-20-05-59-37-2019.png','uploads/04-20-05-59-37-2019.png',NULL,'.png',1,'1xnAR6Jw4f-kIYjjEs6KUDY9dMSoWQ8NV'),(67,'04-20-05-59-45-2019.png','uploads/04-20-05-59-45-2019.png',NULL,'.png',1,'14hdTpBqvHgnm42KEGf63mLsx4aaejwsP'),(68,'04-20-06-04-32-2019.jpg','uploads/04-20-06-04-32-2019.jpg',NULL,'.jpg',1,'1qb0CUzMAsI-fTK4toZ0gU2MM4dsNjd0c'),(69,'04-20-06-09-06-2019.png','uploads/04-20-06-09-06-2019.png',NULL,'.png',1,'1U7fYurDcV1tH3IAXObrCtSyjxj7lKwfy'),(70,'04-20-06-19-37-2019.jpg','uploads/04-20-06-19-37-2019.jpg',NULL,'.jpg',1,'1tuqPzyL8Vo4-YQ6s68xeMEx1cQ9knPdd'),(71,'04-20-06-06-30-2019.jpg','uploads/04-20-06-06-30-2019.jpg',NULL,'.jpg',1,'1sr4HhEa6BaiIVQzs7chvJ2N-9zU0IeXW'),(72,'04-20-06-23-10-2019.png','uploads/04-20-06-23-10-2019.png',NULL,'.png',1,'1ty_yiUWlnCBpXl-WAhu-GWIiLDYNWGrx'),(73,'04-20-06-23-14-2019.png','uploads/04-20-06-23-14-2019.png',NULL,'.png',1,'1uNqW7O0DQpeMrPd5ZeOBk2HpJ0HLSeO6'),(74,'04-20-06-40-03-2019.png','uploads/04-20-06-40-03-2019.png',NULL,'.png',1,'1OiJIQHrJ629x8b7MifprQ1TSfDV0xf1i'),(75,'04-20-06-44-04-2019.png','uploads/04-20-06-44-04-2019.png',NULL,'.png',1,'19J1XBvQMn0nZrSLnEzBn5sv2_npmk7Qv'),(76,'04-20-06-53-02-2019.png','uploads/04-20-06-53-02-2019.png',NULL,'.png',1,'1YBNgGeuUqi6ynSo3k_gW9xtBC0nF2Lnb'),(77,'04-20-06-54-08-2019.jpg','uploads/04-20-06-54-08-2019.jpg',NULL,'.jpg',1,'1rMJVqOoB3bgCR56wo7rsFNzbk6GzH7H5'),(78,'04-20-06-55-44-2019.png','uploads/04-20-06-55-44-2019.png',NULL,'.png',1,'1vRhIRZJHbpRYQD-J5ygrsJyegps0BLXA'),(79,'04-20-07-27-34-2019.png','uploads/04-20-07-27-34-2019.png',NULL,'.png',1,'1redRAlxBszwt3lc7jzSXExZUsGzG51oU'),(80,'04-20-07-27-43-2019.png','uploads/04-20-07-27-43-2019.png',NULL,'.png',1,'1vRPM37h3BUx0Y_XYYkNloms7Zehk6SJM'),(81,'04-20-08-13-04-2019.png','uploads/04-20-08-13-04-2019.png',NULL,'.png',1,'1e0UUlXUcTvHjrNIMRc1F2NY-vZGoC8Ke'),(82,'04-21-07-05-31-2019.png','uploads/04-21-07-05-31-2019.png',NULL,'.png',1,'1HFk75VZlnqWTM_LYmcwEbr9xPA12lZ3e'),(83,'04-21-06-58-37-2019.png','uploads/04-21-06-58-37-2019.png',NULL,'.png',1,'11uFhR05MAjsiLYKaHu66n5k8md-oHaIy'),(84,'04-21-07-04-48-2019.png','uploads/04-21-07-04-48-2019.png',NULL,'.png',1,'14Q2qmcvRlaiBqc7CLqmeSmsmiNksjKK3'),(85,'04-21-07-09-29-2019.png','uploads/04-21-07-09-29-2019.png',NULL,'.png',1,'1rpJW3FTHiAoDn4WF3oIvmg8ycCHT0gtL'),(86,'04-21-07-09-59-2019.png','uploads/04-21-07-09-59-2019.png',NULL,'.png',1,'15qW2-nnG-i7xS79l1UX-AV2S3Ub_XiJi'),(87,'04-21-07-11-57-2019.png','uploads/04-21-07-11-57-2019.png',NULL,'.png',1,'1lw7lvuC5k0fSZ9_1_xObeoF4nh-CzBEA'),(88,'04-21-07-13-05-2019.png','uploads/04-21-07-13-05-2019.png',NULL,'.png',1,'1dqGSzLXINtNpBFb-9cUyF2JanYivRHI1'),(89,'04-21-07-15-00-2019.jpg','uploads/04-21-07-15-00-2019.jpg',NULL,'.jpg',1,'1TFMo-ixOYvusseXffqMG8KJe7wYTY1W4'),(90,'04-21-07-33-23-2019.png','uploads/04-21-07-33-23-2019.png',NULL,'.png',1,'1pybiM495RJr_KzKCbDOeuhpjJnYlkqC0'),(91,'04-21-07-43-39-2019.png','uploads/04-21-07-43-39-2019.png',NULL,'.png',1,'1JILkq4h5vj3pXRWxXWN1EUXJwBTFEoAB'),(92,'04-21-07-44-39-2019.png','uploads/04-21-07-44-39-2019.png',NULL,'.png',1,'10tk2Mm-v6Y5WrUWdmN6TkjHCIlJbA1lF'),(93,'04-21-07-44-41-2019.png','uploads/04-21-07-44-41-2019.png',NULL,'.png',1,'13vQ3bUl40BeGpAcj3ZTFRrdKj4g4a3xn'),(94,'04-21-07-46-54-2019.png','uploads/04-21-07-46-54-2019.png',NULL,'.png',1,'1mGxSn7OqVMGivNkuqjARePNuqwEVulJG'),(95,'04-21-07-47-26-2019.png','uploads/04-21-07-47-26-2019.png',NULL,'.png',1,'1io69_zn1dxDHJQ_UTHbQ9jmOivJnGYYG'),(96,'04-21-07-47-35-2019.png','uploads/04-21-07-47-35-2019.png',NULL,'.png',1,'1qgx7M37GUP503ezpRk23c9jLMEXcuDZD'),(97,'04-21-08-11-54-2019.png','uploads/04-21-08-11-54-2019.png',NULL,'.png',1,'1blbpVRVIpSAcc-xHunVC58iPUUASIPBJ'),(98,'04-21-08-12-36-2019.png','uploads/04-21-08-12-36-2019.png',NULL,'.png',1,'1toSoJqHAwWNzYL4-npba0MIM-TsBtZXr'),(99,'04-21-08-16-27-2019.png','uploads/04-21-08-16-27-2019.png',NULL,'.png',1,'1i3NyIw4g1TcgKBdOj9N1k3_G7CPupae_'),(100,'04-21-08-14-21-2019.png','uploads/04-21-08-14-21-2019.png',NULL,'.png',1,'1HKyvnnj6QigCBQ9M6hgt4Cn3V4TvJKDL'),(101,'04-21-08-21-42-2019.jpg','uploads/04-21-08-21-42-2019.jpg',NULL,'.jpg',1,'1KQLBagrrSiFElj6my55t6E1odEmdBuHA'),(102,'04-21-08-31-29-2019.png','uploads/04-21-08-31-29-2019.png',NULL,'.png',1,'1aCmf3zspP_D7K_osrE28etl6NgLa3Ymb'),(103,'04-22-07-16-23-2019.png','uploads/04-22-07-16-23-2019.png',NULL,'.png',1,'1H7j6twxhgFDUiw_juZYFWTwMuPA73yzQ'),(104,'04-22-07-17-04-2019.png','uploads/04-22-07-17-04-2019.png',NULL,'.png',1,'1eGvJF80KK9eWveW5XIjsViEPCmTCTIKZ'),(105,'04-22-07-19-45-2019.png','uploads/04-22-07-19-45-2019.png',NULL,'.png',1,'1kp-uTrVUdLnBualsfeHEvhWLv55tuqsr'),(106,'04-22-07-28-53-2019.png','uploads/04-22-07-28-53-2019.png',NULL,'.png',1,'1gNC9sebnBWcVCIipSC4Dj3AbjdFHobD1'),(107,'04-22-08-01-04-2019.png','uploads/04-22-08-01-04-2019.png',NULL,'.png',1,'1a99fXYXAcM31hyW6FicfLwB0ZhJ6Ch4I'),(108,'04-22-08-06-11-2019.jpg','uploads/04-22-08-06-11-2019.jpg',NULL,'.jpg',1,'1HFqzvtxrxa3SPRTi1o02Cx_o2881FC0L'),(109,'04-22-08-07-04-2019.png','uploads/04-22-08-07-04-2019.png',NULL,'.png',1,'1EAnLegPGevodRfS4LBgBcCHjcxSQr79A'),(110,'04-22-08-07-21-2019.png','uploads/04-22-08-07-21-2019.png',NULL,'.png',1,'1m9scGDe-TKnm4__oL0eyLIMOy6IIUzNU'),(111,'04-22-08-07-41-2019.png','uploads/04-22-08-07-41-2019.png',NULL,'.png',1,'1EXyFFBFyUB54ay72vgVhlSNSJ7SpSTEs'),(112,'04-22-08-10-07-2019.png','uploads/04-22-08-10-07-2019.png',NULL,'.png',1,'1JEVko8-sscRt_T_hUC7CNw5eOCaytfFD'),(113,'04-22-08-11-43-2019.jpg','uploads/04-22-08-11-43-2019.jpg',NULL,'.jpg',1,'1fFuaPcG_-D9uqPrpLO0-wgp-pNHdeGo7'),(114,'04-22-08-25-15-2019.jpg','uploads/04-22-08-25-15-2019.jpg',NULL,'.jpg',1,'10tCLoygBkTB4v3ehArpdrlPDE5-O_d58'),(115,'04-22-08-13-15-2019.jpg','uploads/04-22-08-13-15-2019.jpg',NULL,'.jpg',1,'1vIgucr0eAk8cG0W-MrSL9xxlR6646cIi'),(116,'04-22-08-13-55-2019.jpg','uploads/04-22-08-13-55-2019.jpg',NULL,'.jpg',0,'0'),(117,'04-22-08-18-08-2019.png','uploads/04-22-08-18-08-2019.png',NULL,'.png',1,'1WOYF8j98O3PZS-cCoO9CzjrzSmKzopHK'),(118,'04-22-08-18-38-2019.png','uploads/04-22-08-18-38-2019.png',NULL,'.png',1,'1dNxcQCu08wGtbw8e7fssPjTgZXmub0jY'),(119,'04-22-08-19-48-2019.png','uploads/04-22-08-19-48-2019.png',NULL,'.png',1,'1HM1_739BuhEYlj5pWJCx4sSZZGFWomaq'),(120,'04-22-08-20-52-2019.png','uploads/04-22-08-20-52-2019.png',NULL,'.png',1,'1NcoEsK3ulbv4FwkzLCHtI8dgRpcT2tjM'),(121,'04-22-08-21-13-2019.jpg','uploads/04-22-08-21-13-2019.jpg',NULL,'.jpg',1,'18rQ6A62YwXu7GeFddiXOTGvZXWMmeAjH'),(122,'04-22-08-27-08-2019.png','uploads/04-22-08-27-08-2019.png',NULL,'.png',1,'1TTPnhpnPxYYSpZDsVi0EFgkFfDkGLLVJ'),(123,'04-22-08-29-37-2019.png','uploads/04-22-08-29-37-2019.png',NULL,'.png',1,'1RdsplcxsyxLD7QiNjseCAjSrr-KFmJmv'),(124,'04-22-08-33-13-2019.png','uploads/04-22-08-33-13-2019.png',NULL,'.png',1,'1_hjWJvoRYT50uUaP-D_UqYH9nJd_4CkF'),(125,'04-22-08-34-13-2019.png','uploads/04-22-08-34-13-2019.png',NULL,'.png',1,'1PXSisSbhDC4-3wrYnOrNbDfo8rDhWgHB'),(126,'04-22-08-34-36-2019.png','uploads/04-22-08-34-36-2019.png',NULL,'.png',1,'1HUgjACAvVSYmaR15Tun16q61qKzFx6fo'),(127,'04-22-08-34-43-2019.png','uploads/04-22-08-34-43-2019.png',NULL,'.png',1,'10M1xbUeAWeOnHsEgB6wheVLD4Yx55cJX'),(128,'04-22-08-35-18-2019.png','uploads/04-22-08-35-18-2019.png',NULL,'.png',1,'1GLD4s86fzqjupPUb0OQZNj5SK84Ylewi'),(129,'04-22-08-52-31-2019.jpg','uploads/04-22-08-52-31-2019.jpg',NULL,'.jpg',1,'1d0s5CW9wCPQspzWGEpTwkk4xKFwmjcj4'),(130,'04-22-08-56-18-2019.png','uploads/04-22-08-56-18-2019.png',NULL,'.png',1,'1Kfkglft6hIutLyz6zX3Mtgt7q3RraNl7'),(131,'04-22-09-01-24-2019.png','uploads/04-22-09-01-24-2019.png',NULL,'.png',1,'1FuQR8iRma0IYD--we9_x5yfh0zBT6YP4'),(132,'04-22-09-01-29-2019.png','uploads/04-22-09-01-29-2019.png',NULL,'.png',1,'16iYP7Wb2j1R6BSIKsNoAmLKHHXgXrgIX'),(133,'04-22-09-05-11-2019.png','uploads/04-22-09-05-11-2019.png',NULL,'.png',1,'1f_Drs4QQfgxLzuZHCM9hPzMwn6sON3wh'),(134,'04-22-09-05-30-2019.png','uploads/04-22-09-05-30-2019.png',NULL,'.png',1,'1xSLwuGPItLf7kuFQBAr9WDCPUPTijehi'),(135,'04-22-09-06-53-2019.jpg','uploads/04-22-09-06-53-2019.jpg',NULL,'.jpg',1,'1jmTFB8h6ro07vVsBK8KjxCjN2CqN9ZVk'),(136,'04-22-09-12-48-2019.png','uploads/04-22-09-12-48-2019.png',NULL,'.png',1,'1xYlMGV5NcghYr0TnbOvqZgRTPPuDutYj'),(137,'04-23-09-04-50-2019.png','uploads/04-23-09-04-50-2019.png',NULL,'.png',1,'1UTw3Xtra7oegW3Zxb69tkyMypASVqUkb'),(138,'04-23-09-07-20-2019.png','uploads/04-23-09-07-20-2019.png',NULL,'.png',1,'19lq0oTMNU9WXUC2L_KcdQ9E6_Hu06cH7'),(139,'04-23-09-07-45-2019.png','uploads/04-23-09-07-45-2019.png',NULL,'.png',1,'1zZzbJWEbP9dmkmlYN53OQOuUoWYBmG_K'),(140,'04-23-09-07-47-2019.png','uploads/04-23-09-07-47-2019.png',NULL,'.png',1,'1M8K9OC9vya0YuGmDaOtkpPExmT3fA_Af'),(141,'04-23-09-07-51-2019.png','uploads/04-23-09-07-51-2019.png',NULL,'.png',1,'1hBU2BomIKWOv3rDlRSAq7GGVEZlsPjXT'),(142,'04-23-09-09-22-2019.png','uploads/04-23-09-09-22-2019.png',NULL,'.png',1,'1XjE8Pat0_UVM-D2c8Wo3dShRT7hsAHIl'),(143,'04-23-09-09-35-2019.png','uploads/04-23-09-09-35-2019.png',NULL,'.png',0,'0'),(144,'04-23-09-13-34-2019.png','uploads/04-23-09-13-34-2019.png',NULL,'.png',1,'1xdk2rD6p1SIEZnZIloRdl5YHDv6valKm'),(145,'04-23-09-13-36-2019.png','uploads/04-23-09-13-36-2019.png',NULL,'.png',1,'1aI8g8IO2hUGD11nwm67w2yiMr2mKHKYb'),(146,'04-23-09-14-59-2019.png','uploads/04-23-09-14-59-2019.png',NULL,'.png',1,'1VPyFdUcLY_xlkWRDaEJ9cCi5yp6bGgkg'),(147,'04-23-09-16-56-2019.png','uploads/04-23-09-16-56-2019.png',NULL,'.png',1,'147ha-ePpT_JH6c8yhhaI6FOQ3zH7R37z'),(148,'04-23-09-24-30-2019.png','uploads/04-23-09-24-30-2019.png',NULL,'.png',0,'0'),(149,'04-23-09-29-22-2019.png','uploads/04-23-09-29-22-2019.png',NULL,'.png',1,'1PaEVHI_NXG9RWGix9raPTp9DU2CIMyKs'),(150,'04-23-09-41-08-2019.png','uploads/04-23-09-41-08-2019.png',NULL,'.png',1,'11sUIlBTCRRBGfgHNI1Hjr8PIGLcQnwLk'),(151,'04-23-09-41-56-2019.png','uploads/04-23-09-41-56-2019.png',NULL,'.png',1,'1HK_4kqJLPYf3059hu7o2ZRqfUGG3d7-f'),(152,'04-23-09-43-50-2019.png','uploads/04-23-09-43-50-2019.png',NULL,'.png',1,'1PLD8nxZtvLWgY2oDoSG9W_v5fPB0nWkv'),(153,'04-23-09-48-10-2019.png','uploads/04-23-09-48-10-2019.png',NULL,'.png',1,'1fyXyYWFLDpyRbk0pQr8pfLutwZbZTlmz'),(154,'04-23-09-43-51-2019.png','uploads/04-23-09-43-51-2019.png',NULL,'.png',1,'1-w84uW1-qLTqXXgHIEH60digxCOP7beF'),(155,'04-23-09-48-22-2019.png','uploads/04-23-09-48-22-2019.png',NULL,'.png',1,'1o9cYjR124LA4JNmQYkH7ILZQohdD9_N2'),(156,'04-23-10-15-26-2019.png','uploads/04-23-10-15-26-2019.png',NULL,'.png',1,'1ydWuVxZ62R-Aj6Tf2J8LDYXW2RXdGif2'),(157,'04-23-10-16-20-2019.png','uploads/04-23-10-16-20-2019.png',NULL,'.png',1,'1UI5wKu2IrRDQiv45DPJKW6CzPmhhVwy7'),(158,'04-23-10-17-43-2019.png','uploads/04-23-10-17-43-2019.png',NULL,'.png',1,'1-mStA7i6_XcgJ-oUTDeWTNhKJ3ZheKdL'),(159,'04-23-10-20-56-2019.png','uploads/04-23-10-20-56-2019.png',NULL,'.png',1,'1by7y_wfah8xmp2qyaIRScBJUq_UFkxlg'),(160,'04-23-10-22-24-2019.jpg','uploads/04-23-10-22-24-2019.jpg',NULL,'.jpg',1,'1ecb0FRnOZkEATDXv5FAslzU0PhzP_AIP'),(161,'04-23-10-30-59-2019.jpg','uploads/04-23-10-30-59-2019.jpg',NULL,'.jpg',1,'1N_kW1wIKRskvTv1-tTamajC5JfS1MPaB'),(162,'04-23-10-38-25-2019.png','uploads/04-23-10-38-25-2019.png',NULL,'.png',1,'1fO4987o31U3FGDxPNH79iZneED6RMP13'),(163,'04-23-10-39-39-2019.jpg','uploads/04-23-10-39-39-2019.jpg',NULL,'.jpg',1,'1f4Y41onLHiSnUVwRIYcd6C1qJqWV4qao'),(164,'04-23-10-38-53-2019.png','uploads/04-23-10-38-53-2019.png',NULL,'.png',1,'1_wh_sugVF2kBwWzr2V5HjtIlJfn0j7EM'),(165,'04-23-10-41-41-2019.png','uploads/04-23-10-41-41-2019.png',NULL,'.png',1,'1qZJStgodaUt8NYOO3UOB4eYYa7F-BVJ4'),(166,'04-25-06-46-08-2019.png','uploads/04-25-06-46-08-2019.png',NULL,'.png',1,'1YJoOqCTDmZZ2UPZuWQHoZrbkrVetBrGg'),(167,'04-23-10-47-05-2019.png','uploads/04-23-10-47-05-2019.png',NULL,'.png',1,'1WfvIuhYqQ17xG28z_Eb3zIW_8OVzU3tL'),(168,'04-23-10-57-50-2019.png','uploads/04-23-10-57-50-2019.png',NULL,'.png',1,'1N5ou__BUkqIPco0fJlWxu8z7-vgKRaRk'),(169,'04-23-10-59-34-2019.png','uploads/04-23-10-59-34-2019.png',NULL,'.png',1,'17aYenSQYhNxyabAOTJ0Pn3yLJ0RysEik'),(170,'04-23-11-02-06-2019.png','uploads/04-23-11-02-06-2019.png',NULL,'.png',1,'11nMithmxsjLoaTFD1t_iC97oHYYEb4yP'),(171,'04-25-06-46-18-2019.png','uploads/04-25-06-46-18-2019.png',NULL,'.png',1,'1lnaXXd-ujAMl2E-HVdryH_EhWGV8LhPI'),(172,'04-25-06-53-05-2019.png','uploads/04-25-06-53-05-2019.png',NULL,'.png',1,'1uRsaKAH0hXF8CnYXAir88_5tAx1kzgzS'),(173,'04-25-06-54-37-2019.png','uploads/04-25-06-54-37-2019.png',NULL,'.png',1,'1xCc6_vDRBbjZjw-rNtnagoXI7Ml-donC'),(174,'04-25-06-54-52-2019.jpg','uploads/04-25-06-54-52-2019.jpg',NULL,'.jpg',1,'13KFD_1kCFqVlAnW9PkipGwBVa9dFwjW4'),(175,'04-25-07-14-17-2019.png','uploads/04-25-07-14-17-2019.png',NULL,'.png',1,'1FyCekeHlVUeQOOUb5j73uCv4FLb-qWcr'),(176,'04-25-07-15-02-2019.png','uploads/04-25-07-15-02-2019.png',NULL,'.png',1,'1zVimMqQ6y8kWawFml4m92mc_bJmlF7V2'),(177,'04-25-07-19-57-2019.png','uploads/04-25-07-19-57-2019.png',NULL,'.png',1,'1irZloDASbp8jZy-vhmqvzUeAYkYUwxz7'),(178,'04-25-07-36-29-2019.png','uploads/04-25-07-36-29-2019.png',NULL,'.png',1,'1_F9YFLoMbqTTlG1Oq_9m65_fEU28jkwO'),(179,'04-25-07-38-39-2019.png','uploads/04-25-07-38-39-2019.png',NULL,'.png',1,'1be8uBUrXlWdBjuTnctFC6Zub_0Iw5IBl'),(180,'04-25-07-39-35-2019.jpg','uploads/04-25-07-39-35-2019.jpg',NULL,'.jpg',1,'1eX47ws2svAwJR_Oxmw-JH8vigNAqZD7n'),(181,'04-25-07-50-48-2019.png','uploads/04-25-07-50-48-2019.png',NULL,'.png',1,'1-LFIJ8mk6gO5DZs0NXI6YnDrilN4w6KJ'),(182,'04-25-07-37-25-2019.png','uploads/04-25-07-37-25-2019.png',NULL,'.png',1,'1F_0l5xuUnUOZeAkEPkDoqoqev79JeR9R'),(183,'04-25-07-37-29-2019.png','uploads/04-25-07-37-29-2019.png',NULL,'.png',1,'1M8WRhuQAoBX5GdCi7L3V8mEi3k0_Fvwn'),(184,'04-25-07-40-31-2019.png','uploads/04-25-07-40-31-2019.png',NULL,'.png',1,'1V30EkJKzCRRgYl4d3QgcrX8ZiWDKTAUF'),(185,'04-25-07-49-26-2019.png','uploads/04-25-07-49-26-2019.png',NULL,'.png',1,'1AHG3Hwvz9NYn3elkFF6UF8BH0NnhqMR3'),(186,'04-25-07-49-30-2019.png','uploads/04-25-07-49-30-2019.png',NULL,'.png',1,'1AUvN1wgBRkrnvh7ccdK_EvRxvpjzmoTv'),(187,'04-25-07-50-08-2019.png','uploads/04-25-07-50-08-2019.png',NULL,'.png',1,'1_CK5jelUOO_n94tWXc44YZ5yBhiNSVJt'),(188,'04-25-07-50-36-2019.png','uploads/04-25-07-50-36-2019.png',NULL,'.png',1,'13xQMAKT2Rkmac3T5vQnydWuilRzQ4IAo'),(189,'04-25-07-50-41-2019.png','uploads/04-25-07-50-41-2019.png',NULL,'.png',1,'128fnLuezxkqBWPl4bMbK5iQVbiynmneK'),(190,'04-25-07-50-53-2019.png','uploads/04-25-07-50-53-2019.png',NULL,'.png',1,'1iiGaLqAXlDAJfQwWN98C4tl9b__5HeSS'),(191,'04-25-07-51-04-2019.jpg','uploads/04-25-07-51-04-2019.jpg',NULL,'.jpg',1,'1Ap5XG4yw2xddXt_4zIyL6D69R1tITrdl'),(192,'04-25-07-51-20-2019.jpg','uploads/04-25-07-51-20-2019.jpg',NULL,'.jpg',1,'1sbmv2J6NibGZFKHgwt6X2f9jHnGOSv2N'),(193,'04-25-07-51-26-2019.png','uploads/04-25-07-51-26-2019.png',NULL,'.png',1,'1z-MV8SAWcefwsvJAzMtswLOvXm4ujKqy'),(194,'04-25-07-51-33-2019.png','uploads/04-25-07-51-33-2019.png',NULL,'.png',1,'1yPogcr1wOo6uuvfhX4zh0xOcl9oFoVtb'),(195,'04-25-07-51-49-2019.png','uploads/04-25-07-51-49-2019.png',NULL,'.png',1,'1oiUQj1DW-4CQns2QpUtFc9oAMpbM9TMc'),(196,'04-25-07-52-00-2019.png','uploads/04-25-07-52-00-2019.png',NULL,'.png',1,'1-KuJUcGn6IRnIAqfgYFo7mD2VbjrHVFm'),(197,'04-25-07-52-58-2019.png','uploads/04-25-07-52-58-2019.png',NULL,'.png',1,'1yn3w5wLBRrZhqKoJjK_ofpe3esqNSCon'),(198,'04-25-07-53-48-2019.jpg','uploads/04-25-07-53-48-2019.jpg',NULL,'.jpg',0,'0'),(199,'04-25-07-54-00-2019.png','uploads/04-25-07-54-00-2019.png',NULL,'.png',1,'1wR4duhi9tHFca6_53WDFrcnM78NkfI07'),(200,'04-25-07-54-08-2019.png','uploads/04-25-07-54-08-2019.png',NULL,'.png',1,'1_araavXcAgLYcB-1s_PkCc4EnqcuTfb9');
/*!40000 ALTER TABLE `documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grades`
--

DROP TABLE IF EXISTS `grades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `grades` (
  `grades_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Rank` int(11) NOT NULL,
  `Code` varchar(45) NOT NULL,
  `Accreditation_ID` int(11) NOT NULL,
  PRIMARY KEY (`grades_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grades`
--

LOCK TABLES `grades` WRITE;
/*!40000 ALTER TABLE `grades` DISABLE KEYS */;
INSERT INTO `grades` VALUES (1,1,'123',10),(2,2,'234',10),(3,3,'345',10),(4,4,'456',10),(5,6,'678',10),(6,5,'567',10),(7,1,'123',11),(8,2,'234',11),(9,3,'345',11),(10,5,'567',11),(11,4,'456',11),(12,6,'678',11),(13,1,'123',12),(14,2,'234',12),(15,3,'345',12),(16,4,'456',12),(17,5,'567',12),(18,1,'A',13),(19,2,'B',13),(20,3,'C',13),(21,4,'D',13),(22,5,'E',13),(23,6,'F',13),(24,7,'G',13),(25,8,'H',13),(26,11,'K',13),(27,10,'J',13),(28,9,'I',13),(29,12,'L',13),(30,13,'M',13),(31,14,'N',13),(32,15,'O',13),(33,16,'P',13),(34,1,'123',14),(35,2,'234',14),(36,3,'345',14),(37,4,'456',14),(38,5,'567',14),(39,6,'678',14),(40,7,'789',14),(41,8,'890',14),(42,1,'123',15),(43,2,'234',15),(44,3,'345',15),(45,4,'456',15),(46,5,'567',15),(47,6,'678',15),(48,1,'123',16),(49,2,'234',16),(50,3,'345',16),(51,6,'678',16),(52,4,'456',16),(53,5,'567',16);
/*!40000 ALTER TABLE `grades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group`
--

DROP TABLE IF EXISTS `group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `group` (
  `Group_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Group_Name` varchar(45) DEFAULT NULL,
  `Area_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`Group_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group`
--

LOCK TABLES `group` WRITE;
/*!40000 ALTER TABLE `group` DISABLE KEYS */;
INSERT INTO `group` VALUES (0,'No Group Assigned',0),(1,'Analysis',1),(2,'Evaluation',1),(3,'Analysis',2),(4,'Evaluation',2),(5,'Analysis',3),(6,'Evaluation',3),(7,'Analysis',4),(8,'Evaluation',4),(9,'Analysis',5),(10,'Evaluation',5),(11,'Analysis',6),(12,'Evaluation',6),(13,'Analysis',7),(14,'Evaluation',7),(15,'Analysis',8),(16,'Evaluation',8),(17,'Analysis',9),(18,'Evaluation',9),(19,'Test Area',1),(20,'TESTING',2);
/*!40000 ALTER TABLE `group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groupdetails`
--

DROP TABLE IF EXISTS `groupdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `groupdetails` (
  `Groupdetails_ID` int(11) NOT NULL,
  `Groupdetails_UserID` int(11) NOT NULL,
  `Groupdetails_Position` varchar(45) NOT NULL DEFAULT 'Member'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groupdetails`
--

LOCK TABLES `groupdetails` WRITE;
/*!40000 ALTER TABLE `groupdetails` DISABLE KEYS */;
INSERT INTO `groupdetails` VALUES (1,35,'Member'),(1,47,'Member'),(1,51,'Member'),(1,57,'Member'),(1,56,'Member'),(1,46,'Member'),(1,52,'Member'),(1,49,'Member'),(1,53,'Member'),(1,48,'Member'),(1,73,'Member'),(1,54,'Member'),(1,50,'Member'),(1,55,'Member'),(1,58,'Member'),(1,59,'Member'),(1,69,'Member'),(1,63,'Member'),(1,68,'Member'),(1,62,'Member'),(1,61,'Member'),(1,67,'Member'),(1,60,'Member'),(1,74,'Member'),(1,71,'Member'),(1,72,'Member'),(1,66,'Member'),(1,65,'Member'),(1,70,'Member'),(1,75,'Member'),(1,77,'Member'),(1,64,'Member'),(1,76,'Member'),(1,81,'Member'),(1,79,'Member'),(1,80,'Member'),(1,78,'Member'),(2,82,'Leader'),(2,83,'Member'),(2,84,'Member'),(19,85,'Member'),(19,87,'Member'),(19,86,'Member'),(19,88,'Member'),(19,89,'Member');
/*!40000 ALTER TABLE `groupdetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `measurement`
--

DROP TABLE IF EXISTS `measurement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `measurement` (
  `measurement_ID` int(11) NOT NULL AUTO_INCREMENT,
  `QualityTarget` int(11) NOT NULL,
  `Procedures` varchar(500) NOT NULL,
  `GroupAssigned` int(11) NOT NULL,
  `metric_ID` int(11) NOT NULL,
  `measurement_Name` varchar(45) NOT NULL,
  `measurement_Description` varchar(200) NOT NULL,
  `Deadline` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`measurement_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `measurement`
--

LOCK TABLES `measurement` WRITE;
/*!40000 ALTER TABLE `measurement` DISABLE KEYS */;
INSERT INTO `measurement` VALUES (1,123,'123',1,18,'123','123',NULL),(2,123,'SYLLABUS, PHOTO EVIDENCES OF CLASS, ACTIVITIES DONE IN THE CLASS WITH SERVICE LEARNING',1,18,'NO OF COURSES WITH SERVICE LEARNING','KEEP COUNT OF THE NUMBER OF COURSES THAT HAVE SERVICE LEARNING',NULL),(3,123,'ASD',1,20,'MEASUREMENT 1','% OF CURRICULUM AND SYLLABI REVISED BASED ON LEARNER CENTERED PHILOSOPHY AND LSALLIAN GUIDING PRINCIPLES',NULL),(4,123,'EVIDENCES = SYLLABI',1,20,'MEASUREMENT 2','% OF CURRICULUM AND SYLLABI REVISED BASED ON LEARNER CENTERED PHILOSOPHY AND LSALLIAN GUIDING PRINCIPLES',NULL),(5,100,'TESTING INSERT MEASUREMENT UNDER METRIC',20,22,'TESTING INSERT MEASUREMENT UNDER METRIC','TESTING INSERT MEASUREMENT UNDER METRIC',NULL);
/*!40000 ALTER TABLE `measurement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meetingdetails`
--

DROP TABLE IF EXISTS `meetingdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `meetingdetails` (
  `meetings_ID` int(11) NOT NULL,
  `members_ID` int(11) NOT NULL,
  `Status` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meetingdetails`
--

LOCK TABLES `meetingdetails` WRITE;
/*!40000 ALTER TABLE `meetingdetails` DISABLE KEYS */;
INSERT INTO `meetingdetails` VALUES (1,57,0),(1,51,0),(1,55,0),(1,48,0),(1,47,0),(1,49,0),(1,50,0),(1,56,0),(1,53,0),(1,54,0),(1,52,0);
/*!40000 ALTER TABLE `meetingdetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meetings`
--

DROP TABLE IF EXISTS `meetings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `meetings` (
  `meetings_ID` int(11) NOT NULL AUTO_INCREMENT,
  `meetingname` varchar(45) NOT NULL,
  `meetingdesc` mediumtext NOT NULL,
  `meeting_creator` int(11) NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  PRIMARY KEY (`meetings_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meetings`
--

LOCK TABLES `meetings` WRITE;
/*!40000 ALTER TABLE `meetings` DISABLE KEYS */;
INSERT INTO `meetings` VALUES (1,'Test Meeting','Test Description',46,'2019-07-31 11:11:00','2019-07-31 11:12:00');
/*!40000 ALTER TABLE `meetings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metric`
--

DROP TABLE IF EXISTS `metric`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `metric` (
  `metric_ID` int(11) NOT NULL AUTO_INCREMENT,
  `metric_Name` varchar(200) DEFAULT NULL,
  `metric_Desc` varchar(200) DEFAULT NULL,
  `priority_Level` varchar(45) DEFAULT NULL,
  `date_insert` datetime DEFAULT NULL,
  `group_ID` int(11) DEFAULT '0',
  `source_ID` int(11) DEFAULT NULL,
  `cycle_ID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`metric_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metric`
--

LOCK TABLES `metric` WRITE;
/*!40000 ALTER TABLE `metric` DISABLE KEYS */;
INSERT INTO `metric` VALUES (18,'123','123','High','2019-07-21 00:00:00',1,1,0),(19,'To fully integrate the learner-centered pedagogy and Lasallian guiding principles','to apply these things in all curricular and co-curricular programs','High','2019-07-29 00:00:00',0,1,0),(20,'GOAL TITLE','TO FULLY INTEGRATE THE LEARNER CENTERED PEDAGOGY AND LASALLIAN GUIDING PRINCIPLES IN ALL CURRICULAR AND CO-CURRICULAR PROGRAMS','High','2019-07-29 00:00:00',1,1,0),(21,'TEST METRIC ADD EDIT','TESTING METRIC ADD EDIT','Medium','2019-07-30 00:00:00',19,19,0),(22,'ADDING METRIC UNDER A SOURCE','ADDING METRIC UNDER SOURCE','Low','2019-07-30 00:00:00',20,19,0),(23,'TESTING NEW INSERT','TESTING','Medium','2019-07-31 00:00:00',1,2,10);
/*!40000 ALTER TABLE `metric` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pending_activities`
--

DROP TABLE IF EXISTS `pending_activities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `pending_activities` (
  `activity_ID` int(11) NOT NULL,
  `activity_name` varchar(45) NOT NULL,
  `target` int(11) NOT NULL,
  `code` tinyint(1) NOT NULL,
  `description` mediumtext,
  `measurement_ID` int(11) NOT NULL,
  `current_Score` int(11) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pending_activities`
--

LOCK TABLES `pending_activities` WRITE;
/*!40000 ALTER TABLE `pending_activities` DISABLE KEYS */;
INSERT INTO `pending_activities` VALUES (2,'123',100,0,'test check',7,100,NULL),(1,'123',23,1,'test count',1,5,NULL),(2,'123',100,0,'test check',1,100,NULL),(3,'123',100,0,'234',1,100,NULL);
/*!40000 ALTER TABLE `pending_activities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plandetails`
--

DROP TABLE IF EXISTS `plandetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `plandetails` (
  `Plan_ID` int(11) NOT NULL,
  `Member_ID` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plandetails`
--

LOCK TABLES `plandetails` WRITE;
/*!40000 ALTER TABLE `plandetails` DISABLE KEYS */;
INSERT INTO `plandetails` VALUES (7,'57'),(7,'35'),(7,'47'),(7,'56'),(7,'51'),(7,'46'),(7,'71'),(7,'70'),(7,'72'),(7,'62'),(7,'58'),(7,'50'),(7,'52'),(7,'48'),(7,'77'),(7,'59'),(7,'55'),(7,'81'),(7,'74'),(7,'66'),(7,'69'),(7,'76'),(7,'80'),(7,'73'),(7,'54'),(7,'63'),(7,'67'),(7,'78'),(7,'79'),(7,'61'),(7,'65'),(7,'68'),(7,'60'),(7,'49'),(7,'75'),(7,'53'),(7,'64');
/*!40000 ALTER TABLE `plandetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plans_members`
--

DROP TABLE IF EXISTS `plans_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `plans_members` (
  `plan_ID` int(11) NOT NULL,
  `user_ID` int(11) NOT NULL,
  `recommendation_ID` int(11) NOT NULL,
  `group_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plans_members`
--

LOCK TABLES `plans_members` WRITE;
/*!40000 ALTER TABLE `plans_members` DISABLE KEYS */;
/*!40000 ALTER TABLE `plans_members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plansubmissions`
--

DROP TABLE IF EXISTS `plansubmissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `plansubmissions` (
  `Submission_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Plan_ID` int(11) DEFAULT NULL,
  `User_ID` int(11) DEFAULT NULL,
  `Submission_Title` varchar(45) DEFAULT NULL,
  `Submission_File` varchar(100) DEFAULT NULL,
  `Submission_Description` varchar(300) DEFAULT NULL,
  `Submission_Date` date DEFAULT NULL,
  `Submission_Status` tinyint(1) DEFAULT '1',
  `Leader_Notes` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Submission_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plansubmissions`
--

LOCK TABLES `plansubmissions` WRITE;
/*!40000 ALTER TABLE `plansubmissions` DISABLE KEYS */;
INSERT INTO `plansubmissions` VALUES (1,7,35,'test','uploads/1.JPG','DESCRIPTION NUMBER 1','2019-07-23',3,'123'),(2,7,35,'TESTING','uploads/asean.docx','DESCRIPTION NUMBER 2','2019-07-24',0,NULL),(3,7,35,'TESTING PART 2','uploads/RoviSorianoA99.docx','DESCRIPTION NUMBER 3','2019-07-24',1,NULL),(4,8,35,'TESTING ANOTHER ONE','uploads/F1institutional-moa-re-ojt.doc','TESTING ANOTHER ONE','2019-07-25',1,NULL),(5,9,35,'TESTI','uploads/F1institutional-moa-re-ojt.doc','ASDASD','2019-07-25',0,NULL),(6,7,46,'Hi','uploads/07-01-01-07-05-2019.jpg','123','2019-07-28',1,NULL),(7,7,46,'645','uploads/06-01-01-45-57-2019.png','634','2019-07-28',1,NULL);
/*!40000 ALTER TABLE `plansubmissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `roles` (
  `Role_ID` int(11) NOT NULL,
  `Role_Name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Role_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Admin'),(2,'Group Member'),(3,'Group Leader'),(4,'QA Officer'),(5,'User');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `source`
--

DROP TABLE IF EXISTS `source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `source` (
  `source_ID` int(11) NOT NULL AUTO_INCREMENT,
  `source_Name` varchar(200) DEFAULT NULL,
  `source_Description` mediumtext,
  PRIMARY KEY (`source_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `source`
--

LOCK TABLES `source` WRITE;
/*!40000 ALTER TABLE `source` DISABLE KEYS */;
INSERT INTO `source` VALUES (1,'PAASCU','PAASCU is governed by a 15-person Board of Directors elected at large by\r\nmembers during the annual General Assembly. It has seven Commissions with five\r\nto seven members each to perform its mandate. These are the Commissions on\r\nGraduate Education, Medical Education, Engineering Education, Tertiary\r\nEducation, Integrated Basic Education, Secondary Education and Elementary\r\nEducation. The Commission members are recommended during the General\r\nAssembly and appointed by the Board.\r\n\r\nThe Commissions plan and initiate projects for each level, revise survey\r\ninstruments, and train accreditors and team chairs. Moreover, they review the\r\nreports of the survey teams before these are submitted to the Board.\r\nPAASCU’s day to day operations are handled by a Secretariat which is headed by\r\nthe Executive Director. The Secretariat takes care of the logistics of the survey\r\nvisits, invites accreditors, prepares reports and forms, and implements the projects\r\nof the Commissions.'),(2,'ABET','At ABET, our purpose is to assure confidence in university programs in STEM (science, technology, engineering and mathematics) disciplines. Our approach, the standards we set and the quality we guarantee, inspires confidence in those who aim to build a better world—one that is safer, more efficient, more comfortable and more sustainable.\r\n\r\nWe accredit college and university programs in the disciplines of applied and natural science, computing, engineering and engineering technology at the associate, bachelor’s and master’s degree levels.\r\n\r\nWith ABET accreditation, students, employers and the society we serve can be confident that a program meets the quality standards that produce graduates prepared to enter a global workforce.\r\n\r\nWe began as the educational standard against which professional engineers in the United States were held for licensure. Today, after more than 80 years, our standards continue to play this fundamental role and have become the basis of quality for STEM disciplines all over the world.\r\n\r\nDeveloped by technical professionals from ABET’s member societies, our criteria focus on what students experience and learn. Sought worldwide, ABET’s voluntary peer-review process is highly respected because it adds critical value to academic programs in the technical disciplines, where quality, precision and safety are of the utmost importance.\r\n\r\nOur more than 2,200 experts come from industry, academia and government. They give their time and effort supporting quality assurance activities around the world by serving as Program Evaluators, commissioners, board members and advisors.\r\n\r\nABET is a nonprofit, non-governmental organization with ISO 9001:2015 certification.'),(3,'TEst Item','AAAAA'),(4,'TEst Item2','1234'),(5,'TEst Item3','2345'),(6,'TEst Item4','1234'),(7,'TEst Item5','1234'),(8,'TEst Item6','1234'),(9,'TEst Item7','1234'),(10,'TEst Item10','1234'),(11,'TEst Item112','1234'),(12,'TEst Item1123','1234'),(13,'TEst Item23423','1234345'),(14,'TEst Item112334','1234'),(15,'TEst Item11432334','1234'),(16,'TEst Item11435623','1234'),(17,'Test ','sihdfsjfsfd'),(18,'dfsadf','asdfasdf'),(19,'TEST SOURCE EDIT','TEST SOURCE EDIT');
/*!40000 ALTER TABLE `source` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tasks`
--

DROP TABLE IF EXISTS `tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `tasks` (
  `task_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Task_Name` varchar(45) NOT NULL,
  `Task_Desc` varchar(45) NOT NULL,
  `GenObj` varchar(45) NOT NULL,
  `Measurement` varchar(45) NOT NULL,
  `QT` varchar(45) NOT NULL,
  `BaseStandard` varchar(45) NOT NULL,
  `Group` varchar(45) DEFAULT 'Not Assigned',
  `Personnel` varchar(45) DEFAULT 'Not Assigned',
  `Level` varchar(45) DEFAULT 'Not Assigned',
  `plan_ID` int(11) NOT NULL,
  PRIMARY KEY (`task_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks`
--

LOCK TABLES `tasks` WRITE;
/*!40000 ALTER TABLE `tasks` DISABLE KEYS */;
/*!40000 ALTER TABLE `tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `users` (
  `User_ID` int(11) NOT NULL AUTO_INCREMENT,
  `User_First` varchar(45) DEFAULT NULL,
  `User_Last` varchar(45) DEFAULT NULL,
  `email_address` varchar(100) DEFAULT NULL,
  `Role` int(11) DEFAULT NULL,
  `Group` int(11) DEFAULT NULL,
  `ContactNo` varchar(12) DEFAULT NULL,
  `username` varchar(45) DEFAULT NULL,
  `passwd` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`User_ID`),
  UNIQUE KEY `username_UNIQUE` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=120 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (35,'Admin','Admin','debug@debug.com',1,1,'99999999999','Admin','$2b$10$w1q.GZyvVMwt9c6aiFjBEuahRim1NOtIgFOY8DYsxoJuN31CsUGsu'),(46,'AdminX','AdminX','debug@debug.com',1,1,'99999999999','AdminX','$2b$10$bWyFihniq34XjVzTZXXMjeqbF1LeG.gP06X2FLc.XZ6vgH5wHo6.e'),(47,'Jayme','Randall','quis.massa.Mauris@amalesuadaid.com',5,1,'0827150506','orci.consectetuer.euismod@convalliserat.co.uk',NULL),(48,'Hedda','Blanchard','dolor.egestas.rhoncus@etmagnisdis.com',5,1,'0532678474','egestas.hendrerit@Maurisblanditenim.co.uk',NULL),(49,'Quentin','Farmer','senectus.et.netus@Nulla.co.uk',5,1,'0424963076','vitae.erat@risusDuisa.net',NULL),(50,'Rooney','Lawson','lectus@utipsumac.com',5,1,'0017842615','ipsum.nunc.id@velitSedmalesuada.edu',NULL),(51,'Fuller','Lawson','lorem.vitae.odio@turpisNulla.com',5,1,'0104998917','ut.pellentesque.eget@Aliquamvulputate.net',NULL),(52,'Naida','Travis','molestie.orci.tincidunt@diamSed.org',5,1,'0396262927','ipsum@hymenaeosMaurisut.com',NULL),(53,'Shelly','Odonnell','consequat.purus@ut.com',5,1,'0741793038','Etiam.gravida.molestie@lectus.edu',NULL),(54,'Nomlanga','Wiley','sociis@imperdietnecleo.net',5,1,'0463195329','ut.pellentesque.eget@semNulla.org',NULL),(55,'Pamela','Payne','cursus.et.magna@cursusaenim.net',5,1,'0336253671','diam@tempus.edu',NULL),(56,'Dale','Fulton','consequat.dolor@vestibulum.edu',5,1,'0621007822','ultricies@Vivamuseuismodurna.co.uk',NULL),(57,'Brock','Tanner','magnis.dis@iaculisaliquetdiam.com',5,1,'0485322526','ornare.lectus.justo@dolorFuscemi.net',NULL),(58,'Drake','Hogan','Integer@nequeMorbi.co.uk',5,1,'0122087593','sed.turpis@arcuVestibulum.net',NULL),(59,'Fitzgerald','Ortiz','arcu@in.edu',5,1,'0353804236','vitae.aliquam.eros@quispedePraesent.edu',NULL),(60,'Isaiah','Kemp','pellentesque@lacinia.co.uk',5,1,'0687689022','enim.Etiam.gravida@enimEtiamgravida.org',NULL),(61,'Cassady','Carson','adipiscing@quisaccumsan.org',5,1,'0822841725','justo@Loremipsumdolor.org',NULL),(62,'Yeo','Allison','Sed.auctor@vulputate.edu',5,1,'0751834790','Nunc.quis@arcuVestibulum.com',NULL),(63,'Daria','Knox','nec.mauris.blandit@rhoncusDonec.co.uk',5,1,'0068744702','neque.sed@quispedePraesent.co.uk',NULL),(64,'Preston','Melton','massa.non@tempusscelerisque.com',5,1,'0385565489','vel.venenatis@non.net',NULL),(65,'Chaim','Walls','ullamcorper.nisl.arcu@Vivamus.org',5,1,'0994904810','vitae.nibh@eget.com',NULL),(66,'Karly','Shaw','nisl.Quisque.fringilla@nonfeugiatnec.co.uk',5,1,'0617257074','penatibus.et@nuncsed.net',NULL),(67,'Maisie','Sharp','ac.mi.eleifend@eratSed.edu',5,1,'0046643354','at.iaculis.quis@malesuadamalesuadaInteger.com',NULL),(68,'Indigo','Mccoy','sit.amet.nulla@feugiatnec.ca',5,1,'0769322656','consectetuer.cursus@risusQuisque.ca',NULL),(69,'Keane','Parsons','Morbi@Aliquameratvolutpat.net',5,1,'0876062059','libero.est@necmaurisblandit.edu',NULL),(70,'Rafael','Schmidt','urna.convallis.erat@ipsum.co.uk',5,1,'0912845172','ac@pretiumneque.com',NULL),(71,'Haley','Wheeler','tristique.aliquet@nibh.net',5,1,'0510355744','sit.amet@Loremipsumdolor.ca',NULL),(72,'William','Dickson','euismod@Aliquamvulputate.com',5,1,'0422612351','convallis.convallis@risusquisdiam.ca',NULL),(73,'Quentin','Church','at.sem.molestie@sapiencursusin.ca',5,1,'0701695380','Donec.tempor.est@feugiat.com',NULL),(74,'Rebekah','Velez','lacus.pede@aaliquet.ca',5,1,'0094284493','Nullam.lobortis@metus.com',NULL),(75,'Lavinia','Yang','dui.nec.urna@faucibus.edu',5,1,'0329088663','dictum.sapien@purus.org',NULL),(76,'Keefe','Ross','elit@nibhsitamet.edu',5,1,'0679701501','dolor.elit.pellentesque@in.com',NULL),(77,'Wendy','Hoover','fringilla.cursus.purus@imperdiet.ca',5,1,'0379574808','orci.tincidunt.adipiscing@malesuada.org',NULL),(78,'Jared','Summers','aliquet@aliquetsem.ca',5,1,'0733466712','Phasellus.elit.pede@quamquisdiam.co.uk',NULL),(79,'Addison','Goodman','orci@disparturientmontes.com',5,1,'0980636012','et.ultrices.posuere@maurisIntegersem.net',NULL),(80,'Patricia','Walsh','Proin.nisl.sem@loremtristiquealiquet.com',5,1,'0297573566','sit.amet@iaculislacus.co.uk',NULL),(81,'Skyler','Gould','risus.Duis.a@rutrummagna.co.uk',5,1,'0540489098','mus.Donec.dignissim@porttitorscelerisque.edu',NULL),(82,'Yetta','Beasley','luctus.aliquet@Morbiquisurna.com',5,2,'0503200466','Cras.convallis.convallis@metuseuerat.com',NULL),(83,'Dexter','Riddle','at.egestas.a@risusaultricies.com',5,2,'0496751635','Cras.eu@etmagnaPraesent.com',NULL),(84,'Lewis','Orr','ac.arcu@etmagnis.org',5,2,'0480299478','commodo@gravidamolestiearcu.edu',NULL),(85,'Geoffrey','Walters','Integer.tincidunt@Etiam.edu',5,19,'0611025254','elementum@malesuadaIntegerid.net',NULL),(86,'Elvis','Frank','consequat@Aeneanegetmagna.edu',5,19,'0359018577','dui.Suspendisse@Quisqueornaretortor.ca',NULL),(87,'Chase','Banks','lectus.Cum@pellentesqueafacilisis.net',5,19,'0756987085','semper.pretium@mauriserateget.edu',NULL),(88,'Adara','Dixon','egestas.Aliquam@semperNam.co.uk',5,19,'0618851512','amet.ante@lectuspedeet.org',NULL),(89,'Derek','Guthrie','enim.nisl.elementum@loremipsum.co.uk',5,19,'0127852498','leo@dolor.co.uk',NULL),(90,'Daquan','Hurst','mattis.Integer.eu@lectussit.ca',5,NULL,'0751198698','velit@atliberoMorbi.org',NULL),(91,'Gareth','Dyer','quam@quisturpisvitae.org',5,NULL,'0023856993','est.ac@nec.edu',NULL),(92,'Lucian','Sawyer','tellus.Phasellus.elit@euismod.com',5,NULL,'0670823754','Nulla.interdum@nislQuisquefringilla.com',NULL),(93,'Donovan','Little','nunc.interdum@miDuisrisus.net',5,NULL,'0248308253','tempus@nonummy.edu',NULL),(94,'Molly','Foley','lobortis.mauris@porttitor.co.uk',5,NULL,'0921669041','Donec@Cras.edu',NULL),(95,'Igor','Holman','volutpat.Nulla@vehicularisusNulla.co.uk',5,NULL,'0573787089','orci.quis@id.org',NULL),(96,'Risa','Hammond','nulla.Integer.urna@ultricesposuerecubilia.ca',5,NULL,'0824503469','accumsan.convallis@eget.ca',NULL),(97,'Jennifer','Woodard','et@tristique.edu',5,NULL,'0535069755','mollis.Duis@ac.co.uk',NULL),(98,'Brenna','Hobbs','neque@lacus.co.uk',5,NULL,'0802762227','aliquet.molestie@semNullainterdum.org',NULL),(99,'Dale','Battle','accumsan@Duisatlacus.com',5,NULL,'0838195388','eget@vulputate.co.uk',NULL),(100,'Chiquita','Frank','lectus.a@Donecfeugiat.net',5,NULL,'0436439755','tincidunt.congue@ac.ca',NULL),(101,'Iola','Chen','vulputate.velit@elementum.net',5,NULL,'0247815078','auctor.ullamcorper@amet.ca',NULL),(102,'Jana','Blanchard','lectus.a.sollicitudin@ipsum.ca',5,NULL,'0322798799','est.Nunc.ullamcorper@dictumeueleifend.org',NULL),(103,'Ferris','Alexander','diam.dictum@Fuscedolorquam.ca',5,NULL,'0354503871','orci.consectetuer@nonummy.co.uk',NULL),(104,'Jenette','Singleton','a.neque.Nullam@semper.co.uk',5,NULL,'0216726577','Suspendisse@sitametluctus.org',NULL),(105,'Slade','Stark','commodo@Fuscemilorem.net',5,NULL,'0234534640','amet@venenatisvel.net',NULL),(106,'Evelyn','Rich','vel.sapien@fermentumconvallis.ca',5,NULL,'0169935725','Ut.semper.pretium@Nunc.co.uk',NULL),(107,'Phyllis','Wolfe','Class@idrisusquis.edu',5,NULL,'0747222437','massa@sodalesatvelit.co.uk',NULL),(108,'Tallulah','Hebert','nunc.ullamcorper@Nullamscelerisque.co.uk',5,NULL,'0282980099','semper.auctor.Mauris@conubia.edu',NULL),(109,'Michael','Garza','dolor.Fusce.feugiat@lobortistellusjusto.net',5,NULL,'0165290651','metus.In@Aenean.org',NULL),(110,'Tucker','Mcleod','quis.urna@viverraDonectempus.co.uk',5,NULL,'0123377019','Fusce.mi@nonquamPellentesque.edu',NULL),(111,'Macy','Benjamin','vitae@ligulaAliquam.org',5,NULL,'0028986385','nibh@Quisquefringilla.edu',NULL),(112,'Xaviera','Kelley','turpis@metus.org',5,NULL,'0781759756','eget.laoreet.posuere@quis.edu',NULL),(113,'Conan','Rose','sodales.elit@sociosquad.com',5,NULL,'0207126016','sit.amet.massa@habitantmorbitristique.ca',NULL),(114,'Jemima','Henderson','elit@nonummyultricies.edu',5,NULL,'0297072047','Aenean@Praesenteudui.co.uk',NULL),(115,'Florence','Hewitt','adipiscing@arcuCurabitur.com',5,NULL,'0217060662','et@posuere.ca',NULL),(116,'Cadman','Baldwin','pharetra@seddolor.org',5,NULL,'0231643413','nisl@tinciduntnibh.ca',NULL),(117,'Fredericka','Yang','odio.Nam@scelerisquesedsapien.co.uk',5,NULL,'0607159193','Mauris@vulputate.org',NULL),(118,'Lucy','Parrish','turpis.In.condimentum@velsapien.net',5,NULL,'0165917109','turpis@est.net',NULL),(119,'Josiah','Buck','non.lorem.vitae@MaurismagnaDuis.com',5,NULL,'0817039008','tellus@nonquam.co.uk',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-08-01  8:35:47
