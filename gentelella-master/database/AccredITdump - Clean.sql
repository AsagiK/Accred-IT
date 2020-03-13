/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: meetings
# ------------------------------------------------------------

DROP TABLE IF EXISTS `meetings`;
CREATE TABLE `meetings` (
  `meetings_ID` int(11) NOT NULL AUTO_INCREMENT,
  `meetingname` varchar(45) NOT NULL,
  `meetingdesc` mediumtext NOT NULL,
  `meeting_creator` int(11) NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  PRIMARY KEY (`meetings_ID`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: accreditation
# ------------------------------------------------------------

DROP TABLE IF EXISTS `accreditation`;
CREATE TABLE `accreditation` (
  `accreditation_ID` int(11) NOT NULL AUTO_INCREMENT,
  `accreditation_Name` varchar(200) DEFAULT NULL,
  `accreditation_Description` mediumtext,
  `gradesset` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`accreditation_ID`)
) ENGINE = InnoDB AUTO_INCREMENT = 18 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: activity_members
# ------------------------------------------------------------

DROP TABLE IF EXISTS `activity_members`;
CREATE TABLE `activity_members` (
  `activity_ID` int(11) NOT NULL,
  `activity_Member` int(11) NOT NULL,
  `measurement_ID` int(11) NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: activity_outputs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `activity_outputs`;
CREATE TABLE `activity_outputs` (
  `output_ID` int(11) NOT NULL AUTO_INCREMENT,
  `activity_ID` int(11) NOT NULL,
  `output` varchar(45) NOT NULL,
  `output_Status` int(11) DEFAULT '0',
  PRIMARY KEY (`output_ID`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: approved_activities
# ------------------------------------------------------------

DROP TABLE IF EXISTS `approved_activities`;
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
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: approved_activities_audit
# ------------------------------------------------------------

DROP TABLE IF EXISTS `approved_activities_audit`;
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
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: area
# ------------------------------------------------------------

DROP TABLE IF EXISTS `area`;
CREATE TABLE `area` (
  `Area_ID` int(11) NOT NULL,
  `Area_Name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Area_ID`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: audit_activities
# ------------------------------------------------------------

DROP TABLE IF EXISTS `audit_activities`;
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
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: cycle
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cycle`;
CREATE TABLE `cycle` (
  `cycle_ID` int(11) NOT NULL AUTO_INCREMENT,
  `cycle_Name` varchar(45) NOT NULL,
  `start_Date` date NOT NULL,
  `end_Date` date NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `goal_ID` int(11) NOT NULL DEFAULT '0',
  `termnum` varchar(45) NOT NULL,
  `totalterm` varchar(45) NOT NULL,
  PRIMARY KEY (`cycle_ID`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: documents
# ------------------------------------------------------------

DROP TABLE IF EXISTS `documents`;
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
  `md5` varchar(100) DEFAULT NULL,
  `upload_id` int(11) NOT NULL,
  PRIMARY KEY (`Document_ID`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: folder_documents
# ------------------------------------------------------------

DROP TABLE IF EXISTS `folder_documents`;
CREATE TABLE `folder_documents` (
  `folder_id` int(11) NOT NULL,
  `document_id` int(11) NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: grades
# ------------------------------------------------------------

DROP TABLE IF EXISTS `grades`;
CREATE TABLE `grades` (
  `grades_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Rank` int(11) NOT NULL,
  `Code` varchar(45) NOT NULL,
  `Accreditation_ID` int(11) NOT NULL,
  PRIMARY KEY (`grades_ID`)
) ENGINE = InnoDB AUTO_INCREMENT = 54 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: group
# ------------------------------------------------------------

DROP TABLE IF EXISTS `group`;
CREATE TABLE `group` (
  `Group_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Group_Name` varchar(45) DEFAULT NULL,
  `Area_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`Group_ID`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: groupdetails
# ------------------------------------------------------------

DROP TABLE IF EXISTS `groupdetails`;
CREATE TABLE `groupdetails` (
  `Groupdetails_ID` int(11) NOT NULL,
  `Groupdetails_UserID` int(11) NOT NULL,
  `Groupdetails_Position` varchar(45) NOT NULL DEFAULT 'Member'
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: measurement
# ------------------------------------------------------------

DROP TABLE IF EXISTS `measurement`;
CREATE TABLE `measurement` (
  `measurement_ID` int(11) NOT NULL AUTO_INCREMENT,
  `QualityTarget` int(11) DEFAULT NULL,
  `Procedures` varchar(500) DEFAULT NULL,
  `GroupAssigned` int(11) DEFAULT NULL,
  `metric_ID` int(11) DEFAULT NULL,
  `measurement_Name` varchar(45) NOT NULL,
  `measurement_Description` mediumtext NOT NULL,
  `Deadline` varchar(45) DEFAULT NULL,
  `cycle_ID` int(11) NOT NULL,
  `priority_Level` int(11) NOT NULL,
  PRIMARY KEY (`measurement_ID`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: measurement_audit
# ------------------------------------------------------------

DROP TABLE IF EXISTS `measurement_audit`;
CREATE TABLE `measurement_audit` (
  `measurement_auditID` int(11) NOT NULL AUTO_INCREMENT,
  `measurement_ID` int(11) NOT NULL,
  `QualityTarget` int(11) DEFAULT NULL,
  `Procedures` varchar(500) DEFAULT NULL,
  `GroupAssigned` int(11) DEFAULT NULL,
  `metric_ID` int(11) DEFAULT NULL,
  `measurement_Name` varchar(45) NOT NULL,
  `measurement_Description` mediumtext NOT NULL,
  `Deadline` varchar(45) DEFAULT NULL,
  `cycle_ID` int(11) NOT NULL,
  `audit_date` date NOT NULL,
  `priority_Level` int(11) NOT NULL,
  PRIMARY KEY (`measurement_auditID`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: measurements_activities
# ------------------------------------------------------------

DROP TABLE IF EXISTS `measurements_activities`;
CREATE TABLE `measurements_activities` (
  `measurement_ID` int(11) NOT NULL,
  `activity_ID` int(11) NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: measurements_activities_audit
# ------------------------------------------------------------

DROP TABLE IF EXISTS `measurements_activities_audit`;
CREATE TABLE `measurements_activities_audit` (
  `measurement_activities_audit_ID` int(11) NOT NULL AUTO_INCREMENT,
  `measurements_auditID` int(11) DEFAULT NULL,
  `measurement_ID` int(11) NOT NULL,
  `activity_ID` int(11) NOT NULL,
  PRIMARY KEY (`measurement_activities_audit_ID`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: measurements_targets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `measurements_targets`;
CREATE TABLE `measurements_targets` (
  `measurementID` int(11) NOT NULL,
  `target` int(11) NOT NULL,
  `progress` int(11) DEFAULT NULL,
  `target_ID` int(11) NOT NULL AUTO_INCREMENT,
  `target_Type` int(11) DEFAULT NULL,
  `target_Desc` mediumtext,
  PRIMARY KEY (`target_ID`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: measurements_targets_audit
# ------------------------------------------------------------

DROP TABLE IF EXISTS `measurements_targets_audit`;
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
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: meetingdetails
# ------------------------------------------------------------

DROP TABLE IF EXISTS `meetingdetails`;
CREATE TABLE `meetingdetails` (
  `meetings_ID` int(11) NOT NULL,
  `members_ID` int(11) NOT NULL,
  `Status` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: activity_evidences
# ------------------------------------------------------------

DROP TABLE IF EXISTS `activity_evidences`;
CREATE TABLE `activity_evidences` (
  `activityID` int(11) NOT NULL,
  `documentID` int(11) NOT NULL,
  `pendingID` int(11) NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: metric
# ------------------------------------------------------------

DROP TABLE IF EXISTS `metric`;
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
  `source_Type` varchar(200) DEFAULT NULL,
  `cycle_Created` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`metric_ID`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: notifications
# ------------------------------------------------------------

DROP TABLE IF EXISTS `notifications`;
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
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: notifications_read
# ------------------------------------------------------------

DROP TABLE IF EXISTS `notifications_read`;
CREATE TABLE `notifications_read` (
  `Notifications_ID` int(11) NOT NULL,
  `Recipient_ID` int(11) NOT NULL,
  `notif_read` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: pending_activities
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pending_activities`;
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
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: pending_activities_audit
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pending_activities_audit`;
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
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: pending_outputs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pending_outputs`;
CREATE TABLE `pending_outputs` (
  `activityID` int(11) NOT NULL,
  `outputID` int(11) NOT NULL,
  `pendingID` int(11) NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: plandetails
# ------------------------------------------------------------

DROP TABLE IF EXISTS `plandetails`;
CREATE TABLE `plandetails` (
  `Plan_ID` int(11) NOT NULL,
  `Member_ID` varchar(45) NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: plans
# ------------------------------------------------------------

DROP TABLE IF EXISTS `plans`;
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
) ENGINE = InnoDB AUTO_INCREMENT = 8 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: plans_members
# ------------------------------------------------------------

DROP TABLE IF EXISTS `plans_members`;
CREATE TABLE `plans_members` (
  `plan_ID` int(11) NOT NULL,
  `user_ID` int(11) NOT NULL,
  `recommendation_ID` int(11) NOT NULL,
  `group_ID` int(11) NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: plansubmissions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `plansubmissions`;
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
) ENGINE = InnoDB AUTO_INCREMENT = 8 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: players
# ------------------------------------------------------------

DROP TABLE IF EXISTS `players`;
CREATE TABLE `players` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `position` varchar(255) NOT NULL,
  `number` int(11) NOT NULL,
  `image` varchar(255) NOT NULL,
  `user_name` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = latin1;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: privileges
# ------------------------------------------------------------

DROP TABLE IF EXISTS `privileges`;
CREATE TABLE `privileges` (
  `privilegeId` int(11) NOT NULL AUTO_INCREMENT,
  `PrivilegeType` varchar(45) NOT NULL,
  PRIMARY KEY (`privilegeId`)
) ENGINE = InnoDB AUTO_INCREMENT = 4 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: recommendation
# ------------------------------------------------------------

DROP TABLE IF EXISTS `recommendation`;
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
) ENGINE = InnoDB AUTO_INCREMENT = 19 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: roles
# ------------------------------------------------------------

DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `Role_ID` int(11) NOT NULL,
  `Role_Name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Role_ID`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: scores
# ------------------------------------------------------------

DROP TABLE IF EXISTS `scores`;
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
) ENGINE = InnoDB AUTO_INCREMENT = 7 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: source
# ------------------------------------------------------------

DROP TABLE IF EXISTS `source`;
CREATE TABLE `source` (
  `source_ID` int(11) NOT NULL AUTO_INCREMENT,
  `source_Name` varchar(200) DEFAULT NULL,
  `source_Description` mediumtext,
  PRIMARY KEY (`source_ID`)
) ENGINE = InnoDB AUTO_INCREMENT = 2 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: sourcetype
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sourcetype`;
CREATE TABLE `sourcetype` (
  `stype_ID` int(11) NOT NULL,
  `SourceType` varchar(100) NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: sysvalues
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sysvalues`;
CREATE TABLE `sysvalues` (
  `idsysvalues` int(11) NOT NULL,
  `inmaintenance` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idsysvalues`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: tasks
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tasks`;
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
) ENGINE = InnoDB AUTO_INCREMENT = 3 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users`;
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
) ENGINE = InnoDB AUTO_INCREMENT = 131 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: yearlycycle
# ------------------------------------------------------------

DROP TABLE IF EXISTS `yearlycycle`;
CREATE TABLE `yearlycycle` (
  `yearlyCycleID` int(11) NOT NULL,
  `cycle_Name` varchar(45) NOT NULL,
  `start_Date` date NOT NULL,
  `end_Date` date NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `cycle_ID` int(11) NOT NULL,
  PRIMARY KEY (`yearlyCycleID`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: meetings
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: accreditation
# ------------------------------------------------------------

INSERT INTO
  `accreditation` (
    `accreditation_ID`,
    `accreditation_Name`,
    `accreditation_Description`,
    `gradesset`
  )
VALUES
  (
    1,
    'PAASCU',
    'PAASCU is governed by a 15-person Board of Directors elected at large by\r\nmembers during the annual General Assembly. It has seven Commissions with five\r\nto seven members each to perform its mandate. These are the Commissions on\r\nGraduate Education, Medical Education, Engineering Education, Tertiary\r\nEducation, Integrated Basic Education, Secondary Education and Elementary\r\nEducation. The Commission members are recommended during the General\r\nAssembly and appointed by the Board.\r\n\r\nThe Commissions plan and initiate projects for each level, revise survey\r\ninstruments, and train accreditors and team chairs. Moreover, they review the\r\nreports of the survey teams before these are submitted to the Board.\r\nPAASCU’s day to day operations are handled by a Secretariat which is headed by\r\nthe Executive Director. The Secretariat takes care of the logistics of the survey\r\nvisits, invites accreditors, prepares reports and forms, and implements the projects\r\nof the Commissions.',
    0
  ),(
    2,
    'ABET',
    'At ABET, our purpose is to assure confidence in university programs in STEM (science, technology, engineering and mathematics) disciplines. Our approach, the standards we set and the quality we guarantee, inspires confidence in those who aim to build a better world—one that is safer, more efficient, more comfortable and more sustainable.\r\n\r\nWe accredit college and university programs in the disciplines of applied and natural science, computing, engineering and engineering technology at the associate, bachelor’s and master’s degree levels.\r\n\r\nWith ABET accreditation, students, employers and the society we serve can be confident that a program meets the quality standards that produce graduates prepared to enter a global workforce.\r\n\r\nWe began as the educational standard against which professional engineers in the United States were held for licensure. Today, after more than 80 years, our standards continue to play this fundamental role and have become the basis of quality for STEM disciplines all over the world.\r\n\r\nDeveloped by technical professionals from ABET’s member societies, our criteria focus on what students experience and learn. Sought worldwide, ABET’s voluntary peer-review process is highly respected because it adds critical value to academic programs in the technical disciplines, where quality, precision and safety are of the utmost importance.\r\n\r\nOur more than 2,200 experts come from industry, academia and government. They give their time and effort supporting quality assurance activities around the world by serving as Program Evaluators, commissioners, board members and advisors.\r\n\r\nABET is a nonprofit, non-governmental organization with ISO 9001:2015 certification.',
    0
  ),(3, 'TEst Item', 'AAAAA', 0),(4, 'TEst Item2', '1234', 0),(5, 'TEst Item3', '2345', 0),(6, 'TEst Item4', '1234', 0),(7, 'TEst Item5', '1234', 0),(8, 'TEst Item6', '1234', 0),(9, 'TEst Item7', '1234', 0),(10, 'TEst Item10', '1234', 0),(11, 'TEst Item112', '1234', 0),(12, 'TEst Item1123', '1234', 0),(13, 'TEst Item23423', '1234345', 0),(14, 'TEst Item112334', '1234', 0),(15, 'TEst Item11432334', '1234', 0),(16, 'TEst Item11435623', '1234', 1),(17, 'TEst Item1143233423', '123', 0);

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: activity_members
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: activity_outputs
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: approved_activities
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: approved_activities_audit
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: area
# ------------------------------------------------------------

INSERT INTO
  `area` (`Area_ID`, `Area_Name`)
VALUES
  (1, 'Purposes and Objectives'),(2, 'Faculty'),(3, 'Instruction'),(4, 'Library'),(5, 'Laboratories'),(6, 'Physial Plan'),(7, 'Student Services'),(8, 'Administration'),(9, 'School and Community');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: audit_activities
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: cycle
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: documents
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: folder_documents
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: grades
# ------------------------------------------------------------

INSERT INTO
  `grades` (`grades_ID`, `Rank`, `Code`, `Accreditation_ID`)
VALUES
  (1, 1, '123', 10),(2, 2, '234', 10),(3, 3, '345', 10),(4, 4, '456', 10),(5, 6, '678', 10),(6, 5, '567', 10),(7, 1, '123', 11),(8, 2, '234', 11),(9, 3, '345', 11),(10, 5, '567', 11),(11, 4, '456', 11),(12, 6, '678', 11),(13, 1, '123', 12),(14, 2, '234', 12),(15, 3, '345', 12),(16, 4, '456', 12),(17, 5, '567', 12),(18, 1, 'A', 13),(19, 2, 'B', 13),(20, 3, 'C', 13),(21, 4, 'D', 13),(22, 5, 'E', 13),(23, 6, 'F', 13),(24, 7, 'G', 13),(25, 8, 'H', 13),(26, 11, 'K', 13),(27, 10, 'J', 13),(28, 9, 'I', 13),(29, 12, 'L', 13),(30, 13, 'M', 13),(31, 14, 'N', 13),(32, 15, 'O', 13),(33, 16, 'P', 13),(34, 1, '123', 14),(35, 2, '234', 14),(36, 3, '345', 14),(37, 4, '456', 14),(38, 5, '567', 14),(39, 6, '678', 14),(40, 7, '789', 14),(41, 8, '890', 14),(42, 1, '123', 15),(43, 2, '234', 15),(44, 3, '345', 15),(45, 4, '456', 15),(46, 5, '567', 15),(47, 6, '678', 15),(48, 1, '123', 16),(49, 2, '234', 16),(50, 3, '345', 16),(51, 6, '678', 16),(52, 4, '456', 16),(53, 5, '567', 16);

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: group
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: groupdetails
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: measurement
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: measurement_audit
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: measurements_activities
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: measurements_activities_audit
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: measurements_targets
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: measurements_targets_audit
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: meetingdetails
# ------------------------------------------------------------

INSERT INTO
  `meetingdetails` (`meetings_ID`, `members_ID`, `Status`)
VALUES
  (1, 57, 0),(1, 51, 0),(1, 55, 0),(1, 48, 0),(1, 47, 0),(1, 49, 0),(1, 50, 0),(1, 56, 0),(1, 53, 0),(1, 54, 0),(1, 52, 0);

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: activity_evidences
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: metric
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: notifications
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: notifications_read
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: pending_activities
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: pending_activities_audit
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: pending_outputs
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: plandetails
# ------------------------------------------------------------

INSERT INTO
  `plandetails` (`Plan_ID`, `Member_ID`)
VALUES
  (7, '57'),(7, '35'),(7, '47'),(7, '56'),(7, '51'),(7, '46'),(7, '71'),(7, '70'),(7, '72'),(7, '62'),(7, '58'),(7, '50'),(7, '52'),(7, '48'),(7, '77'),(7, '59'),(7, '55'),(7, '81'),(7, '74'),(7, '66'),(7, '69'),(7, '76'),(7, '80'),(7, '73'),(7, '54'),(7, '63'),(7, '67'),(7, '78'),(7, '79'),(7, '61'),(7, '65'),(7, '68'),(7, '60'),(7, '49'),(7, '75'),(7, '53'),(7, '64');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: plans
# ------------------------------------------------------------

INSERT INTO
  `plans` (
    `Plan_ID`,
    `GenObjective`,
    `Measurement`,
    `BaseFormula`,
    `QualityTarget`,
    `Procedures`,
    `GroupAssigned`,
    `CycleTime`,
    `PriorityLevel`,
    `BaseStandard`,
    `recommendation_ID`,
    `PlanName`,
    `PlanDescription`,
    `Plan_MinCycles`,
    `Deadline`,
    `CycleCount`
  )
VALUES
  (
    7,
    '123',
    '123',
    '123',
    '123',
    '123',
    1,
    0,
    'High',
    'No base standard assigned',
    18,
    '123',
    '123',
    3,
    '07/30/2019',
    NULL
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: plans_members
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: plansubmissions
# ------------------------------------------------------------

INSERT INTO
  `plansubmissions` (
    `Submission_ID`,
    `Plan_ID`,
    `User_ID`,
    `Submission_Title`,
    `Submission_File`,
    `Submission_Description`,
    `Submission_Date`,
    `Submission_Status`,
    `Leader_Notes`
  )
VALUES
  (
    1,
    7,
    35,
    'test',
    'uploads/1.JPG',
    'DESCRIPTION NUMBER 1',
    '2019-07-23',
    3,
    '123'
  ),(
    2,
    7,
    35,
    'TESTING',
    'uploads/asean.docx',
    'DESCRIPTION NUMBER 2',
    '2019-07-24',
    0,
    NULL
  ),(
    3,
    7,
    35,
    'TESTING PART 2',
    'uploads/RoviSorianoA99.docx',
    'DESCRIPTION NUMBER 3',
    '2019-07-24',
    1,
    NULL
  ),(
    4,
    8,
    35,
    'TESTING ANOTHER ONE',
    'uploads/F1institutional-moa-re-ojt.doc',
    'TESTING ANOTHER ONE',
    '2019-07-25',
    1,
    NULL
  ),(
    5,
    9,
    35,
    'TESTI',
    'uploads/F1institutional-moa-re-ojt.doc',
    'ASDASD',
    '2019-07-25',
    0,
    NULL
  ),(
    6,
    7,
    46,
    'Hi',
    'uploads/07-01-01-07-05-2019.jpg',
    '123',
    '2019-07-28',
    1,
    NULL
  ),(
    7,
    7,
    46,
    '645',
    'uploads/06-01-01-45-57-2019.png',
    '634',
    '2019-07-28',
    1,
    NULL
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: players
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: privileges
# ------------------------------------------------------------

INSERT INTO
  `privileges` (`privilegeId`, `PrivilegeType`)
VALUES
  (1, 'Edit,View,Upload,Delete'),(2, 'Edit,View,Upload'),(3, 'View,Upload');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: recommendation
# ------------------------------------------------------------

INSERT INTO
  `recommendation` (
    `recommendation_ID`,
    `recommendation_Name`,
    `recommendation_Desc`,
    `recommendation_Grade`,
    `priority_Level`,
    `date_insert`,
    `area_ID`,
    `group_ID`,
    `accreditation_ID`
  )
VALUES
  (
    18,
    '123',
    '123',
    'A',
    'High',
    '2019-07-21 00:00:00',
    1,
    1,
    1
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: roles
# ------------------------------------------------------------

INSERT INTO
  `roles` (`Role_ID`, `Role_Name`)
VALUES
  (1, 'Admin'),(2, 'QA Officer'),(3, 'Department Chair'),(4, 'User');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: scores
# ------------------------------------------------------------

INSERT INTO
  `scores` (
    `idScores`,
    `Criteria`,
    `GeneralObjective`,
    `QualityTarget`,
    `GroupAssigned`,
    `PersonnelAssigned`,
    `PriorityLevel`,
    `PreviousScore`,
    `CurrentScore`,
    `PrevOrCurr`
  )
VALUES
  (
    1,
    'All classrooms contain fire extinguishers for cases of emergency\t',
    'Safety Practices and Academic Efficiency',
    8,
    'Student Services',
    'Jana',
    9,
    5,
    7,
    0
  ),(
    2,
    'All Scientific Laboratories contain proper safety materials and follow proper safety guidelines',
    'Safety Practices and Academic Efficiency',
    9,
    'Student Services',
    'Test',
    9,
    9,
    6,
    0
  ),(
    3,
    'Each classrooms contain learning materials athat are in good condition to be used for academic learning',
    'Safety Practices and Academic Efficiency',
    9,
    'Student Services',
    'Test',
    9,
    6,
    8,
    0
  ),(
    4,
    'The library has enough learnin resources that can help the student with their specific courses',
    'Library',
    8,
    'Student Services',
    NULL,
    9,
    7,
    7,
    1
  ),(
    5,
    'All Computers in the computer laboratories are well maintained and suffices the technological specifications for the student\'s needs',
    'Safety Practices and Academic Efficiency',
    9,
    'Student Services',
    NULL,
    9,
    7,
    9,
    1
  ),(
    6,
    'The Laboratories are well maintained and upgraded to increase guranteed safety and learning efficiency of the students',
    'Safety Practices and Academic Efficiency',
    9,
    'Student Services',
    NULL,
    9,
    6,
    6,
    1
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: source
# ------------------------------------------------------------

INSERT INTO
  `source` (`source_ID`, `source_Name`, `source_Description`)
VALUES
  (1, 'Departmento', 'Galing sa Depart');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: sourcetype
# ------------------------------------------------------------

INSERT INTO
  `sourcetype` (`stype_ID`, `SourceType`)
VALUES
  (1, 'Quality Assurance Goals'),(1, 'University Goals'),(1, 'Department Goals');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: sysvalues
# ------------------------------------------------------------

INSERT INTO
  `sysvalues` (`idsysvalues`, `inmaintenance`)
VALUES
  (1, 0);

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: tasks
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: users
# ------------------------------------------------------------

INSERT INTO
  `users` (
    `User_ID`,
    `User_First`,
    `User_Last`,
    `email_address`,
    `Role`,
    `Group`,
    `ContactNo`,
    `username`,
    `passwd`
  )
VALUES
  (
    35,
    'Admin',
    'Admin',
    'debug@debug.com',
    1,
    1,
    '99999999999',
    'Admin',
    '$2b$10$w1q.GZyvVMwt9c6aiFjBEuahRim1NOtIgFOY8DYsxoJuN31CsUGsu'
  ),(
    46,
    'AdminX',
    'AdminX',
    'debug@debug.com',
    1,
    1,
    '99999999999',
    'AdminX',
    '$2b$10$bWyFihniq34XjVzTZXXMjeqbF1LeG.gP06X2FLc.XZ6vgH5wHo6.e'
  ),(
    47,
    'Jayme',
    'Randall',
    'quis.massa.Mauris@amalesuadaid.com',
    4,
    1,
    '0827150506',
    'orci.consectetuer.euismod@convalliserat.co.uk',
    NULL
  ),(
    48,
    'Hedda',
    'Blanchard',
    'dolor.egestas.rhoncus@etmagnisdis.com',
    4,
    1,
    '0532678474',
    'egestas.hendrerit@Maurisblanditenim.co.uk',
    NULL
  ),(
    49,
    'Quentin',
    'Farmer',
    'senectus.et.netus@Nulla.co.uk',
    4,
    1,
    '0424963076',
    'vitae.erat@risusDuisa.net',
    NULL
  ),(
    50,
    'Rooney',
    'Lawson',
    'lectus@utipsumac.com',
    4,
    1,
    '0017842615',
    'ipsum.nunc.id@velitSedmalesuada.edu',
    NULL
  ),(
    51,
    'Fuller',
    'Lawson',
    'lorem.vitae.odio@turpisNulla.com',
    4,
    1,
    '0104998917',
    'ut.pellentesque.eget@Aliquamvulputate.net',
    NULL
  ),(
    52,
    'Naida',
    'Travis',
    'molestie.orci.tincidunt@diamSed.org',
    4,
    1,
    '0396262927',
    'ipsum@hymenaeosMaurisut.com',
    NULL
  ),(
    53,
    'Shelly',
    'Odonnell',
    'consequat.purus@ut.com',
    4,
    1,
    '0741793038',
    'Etiam.gravida.molestie@lectus.edu',
    NULL
  ),(
    54,
    'Nomlanga',
    'Wiley',
    'sociis@imperdietnecleo.net',
    4,
    1,
    '0463195329',
    'ut.pellentesque.eget@semNulla.org',
    NULL
  ),(
    55,
    'Pamela',
    'Payne',
    'cursus.et.magna@cursusaenim.net',
    4,
    1,
    '0336253671',
    'diam@tempus.edu',
    NULL
  ),(
    56,
    'Dale',
    'Fulton',
    'consequat.dolor@vestibulum.edu',
    4,
    1,
    '0621007822',
    'ultricies@Vivamuseuismodurna.co.uk',
    NULL
  ),(
    57,
    'Brock',
    'Tanner',
    'magnis.dis@iaculisaliquetdiam.com',
    4,
    1,
    '0485322526',
    'ornare.lectus.justo@dolorFuscemi.net',
    NULL
  ),(
    58,
    'Drake',
    'Hogan',
    'Integer@nequeMorbi.co.uk',
    4,
    1,
    '0122087593',
    'sed.turpis@arcuVestibulum.net',
    NULL
  ),(
    59,
    'Fitzgerald',
    'Ortiz',
    'arcu@in.edu',
    4,
    1,
    '0353804236',
    'vitae.aliquam.eros@quispedePraesent.edu',
    NULL
  ),(
    60,
    'Isaiah',
    'Kemp',
    'pellentesque@lacinia.co.uk',
    4,
    1,
    '0687689022',
    'enim.Etiam.gravida@enimEtiamgravida.org',
    NULL
  ),(
    61,
    'Cassady',
    'Carson',
    'adipiscing@quisaccumsan.org',
    4,
    1,
    '0822841725',
    'justo@Loremipsumdolor.org',
    NULL
  ),(
    62,
    'Yeo',
    'Allison',
    'Sed.auctor@vulputate.edu',
    4,
    1,
    '0751834790',
    'Nunc.quis@arcuVestibulum.com',
    NULL
  ),(
    63,
    'Daria',
    'Knox',
    'nec.mauris.blandit@rhoncusDonec.co.uk',
    4,
    1,
    '0068744702',
    'neque.sed@quispedePraesent.co.uk',
    NULL
  ),(
    64,
    'Preston',
    'Melton',
    'massa.non@tempusscelerisque.com',
    4,
    1,
    '0385565489',
    'vel.venenatis@non.net',
    NULL
  ),(
    65,
    'Chaim',
    'Walls',
    'ullamcorper.nisl.arcu@Vivamus.org',
    4,
    1,
    '0994904810',
    'vitae.nibh@eget.com',
    NULL
  ),(
    66,
    'Karly',
    'Shaw',
    'nisl.Quisque.fringilla@nonfeugiatnec.co.uk',
    4,
    1,
    '0617257074',
    'penatibus.et@nuncsed.net',
    NULL
  ),(
    67,
    'Maisie',
    'Sharp',
    'ac.mi.eleifend@eratSed.edu',
    4,
    1,
    '0046643354',
    'at.iaculis.quis@malesuadamalesuadaInteger.com',
    NULL
  ),(
    68,
    'Indigo',
    'Mccoy',
    'sit.amet.nulla@feugiatnec.ca',
    4,
    1,
    '0769322656',
    'consectetuer.cursus@risusQuisque.ca',
    NULL
  ),(
    69,
    'Keane',
    'Parsons',
    'Morbi@Aliquameratvolutpat.net',
    4,
    1,
    '0876062059',
    'libero.est@necmaurisblandit.edu',
    NULL
  ),(
    70,
    'Rafael',
    'Schmidt',
    'urna.convallis.erat@ipsum.co.uk',
    4,
    1,
    '0912845172',
    'ac@pretiumneque.com',
    NULL
  ),(
    71,
    'Haley',
    'Wheeler',
    'tristique.aliquet@nibh.net',
    4,
    1,
    '0510355744',
    'sit.amet@Loremipsumdolor.ca',
    NULL
  ),(
    72,
    'William',
    'Dickson',
    'euismod@Aliquamvulputate.com',
    4,
    1,
    '0422612351',
    'convallis.convallis@risusquisdiam.ca',
    NULL
  ),(
    73,
    'Quentin',
    'Church',
    'at.sem.molestie@sapiencursusin.ca',
    4,
    1,
    '0701695380',
    'Donec.tempor.est@feugiat.com',
    NULL
  ),(
    74,
    'Rebekah',
    'Velez',
    'lacus.pede@aaliquet.ca',
    4,
    1,
    '0094284493',
    'Nullam.lobortis@metus.com',
    NULL
  ),(
    75,
    'Lavinia',
    'Yang',
    'dui.nec.urna@faucibus.edu',
    4,
    1,
    '0329088663',
    'dictum.sapien@purus.org',
    NULL
  ),(
    76,
    'Keefe',
    'Ross',
    'elit@nibhsitamet.edu',
    4,
    1,
    '0679701501',
    'dolor.elit.pellentesque@in.com',
    NULL
  ),(
    77,
    'Wendy',
    'Hoover',
    'fringilla.cursus.purus@imperdiet.ca',
    4,
    1,
    '0379574808',
    'orci.tincidunt.adipiscing@malesuada.org',
    NULL
  ),(
    78,
    'Jared',
    'Summers',
    'aliquet@aliquetsem.ca',
    4,
    1,
    '0733466712',
    'Phasellus.elit.pede@quamquisdiam.co.uk',
    NULL
  ),(
    79,
    'Addison',
    'Goodman',
    'orci@disparturientmontes.com',
    4,
    1,
    '0980636012',
    'et.ultrices.posuere@maurisIntegersem.net',
    NULL
  ),(
    80,
    'Patricia',
    'Walsh',
    'Proin.nisl.sem@loremtristiquealiquet.com',
    4,
    1,
    '0297573566',
    'sit.amet@iaculislacus.co.uk',
    NULL
  ),(
    81,
    'Skyler',
    'Gould',
    'risus.Duis.a@rutrummagna.co.uk',
    4,
    1,
    '0540489098',
    'mus.Donec.dignissim@porttitorscelerisque.edu',
    NULL
  ),(
    82,
    'Yetta',
    'Beasley',
    'luctus.aliquet@Morbiquisurna.com',
    4,
    2,
    '0503200466',
    'Cras.convallis.convallis@metuseuerat.com',
    NULL
  ),(
    83,
    'Dexter',
    'Riddle',
    'at.egestas.a@risusaultricies.com',
    4,
    2,
    '0496751635',
    'Cras.eu@etmagnaPraesent.com',
    NULL
  ),(
    84,
    'Lewis',
    'Orr',
    'ac.arcu@etmagnis.org',
    4,
    2,
    '0480299478',
    'commodo@gravidamolestiearcu.edu',
    NULL
  ),(
    85,
    'Geoffrey',
    'Walters',
    'Integer.tincidunt@Etiam.edu',
    4,
    19,
    '0611025254',
    'elementum@malesuadaIntegerid.net',
    NULL
  ),(
    86,
    'Elvis',
    'Frank',
    'consequat@Aeneanegetmagna.edu',
    4,
    19,
    '0359018577',
    'dui.Suspendisse@Quisqueornaretortor.ca',
    NULL
  ),(
    87,
    'Chase',
    'Banks',
    'lectus.Cum@pellentesqueafacilisis.net',
    4,
    19,
    '0756987085',
    'semper.pretium@mauriserateget.edu',
    NULL
  ),(
    88,
    'Adara',
    'Dixon',
    'egestas.Aliquam@semperNam.co.uk',
    4,
    19,
    '0618851512',
    'amet.ante@lectuspedeet.org',
    NULL
  ),(
    89,
    'Derek',
    'Guthrie',
    'enim.nisl.elementum@loremipsum.co.uk',
    4,
    19,
    '0127852498',
    'leo@dolor.co.uk',
    NULL
  ),(
    90,
    'Daquan',
    'Hurst',
    'mattis.Integer.eu@lectussit.ca',
    4,
    3,
    '0751198698',
    'velit@atliberoMorbi.org',
    NULL
  ),(
    91,
    'Gareth',
    'Dyer',
    'quam@quisturpisvitae.org',
    4,
    21,
    '0023856993',
    'est.ac@nec.edu',
    NULL
  ),(
    92,
    'Lucian',
    'Sawyer',
    'tellus.Phasellus.elit@euismod.com',
    4,
    21,
    '0670823754',
    'Nulla.interdum@nislQuisquefringilla.com',
    NULL
  ),(
    93,
    'Donovan',
    'Little',
    'nunc.interdum@miDuisrisus.net',
    4,
    21,
    '0248308253',
    'tempus@nonummy.edu',
    NULL
  ),(
    94,
    'Molly',
    'Foley',
    'lobortis.mauris@porttitor.co.uk',
    4,
    3,
    '0921669041',
    'Donec@Cras.edu',
    NULL
  ),(
    95,
    'Igor',
    'Holman',
    'volutpat.Nulla@vehicularisusNulla.co.uk',
    4,
    5,
    '0573787089',
    'orci.quis@id.org',
    NULL
  ),(
    96,
    'Risa',
    'Hammond',
    'nulla.Integer.urna@ultricesposuerecubilia.ca',
    4,
    5,
    '0824503469',
    'accumsan.convallis@eget.ca',
    NULL
  ),(
    97,
    'Jennifer',
    'Woodard',
    'et@tristique.edu',
    4,
    5,
    '0535069755',
    'mollis.Duis@ac.co.uk',
    NULL
  ),(
    98,
    'Brenna',
    'Hobbs',
    'neque@lacus.co.uk',
    4,
    5,
    '0802762227',
    'aliquet.molestie@semNullainterdum.org',
    NULL
  ),(
    99,
    'Dale',
    'Battle',
    'accumsan@Duisatlacus.com',
    4,
    5,
    '0838195388',
    'eget@vulputate.co.uk',
    NULL
  ),(
    100,
    'Chiquita',
    'Frank',
    'lectus.a@Donecfeugiat.net',
    4,
    7,
    '0436439755',
    'tincidunt.congue@ac.ca',
    NULL
  ),(
    101,
    'Iola',
    'Chen',
    'vulputate.velit@elementum.net',
    4,
    7,
    '0247815078',
    'auctor.ullamcorper@amet.ca',
    NULL
  ),(
    102,
    'Jana',
    'Blanchard',
    'lectus.a.sollicitudin@ipsum.ca',
    4,
    7,
    '0322798799',
    'est.Nunc.ullamcorper@dictumeueleifend.org',
    NULL
  ),(
    103,
    'Ferris',
    'Alexander',
    'diam.dictum@Fuscedolorquam.ca',
    4,
    7,
    '0354503871',
    'orci.consectetuer@nonummy.co.uk',
    NULL
  ),(
    104,
    'Jenette',
    'Singleton',
    'a.neque.Nullam@semper.co.uk',
    4,
    7,
    '0216726577',
    'Suspendisse@sitametluctus.org',
    NULL
  ),(
    105,
    'Slade',
    'Stark',
    'commodo@Fuscemilorem.net',
    4,
    NULL,
    '0234534640',
    'amet@venenatisvel.net',
    NULL
  ),(
    106,
    'Evelyn',
    'Rich',
    'vel.sapien@fermentumconvallis.ca',
    4,
    NULL,
    '0169935725',
    'Ut.semper.pretium@Nunc.co.uk',
    NULL
  ),(
    107,
    'Phyllis',
    'Wolfe',
    'Class@idrisusquis.edu',
    4,
    NULL,
    '0747222437',
    'massa@sodalesatvelit.co.uk',
    NULL
  ),(
    108,
    'Tallulah',
    'Hebert',
    'nunc.ullamcorper@Nullamscelerisque.co.uk',
    4,
    NULL,
    '0282980099',
    'semper.auctor.Mauris@conubia.edu',
    NULL
  ),(
    109,
    'Michael',
    'Garza',
    'dolor.Fusce.feugiat@lobortistellusjusto.net',
    4,
    NULL,
    '0165290651',
    'metus.In@Aenean.org',
    NULL
  ),(
    110,
    'Tucker',
    'Mcleod',
    'quis.urna@viverraDonectempus.co.uk',
    4,
    NULL,
    '0123377019',
    'Fusce.mi@nonquamPellentesque.edu',
    NULL
  ),(
    111,
    'Macy',
    'Benjamin',
    'vitae@ligulaAliquam.org',
    4,
    NULL,
    '0028986385',
    'nibh@Quisquefringilla.edu',
    NULL
  ),(
    112,
    'Xaviera',
    'Kelley',
    'turpis@metus.org',
    4,
    NULL,
    '0781759756',
    'eget.laoreet.posuere@quis.edu',
    NULL
  ),(
    113,
    'Conan',
    'Rose',
    'sodales.elit@sociosquad.com',
    4,
    NULL,
    '0207126016',
    'sit.amet.massa@habitantmorbitristique.ca',
    NULL
  ),(
    114,
    'Jemima',
    'Henderson',
    'elit@nonummyultricies.edu',
    4,
    NULL,
    '0297072047',
    'Aenean@Praesenteudui.co.uk',
    NULL
  ),(
    115,
    'Florence',
    'Hewitt',
    'adipiscing@arcuCurabitur.com',
    4,
    NULL,
    '0217060662',
    'et@posuere.ca',
    NULL
  ),(
    116,
    'Cadman',
    'Baldwin',
    'pharetra@seddolor.org',
    4,
    NULL,
    '0231643413',
    'nisl@tinciduntnibh.ca',
    NULL
  ),(
    117,
    'Fredericka',
    'Yang',
    'odio.Nam@scelerisquesedsapien.co.uk',
    4,
    NULL,
    '0607159193',
    'Mauris@vulputate.org',
    NULL
  ),(
    118,
    'Lucy',
    'Parrish',
    'turpis.In.condimentum@velsapien.net',
    4,
    NULL,
    '0165917109',
    'turpis@est.net',
    NULL
  ),(
    119,
    'Josiah',
    'Buck',
    'non.lorem.vitae@MaurismagnaDuis.com',
    4,
    NULL,
    '0817039008',
    'tellus@nonquam.co.uk',
    NULL
  ),(
    120,
    'ROANO',
    'SORIA',
    'roano@test.com',
    4,
    20,
    '09177825083',
    'ROANOSORIA76',
    '$2b$10$tV6m449Yuj3ofVX2XwZnze83HYRGZp9nlu47CbAooKt2vShvQo6IO'
  ),(
    121,
    'EDGE',
    'LORD',
    'EDGELORD@TEST.COM',
    4,
    20,
    '12345569687',
    'EDGELORD77',
    '$2b$10$RzJbaoqrPef.qC8t7G6EaOQovwlhJfc4OTQnY207DLCjPlJj3qHIO'
  ),(
    122,
    'Anjelo Justine',
    ' Padua',
    'anjelo.padua@yahoo.com',
    3,
    20,
    '0995011384',
    'Anjelo Justine Padua78',
    '$2b$10$BZYBhgOuAflHt24F57124Oe4dyp0/n79mydMxrCJ/TUtKiBGzV8U2'
  ),(
    123,
    'Jericho',
    'Mendoza',
    'jermon@gmail.com',
    4,
    20,
    '43897892343',
    'JerichoMendoza79',
    '$2b$10$Ei.hKcqpCBe2BMBzEXargezjodO4QyQaOVuZQQtZlRiInqB7Y720u'
  ),(
    124,
    'Test',
    'User',
    'hi@test.com',
    4,
    NULL,
    '121111111',
    'TestUser80',
    '$2b$10$DFAWs9h/xHdCINNmQoIsteGSAK5tc7h5bl2zcDWAwPt9o//E8ZfK2'
  ),(
    125,
    'Look',
    'Forme',
    'h125i@test.com',
    4,
    NULL,
    '1245',
    'LookForme81',
    '$2b$10$YBMSXdG4xxBAkR3mzccXXuKbEia59133Qk6f99xaRe.u/svasXCzi'
  ),(
    126,
    '12412',
    '6643524',
    '1241@hger.com',
    4,
    NULL,
    '1111',
    '12412664352481',
    '$2b$10$UebHqHBJGyneqKheCwn37ee.sy39GlZjh4mcmkHG8mCrB5rRUezoK'
  ),(
    127,
    '5423',
    '4623456',
    'hjert@sdgjewt.com',
    4,
    NULL,
    '124',
    '5423462345683',
    '$2b$10$fHzy6iJA/r.AL2d8QjXd0u3mzByfS9BEjN8.aU0.2Oul1qinWaJ7u'
  ),(
    128,
    '12412545',
    '634734',
    '12421@hete.com',
    4,
    NULL,
    '12415',
    '1241254563473484',
    '$2b$10$ryyeUQrPk6xaB6atiL8rKeiz.kyFFh8/EYrpmQacOxaSNm8kIysrS'
  ),(
    129,
    '3251',
    '2`14`123`12',
    '2513223@jhetre.com',
    4,
    NULL,
    '13252134',
    '32512`14`123`1284',
    '$2b$10$70NTfqVAlZrSaJtBa0btRO/PhXPWvmoktuLfnvE72yDe2DXg96gBO'
  ),(
    130,
    '123',
    '52346',
    '4326423723@he4t43.com',
    4,
    NULL,
    '124',
    '1235234686',
    '$2b$10$zF3hYQirYc5VujjL/X7DT.uFm/1t1Sc/qryxybp7egIMZkrzilum.'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: yearlycycle
# ------------------------------------------------------------


/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
