CREATE DATABASE  IF NOT EXISTS `capstone` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `capstone`;
-- MySQL dump 10.13  Distrib 8.0.16, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: capstone
-- ------------------------------------------------------
-- Server version	8.0.16

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
-- Table structure for table `accreditation`
--

DROP TABLE IF EXISTS `accreditation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `accreditation` (
  `accreditation_ID` int(11) NOT NULL AUTO_INCREMENT,
  `accreditation_Name` varchar(200) DEFAULT NULL,
  `accreditation_Description` mediumtext,
  `gradesset` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`accreditation_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accreditation`
--

LOCK TABLES `accreditation` WRITE;
/*!40000 ALTER TABLE `accreditation` DISABLE KEYS */;
INSERT INTO `accreditation` VALUES (1,'PAASCU','PAASCU is governed by a 15-person Board of Directors elected at large by\r\nmembers during the annual General Assembly. It has seven Commissions with five\r\nto seven members each to perform its mandate. These are the Commissions on\r\nGraduate Education, Medical Education, Engineering Education, Tertiary\r\nEducation, Integrated Basic Education, Secondary Education and Elementary\r\nEducation. The Commission members are recommended during the General\r\nAssembly and appointed by the Board.\r\n\r\nThe Commissions plan and initiate projects for each level, revise survey\r\ninstruments, and train accreditors and team chairs. Moreover, they review the\r\nreports of the survey teams before these are submitted to the Board.\r\nPAASCU’s day to day operations are handled by a Secretariat which is headed by\r\nthe Executive Director. The Secretariat takes care of the logistics of the survey\r\nvisits, invites accreditors, prepares reports and forms, and implements the projects\r\nof the Commissions.',0),(2,'ABET','At ABET, our purpose is to assure confidence in university programs in STEM (science, technology, engineering and mathematics) disciplines. Our approach, the standards we set and the quality we guarantee, inspires confidence in those who aim to build a better world—one that is safer, more efficient, more comfortable and more sustainable.\r\n\r\nWe accredit college and university programs in the disciplines of applied and natural science, computing, engineering and engineering technology at the associate, bachelor’s and master’s degree levels.\r\n\r\nWith ABET accreditation, students, employers and the society we serve can be confident that a program meets the quality standards that produce graduates prepared to enter a global workforce.\r\n\r\nWe began as the educational standard against which professional engineers in the United States were held for licensure. Today, after more than 80 years, our standards continue to play this fundamental role and have become the basis of quality for STEM disciplines all over the world.\r\n\r\nDeveloped by technical professionals from ABET’s member societies, our criteria focus on what students experience and learn. Sought worldwide, ABET’s voluntary peer-review process is highly respected because it adds critical value to academic programs in the technical disciplines, where quality, precision and safety are of the utmost importance.\r\n\r\nOur more than 2,200 experts come from industry, academia and government. They give their time and effort supporting quality assurance activities around the world by serving as Program Evaluators, commissioners, board members and advisors.\r\n\r\nABET is a nonprofit, non-governmental organization with ISO 9001:2015 certification.',0),(3,'TEst Item','AAAAA',0),(4,'TEst Item2','1234',0),(5,'TEst Item3','2345',0),(6,'TEst Item4','1234',0),(7,'TEst Item5','1234',0),(8,'TEst Item6','1234',0),(9,'TEst Item7','1234',0),(10,'TEst Item10','1234',0),(11,'TEst Item112','1234',0),(12,'TEst Item1123','1234',0),(13,'TEst Item23423','1234345',0),(14,'TEst Item112334','1234',0),(15,'TEst Item11432334','1234',0),(16,'TEst Item11435623','1234',1),(17,'TEst Item1143233423','123',0);
/*!40000 ALTER TABLE `accreditation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `activity_evidences`
--

DROP TABLE IF EXISTS `activity_evidences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `activity_evidences` (
  `activityID` int(11) NOT NULL,
  `documentID` int(11) NOT NULL,
  `pendingID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity_evidences`
--

LOCK TABLES `activity_evidences` WRITE;
/*!40000 ALTER TABLE `activity_evidences` DISABLE KEYS */;
INSERT INTO `activity_evidences` VALUES (3,1,1),(3,2,1),(4,16,2),(1,17,3),(2,18,4),(2,18,5),(2,19,5),(5,1,6),(5,34,8),(5,35,9),(5,36,11),(5,10,12),(5,11,12),(5,28,13),(5,29,13),(5,37,14),(5,38,15),(5,39,15);
/*!40000 ALTER TABLE `activity_evidences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `activity_members`
--

DROP TABLE IF EXISTS `activity_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `activity_members` (
  `activity_ID` int(11) NOT NULL,
  `activity_Member` int(11) NOT NULL,
  `measurement_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity_members`
--

LOCK TABLES `activity_members` WRITE;
/*!40000 ALTER TABLE `activity_members` DISABLE KEYS */;
INSERT INTO `activity_members` VALUES (3,21,2),(4,21,2),(5,21,3),(1,21,1),(2,21,1),(5,20,3),(5,22,3),(5,23,3);
/*!40000 ALTER TABLE `activity_members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `activity_members_members`
--

DROP TABLE IF EXISTS `activity_members_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `activity_members_members` (
  `activity_ID` int(11) NOT NULL,
  `activity_member_member` int(11) NOT NULL,
  `measurement_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity_members_members`
--

LOCK TABLES `activity_members_members` WRITE;
/*!40000 ALTER TABLE `activity_members_members` DISABLE KEYS */;
INSERT INTO `activity_members_members` VALUES (5,120,3),(5,122,3),(5,121,3),(5,133,3),(5,135,3),(5,137,3);
/*!40000 ALTER TABLE `activity_members_members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `activity_outputs`
--

DROP TABLE IF EXISTS `activity_outputs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `activity_outputs` (
  `output_ID` int(11) NOT NULL AUTO_INCREMENT,
  `activity_ID` int(11) NOT NULL,
  `output` varchar(45) NOT NULL,
  `output_Status` int(11) DEFAULT '0',
  PRIMARY KEY (`output_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity_outputs`
--

LOCK TABLES `activity_outputs` WRITE;
/*!40000 ALTER TABLE `activity_outputs` DISABLE KEYS */;
INSERT INTO `activity_outputs` VALUES (1,1,'Business Card or Contact Info',0),(2,2,'Training Plan',0),(3,3,'Seminar proposals',0),(4,3,'Seminar Schedules',0),(5,4,'Locations Document w/ Price list',0),(6,4,'Schedule of availability',0),(7,5,'Comparative Report',0),(9,5,'Reports',0),(10,5,'testing folder create',0);
/*!40000 ALTER TABLE `activity_outputs` ENABLE KEYS */;
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
  `target` int(11) DEFAULT NULL,
  `code` tinyint(1) DEFAULT '0',
  `description` mediumtext NOT NULL,
  `measurement_ID` int(11) DEFAULT NULL,
  `current_Score` int(11) NOT NULL DEFAULT '0',
  `deadline` date NOT NULL,
  PRIMARY KEY (`activity_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `approved_activities`
--

LOCK TABLES `approved_activities` WRITE;
/*!40000 ALTER TABLE `approved_activities` DISABLE KEYS */;
INSERT INTO `approved_activities` VALUES (1,'Technology Convention 2020 Recruitment',NULL,0,'Attend this years technology convention and scout out potential employees.',NULL,0,'2020-03-20'),(2,'Teaching Training Workshop 2020',NULL,0,'Provide teaching training workshop for new professors to ensure curriculum and lasallian teaching qualities are followed as example.',NULL,0,'2020-03-21'),(3,'Seminar Plans',NULL,0,'Documents for seminars',NULL,0,'2020-03-20'),(4,'Possible Locations To hold Seminars',NULL,0,'Documents about the locations as well as price lists and availability',NULL,0,'2020-03-31'),(5,'Comparative count reports EDITED',NULL,0,'A report that compares the amount of outputs from the previous year',NULL,0,'2020-03-25');
/*!40000 ALTER TABLE `approved_activities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `approved_activities_audit`
--

DROP TABLE IF EXISTS `approved_activities_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `approved_activities_audit` (
  `approved_activities_auditID` int(11) NOT NULL AUTO_INCREMENT,
  `measurement_auditID` int(11) NOT NULL,
  `activity_ID` int(11) NOT NULL,
  `activity_name` varchar(45) NOT NULL,
  `target` int(11) DEFAULT NULL,
  `code` tinyint(1) DEFAULT NULL,
  `description` mediumtext NOT NULL,
  `measurement_ID` int(11) DEFAULT NULL,
  `current_Score` int(11) NOT NULL,
  `deadline` date NOT NULL,
  PRIMARY KEY (`approved_activities_auditID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `approved_activities_audit`
--

LOCK TABLES `approved_activities_audit` WRITE;
/*!40000 ALTER TABLE `approved_activities_audit` DISABLE KEYS */;
INSERT INTO `approved_activities_audit` VALUES (1,1,2,'Teaching Training Workshop 2020',NULL,0,'Provide teaching training workshop for new professors to ensure curriculum and lasallian teaching qualities are followed as example.',NULL,0,'2020-03-20'),(2,1,1,'Technology Convention 2020 Recruitment',NULL,0,'Attend this years technology convention and scout out potential employees.',NULL,0,'2020-03-19'),(3,2,4,'Possible Locations To hold Seminars',NULL,0,'Documents about the locations as well as price lists and availability',NULL,0,'2020-03-30'),(4,2,3,'Seminar Plans',NULL,0,'Documents for seminars',NULL,0,'2020-03-19'),(5,3,5,'Comparative count reports',NULL,0,'A report that compares the amount of outputs from the previous year',NULL,0,'2020-03-24');
/*!40000 ALTER TABLE `approved_activities_audit` ENABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit_activities`
--

LOCK TABLES `audit_activities` WRITE;
/*!40000 ALTER TABLE `audit_activities` DISABLE KEYS */;
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
  `goal_ID` int(11) NOT NULL DEFAULT '0',
  `termnum` varchar(45) NOT NULL,
  `totalterm` varchar(45) NOT NULL,
  `termindex` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`cycle_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cycle`
--

LOCK TABLES `cycle` WRITE;
/*!40000 ALTER TABLE `cycle` DISABLE KEYS */;
INSERT INTO `cycle` VALUES (1,'Year 1 - Term 2','2020-04-16','2020-05-16',1,1,'2','2','2'),(2,'Year 2 - Term 1','2020-05-16','2020-06-16',0,1,'3','2','1'),(3,'Year 1 - Term 1','2020-03-16','2020-04-16',4,1,'1','2','1'),(4,'Year 2 - Term 2','2020-06-16','2020-07-16',0,1,'4','2','2'),(5,'Year 1 - Term 1','2020-03-19','2020-03-25',0,2,'1','2','1'),(6,'Year 2 - Term 1','2020-03-28','2020-03-29',0,2,'3','2','1'),(7,'Year 1 - Term 2','2020-03-26','2020-03-27',0,2,'2','2','2'),(8,'Year 2 - Term 2','2020-03-30','2020-03-31',0,2,'4','2','2');
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
  `Document_Name` mediumtext NOT NULL,
  `Document_Route` text NOT NULL,
  `Document_Desc` varchar(300) DEFAULT 'No Description Given.',
  `Document_Ext` varchar(45) NOT NULL DEFAULT 'Not a file',
  `InDrive` tinyint(1) NOT NULL DEFAULT '0',
  `DriveID` varchar(40) DEFAULT '0',
  `isaversionof` int(11) DEFAULT NULL,
  `version` int(11) NOT NULL DEFAULT '1',
  `md5` varchar(100) DEFAULT NULL,
  `upload_id` int(11) NOT NULL,
  `isfolder` tinyint(1) NOT NULL DEFAULT '0',
  `ao_ID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Document_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documents`
--

LOCK TABLES `documents` WRITE;
/*!40000 ALTER TABLE `documents` DISABLE KEYS */;
INSERT INTO `documents` VALUES (1,'FRONOP1.docx','uploads/FRONOP1.docx',NULL,'.docx',1,'1hawIaG7gdwNNh6OYb3r2p66m3YknskvA',NULL,1,'651548ec67c5f1435e2dbc0789cd80ed',132,0,0),(2,'Schedule-of-Availability-1.docx','uploads/Schedule-of-Availability-1.docx',NULL,'.docx',1,'1a5hclKT_uIqwIKj3MYXU0nKSLmTYf0Bs',NULL,1,'973402e6a69ef87a522f7c3c2f37ec65',132,0,0),(3,'3d2kbq7XIzQ.jpg','uploads/3d2kbq7XIzQ.jpg','Files','.jpg',1,'1EgNdetbYYcq0vNOKrYHfwYvGeYbAArKu',NULL,1,'d500c80f5b759c11a1b46822893fe3cc',132,0,0),(4,'-4K1uEPOGys.jpg','uploads/-4K1uEPOGys.jpg','Files','.jpg',1,'1pr3FCZIxxiXIQvoaEXMFEDGPqRPcuEPc',NULL,1,'1a3fb658f3e6c81fcfdb22acd751d488',132,0,0),(5,'32toiPKE0T8.jpg','uploads/32toiPKE0T8.jpg','Files','.jpg',1,'1FMdxKYE-yu01AQntHhUB5Et6S_BrmxSF',NULL,1,'d0a204c63c321b874dedb49a958f56f8',132,0,0),(6,'approval-letter.docx','uploads/approval-letter.docx','Files','.docx',1,'1b3VWQB0XEYRK21vLhCxAmaxVCHRl_zpZ',NULL,1,'67a4c6ce26779706718620f1b955a945',132,0,0),(7,'61TfyNIrWmI.jpg','uploads/61TfyNIrWmI.jpg','Files','.jpg',1,'1vBPSXReB43WU8joeep1FGw7ovcAOdGoQ',NULL,1,'136e8761661f8ae787f1290d00a2ddf4',132,0,0),(8,'businesscard.txt','uploads/businesscard.txt','Files','.txt',1,'1-KT5TlGdr_4BRoKDWk86pBTv_r6x4_Cy',NULL,1,'412ab299b6af5c1b425fff9fcfb4b6e2',132,0,0),(9,'c6sKJlA8qVE.jpg','uploads/c6sKJlA8qVE.jpg','Files','.jpg',1,'1danE0Kt4kkqwl0RbvQBysb5p7KAhYxDE',NULL,1,'23fa4ba030c2a2180713a15cb192dd08',132,0,0),(10,'BusinessCards.zip','uploads/BusinessCards.zip','Files','.zip',1,'1WqrywkY2gDV11A8LZ7O1pToZ66yT_c33',NULL,1,'5ae5bad1eb55f40886cf89abaea1ac48',132,0,0),(11,'Course-Plan-1.docx','uploads/Course-Plan-1.docx','Files','.docx',1,'1sK5U5tZGaIHKQW6mTN_HCWmZ0UUX3qRJ',NULL,1,'f06fd87ace1a8544b14533de65feec5b',132,0,0),(12,'Course-Plan-2.docx','uploads/Course-Plan-2.docx','Files','.docx',1,'1GfVuTDoxzjOIvKs3RRtD-iVhQLEufF1P',NULL,1,'5c432d4437a91b3766e110388419047f',132,0,0),(13,'drive-download-20200316T142319Z-001.zip','uploads/drive-download-20200316T142319Z-001.zip','Files','.zip',1,'1z7gZ1xMZ2JVyb7uvV3ZvWqkiHCsSAbCl',NULL,1,'0918c2418ed0fa66cb659b17f5fd33ca',132,0,0),(14,'FRONOP1.docx','uploads/FRONOP1.docx','Files','.docx',1,'1hawIaG7gdwNNh6OYb3r2p66m3YknskvA',NULL,1,'651548ec67c5f1435e2dbc0789cd80ed',132,0,0),(15,'FRONOP2ALPHA.docx','uploads/FRONOP2ALPHA.docx','Files','.docx',1,'1lwJYnGBw6PHaz2htyg2nJN0500MVfOAa',NULL,1,'fbb560a9d148bf0d16d8ce4293cc3226',132,0,0),(16,'price-20200316T142756Z-001.zip','uploads/price-20200316T142756Z-001.zip',NULL,'.zip',1,'1wcY9IoLAIf2wAGFcSnGfzajwAAToz8md',NULL,1,'64226d90ebff92177ecf6f2c6f8b7991',132,0,0),(17,'businesscard.txt','uploads/businesscard.txt',NULL,'.txt',1,'1-KT5TlGdr_4BRoKDWk86pBTv_r6x4_Cy',NULL,1,'412ab299b6af5c1b425fff9fcfb4b6e2',132,0,0),(18,'Training-Plan-2.docx','uploads/Training-Plan-2.docx',NULL,'.docx',1,'1YinwVsGm-5gWjvDZuCl4isMVvtKXgyKj',NULL,1,'c206f588556e205ea356276f0b5784ad',132,0,0),(19,'Training-Plan-1.docx','uploads/Training-Plan-1.docx',NULL,'.docx',1,'1bniLGVS4LuESl8w_8F5k1YoRQbO22Onj',NULL,1,'2f4486a6baa89a685163608cc26f3de4',132,0,0),(20,'Test Folder','kek','No Description Given.','Not a file',0,'0',NULL,1,'Is a Folder',120,1,0),(21,'FRONOP1.docx','uploads/FRONOP1.docx','Test Files in Test Folder','.docx',1,'1hawIaG7gdwNNh6OYb3r2p66m3YknskvA',NULL,1,'651548ec67c5f1435e2dbc0789cd80ed',120,0,0),(22,'FRONOP2.docx','uploads/FRONOP2.docx','Test Files in Test Folder','.docx',1,'12DOFtWKsZt7hIoqPQ5HT3Q_obaCJASrl',NULL,1,'31731ce4418b7862b842dba9bb6649a5',120,0,0),(23,'FRONOP22.docx','uploads/FRONOP22.docx','Test Files in Test Folder','.docx',1,'1xCdY27Grqrlf3ubABa2Fyk4-NPXaGKV9',NULL,1,'22a05dbf92d6d101336ab22dd57fb045',120,0,0),(24,'IMMERSIONREFLECTION.docx','uploads/IMMERSIONREFLECTION.docx','Test Files in Test Folder','.docx',1,'1uZg2dAyoIzUCVOKbxH8vNEo8WVMNLSZR',NULL,1,'8a0b681073e2c4acb55d51e66c5ffa43',120,0,0),(25,'FRONOP2ALPHA.docx','uploads/FRONOP2ALPHA.docx','Test Files in Test Folder','.docx',1,'1lwJYnGBw6PHaz2htyg2nJN0500MVfOAa',NULL,1,'fbb560a9d148bf0d16d8ce4293cc3226',120,0,0),(26,'SorianoFRONOP1.docx','uploads/SorianoFRONOP1.docx','test folder files','.docx',1,'1AcwTz8Yht9BG9f_fznqLjHVtf7Sax2Fq',NULL,1,'ce8d00ee0d565a656c6427f83ca88e6a',35,0,0),(27,'TWEEDLEDUM.docx','uploads/TWEEDLEDUM.docx','test folder files','.docx',1,'1sRmTLMg3EhNbSDCJEKDT416CHOwuIjwH',NULL,1,'184097021ab24329531072ee4794556f',35,0,0),(28,'SorianoFRONOP1.docx','uploads/SorianoFRONOP1.docx','test folder files','.docx',1,'1AcwTz8Yht9BG9f_fznqLjHVtf7Sax2Fq',NULL,1,'ce8d00ee0d565a656c6427f83ca88e6a',35,0,0),(29,'TWEEDLEDUM.docx','uploads/TWEEDLEDUM.docx','test folder files','.docx',1,'1sRmTLMg3EhNbSDCJEKDT416CHOwuIjwH',NULL,1,'184097021ab24329531072ee4794556f',35,0,0),(30,'5 Reports','not a document','No Description Given.','Not a file',0,'0',NULL,1,'0',0,1,9),(31,'Comparative count reports testing folder create','not a document','No Description Given.','Not a file',0,'0',NULL,1,'0',0,1,10),(32,'04-April-6-2011-Education-Research-and-Community-Engagements-Revised1.docx','uploads/04-April-6-2011-Education-Research-and-Community-Engagements-Revised1.docx','testing file upload','.docx',1,'1ouKrbAuSOdCozmQ8jbABOLCihlWt1Of9',NULL,1,'3fd2fa266f87cb1d509dc4184214f6ae',120,0,0),(33,'SYSADMNLab-05DiskAdministration.docx','uploads/SYSADMNLab-05DiskAdministration.docx','testing file upload','.docx',1,'15ZxF3yjhoeHjBClRyqP9OV8rTcGNC0tM',NULL,1,'10c2a7a4823d51b833c776eaa8d51e20',120,0,0),(34,'Dump20190716.sql','uploads/Dump20190716.sql',NULL,'.sql',1,'1FzbdIb9kvqTDFGZqLb_BcVCS6wIfjmci',NULL,1,'7d85fbf77811f28403295a24ef4d42fb',120,0,0),(36,'04-April-6-2011-Education-Research-and-Community-Engagements-Revised151300a859edocx','uploads/04-April-6-2011-Education-Research-and-Community-Engagements-Revised151300a859edocx',NULL,'.docx',0,'0',NULL,1,'51300a859e1f9569749a4440b9781ab4',120,0,0),(37,'AlasRamus.jpg','uploads/AlasRamus.jpg',NULL,'.jpg',0,'0',NULL,1,'e6561552b8c031525e00a330dfe0bdb5',137,0,0),(38,'356587.jpg','uploads/356587.jpg',NULL,'.jpg',1,'1fnfrj5nIlQ15TouN91ZNsddzN4PLPAkr',NULL,1,'95cd9b821a08ba01d2a5aa4371f434bf',121,0,0),(39,'18582269_1166557730156984_7612090937287607457_n.jpg','uploads/18582269_1166557730156984_7612090937287607457_n.jpg',NULL,'.jpg',1,'1Avc6fVQo_8y6ejuGFNzyUAtdWenNiNCI',NULL,1,'66523c0496d27a26988e254d8640a629',121,0,0);
/*!40000 ALTER TABLE `documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `folder_documents`
--

DROP TABLE IF EXISTS `folder_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `folder_documents` (
  `folder_id` int(11) NOT NULL,
  `document_id` int(11) NOT NULL,
  `folder_name` mediumtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `folder_documents`
--

LOCK TABLES `folder_documents` WRITE;
/*!40000 ALTER TABLE `folder_documents` DISABLE KEYS */;
INSERT INTO `folder_documents` VALUES (20,28,'Test Folder'),(20,29,'Test Folder'),(31,2,'Comparative count reports testing folder create'),(31,1,'Comparative count reports testing folder create'),(31,3,'Comparative count reports testing folder create'),(30,10,'5 Reports'),(30,11,'5 Reports'),(30,12,'5 Reports'),(30,13,'5 Reports');
/*!40000 ALTER TABLE `folder_documents` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group`
--

LOCK TABLES `group` WRITE;
/*!40000 ALTER TABLE `group` DISABLE KEYS */;
INSERT INTO `group` VALUES (0,'No Group Assigned',0),(1,'Analysis',1),(2,'Evaluation',1),(3,'Analysis',2),(4,'Evaluation',2),(5,'Analysis',3),(6,'Evaluation',3),(7,'Analysis',4),(8,'Evaluation',4),(9,'Analysis',5),(10,'Evaluation',5),(11,'Analysis',6),(12,'Evaluation',6),(13,'Analysis',7),(14,'Evaluation',7),(15,'Analysis',8),(16,'Evaluation',8),(17,'Analysis',9),(18,'Evaluation',9),(19,'Test Area',1),(20,'TESTING',2),(21,'RESEARCH GROUP',1),(22,'GROUP NUMBER 5',1),(23,'GROUP NUMBER 6 ',1);
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
INSERT INTO `groupdetails` VALUES (1,35,'Member'),(1,46,'Member'),(2,82,'Leader'),(2,83,'Member'),(2,84,'Member'),(19,85,'Member'),(19,87,'Member'),(19,86,'Member'),(19,88,'Member'),(19,89,'Member'),(21,91,'Member'),(21,93,'Member'),(21,92,'Member'),(3,94,'Leader'),(3,90,'Member'),(5,98,'Member'),(5,99,'Member'),(5,97,'Member'),(5,96,'Member'),(5,95,'Member'),(7,100,'Member'),(7,103,'Member'),(7,104,'Member'),(7,102,'Member'),(7,101,'Member'),(18,120,'Member'),(18,121,'Member'),(21,131,'Member'),(21,132,'Leader'),(21,133,'Member'),(20,120,'Leader'),(20,121,'Member'),(20,123,'Member'),(20,122,'Member'),(22,134,'Leader'),(22,135,'Member'),(22,136,'Member'),(23,137,'Member'),(23,138,'Leader');
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
  `QualityTarget` int(11) DEFAULT NULL,
  `Procedures` varchar(500) DEFAULT NULL,
  `GroupAssigned` int(11) DEFAULT NULL,
  `metric_ID` int(11) DEFAULT NULL,
  `measurement_Name` mediumtext NOT NULL,
  `measurement_Description` mediumtext NOT NULL,
  `Deadline` varchar(45) DEFAULT NULL,
  `cycle_ID` int(11) NOT NULL,
  `priority_Level` int(11) NOT NULL,
  PRIMARY KEY (`measurement_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `measurement`
--

LOCK TABLES `measurement` WRITE;
/*!40000 ALTER TABLE `measurement` DISABLE KEYS */;
INSERT INTO `measurement` VALUES (1,NULL,NULL,NULL,NULL,'Recruitment','Incremental increase in the number of faculty.',NULL,1,1),(2,NULL,NULL,NULL,NULL,'Training Seminars held in and out of campus','Seminars which will develop the skills of the faculty as well possibly encourage outsiders to apply for work in DLSU',NULL,1,2),(3,NULL,NULL,NULL,NULL,'Increase rate and quality of published research/works','To improve the Confidentiality, Integrity, and Accessibility of files created by students or professors that can be used for references',NULL,1,2);
/*!40000 ALTER TABLE `measurement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `measurement_audit`
--

DROP TABLE IF EXISTS `measurement_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `measurement_audit` (
  `measurement_auditID` int(11) NOT NULL AUTO_INCREMENT,
  `measurement_ID` int(11) NOT NULL,
  `QualityTarget` int(11) DEFAULT NULL,
  `Procedures` varchar(500) DEFAULT NULL,
  `GroupAssigned` int(11) DEFAULT NULL,
  `metric_ID` int(11) DEFAULT NULL,
  `measurement_Name` mediumtext NOT NULL,
  `measurement_Description` mediumtext NOT NULL,
  `Deadline` varchar(45) DEFAULT NULL,
  `cycle_ID` int(11) NOT NULL,
  `audit_date` date NOT NULL,
  `priority_Level` int(11) NOT NULL,
  PRIMARY KEY (`measurement_auditID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `measurement_audit`
--

LOCK TABLES `measurement_audit` WRITE;
/*!40000 ALTER TABLE `measurement_audit` DISABLE KEYS */;
INSERT INTO `measurement_audit` VALUES (1,1,NULL,NULL,NULL,NULL,'Recruitment','Incremental increase in the number of faculty.',NULL,3,'2020-03-16',1),(2,2,NULL,NULL,NULL,NULL,'Training Seminars held in and out of campus','Seminars which will develop the skills of the faculty as well possibly encourage outsiders to apply for work in DLSU',NULL,3,'2020-03-16',2),(3,3,NULL,NULL,NULL,NULL,'Increase rate and quality of published research/works','To improve the Confidentiality, Integrity, and Accessibility of files created by students or professors that can be used for references',NULL,3,'2020-03-16',2);
/*!40000 ALTER TABLE `measurement_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `measurements_activities`
--

DROP TABLE IF EXISTS `measurements_activities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `measurements_activities` (
  `measurement_ID` int(11) NOT NULL,
  `activity_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `measurements_activities`
--

LOCK TABLES `measurements_activities` WRITE;
/*!40000 ALTER TABLE `measurements_activities` DISABLE KEYS */;
INSERT INTO `measurements_activities` VALUES (1,1),(1,2),(2,3),(2,4),(3,5);
/*!40000 ALTER TABLE `measurements_activities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `measurements_activities_audit`
--

DROP TABLE IF EXISTS `measurements_activities_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `measurements_activities_audit` (
  `measurement_activities_audit_ID` int(11) NOT NULL AUTO_INCREMENT,
  `measurements_auditID` int(11) DEFAULT NULL,
  `measurement_ID` int(11) NOT NULL,
  `activity_ID` int(11) NOT NULL,
  PRIMARY KEY (`measurement_activities_audit_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `measurements_activities_audit`
--

LOCK TABLES `measurements_activities_audit` WRITE;
/*!40000 ALTER TABLE `measurements_activities_audit` DISABLE KEYS */;
INSERT INTO `measurements_activities_audit` VALUES (1,1,1,1),(2,1,1,2),(3,2,2,3),(4,2,2,4),(5,3,3,5);
/*!40000 ALTER TABLE `measurements_activities_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `measurements_targets`
--

DROP TABLE IF EXISTS `measurements_targets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `measurements_targets` (
  `measurementID` int(11) NOT NULL,
  `target` int(11) NOT NULL,
  `progress` int(11) DEFAULT NULL,
  `target_ID` int(11) NOT NULL AUTO_INCREMENT,
  `target_Type` int(11) DEFAULT NULL,
  `target_Desc` mediumtext,
  PRIMARY KEY (`target_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `measurements_targets`
--

LOCK TABLES `measurements_targets` WRITE;
/*!40000 ALTER TABLE `measurements_targets` DISABLE KEYS */;
INSERT INTO `measurements_targets` VALUES (1,5,3,1,1,'at least 5 new recruited faculty.'),(1,80,20,2,0,'faculty retention within the succeeding years'),(2,3,3,3,1,'At least 3 per term'),(2,3,4,4,1,'At least 3 venues'),(3,5,2,5,0,'Increase outputs');
/*!40000 ALTER TABLE `measurements_targets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `measurements_targets_audit`
--

DROP TABLE IF EXISTS `measurements_targets_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `measurements_targets_audit` (
  `measurements_targets_auditID` int(11) NOT NULL AUTO_INCREMENT,
  `measurements_auditID` int(11) NOT NULL,
  `measurementID` int(11) NOT NULL,
  `target` int(11) NOT NULL,
  `progress` int(11) DEFAULT NULL,
  `target_ID` int(11) NOT NULL,
  `target_Type` int(11) DEFAULT NULL,
  `target_Desc` mediumtext,
  PRIMARY KEY (`measurements_targets_auditID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `measurements_targets_audit`
--

LOCK TABLES `measurements_targets_audit` WRITE;
/*!40000 ALTER TABLE `measurements_targets_audit` DISABLE KEYS */;
INSERT INTO `measurements_targets_audit` VALUES (1,1,1,5,3,1,1,'at least 5 new recruited faculty.'),(2,1,1,80,20,2,0,'faculty retention within the succeeding years'),(3,2,2,3,3,3,1,'At least 3 per term'),(4,2,2,3,4,4,1,'At least 3 venues'),(5,3,3,5,2,5,0,'Increase outputs');
/*!40000 ALTER TABLE `measurements_targets_audit` ENABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meetings`
--

LOCK TABLES `meetings` WRITE;
/*!40000 ALTER TABLE `meetings` DISABLE KEYS */;
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
  `cycle_ID` int(11) DEFAULT '0',
  `duration` varchar(200) DEFAULT NULL,
  `cycle_Status` varchar(11) DEFAULT NULL,
  `source_Type` varchar(200) DEFAULT NULL,
  `cycle_Created` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`metric_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metric`
--

LOCK TABLES `metric` WRITE;
/*!40000 ALTER TABLE `metric` DISABLE KEYS */;
INSERT INTO `metric` VALUES (1,'Grow and develop I.T Department  2020-2025','To provide sufficient and quality personnel for the every growing student body, at the same time an opportunity for faculty developement and invite new perspective into DLSU-CCS-IT Dept.',NULL,NULL,0,1,0,NULL,'Active','Quality Assurance Goals',1),(2,'test ','test',NULL,NULL,0,1,0,NULL,'Active','Quality Assurance Goals',1);
/*!40000 ALTER TABLE `metric` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `notifications` (
  `Notifications_ID` int(11) NOT NULL AUTO_INCREMENT,
  `message` mediumtext NOT NULL,
  `sender` int(11) DEFAULT NULL,
  `receiver` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `range` int(11) NOT NULL,
  `admin` tinyint(1) NOT NULL,
  `sysadmin` tinyint(1) NOT NULL,
  `triggerdate` date DEFAULT NULL,
  `isactivity` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Notifications_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` VALUES (1,'Cycles have been created for Goal: undefined',35,0,1,1,1,1,'2020-03-16',0),(2,'Measurements have been created for Goal: undefined',35,0,1,1,1,1,'2020-03-16',0),(3,'Activity: Technology Convention 2020 Recruitmentis due today',35,1,1,1,1,1,'2020-03-20',1),(4,'Activity: Technology Convention 2020 Recruitmentis due tomorrow',35,1,1,1,1,1,'2020-03-19',1),(5,'Activity: Technology Convention 2020 Recruitmentis due in 3 days at:2020-03-20',35,1,1,1,1,1,'2020-03-17',1),(6,'Activity: Technology Convention 2020 Recruitmentis due in 7 days at:2020-03-20',35,1,1,1,1,1,'2020-03-13',1),(7,'Activity: Teaching Training Workshop 2020is due today',35,2,1,1,1,1,'2020-03-21',1),(8,'Activity: Teaching Training Workshop 2020is due in 3 days at:2020-03-21',35,2,1,1,1,1,'2020-03-18',1),(9,'Activity: Teaching Training Workshop 2020is due tomorrow',35,2,1,1,1,1,'2020-03-20',1),(10,'Activity: Teaching Training Workshop 2020is due in 7 days at:2020-03-21',35,2,1,1,1,1,'2020-03-14',1),(11,'Activities have been added to Measurement/s Recruitment',35,0,1,2,1,1,'2020-03-16',0),(12,'Activities have been added to Measurement/s Recruitment',35,0,1,2,1,1,'2020-03-16',0),(13,'Measurements have been created for Goal: undefined',35,0,1,1,1,1,'2020-03-16',0),(14,'Measurements have been created for Goal: undefined',35,0,1,1,1,1,'2020-03-16',0),(15,'Activity: Seminar Plansis due today',35,3,1,1,1,1,'2020-03-20',1),(16,'Activity: Seminar Plansis due tomorrow',35,3,1,1,1,1,'2020-03-19',1),(17,'Activity: Possible Locations To hold Seminarsis due today',35,4,1,1,1,1,'2020-03-31',1),(18,'Activity: Possible Locations To hold Seminarsis due in 3 days at:2020-03-31',35,4,1,1,1,1,'2020-03-28',1),(19,'Activity: Seminar Plansis due in 3 days at:2020-03-20',35,3,1,1,1,1,'2020-03-17',1),(20,'Activity: Seminar Plansis due in 7 days at:2020-03-20',35,3,1,1,1,1,'2020-03-13',1),(21,'Activity: Possible Locations To hold Seminarsis due in 7 days at:2020-03-31',35,4,1,1,1,1,'2020-03-24',1),(22,'Activities have been added to Measurement/s Training Seminars held in and out of campus',35,0,1,2,1,1,'2020-03-16',0),(23,'Activity: Possible Locations To hold Seminarsis due tomorrow',35,4,1,1,1,1,'2020-03-30',1),(24,'Activities have been added to Measurement/s Training Seminars held in and out of campus',35,0,1,2,1,1,'2020-03-16',0),(25,'Activity: Comparative count reportsis due today',35,5,1,1,1,1,'2020-03-25',1),(26,'Activity: Comparative count reportsis due tomorrow',35,5,1,1,1,1,'2020-03-24',1),(27,'Activity: Comparative count reportsis due in 3 days at:2020-03-25',35,5,1,1,1,1,'2020-03-22',1),(28,'Activity: Comparative count reportsis due in 7 days at:2020-03-25',35,5,1,1,1,1,'2020-03-18',1),(29,'Activities have been added to Measurement/s Increase rate and quality of published research/works',35,0,1,2,1,1,'2020-03-16',0),(30,'User Jericho Rosales has been created',35,133,1,1,1,1,'2020-03-16',0),(31,'User undefined undefined has been assigned to Group',35,133,1,2,1,1,'2020-03-16',0),(32,'Progress has been declared for Measurement: undefined',35,0,1,1,1,1,'2020-03-16',0),(33,'Progress has been declared for Measurement: undefined',35,0,1,1,1,1,'2020-03-16',0),(34,'Progress has been declared for Measurement: undefined',35,0,1,1,1,1,'2020-03-16',0),(35,'Cycles have been created for Goal: undefined',35,0,1,1,1,1,'2020-03-19',0),(36,'User undefined undefined has been assigned to Group',35,120,1,2,1,1,'2020-03-20',0),(37,'User undefined undefined has been assigned to Group',35,123,1,2,1,1,'2020-03-20',0),(38,'User undefined undefined has been assigned to Group',35,122,1,2,1,1,'2020-03-20',0),(39,'User undefined undefined has been assigned to Group',35,121,1,2,1,1,'2020-03-20',0),(40,'User Brian Jason has been created',35,134,1,1,1,1,'2020-03-21',0),(41,'User Echo Ng has been created',35,135,1,1,1,1,'2020-03-21',0),(42,'User Group Five has been created',35,136,1,1,1,1,'2020-03-21',0),(43,'User undefined undefined has been assigned to Group',35,134,1,2,1,1,'2020-03-21',0),(44,'User undefined undefined has been assigned to Group',35,135,1,2,1,1,'2020-03-21',0),(45,'User undefined undefined has been assigned to Group',35,136,1,2,1,1,'2020-03-21',0),(46,'User Group six has been created',35,137,1,1,1,1,'2020-03-21',0),(47,'User Desmond Las has been created',35,138,1,1,1,1,'2020-03-21',0),(48,'User undefined undefined has been assigned to Group',35,137,1,2,1,1,'2020-03-21',0),(49,'User undefined undefined has been assigned to Group',35,138,1,2,1,1,'2020-03-21',0);
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications_read`
--

DROP TABLE IF EXISTS `notifications_read`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `notifications_read` (
  `Notifications_ID` int(11) NOT NULL,
  `Recipient_ID` int(11) NOT NULL,
  `notif_read` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications_read`
--

LOCK TABLES `notifications_read` WRITE;
/*!40000 ALTER TABLE `notifications_read` DISABLE KEYS */;
INSERT INTO `notifications_read` VALUES (1,0,0),(1,35,0),(1,46,0),(2,0,0),(2,46,0),(2,35,0),(3,1,1),(4,1,1),(5,1,1),(3,35,0),(6,1,1),(8,2,1),(10,2,1),(9,2,1),(7,2,1),(11,0,0),(11,35,0),(3,46,0),(12,0,0),(12,35,0),(4,35,0),(4,46,0),(5,35,0),(5,46,0),(11,35,0),(11,46,0),(6,35,0),(6,46,0),(8,35,0),(8,46,0),(10,35,0),(10,46,0),(9,35,0),(9,46,0),(7,35,0),(12,35,0),(12,46,0),(7,46,0),(13,0,0),(13,35,0),(13,46,0),(14,0,0),(14,35,0),(14,46,0),(15,3,1),(16,3,1),(17,4,1),(20,3,1),(18,4,1),(19,3,1),(21,4,1),(20,35,0),(22,0,0),(22,35,0),(15,35,0),(16,35,0),(16,46,0),(23,4,1),(17,35,0),(21,35,0),(21,46,0),(23,35,0),(23,46,0),(20,46,0),(15,46,0),(17,46,0),(18,35,0),(18,46,0),(19,35,0),(24,0,0),(19,46,0),(24,35,0),(22,35,0),(22,46,0),(24,35,0),(24,46,0),(25,5,1),(27,5,1),(28,5,1),(26,5,1),(25,46,0),(25,35,0),(27,35,0),(27,46,0),(29,0,0),(29,35,0),(28,35,0),(28,46,0),(26,35,0),(26,46,0),(29,35,0),(29,46,0),(30,133,0),(30,35,0),(30,46,0),(31,133,0),(31,35,0),(31,35,0),(31,46,0),(32,0,0),(32,35,0),(32,46,0),(33,0,0),(33,35,0),(33,46,0),(34,0,0),(34,35,0),(34,46,0),(35,0,0),(35,35,0),(35,46,0),(36,120,0),(36,35,0),(36,46,0),(36,35,0),(37,123,0),(37,35,0),(38,122,0),(39,121,0),(38,35,0),(39,35,0),(39,46,0),(38,35,0),(39,35,0),(38,46,0),(37,35,0),(37,46,0),(40,134,0),(40,35,0),(40,46,0),(41,135,0),(41,35,0),(41,46,0),(42,136,0),(42,35,0),(42,46,0),(43,134,0),(43,35,0),(43,46,0),(43,35,0),(45,136,0),(44,135,0),(45,35,0),(45,35,0),(45,46,0),(44,35,0),(44,46,0),(44,35,0),(46,137,0),(46,35,0),(46,46,0),(47,138,0),(47,35,0),(47,46,0),(48,137,0),(48,35,0),(48,46,0),(48,35,0),(49,138,0),(49,35,0),(49,46,0),(49,35,0);
/*!40000 ALTER TABLE `notifications_read` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pending_activities`
--

DROP TABLE IF EXISTS `pending_activities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `pending_activities` (
  `pending_ID` int(11) NOT NULL AUTO_INCREMENT,
  `activity_ID` int(11) NOT NULL,
  `activity_name` varchar(500) NOT NULL,
  `target` int(11) DEFAULT NULL,
  `code` tinyint(1) DEFAULT NULL,
  `description` mediumtext,
  `measurement_ID` int(11) DEFAULT NULL,
  `current_Score` int(11) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '0',
  `suggested_Score` int(11) DEFAULT NULL,
  `dateupdated` date NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `user_ID` int(11) NOT NULL,
  `comment` mediumtext,
  `cycle_ID` int(11) NOT NULL,
  PRIMARY KEY (`pending_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pending_activities`
--

LOCK TABLES `pending_activities` WRITE;
/*!40000 ALTER TABLE `pending_activities` DISABLE KEYS */;
INSERT INTO `pending_activities` VALUES (1,3,'Seminar Plans',NULL,0,'Submission for both proposal and schedule',NULL,NULL,1,0,'2020-03-16',0,132,'Good Job',3),(2,4,'Possible Locations To hold Seminars',NULL,0,'Price List',NULL,NULL,1,0,'2020-03-16',0,132,'Nice Work',3),(3,1,'Technology Convention 2020 Recruitment',NULL,0,'Business Card of Person A',NULL,NULL,1,0,'2020-03-16',0,132,'Good Job',3),(4,2,'Teaching Training Workshop 2020',NULL,0,'Training Plan Term 2',NULL,NULL,2,0,'2020-03-16',1,132,'1 More example',3),(5,2,'Teaching Training Workshop 2020',NULL,0,'Training Plan files 1 and 2',NULL,NULL,1,0,'2020-03-16',0,132,'Complete',3),(6,5,'Comparative count reports',NULL,0,'Comparative report 2019',NULL,NULL,1,0,'2020-03-16',1,132,'Great Evidence',3),(7,5,'Comparative count reports',NULL,0,'testing duplicate',NULL,NULL,0,0,'2020-03-20',1,120,NULL,1),(8,5,'Comparative count reports',NULL,0,'testing ',NULL,NULL,0,0,'2020-03-20',1,120,NULL,1),(9,5,'Comparative count reports',NULL,0,'testing ',NULL,NULL,0,0,'2020-03-20',1,120,NULL,1),(10,5,'Comparative count reports',NULL,0,'testing same name different content',NULL,NULL,0,0,'2020-03-20',1,120,NULL,1),(11,5,'Comparative count reports',NULL,0,'testing same name different content',NULL,NULL,0,0,'2020-03-20',1,120,NULL,1),(12,5,'Comparative count reports',NULL,0,'RESEARCH GROUP MEMBER SUBMISSION JERICHO ROSALES',NULL,NULL,0,0,'2020-03-21',1,133,NULL,1),(13,5,'Comparative count reports',NULL,0,'SUBMISSION REPORT BY ECHO NG OF GROUP NUMBER 5',NULL,NULL,0,0,'2020-03-21',1,135,NULL,1),(14,5,'Comparative count reports',NULL,0,'SUBMISSION REPORT BY GROUPSIX OF GROUP NUMBER 6',NULL,NULL,0,0,'2020-03-21',1,137,NULL,1),(15,5,'Comparative count reports',NULL,0,'SUBMISSION REPORT BY EDGELORD OF GROUP TESTING',NULL,NULL,1,0,'2020-03-21',1,121,'good enough',1);
/*!40000 ALTER TABLE `pending_activities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pending_activities_audit`
--

DROP TABLE IF EXISTS `pending_activities_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `pending_activities_audit` (
  `pending_activities_auditID` int(11) NOT NULL AUTO_INCREMENT,
  `measurement_activities_auditID` int(11) NOT NULL,
  `measurement_auditID` int(11) NOT NULL,
  `pending_ID` int(11) NOT NULL,
  `activity_ID` int(11) NOT NULL,
  `activity_name` varchar(500) NOT NULL,
  `target` int(11) DEFAULT NULL,
  `code` tinyint(1) DEFAULT NULL,
  `description` mediumtext,
  `measurement_ID` int(11) DEFAULT NULL,
  `current_Score` int(11) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '0',
  `suggested_Score` int(11) DEFAULT NULL,
  `dateupdated` date NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `user_ID` int(11) NOT NULL,
  `comment` mediumtext,
  `cycle_ID` int(11) NOT NULL,
  PRIMARY KEY (`pending_activities_auditID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pending_activities_audit`
--

LOCK TABLES `pending_activities_audit` WRITE;
/*!40000 ALTER TABLE `pending_activities_audit` DISABLE KEYS */;
INSERT INTO `pending_activities_audit` VALUES (1,1,1,3,1,'Technology Convention 2020 Recruitment',NULL,0,'Business Card of Person A',NULL,NULL,1,0,'2020-03-15',1,132,'Good Job',3),(2,2,1,5,2,'Teaching Training Workshop 2020',NULL,0,'Training Plan files 1 and 2',NULL,NULL,1,0,'2020-03-15',1,132,'Complete',3),(3,4,2,2,4,'Possible Locations To hold Seminars',NULL,0,'Price List',NULL,NULL,1,0,'2020-03-15',1,132,'Nice Work',3),(4,3,2,1,3,'Seminar Plans',NULL,0,'Submission for both proposal and schedule',NULL,NULL,1,0,'2020-03-15',1,132,'Good Job',3),(5,5,3,6,5,'Comparative count reports',NULL,0,'Comparative report 2019',NULL,NULL,1,0,'2020-03-15',1,132,'Great Evidence',3);
/*!40000 ALTER TABLE `pending_activities_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pending_outputs`
--

DROP TABLE IF EXISTS `pending_outputs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `pending_outputs` (
  `activityID` int(11) NOT NULL,
  `outputID` int(11) NOT NULL,
  `pendingID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pending_outputs`
--

LOCK TABLES `pending_outputs` WRITE;
/*!40000 ALTER TABLE `pending_outputs` DISABLE KEYS */;
INSERT INTO `pending_outputs` VALUES (3,3,1),(3,4,1),(4,5,2),(1,1,3),(2,2,4),(2,2,5),(5,7,6),(5,7,7),(5,7,9),(5,7,10),(5,7,11),(5,7,12),(5,7,13),(5,7,14),(5,7,15);
/*!40000 ALTER TABLE `pending_outputs` ENABLE KEYS */;
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
-- Table structure for table `plans`
--

DROP TABLE IF EXISTS `plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `plans` (
  `Plan_ID` int(11) NOT NULL AUTO_INCREMENT,
  `GenObjective` varchar(200) NOT NULL,
  `Measurement` varchar(200) NOT NULL,
  `BaseFormula` varchar(200) NOT NULL,
  `QualityTarget` varchar(200) NOT NULL,
  `Procedures` varchar(500) NOT NULL,
  `GroupAssigned` int(11) DEFAULT NULL,
  `CycleTime` int(11) DEFAULT '0',
  `PriorityLevel` varchar(45) DEFAULT 'No Priority Level Set',
  `BaseStandard` varchar(200) DEFAULT 'No Base Standard Set',
  `recommendation_ID` int(11) DEFAULT NULL,
  `PlanName` varchar(45) NOT NULL,
  `PlanDescription` varchar(200) DEFAULT NULL,
  `Plan_MinCycles` int(11) DEFAULT '3',
  `Deadline` varchar(45) DEFAULT NULL,
  `CycleCount` int(11) DEFAULT NULL,
  PRIMARY KEY (`Plan_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plans`
--

LOCK TABLES `plans` WRITE;
/*!40000 ALTER TABLE `plans` DISABLE KEYS */;
INSERT INTO `plans` VALUES (7,'123','123','123','123','123',1,0,'High','No base standard assigned',18,'123','123',3,'07/30/2019',NULL);
/*!40000 ALTER TABLE `plans` ENABLE KEYS */;
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
-- Table structure for table `players`
--

DROP TABLE IF EXISTS `players`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `players` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `position` varchar(255) NOT NULL,
  `number` int(11) NOT NULL,
  `image` varchar(255) NOT NULL,
  `user_name` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `players`
--

LOCK TABLES `players` WRITE;
/*!40000 ALTER TABLE `players` DISABLE KEYS */;
/*!40000 ALTER TABLE `players` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `privileges`
--

DROP TABLE IF EXISTS `privileges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `privileges` (
  `privilegeId` int(11) NOT NULL AUTO_INCREMENT,
  `PrivilegeType` varchar(45) NOT NULL,
  PRIMARY KEY (`privilegeId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `privileges`
--

LOCK TABLES `privileges` WRITE;
/*!40000 ALTER TABLE `privileges` DISABLE KEYS */;
INSERT INTO `privileges` VALUES (1,'Edit,View,Upload,Delete'),(2,'Edit,View,Upload'),(3,'View,Upload');
/*!40000 ALTER TABLE `privileges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recommendation`
--

DROP TABLE IF EXISTS `recommendation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `recommendation` (
  `recommendation_ID` int(11) NOT NULL AUTO_INCREMENT,
  `recommendation_Name` varchar(45) DEFAULT NULL,
  `recommendation_Desc` varchar(200) DEFAULT NULL,
  `recommendation_Grade` varchar(45) DEFAULT NULL,
  `priority_Level` varchar(45) DEFAULT NULL,
  `date_insert` datetime DEFAULT NULL,
  `area_ID` int(11) DEFAULT NULL,
  `group_ID` int(11) DEFAULT '0',
  `accreditation_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`recommendation_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recommendation`
--

LOCK TABLES `recommendation` WRITE;
/*!40000 ALTER TABLE `recommendation` DISABLE KEYS */;
INSERT INTO `recommendation` VALUES (18,'123','123','A','High','2019-07-21 00:00:00',1,1,1);
/*!40000 ALTER TABLE `recommendation` ENABLE KEYS */;
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
INSERT INTO `roles` VALUES (1,'Admin'),(2,'QA Officer'),(3,'Department Chair'),(4,'User');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scores`
--

DROP TABLE IF EXISTS `scores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `scores` (
  `idScores` int(11) NOT NULL AUTO_INCREMENT,
  `Criteria` varchar(255) NOT NULL,
  `GeneralObjective` varchar(255) NOT NULL,
  `QualityTarget` int(11) NOT NULL,
  `GroupAssigned` varchar(45) NOT NULL,
  `PersonnelAssigned` varchar(45) DEFAULT NULL,
  `PriorityLevel` int(11) DEFAULT NULL,
  `PreviousScore` int(11) DEFAULT NULL,
  `CurrentScore` int(11) DEFAULT NULL,
  `PrevOrCurr` int(11) NOT NULL,
  PRIMARY KEY (`idScores`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scores`
--

LOCK TABLES `scores` WRITE;
/*!40000 ALTER TABLE `scores` DISABLE KEYS */;
INSERT INTO `scores` VALUES (1,'All classrooms contain fire extinguishers for cases of emergency	','Safety Practices and Academic Efficiency',8,'Student Services','Jana',9,5,7,0),(2,'All Scientific Laboratories contain proper safety materials and follow proper safety guidelines','Safety Practices and Academic Efficiency',9,'Student Services','Test',9,9,6,0),(3,'Each classrooms contain learning materials athat are in good condition to be used for academic learning','Safety Practices and Academic Efficiency',9,'Student Services','Test',9,6,8,0),(4,'The library has enough learnin resources that can help the student with their specific courses','Library',8,'Student Services',NULL,9,7,7,1),(5,'All Computers in the computer laboratories are well maintained and suffices the technological specifications for the student\'s needs','Safety Practices and Academic Efficiency',9,'Student Services',NULL,9,7,9,1),(6,'The Laboratories are well maintained and upgraded to increase guranteed safety and learning efficiency of the students','Safety Practices and Academic Efficiency',9,'Student Services',NULL,9,6,6,1);
/*!40000 ALTER TABLE `scores` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `source`
--

LOCK TABLES `source` WRITE;
/*!40000 ALTER TABLE `source` DISABLE KEYS */;
INSERT INTO `source` VALUES (1,'Department','Department Based');
/*!40000 ALTER TABLE `source` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sourcetype`
--

DROP TABLE IF EXISTS `sourcetype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sourcetype` (
  `stype_ID` int(11) NOT NULL,
  `SourceType` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sourcetype`
--

LOCK TABLES `sourcetype` WRITE;
/*!40000 ALTER TABLE `sourcetype` DISABLE KEYS */;
INSERT INTO `sourcetype` VALUES (1,'Quality Assurance Goals'),(1,'University Goals'),(1,'Department Goals');
/*!40000 ALTER TABLE `sourcetype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysvalues`
--

DROP TABLE IF EXISTS `sysvalues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sysvalues` (
  `idsysvalues` int(11) NOT NULL,
  `inmaintenance` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idsysvalues`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysvalues`
--

LOCK TABLES `sysvalues` WRITE;
/*!40000 ALTER TABLE `sysvalues` DISABLE KEYS */;
INSERT INTO `sysvalues` VALUES (1,0);
/*!40000 ALTER TABLE `sysvalues` ENABLE KEYS */;
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
  `isleader` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`User_ID`),
  UNIQUE KEY `username_UNIQUE` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=139 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (35,'Admin','Admin','debug@debug.com',1,1,'99999999999','Admin','$2b$10$w1q.GZyvVMwt9c6aiFjBEuahRim1NOtIgFOY8DYsxoJuN31CsUGsu',0),(46,'AdminX','AdminX','debug@debug.com',1,1,'99999999999','AdminX','$2b$10$bWyFihniq34XjVzTZXXMjeqbF1LeG.gP06X2FLc.XZ6vgH5wHo6.e',0),(47,'Jayme','Randall','quis.massa.Mauris@amalesuadaid.com',4,NULL,'0827150506','orci.consectetuer.euismod@convalliserat.co.uk',NULL,0),(48,'Hedda','Blanchard','dolor.egestas.rhoncus@etmagnisdis.com',4,NULL,'0532678474','egestas.hendrerit@Maurisblanditenim.co.uk',NULL,0),(49,'Quentin','Farmer','senectus.et.netus@Nulla.co.uk',4,NULL,'0424963076','vitae.erat@risusDuisa.net',NULL,0),(50,'Rooney','Lawson','lectus@utipsumac.com',4,NULL,'0017842615','ipsum.nunc.id@velitSedmalesuada.edu',NULL,0),(51,'Fuller','Lawson','lorem.vitae.odio@turpisNulla.com',4,NULL,'0104998917','ut.pellentesque.eget@Aliquamvulputate.net',NULL,0),(52,'Naida','Travis','molestie.orci.tincidunt@diamSed.org',4,NULL,'0396262927','ipsum@hymenaeosMaurisut.com',NULL,0),(53,'Shelly','Odonnell','consequat.purus@ut.com',4,NULL,'0741793038','Etiam.gravida.molestie@lectus.edu',NULL,0),(54,'Nomlanga','Wiley','sociis@imperdietnecleo.net',4,NULL,'0463195329','ut.pellentesque.eget@semNulla.org',NULL,0),(55,'Pamela','Payne','cursus.et.magna@cursusaenim.net',4,NULL,'0336253671','diam@tempus.edu',NULL,0),(56,'Dale','Fulton','consequat.dolor@vestibulum.edu',4,NULL,'0621007822','ultricies@Vivamuseuismodurna.co.uk',NULL,0),(57,'Brock','Tanner','magnis.dis@iaculisaliquetdiam.com',4,NULL,'0485322526','ornare.lectus.justo@dolorFuscemi.net',NULL,0),(58,'Drake','Hogan','Integer@nequeMorbi.co.uk',4,NULL,'0122087593','sed.turpis@arcuVestibulum.net',NULL,0),(59,'Fitzgerald','Ortiz','arcu@in.edu',4,NULL,'0353804236','vitae.aliquam.eros@quispedePraesent.edu',NULL,0),(60,'Isaiah','Kemp','pellentesque@lacinia.co.uk',4,NULL,'0687689022','enim.Etiam.gravida@enimEtiamgravida.org',NULL,0),(61,'Cassady','Carson','adipiscing@quisaccumsan.org',4,NULL,'0822841725','justo@Loremipsumdolor.org',NULL,0),(62,'Yeo','Allison','Sed.auctor@vulputate.edu',4,NULL,'0751834790','Nunc.quis@arcuVestibulum.com',NULL,0),(63,'Daria','Knox','nec.mauris.blandit@rhoncusDonec.co.uk',4,NULL,'0068744702','neque.sed@quispedePraesent.co.uk',NULL,0),(64,'Preston','Melton','massa.non@tempusscelerisque.com',4,NULL,'0385565489','vel.venenatis@non.net',NULL,0),(65,'Chaim','Walls','ullamcorper.nisl.arcu@Vivamus.org',4,NULL,'0994904810','vitae.nibh@eget.com',NULL,0),(66,'Karly','Shaw','nisl.Quisque.fringilla@nonfeugiatnec.co.uk',4,NULL,'0617257074','penatibus.et@nuncsed.net',NULL,0),(67,'Maisie','Sharp','ac.mi.eleifend@eratSed.edu',4,NULL,'0046643354','at.iaculis.quis@malesuadamalesuadaInteger.com',NULL,0),(68,'Indigo','Mccoy','sit.amet.nulla@feugiatnec.ca',4,NULL,'0769322656','consectetuer.cursus@risusQuisque.ca',NULL,0),(69,'Keane','Parsons','Morbi@Aliquameratvolutpat.net',4,NULL,'0876062059','libero.est@necmaurisblandit.edu',NULL,0),(70,'Rafael','Schmidt','urna.convallis.erat@ipsum.co.uk',4,NULL,'0912845172','ac@pretiumneque.com',NULL,0),(71,'Haley','Wheeler','tristique.aliquet@nibh.net',4,NULL,'0510355744','sit.amet@Loremipsumdolor.ca',NULL,0),(72,'William','Dickson','euismod@Aliquamvulputate.com',4,NULL,'0422612351','convallis.convallis@risusquisdiam.ca',NULL,0),(73,'Quentin','Church','at.sem.molestie@sapiencursusin.ca',4,NULL,'0701695380','Donec.tempor.est@feugiat.com',NULL,0),(74,'Rebekah','Velez','lacus.pede@aaliquet.ca',4,NULL,'0094284493','Nullam.lobortis@metus.com',NULL,0),(75,'Lavinia','Yang','dui.nec.urna@faucibus.edu',4,NULL,'0329088663','dictum.sapien@purus.org',NULL,0),(76,'Keefe','Ross','elit@nibhsitamet.edu',4,NULL,'0679701501','dolor.elit.pellentesque@in.com',NULL,0),(77,'Wendy','Hoover','fringilla.cursus.purus@imperdiet.ca',4,NULL,'0379574808','orci.tincidunt.adipiscing@malesuada.org',NULL,0),(78,'Jared','Summers','aliquet@aliquetsem.ca',4,NULL,'0733466712','Phasellus.elit.pede@quamquisdiam.co.uk',NULL,0),(79,'Addison','Goodman','orci@disparturientmontes.com',4,NULL,'0980636012','et.ultrices.posuere@maurisIntegersem.net',NULL,0),(80,'Patricia','Walsh','Proin.nisl.sem@loremtristiquealiquet.com',4,NULL,'0297573566','sit.amet@iaculislacus.co.uk',NULL,0),(81,'Skyler','Gould','risus.Duis.a@rutrummagna.co.uk',4,NULL,'0540489098','mus.Donec.dignissim@porttitorscelerisque.edu',NULL,0),(82,'Yetta','Beasley','luctus.aliquet@Morbiquisurna.com',4,2,'0503200466','Cras.convallis.convallis@metuseuerat.com',NULL,1),(83,'Dexter','Riddle','at.egestas.a@risusaultricies.com',4,2,'0496751635','Cras.eu@etmagnaPraesent.com',NULL,0),(84,'Lewis','Orr','ac.arcu@etmagnis.org',4,2,'0480299478','commodo@gravidamolestiearcu.edu',NULL,0),(85,'Geoffrey','Walters','Integer.tincidunt@Etiam.edu',4,19,'0611025254','elementum@malesuadaIntegerid.net',NULL,0),(86,'Elvis','Frank','consequat@Aeneanegetmagna.edu',4,19,'0359018577','dui.Suspendisse@Quisqueornaretortor.ca',NULL,0),(87,'Chase','Banks','lectus.Cum@pellentesqueafacilisis.net',4,19,'0756987085','semper.pretium@mauriserateget.edu',NULL,0),(88,'Adara','Dixon','egestas.Aliquam@semperNam.co.uk',4,19,'0618851512','amet.ante@lectuspedeet.org',NULL,0),(89,'Derek','Guthrie','enim.nisl.elementum@loremipsum.co.uk',4,19,'0127852498','leo@dolor.co.uk',NULL,0),(90,'Daquan','Hurst','mattis.Integer.eu@lectussit.ca',4,3,'0751198698','velit@atliberoMorbi.org',NULL,0),(91,'Gareth','Dyer','quam@quisturpisvitae.org',4,21,'0023856993','est.ac@nec.edu',NULL,0),(92,'Lucian','Sawyer','tellus.Phasellus.elit@euismod.com',4,21,'0670823754','Nulla.interdum@nislQuisquefringilla.com',NULL,0),(93,'Donovan','Little','nunc.interdum@miDuisrisus.net',4,21,'0248308253','tempus@nonummy.edu',NULL,0),(94,'Molly','Foley','lobortis.mauris@porttitor.co.uk',4,3,'0921669041','Donec@Cras.edu',NULL,1),(95,'Igor','Holman','volutpat.Nulla@vehicularisusNulla.co.uk',4,5,'0573787089','orci.quis@id.org',NULL,0),(96,'Risa','Hammond','nulla.Integer.urna@ultricesposuerecubilia.ca',4,5,'0824503469','accumsan.convallis@eget.ca',NULL,0),(97,'Jennifer','Woodard','et@tristique.edu',4,5,'0535069755','mollis.Duis@ac.co.uk',NULL,0),(98,'Brenna','Hobbs','neque@lacus.co.uk',4,5,'0802762227','aliquet.molestie@semNullainterdum.org',NULL,0),(99,'Dale','Battle','accumsan@Duisatlacus.com',4,5,'0838195388','eget@vulputate.co.uk',NULL,0),(100,'Chiquita','Frank','lectus.a@Donecfeugiat.net',4,7,'0436439755','tincidunt.congue@ac.ca',NULL,0),(101,'Iola','Chen','vulputate.velit@elementum.net',4,7,'0247815078','auctor.ullamcorper@amet.ca',NULL,0),(102,'Jana','Blanchard','lectus.a.sollicitudin@ipsum.ca',4,7,'0322798799','est.Nunc.ullamcorper@dictumeueleifend.org',NULL,0),(103,'Ferris','Alexander','diam.dictum@Fuscedolorquam.ca',4,7,'0354503871','orci.consectetuer@nonummy.co.uk',NULL,0),(104,'Jenette','Singleton','a.neque.Nullam@semper.co.uk',4,7,'0216726577','Suspendisse@sitametluctus.org',NULL,0),(105,'Slade','Stark','commodo@Fuscemilorem.net',4,NULL,'0234534640','amet@venenatisvel.net',NULL,0),(106,'Evelyn','Rich','vel.sapien@fermentumconvallis.ca',4,NULL,'0169935725','Ut.semper.pretium@Nunc.co.uk',NULL,0),(107,'Phyllis','Wolfe','Class@idrisusquis.edu',4,NULL,'0747222437','massa@sodalesatvelit.co.uk',NULL,0),(108,'Tallulah','Hebert','nunc.ullamcorper@Nullamscelerisque.co.uk',4,NULL,'0282980099','semper.auctor.Mauris@conubia.edu',NULL,0),(109,'Michael','Garza','dolor.Fusce.feugiat@lobortistellusjusto.net',4,NULL,'0165290651','metus.In@Aenean.org',NULL,0),(110,'Tucker','Mcleod','quis.urna@viverraDonectempus.co.uk',4,NULL,'0123377019','Fusce.mi@nonquamPellentesque.edu',NULL,0),(111,'Macy','Benjamin','vitae@ligulaAliquam.org',4,NULL,'0028986385','nibh@Quisquefringilla.edu',NULL,0),(112,'Xaviera','Kelley','turpis@metus.org',4,NULL,'0781759756','eget.laoreet.posuere@quis.edu',NULL,0),(113,'Conan','Rose','sodales.elit@sociosquad.com',4,NULL,'0207126016','sit.amet.massa@habitantmorbitristique.ca',NULL,0),(114,'Jemima','Henderson','elit@nonummyultricies.edu',4,NULL,'0297072047','Aenean@Praesenteudui.co.uk',NULL,0),(115,'Florence','Hewitt','adipiscing@arcuCurabitur.com',4,NULL,'0217060662','et@posuere.ca',NULL,0),(116,'Cadman','Baldwin','pharetra@seddolor.org',4,NULL,'0231643413','nisl@tinciduntnibh.ca',NULL,0),(117,'Fredericka','Yang','odio.Nam@scelerisquesedsapien.co.uk',4,NULL,'0607159193','Mauris@vulputate.org',NULL,0),(118,'Lucy','Parrish','turpis.In.condimentum@velsapien.net',4,NULL,'0165917109','turpis@est.net',NULL,0),(119,'Josiah','Buck','non.lorem.vitae@MaurismagnaDuis.com',4,NULL,'0817039008','tellus@nonquam.co.uk',NULL,0),(120,'ROANO','SORIA','roano@test.com',4,20,'09177825083','ROANOSORIA76','$2b$10$tV6m449Yuj3ofVX2XwZnze83HYRGZp9nlu47CbAooKt2vShvQo6IO',1),(121,'EDGE','LORD','EDGELORD@TEST.COM',4,20,'12345569687','EDGELORD77','$2b$10$RzJbaoqrPef.qC8t7G6EaOQovwlhJfc4OTQnY207DLCjPlJj3qHIO',0),(122,'Anjelo Justine',' Padua','anjelo.padua@yahoo.com',3,20,'0995011384','Anjelo Justine Padua78','$2b$10$BZYBhgOuAflHt24F57124Oe4dyp0/n79mydMxrCJ/TUtKiBGzV8U2',0),(123,'Jericho','Mendoza','jermon@gmail.com',4,20,'43897892343','JerichoMendoza79','$2b$10$Ei.hKcqpCBe2BMBzEXargezjodO4QyQaOVuZQQtZlRiInqB7Y720u',0),(124,'Test','User','hi@test.com',4,NULL,'121111111','TestUser80','$2b$10$DFAWs9h/xHdCINNmQoIsteGSAK5tc7h5bl2zcDWAwPt9o//E8ZfK2',0),(125,'Look','Forme','h125i@test.com',4,NULL,'1245','LookForme81','$2b$10$YBMSXdG4xxBAkR3mzccXXuKbEia59133Qk6f99xaRe.u/svasXCzi',0),(126,'12412','6643524','1241@hger.com',4,NULL,'1111','12412664352481','$2b$10$UebHqHBJGyneqKheCwn37ee.sy39GlZjh4mcmkHG8mCrB5rRUezoK',0),(127,'5423','4623456','hjert@sdgjewt.com',4,NULL,'124','5423462345683','$2b$10$fHzy6iJA/r.AL2d8QjXd0u3mzByfS9BEjN8.aU0.2Oul1qinWaJ7u',0),(128,'12412545','634734','12421@hete.com',4,NULL,'12415','1241254563473484','$2b$10$ryyeUQrPk6xaB6atiL8rKeiz.kyFFh8/EYrpmQacOxaSNm8kIysrS',0),(129,'3251','2`14`123`12','2513223@jhetre.com',4,NULL,'13252134','32512`14`123`1284','$2b$10$70NTfqVAlZrSaJtBa0btRO/PhXPWvmoktuLfnvE72yDe2DXg96gBO',0),(130,'123','52346','4326423723@he4t43.com',4,NULL,'124','1235234686','$2b$10$zF3hYQirYc5VujjL/X7DT.uFm/1t1Sc/qryxybp7egIMZkrzilum.',0),(131,'test user','auditing','test@audit.com',4,21,'09177826593','test userauditing87','$2b$10$7iSG1KlVTpUV4VZ9XVamQObnpLJufdyOsypB2dM8jpHWeYEGrXgvO',0),(132,'Robert','Sy','robert_sy@gmail.com',4,21,'09178273645','RobertSy88','$2b$10$AIKM3sCFph4KC7YbpMFA.e3Q48cZSyQoDc3TP5URTtnJQ1.qt1FQa',1),(133,'Jericho','Rosales','jer@cho.com',4,21,'09182736774','JerichoRosales89','$2b$10$016d0gkTHOID8Jjq20nmI.Y0O6jbwKHPy4LEUvSSpTNoTmodnNDPy',0),(134,'Brian','Jason','brian@jason.com',4,22,'09182827364','BrianJason90','$2b$10$gmuHHuef5BQkk0F4egAPs.nv56XFfF17V2sAWTmC1BwRlMFRTx5iy',1),(135,'Echo','Ng','echo@ng.com',4,22,'09283745656','EchoNg90','$2b$10$niL.wz8m0RRrIaAENI6opOe6l8AqCfK2MnHoNULPZ/BRfFb2FhyOC',0),(136,'Group','Five','group@five.com',4,22,'09283474658','GroupFive91','$2b$10$9.wV3zsjImtXTMW28f2fsOgFRR.t7ZhbjmOa0Pw.fXiLnWOrofuje',0),(137,'Group','six','group@six.com',4,23,'09182734515','Groupsix93','$2b$10$67USN3goYF/HO95t/ZlL7ejtC2ZzQxgkPNfGNJ2a8cNepKEuaWQ7O',0),(138,'Desmond','Las','desmond@las.com',4,23,'09283744156','DesmondLas93','$2b$10$1jdcY25vfxdsX6jp0tAx4ONFpSRnW79jeutnUpIW6VNM4kiB7o5NS',1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `yearlycycle`
--

DROP TABLE IF EXISTS `yearlycycle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `yearlycycle` (
  `yearlyCycleID` int(11) NOT NULL,
  `cycle_Name` varchar(45) NOT NULL,
  `start_Date` date NOT NULL,
  `end_Date` date NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `cycle_ID` int(11) NOT NULL,
  PRIMARY KEY (`yearlyCycleID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `yearlycycle`
--

LOCK TABLES `yearlycycle` WRITE;
/*!40000 ALTER TABLE `yearlycycle` DISABLE KEYS */;
/*!40000 ALTER TABLE `yearlycycle` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-03-25 19:47:50
