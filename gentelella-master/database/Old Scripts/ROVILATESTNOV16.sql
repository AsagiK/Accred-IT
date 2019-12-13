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
INSERT INTO `activity_evidences` VALUES (1,33,1),(1,34,1),(1,38,1),(1,56,1),(1,54,2),(1,55,2),(1,35,3),(1,36,3),(1,37,3),(1,71,4),(1,63,4),(1,61,4),(1,65,4),(1,75,4),(1,64,4),(1,66,4),(1,69,4),(1,72,4),(1,62,4),(1,70,4),(1,67,4),(1,60,4),(1,68,4),(1,78,6),(1,85,7),(1,83,8),(1,84,8),(1,85,8);
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
INSERT INTO `activity_members` VALUES (1,120,1),(1,121,1),(1,120,1);
/*!40000 ALTER TABLE `activity_members` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity_outputs`
--

LOCK TABLES `activity_outputs` WRITE;
/*!40000 ALTER TABLE `activity_outputs` DISABLE KEYS */;
INSERT INTO `activity_outputs` VALUES (1,1,'syllabus',0),(2,1,'pdf document of work plan',0),(3,1,'TESTING INSERT OF OUTPUT',0),(4,1,'TESTING INSERT OF OUTPUT 2',0),(5,2,'TESTING INSERT OF OUTPUT AGAIN',0),(6,2,'TESTING INSERT OF OUTPUT AGAIN 2',0);
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `approved_activities`
--

LOCK TABLES `approved_activities` WRITE;
/*!40000 ALTER TABLE `approved_activities` DISABLE KEYS */;
INSERT INTO `approved_activities` VALUES (1,'Get Syllabi',NULL,0,'Kuhanin kay ms stef',NULL,0,'2019-11-10'),(2,'TESTING INSERT OF ACTIVITY',NULL,0,'TESTING INSERT OF ACTIVITY',NULL,0,'2019-11-30');
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
  PRIMARY KEY (`cycle_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cycle`
--

LOCK TABLES `cycle` WRITE;
/*!40000 ALTER TABLE `cycle` DISABLE KEYS */;
INSERT INTO `cycle` VALUES (1,'Term 1:2019-2022','2019-11-10','2020-01-04',4,1),(2,'TEST CYCLE INSERT','2019-11-11','2019-12-31',1,2),(3,'testing create cycles 1','2019-11-12','2019-11-29',3,1),(4,'testing create cycles 3','2020-01-01','2020-01-31',1,1),(5,'testing create cycles 2','2019-12-01','2019-12-31',0,1);
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
  `Document_Ext` varchar(45) NOT NULL,
  `InDrive` tinyint(1) NOT NULL DEFAULT '0',
  `DriveID` varchar(40) DEFAULT '0',
  `isaversionof` int(11) DEFAULT NULL,
  `version` int(11) NOT NULL DEFAULT '1',
  `md5` varchar(100) NOT NULL,
  PRIMARY KEY (`Document_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documents`
--

LOCK TABLES `documents` WRITE;
/*!40000 ALTER TABLE `documents` DISABLE KEYS */;
INSERT INTO `documents` VALUES (1,'04-19-04-35-15-2019.jpg','uploads/04-19-04-35-15-2019.jpg',NULL,'.jpg',1,'1LsHKcOx555Xx4iJJpuZY_yohhvuH7jcW',NULL,1,'933f5ad27efca18d1b16a6a016566b9b'),(2,'04-19-04-39-33-2019.png','uploads/04-19-04-39-33-2019.png',NULL,'.png',1,'1ey6QnCJYdsXToMAfnd7ZV3wZNqwBgGDP',NULL,1,'ec7ee7444229726e5fa2e11cce4291c8'),(3,'04-19-04-40-40-2019.png','uploads/04-19-04-40-40-2019.png',NULL,'.png',1,'1JsOdmSraCLB6RMRUEU-etz2_TMd3_Ngh',NULL,1,'e1f80060f13c043db7f8decba2c814f7'),(4,'04-19-04-46-11-2019.png','uploads/04-19-04-46-11-2019.png',NULL,'.png',1,'1Zxkh2NI-UeWLnNWTr8NB8qFDE_eFLjXD',NULL,1,'def4c2d6360cf9161b282095907c7fda'),(5,'04-19-04-46-21-2019.png','uploads/04-19-04-46-21-2019.png',NULL,'.png',1,'1j8kHCZhqtYL1Wa7YayLnhd3OqSXyiEXQ',NULL,1,'433e69e67b71349aee1e6b1b2257444e'),(6,'04-19-04-47-42-2019.png','uploads/04-19-04-47-42-2019.png',NULL,'.png',1,'1m3cFdoHwdMScjdOf2_aqkCA5N0CSFBs5',NULL,1,'4422da9277238aca6ff2d31fd13b54b9'),(7,'04-19-05-08-09-2019.jpg','uploads/04-19-05-08-09-2019.jpg',NULL,'.jpg',1,'1aR5Dht_HcBjrlpxP3e93kfXvPCZh2n6n',NULL,1,'3fef713b797a17b574dea17d5a16791b'),(8,'04-19-05-25-11-2019.png','uploads/04-19-05-25-11-2019.png',NULL,'.png',1,'1najR-LmJDg1RsT1U1L9aU5f3pSlICsRh',NULL,1,'316666b8704a11cbb52b42a959ec92e1'),(9,'04-19-05-29-45-2019.jpg','uploads/04-19-05-29-45-2019.jpg',NULL,'.jpg',1,'1X76gkwwpfpC6h5e5MEsDbMQMOPabHDIV',NULL,1,'82fb6038207b4c9fac530e88d27dfb98'),(10,'04-19-05-32-38-2019.png','uploads/04-19-05-32-38-2019.png',NULL,'.png',1,'1T0yPqlHUwug5AXKgPHfgWDA0tMZd9Y8t',NULL,1,'aea75005b5eef88ebeb0ac092fdd9e8b'),(11,'04-19-06-10-58-2019.png','uploads/04-19-06-10-58-2019.png',NULL,'.png',1,'1Uum9CsmfIPmwSnnAoi3lchEYPTzkNsSH',NULL,1,'153ddf1974aebaf687f0fc2c1e899137'),(12,'04-19-06-19-39-2019.jpg','uploads/04-19-06-19-39-2019.jpg',NULL,'.jpg',1,'1uN-NXPwGK2OTo2PsNTLeJlPLmwnouM2a',NULL,1,'ed3a9078ca8209ac5d4bb6fed192093c'),(13,'04-19-06-31-58-2019.png','uploads/04-19-06-31-58-2019.png',NULL,'.png',1,'1stu27NBE6IXU_H-Ianx5pYZZDT73_v7x',NULL,1,'badc5e4ea1fe2a227de37d6a5be0d411'),(14,'04-19-06-34-46-2019.jpg','uploads/04-19-06-34-46-2019.jpg',NULL,'.jpg',1,'1kMTaTa_64P2DgsuDrRD82KeUIzjDx7Gu',NULL,1,'6e2442ae51ce2d19635f49344b45449e'),(15,'04-19-06-36-49-2019.png','uploads/04-19-06-36-49-2019.png',NULL,'.png',1,'1HzkMd4jf7-XIV8P9OnK-Vglc7hhaqYKP',NULL,1,'3a3cdc65a5420a330abef4894c585af8'),(16,'04-20-05-59-37-2019.png','uploads/04-20-05-59-37-2019.png',NULL,'.png',1,'1orOUE-pgi-Udqy_TCa9ixD__Ml7gILu-',NULL,1,'61823ba04e83b93b4be8ccb68446395a'),(17,'04-20-05-50-55-2019.png','uploads/04-20-05-50-55-2019.png',NULL,'.png',1,'1KpS6jSrH2zrBXavrw-7vCcGzYXMLggdL',NULL,1,'5e342587a66576a38ff1a14a6d922389'),(18,'04-20-05-59-45-2019.png','uploads/04-20-05-59-45-2019.png',NULL,'.png',1,'10XqVXymFw1imuGtL-XusTPkyE78MGxxO',NULL,1,'9adbfa1f46072fcf291ea4712b998209'),(19,'04-20-06-04-32-2019.jpg','uploads/04-20-06-04-32-2019.jpg',NULL,'.jpg',1,'1TAI84abjFx_1eS2QkMCVSqKUkeGgZDzk',NULL,1,'a2b054faac988c2ed057313561446536'),(20,'04-20-06-06-30-2019.jpg','uploads/04-20-06-06-30-2019.jpg',NULL,'.jpg',1,'1w4tfVEgASJ8Y14A8ltn4oM5eD4stxfct',NULL,1,'76e0f2b03256f2df41b049edf8c9df88'),(21,'04-20-06-09-06-2019.png','uploads/04-20-06-09-06-2019.png',NULL,'.png',1,'1TnzPmkFnNjgdh-H5hnq_gPVgIcgO1SGX',NULL,1,'cdf00110307c1664778d251684c10ce8'),(22,'04-20-05-54-29-2019.png','uploads/04-20-05-54-29-2019.png',NULL,'.png',1,'1glRBt4-0C_HophEAC1pew6ZyBH13TCN1',NULL,1,'ccd0b2ba053134d54391fe47aed03ba9'),(23,'04-19-06-06-47-2019.jpg','uploads/04-19-06-06-47-2019.jpg',NULL,'.jpg',1,'10zN_w50fZQU2yt3ZmM7Wy4Bf5IMtoCie',NULL,1,'9b8b15f2e6ca2da09f5b993d93d35c3b'),(24,'04-19-05-20-00-2019.png','uploads/04-19-05-20-00-2019.png',NULL,'.png',1,'1ZlTsNbu1ooWdwXaAZN4yVp0xgRaP8cBS',NULL,1,'01c9587f3923c8b30f3fc1ca13fc8c5a'),(25,'04-25-07-54-08-2019.png','uploads/04-25-07-54-08-2019.png',NULL,'.png',1,'1fga6e-xFuPL9t6Ki4S405nCKMz_MxAqV',NULL,1,'671ab054475670dc2bfe66ce5e3a3c12'),(26,'55882235_262140041384676_4449226861821558784_n.jpg','uploads/55882235_262140041384676_4449226861821558784_n.jpg',NULL,'.jpg',1,'12acNpL6-65sHhhN5_I05tSIe1yZeIICV',NULL,1,'57a4ac6f9d9696cda95c71d3a25678a3'),(27,'49509434_2307031812669727_8847166844851716096_n.jpg','uploads/49509434_2307031812669727_8847166844851716096_n.jpg',NULL,'.jpg',1,'1QPzfXhVjGy5k1wvcmq1SBjHiGfZk8M95',NULL,1,'c659d829c042ddcb1ed79b36fa6cd14e'),(28,'67102526_2915274415167534_3305999850021060608_n.jpg','uploads/67102526_2915274415167534_3305999850021060608_n.jpg',NULL,'.jpg',1,'1uVfvBRyw0UBxsebVJEDsPsyh7548WErT',NULL,1,'41a4467720478860012d45ff7fb69c25'),(29,'66587876_454551508713195_6701762356159971328_n.jpg','uploads/66587876_454551508713195_6701762356159971328_n.jpg',NULL,'.jpg',1,'1AURZApjoKj_uoZekkO28N6tTowy22h3x',NULL,1,'9e80c408269953fd4f3bdbaf072898de'),(30,'D-3MWjWUwAEhOGt.png','uploads/D-3MWjWUwAEhOGt.png',NULL,'.png',1,'1IrbKSaxO3-GnAIoDwzlpkK1_5cB7ucXG',NULL,1,'8d7cee9be061bbc349b469dc5407941a'),(31,'LITEPOPRI.docx','uploads/LITEPOPRI.docx',NULL,'.docx',1,'1KEcaBlnfTur9lkogefsyZY7PetXtv0cN',NULL,1,'32e463820d950437d15e390e7dbc05b1'),(32,'ONEDECISIONCANCHANGETHEFUTURE.png','uploads/ONEDECISIONCANCHANGETHEFUTURE.png',NULL,'.png',1,'1fjNme06O8vT9hvwzQ1rM7UbugxhHaSPj',NULL,1,'470b7404ca6f23ba3706c508903d840b'),(57,'11-16-00-39-07-2019.png','uploads/11-16-00-39-07-2019.png',NULL,'.png',1,'1YcV_oZUaY10NX5Ql5iBsUG_pToEoCvhQ',NULL,1,'8bb64f4be1e6ee66d654211933c691f8'),(58,'11-16-00-39-26-2019.png','uploads/11-16-00-39-26-2019.png',NULL,'.png',1,'1bBJ45QZZoNK5pA1wHbg686JPViHtf2Rr',NULL,1,'cb5067426885224443184debc25ebe7b'),(59,'11-16-00-39-15-2019.png','uploads/11-16-00-39-15-2019.png',NULL,'.png',1,'1l-JvT3IJQoRILObNMJl2I4Qpt1LJJm1Q',NULL,1,'698e5a58715806ecd34026eba3bac3d2'),(60,'15d90584baf6486614edf6a5d4544ecf.jpg','uploads/15d90584baf6486614edf6a5d4544ecf.jpg',NULL,'.jpg',1,'1zlFgh8MxWv5hFf8EYqWr6KLjI5gl-NYn',NULL,1,'a7c3ac0a00e0d980c561a582a3ceeb22'),(61,'6291325026_a9670aeb0b.jpg','uploads/6291325026_a9670aeb0b.jpg',NULL,'.jpg',1,'1hLHKIjJ5l0L3jAMTBCPo1TESOX-e-JzE',NULL,1,'2bd6fc61a9584b5e22f295df86b5c0a6'),(62,'806205.jpg','uploads/806205.jpg',NULL,'.jpg',1,'1tiCCrUNeimMI0sndE_rS_7_okzeJLCNX',NULL,1,'5e095c18a832412d15e9233ed5cab574'),(63,'95a.gif','uploads/95a.gif',NULL,'.gif',1,'1KMMs6-IsQgXnBEEva64mdHUYuBpQO8dr',NULL,1,'75d69d69fa3b8a9cd79327c26742608f'),(64,'Blair_vs_Mizune.png','uploads/Blair_vs_Mizune.png',NULL,'.png',1,'1AXKpmFCtUmkmPgAObDk2KQj6X6RRBhtf',NULL,1,'1d447315c817054ab36223cfdd44065e'),(65,'MHGU-Bloodbath_Diablos_Render_002.png','uploads/MHGU-Bloodbath_Diablos_Render_002.png',NULL,'.png',1,'1g1Q6UGzS6yBVbIG7GinQzu3fdTXrYDrV',NULL,1,'73a9f48c608508c1ffab76cfc8a0c422'),(66,'hqdefault.jpg','uploads/hqdefault.jpg',NULL,'.jpg',1,'1GZRcdIP1Tizp4jQo1gIxjd7HbfRDDrCf',NULL,1,'bb4146628dd94988ed48508be0d51ab2'),(67,'maxresdefault.jpg','uploads/maxresdefault.jpg',NULL,'.jpg',1,'1ZtwU3i99L8apQrc3-Nh1YTmc43O5yj9g',NULL,1,'7d8f90c51ac70a392b398417cdff7d33'),(68,'Death_Note_In_A_Nutshell.jpg','uploads/Death_Note_In_A_Nutshell.jpg',NULL,'.jpg',1,'1odZmUl0CEfQL477W_9uXKUgZuWkdSciV',NULL,1,'768ac2260234fc2f6e68f1c20ae394ff'),(69,'img-soul-eater-halloween-kitty-717.jpg','uploads/img-soul-eater-halloween-kitty-717.jpg',NULL,'.jpg',1,'1xhOyUUf9JwofW2I3SEEnvAR5WX1dkWEw',NULL,1,'512a81b84bdbbba975de0892aa4a0182'),(70,'images.jpg','uploads/images.jpg',NULL,'.jpg',1,'1kKemkkVgAwq7ZLCe_7eU2sYlvrTKf2sy',NULL,1,'68a4483c89a26464f4a6e709efcf4cf9'),(71,'11-02-18-27-33-2019.png','uploads/11-02-18-27-33-2019.png','No Description Given.','.png',1,'1HfPjBNr7ftbeknx0VzklUsIHEIld_05_',57,2,'832109366053eb08738e51bcc804221c'),(72,'11-01-00-09-25-2019.png','uploads/11-01-00-09-25-2019.png','No Description Given.','.png',1,'15PnZBlw0tmUF58_10-wNwz6Dolua-5UK',58,2,'5c63c1dfff12371c841dfae955c2344a'),(73,'11-01-00-09-25-20193.png','uploads/11-01-00-09-25-20193.png','No Description Given.','.png',0,'0',72,3,'695a02ef00271b2190c223b73e4ce57d'),(74,'images2.jpg','uploads/images2.jpg','No Description Given.','.jpg',0,'0',70,2,'1e153227a3c7e6c9294dffea40edbd6d'),(75,'11-02-19-50-47-2019.png','uploads/11-02-19-50-47-2019.png','No Description Given.','.png',1,'1kHpMDPLMVmcYHQN0QFOdxk5Hs1DjXYvq',59,2,'76229ff5c382e18c6d29e534489fc538'),(76,'hqdefault2.jpg','uploads/hqdefault2.jpg','No Description Given.','.jpg',0,'0',66,2,'e481d044a27af6bfc82eea263f71a54d'),(77,'images2.jpg','uploads/images2.jpg','No Description Given.','.jpg',0,'0',70,2,'b349c9f1480cddbd11aa6bdaac8383e8'),(78,'12-04-19-43-41-2018.jpg','uploads/12-04-19-43-41-2018.jpg',NULL,'.jpg',1,'1jcPTfY60a3QD8U7Mj_czf8KXsrk_N9kA',NULL,1,'8cfb182b41ba94ee48c1de5d14f30c07'),(79,'-you-are-my-sky-beautiful-cloud-9303812.png','uploads/-you-are-my-sky-beautiful-cloud-9303812.png',NULL,'.png',1,'1vU5iHbAFnUsTrLbZczdIdiC-vCCngvth',NULL,1,'26b30d6a98275eceff62423322630018'),(80,'12-01-19-46-35-2018.png','uploads/12-01-19-46-35-2018.png','No Description Given.','.png',1,'1DQiCKxffs_L-o7ExNEXxu86_26Z4r9sd',79,2,'b3c8ebd0748931896c5046944f31bfcc'),(81,'12-01-19-46-35-2018v3.png','uploads/12-01-19-46-35-20183.png','No Description Given.','.png',0,'0',80,3,'8c05b3d5292f50d586836ce969c611bb'),(82,'01.jpg','uploads/01.jpg','No Description Given.','.jpg',1,'11Js3_EUJIIUMZ8tf_8hDuuDjq5I78dJ3',81,4,'2ecd9ba50f50bc114563ecf55e2106d0'),(83,'01v5.jpg','uploads/015.jpg','No Description Given.','.jpg',0,'0',82,5,'6e4de19ebf6619e4be20dcfe0fa74d1f'),(84,'11-01-14-51-56-2019.png','uploads/11-01-14-51-56-2019.png','No Description Given.','.png',1,'1mOjSeyQbXePTinjDzbiRTUD340X-n7l1',83,6,'39d24c530e5225cc7fe7a52b3bdd5bcc'),(85,'11-01-14-51-56-2019v7.png','uploads/11-01-14-51-56-2019v7.png','No Description Given.','.png',1,'1V9Hktwl309U4jNcQlveXfdrhvrbWSs-q',84,7,'0524f1c9d5f1c04d27b16080561198c9');
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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group`
--

LOCK TABLES `group` WRITE;
/*!40000 ALTER TABLE `group` DISABLE KEYS */;
INSERT INTO `group` VALUES (0,'No Group Assigned',0),(1,'Analysis',1),(2,'Evaluation',1),(3,'Analysis',2),(4,'Evaluation',2),(5,'Analysis',3),(6,'Evaluation',3),(7,'Analysis',4),(8,'Evaluation',4),(9,'Analysis',5),(10,'Evaluation',5),(11,'Analysis',6),(12,'Evaluation',6),(13,'Analysis',7),(14,'Evaluation',7),(15,'Analysis',8),(16,'Evaluation',8),(17,'Analysis',9),(18,'Evaluation',9),(19,'Test Area',1),(20,'TESTING',2),(21,'RESEARCH GROUP',1);
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
INSERT INTO `groupdetails` VALUES (1,35,'Member'),(1,47,'Member'),(1,51,'Member'),(1,57,'Member'),(1,56,'Member'),(1,46,'Member'),(1,52,'Member'),(1,49,'Member'),(1,53,'Member'),(1,48,'Member'),(1,73,'Member'),(1,54,'Member'),(1,50,'Member'),(1,55,'Member'),(1,58,'Member'),(1,59,'Member'),(1,69,'Member'),(1,63,'Member'),(1,68,'Member'),(1,62,'Member'),(1,61,'Member'),(1,67,'Member'),(1,60,'Member'),(1,74,'Member'),(1,71,'Member'),(1,72,'Member'),(1,66,'Member'),(1,65,'Member'),(1,70,'Member'),(1,75,'Member'),(1,77,'Member'),(1,64,'Member'),(1,76,'Member'),(1,81,'Member'),(1,79,'Member'),(1,80,'Member'),(1,78,'Member'),(2,82,'Leader'),(2,83,'Member'),(2,84,'Member'),(19,85,'Member'),(19,87,'Member'),(19,86,'Member'),(19,88,'Member'),(19,89,'Member'),(21,91,'Member'),(21,93,'Member'),(21,92,'Member'),(3,94,'Leader'),(3,90,'Member'),(5,98,'Member'),(5,99,'Member'),(5,97,'Member'),(5,96,'Member'),(5,95,'Member'),(7,100,'Member'),(7,103,'Member'),(7,104,'Member'),(7,102,'Member'),(7,101,'Member'),(18,120,'Member'),(18,121,'Member');
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
  `GroupAssigned` int(11) NOT NULL,
  `metric_ID` int(11) DEFAULT NULL,
  `measurement_Name` varchar(45) NOT NULL,
  `measurement_Description` mediumtext NOT NULL,
  `Deadline` varchar(45) DEFAULT NULL,
  `cycle_ID` int(11) NOT NULL,
  PRIMARY KEY (`measurement_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `measurement`
--

LOCK TABLES `measurement` WRITE;
/*!40000 ALTER TABLE `measurement` DISABLE KEYS */;
INSERT INTO `measurement` VALUES (1,NULL,NULL,18,1,'% of curriculum and syllabi revised ','based on learner-centered philosophy and Lasallian Guiding Principles',NULL,1),(2,NULL,NULL,18,2,'TESTING INSERT OF MEASUREMENT IN ANOTHER GOAL','TESTING INSERT OF MEASUREMENT IN ANOTHER GOAL',NULL,2),(3,NULL,NULL,4,NULL,'1111111111111111111','2222222222222222',NULL,3);
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
  `GroupAssigned` int(11) NOT NULL,
  `metric_ID` int(11) DEFAULT NULL,
  `measurement_Name` varchar(45) NOT NULL,
  `measurement_Description` mediumtext NOT NULL,
  `Deadline` varchar(45) DEFAULT NULL,
  `cycle_ID` int(11) NOT NULL,
  `audit_date` date NOT NULL,
  PRIMARY KEY (`measurement_auditID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `measurement_audit`
--

LOCK TABLES `measurement_audit` WRITE;
/*!40000 ALTER TABLE `measurement_audit` DISABLE KEYS */;
INSERT INTO `measurement_audit` VALUES (3,3,NULL,NULL,7,NULL,'52364532','5762345613425',NULL,3,'0000-00-00'),(4,3,NULL,NULL,4,NULL,'gragsera','rt34qt43qt',NULL,3,'0000-00-00'),(5,3,NULL,NULL,5,NULL,'fasfaewf','greegreg',NULL,3,'0000-00-00'),(6,3,NULL,NULL,5,NULL,'213123','3214234',NULL,3,'0000-00-00'),(7,3,NULL,NULL,5,NULL,'gsdfghsre','rgefew',NULL,3,'0000-00-00'),(8,3,NULL,NULL,5,NULL,'1111111111','rgefew2222222222222222',NULL,3,'0000-00-00'),(9,3,NULL,NULL,6,NULL,'qweqwr','twyreghrweg',NULL,3,'2019-11-15');
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
INSERT INTO `measurements_activities` VALUES (1,1),(1,2),(2,1);
/*!40000 ALTER TABLE `measurements_activities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `measurements_targets`
--

DROP TABLE IF EXISTS `measurements_targets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `measurements_targets` (
  `measurementID` int(11) NOT NULL,
  `target` mediumtext NOT NULL,
  `progress` mediumtext,
  `target_ID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`target_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `measurements_targets`
--

LOCK TABLES `measurements_targets` WRITE;
/*!40000 ALTER TABLE `measurements_targets` DISABLE KEYS */;
INSERT INTO `measurements_targets` VALUES (1,'More','TESTING FIRST PROGRESS',1),(1,'kek','TESTING SECOND PROGRESS',2),(1,'Target','TESTING THIRD PROGRESS',3),(2,'TARGET 3',NULL,4),(2,'TARGET 1',NULL,5),(2,'TARGET 2',NULL,6),(3,'123',NULL,7),(3,'123',NULL,8),(3,'123',NULL,9);
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
  `target` mediumtext NOT NULL,
  `progress` mediumtext,
  `target_ID` int(11) NOT NULL,
  PRIMARY KEY (`measurements_targets_auditID`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `measurements_targets_audit`
--

LOCK TABLES `measurements_targets_audit` WRITE;
/*!40000 ALTER TABLE `measurements_targets_audit` DISABLE KEYS */;
INSERT INTO `measurements_targets_audit` VALUES (7,0,3,'123',NULL,7),(8,0,3,'123',NULL,8),(9,0,3,'123',NULL,9),(10,8,3,'123',NULL,7),(11,8,3,'123',NULL,8),(12,8,3,'123',NULL,9),(13,9,3,'123',NULL,7),(14,9,3,'123',NULL,8),(15,9,3,'123',NULL,9);
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
  `cycle_ID` int(11) DEFAULT '0',
  `duration` varchar(200) NOT NULL,
  `cycle_Status` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`metric_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metric`
--

LOCK TABLES `metric` WRITE;
/*!40000 ALTER TABLE `metric` DISABLE KEYS */;
INSERT INTO `metric` VALUES (1,'Testing','Testing Testing',NULL,NULL,0,1,0,'To be Achieved by 2015','Active'),(2,'To fully integrate the learner-centered pedagogy and Lasallian Guiding Principles',' in all curricular and co-curricular programs',NULL,NULL,0,1,0,'Achieve by 2021','Active'),(3,'One more','One more',NULL,NULL,0,1,0,'to be achieved by one more','Active');
/*!40000 ALTER TABLE `metric` ENABLE KEYS */;
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
  `cycle_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`pending_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pending_activities`
--

LOCK TABLES `pending_activities` WRITE;
/*!40000 ALTER TABLE `pending_activities` DISABLE KEYS */;
INSERT INTO `pending_activities` VALUES (1,1,'Get Syllabi',NULL,0,'ADMIN SUBMISSION',NULL,NULL,1,10,'2019-11-09',1,35,'approved',NULL),(2,1,'Get Syllabi',NULL,0,'TESTING SUBMISSION OF ROANO SORIA ID NUMBER 120',NULL,NULL,2,20,'2019-11-09',1,120,'i dont like you',NULL),(3,1,'Get Syllabi',NULL,0,'TESTING ADMIN SUBMISSION',NULL,NULL,1,30,'2019-11-09',1,35,'APPROVED',NULL),(4,1,'Get Syllabi',NULL,0,'testing',NULL,NULL,0,100,'2019-11-15',1,35,NULL,NULL),(5,1,'Get Syllabi',NULL,0,'123',NULL,NULL,0,123,'2019-11-15',1,35,NULL,NULL),(6,1,'Get Syllabi',NULL,0,'Hi',NULL,NULL,0,100,'2019-11-15',1,35,NULL,NULL),(7,1,'Get Syllabi',NULL,0,'Hi',NULL,NULL,0,100,'2019-11-15',1,35,NULL,NULL),(8,1,'Get Syllabi',NULL,0,'TESTING INSERT OF CYCLE ID TO SUBMISSION TESTING INSERT OF CYCLE ID TO SUBMISSION TESTING INSERT OF CYCLE ID TO SUBMISSION TESTING INSERT OF CYCLE ID TO SUBMISSION TESTING INSERT OF CYCLE ID TO SUBMISSION TESTING INSERT OF CYCLE ID TO SUBMISSION ',NULL,NULL,0,12,'2019-11-15',1,35,NULL,1);
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
INSERT INTO `roles` VALUES (1,'Admin'),(2,'QA Officer'),(3,'Department Chair'),(4,'User');
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `source`
--

LOCK TABLES `source` WRITE;
/*!40000 ALTER TABLE `source` DISABLE KEYS */;
INSERT INTO `source` VALUES (1,'PAASCU','BLABLABLABLAk');
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
/*!40000 ALTER TABLE `sourcetype` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=122 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (35,'Admin','Admin','debug@debug.com',1,1,'99999999999','Admin','$2b$10$w1q.GZyvVMwt9c6aiFjBEuahRim1NOtIgFOY8DYsxoJuN31CsUGsu'),(46,'AdminX','AdminX','debug@debug.com',1,1,'99999999999','AdminX','$2b$10$bWyFihniq34XjVzTZXXMjeqbF1LeG.gP06X2FLc.XZ6vgH5wHo6.e'),(47,'Jayme','Randall','quis.massa.Mauris@amalesuadaid.com',4,1,'0827150506','orci.consectetuer.euismod@convalliserat.co.uk',NULL),(48,'Hedda','Blanchard','dolor.egestas.rhoncus@etmagnisdis.com',4,1,'0532678474','egestas.hendrerit@Maurisblanditenim.co.uk',NULL),(49,'Quentin','Farmer','senectus.et.netus@Nulla.co.uk',4,1,'0424963076','vitae.erat@risusDuisa.net',NULL),(50,'Rooney','Lawson','lectus@utipsumac.com',4,1,'0017842615','ipsum.nunc.id@velitSedmalesuada.edu',NULL),(51,'Fuller','Lawson','lorem.vitae.odio@turpisNulla.com',4,1,'0104998917','ut.pellentesque.eget@Aliquamvulputate.net',NULL),(52,'Naida','Travis','molestie.orci.tincidunt@diamSed.org',4,1,'0396262927','ipsum@hymenaeosMaurisut.com',NULL),(53,'Shelly','Odonnell','consequat.purus@ut.com',4,1,'0741793038','Etiam.gravida.molestie@lectus.edu',NULL),(54,'Nomlanga','Wiley','sociis@imperdietnecleo.net',4,1,'0463195329','ut.pellentesque.eget@semNulla.org',NULL),(55,'Pamela','Payne','cursus.et.magna@cursusaenim.net',4,1,'0336253671','diam@tempus.edu',NULL),(56,'Dale','Fulton','consequat.dolor@vestibulum.edu',4,1,'0621007822','ultricies@Vivamuseuismodurna.co.uk',NULL),(57,'Brock','Tanner','magnis.dis@iaculisaliquetdiam.com',4,1,'0485322526','ornare.lectus.justo@dolorFuscemi.net',NULL),(58,'Drake','Hogan','Integer@nequeMorbi.co.uk',4,1,'0122087593','sed.turpis@arcuVestibulum.net',NULL),(59,'Fitzgerald','Ortiz','arcu@in.edu',4,1,'0353804236','vitae.aliquam.eros@quispedePraesent.edu',NULL),(60,'Isaiah','Kemp','pellentesque@lacinia.co.uk',4,1,'0687689022','enim.Etiam.gravida@enimEtiamgravida.org',NULL),(61,'Cassady','Carson','adipiscing@quisaccumsan.org',4,1,'0822841725','justo@Loremipsumdolor.org',NULL),(62,'Yeo','Allison','Sed.auctor@vulputate.edu',4,1,'0751834790','Nunc.quis@arcuVestibulum.com',NULL),(63,'Daria','Knox','nec.mauris.blandit@rhoncusDonec.co.uk',4,1,'0068744702','neque.sed@quispedePraesent.co.uk',NULL),(64,'Preston','Melton','massa.non@tempusscelerisque.com',4,1,'0385565489','vel.venenatis@non.net',NULL),(65,'Chaim','Walls','ullamcorper.nisl.arcu@Vivamus.org',4,1,'0994904810','vitae.nibh@eget.com',NULL),(66,'Karly','Shaw','nisl.Quisque.fringilla@nonfeugiatnec.co.uk',4,1,'0617257074','penatibus.et@nuncsed.net',NULL),(67,'Maisie','Sharp','ac.mi.eleifend@eratSed.edu',4,1,'0046643354','at.iaculis.quis@malesuadamalesuadaInteger.com',NULL),(68,'Indigo','Mccoy','sit.amet.nulla@feugiatnec.ca',4,1,'0769322656','consectetuer.cursus@risusQuisque.ca',NULL),(69,'Keane','Parsons','Morbi@Aliquameratvolutpat.net',4,1,'0876062059','libero.est@necmaurisblandit.edu',NULL),(70,'Rafael','Schmidt','urna.convallis.erat@ipsum.co.uk',4,1,'0912845172','ac@pretiumneque.com',NULL),(71,'Haley','Wheeler','tristique.aliquet@nibh.net',4,1,'0510355744','sit.amet@Loremipsumdolor.ca',NULL),(72,'William','Dickson','euismod@Aliquamvulputate.com',4,1,'0422612351','convallis.convallis@risusquisdiam.ca',NULL),(73,'Quentin','Church','at.sem.molestie@sapiencursusin.ca',4,1,'0701695380','Donec.tempor.est@feugiat.com',NULL),(74,'Rebekah','Velez','lacus.pede@aaliquet.ca',4,1,'0094284493','Nullam.lobortis@metus.com',NULL),(75,'Lavinia','Yang','dui.nec.urna@faucibus.edu',4,1,'0329088663','dictum.sapien@purus.org',NULL),(76,'Keefe','Ross','elit@nibhsitamet.edu',4,1,'0679701501','dolor.elit.pellentesque@in.com',NULL),(77,'Wendy','Hoover','fringilla.cursus.purus@imperdiet.ca',4,1,'0379574808','orci.tincidunt.adipiscing@malesuada.org',NULL),(78,'Jared','Summers','aliquet@aliquetsem.ca',4,1,'0733466712','Phasellus.elit.pede@quamquisdiam.co.uk',NULL),(79,'Addison','Goodman','orci@disparturientmontes.com',4,1,'0980636012','et.ultrices.posuere@maurisIntegersem.net',NULL),(80,'Patricia','Walsh','Proin.nisl.sem@loremtristiquealiquet.com',4,1,'0297573566','sit.amet@iaculislacus.co.uk',NULL),(81,'Skyler','Gould','risus.Duis.a@rutrummagna.co.uk',4,1,'0540489098','mus.Donec.dignissim@porttitorscelerisque.edu',NULL),(82,'Yetta','Beasley','luctus.aliquet@Morbiquisurna.com',4,2,'0503200466','Cras.convallis.convallis@metuseuerat.com',NULL),(83,'Dexter','Riddle','at.egestas.a@risusaultricies.com',4,2,'0496751635','Cras.eu@etmagnaPraesent.com',NULL),(84,'Lewis','Orr','ac.arcu@etmagnis.org',4,2,'0480299478','commodo@gravidamolestiearcu.edu',NULL),(85,'Geoffrey','Walters','Integer.tincidunt@Etiam.edu',4,19,'0611025254','elementum@malesuadaIntegerid.net',NULL),(86,'Elvis','Frank','consequat@Aeneanegetmagna.edu',4,19,'0359018577','dui.Suspendisse@Quisqueornaretortor.ca',NULL),(87,'Chase','Banks','lectus.Cum@pellentesqueafacilisis.net',4,19,'0756987085','semper.pretium@mauriserateget.edu',NULL),(88,'Adara','Dixon','egestas.Aliquam@semperNam.co.uk',4,19,'0618851512','amet.ante@lectuspedeet.org',NULL),(89,'Derek','Guthrie','enim.nisl.elementum@loremipsum.co.uk',4,19,'0127852498','leo@dolor.co.uk',NULL),(90,'Daquan','Hurst','mattis.Integer.eu@lectussit.ca',4,3,'0751198698','velit@atliberoMorbi.org',NULL),(91,'Gareth','Dyer','quam@quisturpisvitae.org',4,21,'0023856993','est.ac@nec.edu',NULL),(92,'Lucian','Sawyer','tellus.Phasellus.elit@euismod.com',4,21,'0670823754','Nulla.interdum@nislQuisquefringilla.com',NULL),(93,'Donovan','Little','nunc.interdum@miDuisrisus.net',4,21,'0248308253','tempus@nonummy.edu',NULL),(94,'Molly','Foley','lobortis.mauris@porttitor.co.uk',4,3,'0921669041','Donec@Cras.edu',NULL),(95,'Igor','Holman','volutpat.Nulla@vehicularisusNulla.co.uk',4,5,'0573787089','orci.quis@id.org',NULL),(96,'Risa','Hammond','nulla.Integer.urna@ultricesposuerecubilia.ca',4,5,'0824503469','accumsan.convallis@eget.ca',NULL),(97,'Jennifer','Woodard','et@tristique.edu',4,5,'0535069755','mollis.Duis@ac.co.uk',NULL),(98,'Brenna','Hobbs','neque@lacus.co.uk',4,5,'0802762227','aliquet.molestie@semNullainterdum.org',NULL),(99,'Dale','Battle','accumsan@Duisatlacus.com',4,5,'0838195388','eget@vulputate.co.uk',NULL),(100,'Chiquita','Frank','lectus.a@Donecfeugiat.net',4,7,'0436439755','tincidunt.congue@ac.ca',NULL),(101,'Iola','Chen','vulputate.velit@elementum.net',4,7,'0247815078','auctor.ullamcorper@amet.ca',NULL),(102,'Jana','Blanchard','lectus.a.sollicitudin@ipsum.ca',4,7,'0322798799','est.Nunc.ullamcorper@dictumeueleifend.org',NULL),(103,'Ferris','Alexander','diam.dictum@Fuscedolorquam.ca',4,7,'0354503871','orci.consectetuer@nonummy.co.uk',NULL),(104,'Jenette','Singleton','a.neque.Nullam@semper.co.uk',4,7,'0216726577','Suspendisse@sitametluctus.org',NULL),(105,'Slade','Stark','commodo@Fuscemilorem.net',4,NULL,'0234534640','amet@venenatisvel.net',NULL),(106,'Evelyn','Rich','vel.sapien@fermentumconvallis.ca',4,NULL,'0169935725','Ut.semper.pretium@Nunc.co.uk',NULL),(107,'Phyllis','Wolfe','Class@idrisusquis.edu',4,NULL,'0747222437','massa@sodalesatvelit.co.uk',NULL),(108,'Tallulah','Hebert','nunc.ullamcorper@Nullamscelerisque.co.uk',4,NULL,'0282980099','semper.auctor.Mauris@conubia.edu',NULL),(109,'Michael','Garza','dolor.Fusce.feugiat@lobortistellusjusto.net',4,NULL,'0165290651','metus.In@Aenean.org',NULL),(110,'Tucker','Mcleod','quis.urna@viverraDonectempus.co.uk',4,NULL,'0123377019','Fusce.mi@nonquamPellentesque.edu',NULL),(111,'Macy','Benjamin','vitae@ligulaAliquam.org',4,NULL,'0028986385','nibh@Quisquefringilla.edu',NULL),(112,'Xaviera','Kelley','turpis@metus.org',4,NULL,'0781759756','eget.laoreet.posuere@quis.edu',NULL),(113,'Conan','Rose','sodales.elit@sociosquad.com',4,NULL,'0207126016','sit.amet.massa@habitantmorbitristique.ca',NULL),(114,'Jemima','Henderson','elit@nonummyultricies.edu',4,NULL,'0297072047','Aenean@Praesenteudui.co.uk',NULL),(115,'Florence','Hewitt','adipiscing@arcuCurabitur.com',4,NULL,'0217060662','et@posuere.ca',NULL),(116,'Cadman','Baldwin','pharetra@seddolor.org',4,NULL,'0231643413','nisl@tinciduntnibh.ca',NULL),(117,'Fredericka','Yang','odio.Nam@scelerisquesedsapien.co.uk',4,NULL,'0607159193','Mauris@vulputate.org',NULL),(118,'Lucy','Parrish','turpis.In.condimentum@velsapien.net',4,NULL,'0165917109','turpis@est.net',NULL),(119,'Josiah','Buck','non.lorem.vitae@MaurismagnaDuis.com',4,NULL,'0817039008','tellus@nonquam.co.uk',NULL),(120,'ROANO','SORIA','roano@test.com',4,18,'09177825083','ROANOSORIA76','$2b$10$tV6m449Yuj3ofVX2XwZnze83HYRGZp9nlu47CbAooKt2vShvQo6IO'),(121,'EDGE','LORD','EDGELORD@TEST.COM',4,18,'12345569687','EDGELORD77','$2b$10$RzJbaoqrPef.qC8t7G6EaOQovwlhJfc4OTQnY207DLCjPlJj3qHIO');
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

-- Dump completed on 2019-11-16  3:20:44
