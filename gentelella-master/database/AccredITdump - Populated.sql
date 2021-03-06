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
) ENGINE = InnoDB AUTO_INCREMENT = 4 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

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
) ENGINE = InnoDB AUTO_INCREMENT = 4 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

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
) ENGINE = InnoDB AUTO_INCREMENT = 9 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

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
) ENGINE = InnoDB AUTO_INCREMENT = 5 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

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
) ENGINE = InnoDB AUTO_INCREMENT = 97 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

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
) ENGINE = InnoDB AUTO_INCREMENT = 22 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

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
) ENGINE = InnoDB AUTO_INCREMENT = 6 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

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
) ENGINE = InnoDB AUTO_INCREMENT = 5 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

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
) ENGINE = InnoDB AUTO_INCREMENT = 9 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

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
) ENGINE = InnoDB AUTO_INCREMENT = 7 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

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
) ENGINE = InnoDB AUTO_INCREMENT = 9 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

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
) ENGINE = InnoDB AUTO_INCREMENT = 3 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

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
) ENGINE = InnoDB AUTO_INCREMENT = 60 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

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
) ENGINE = InnoDB AUTO_INCREMENT = 6 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

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
) ENGINE = InnoDB AUTO_INCREMENT = 4 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

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

INSERT INTO
  `activity_members` (`activity_ID`, `activity_Member`, `measurement_ID`)
VALUES
  (1, 122, 1),(1, 123, 1),(2, 120, 1),(2, 121, 1),(1, 120, 1),(1, 121, 1),(3, 0, 1),(3, 2, 1),(3, 1, 1),(3, 0, 1),(3, 1, 1),(3, 2, 1),(3, 20, 1),(3, 20, 1),(3, 21, 1),(3, 21, 1);

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: activity_outputs
# ------------------------------------------------------------

INSERT INTO
  `activity_outputs` (
    `output_ID`,
    `activity_ID`,
    `output`,
    `output_Status`
  )
VALUES
  (1, 1, 'Jumbong Hatdog', 0),(2, 2, 'Samgyupsal', 0),(3, 1, 'testing', 0);

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: approved_activities
# ------------------------------------------------------------

INSERT INTO
  `approved_activities` (
    `activity_ID`,
    `activity_name`,
    `target`,
    `code`,
    `description`,
    `measurement_ID`,
    `current_Score`,
    `deadline`
  )
VALUES
  (
    1,
    'Revision of syllabi',
    NULL,
    0,
    'Revise syllabi to encorparte new lessons',
    NULL,
    0,
    '2020-02-29'
  ),(
    2,
    'Update faculty listing',
    NULL,
    0,
    'update faculty listing to encorporate new tittles',
    NULL,
    0,
    '2020-02-29'
  ),(
    3,
    'dsiufhsuofh',
    NULL,
    0,
    'iudhgeihf',
    NULL,
    0,
    '2019-12-07'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: approved_activities_audit
# ------------------------------------------------------------

INSERT INTO
  `approved_activities_audit` (
    `approved_activities_auditID`,
    `measurement_auditID`,
    `activity_ID`,
    `activity_name`,
    `target`,
    `code`,
    `description`,
    `measurement_ID`,
    `current_Score`,
    `deadline`
  )
VALUES
  (
    1,
    1,
    2,
    'Update faculty listing',
    NULL,
    0,
    'update faculty listing to encorporate new tittles',
    NULL,
    0,
    '2020-02-28'
  ),(
    2,
    1,
    1,
    'Revision of syllabi',
    NULL,
    0,
    'Revise syllabi to encorparte new lessons',
    NULL,
    0,
    '2020-02-28'
  ),(
    3,
    2,
    1,
    'Revision of syllabi',
    NULL,
    0,
    'Revise syllabi to encorparte new lessons',
    NULL,
    0,
    '2020-02-28'
  ),(
    4,
    2,
    2,
    'Update faculty listing',
    NULL,
    0,
    'update faculty listing to encorporate new tittles',
    NULL,
    0,
    '2020-02-28'
  ),(
    5,
    3,
    1,
    'Revision of syllabi',
    NULL,
    0,
    'Revise syllabi to encorparte new lessons',
    NULL,
    0,
    '2020-02-28'
  ),(
    6,
    3,
    2,
    'Update faculty listing',
    NULL,
    0,
    'update faculty listing to encorporate new tittles',
    NULL,
    0,
    '2020-02-28'
  ),(
    7,
    4,
    1,
    'Revision of syllabi',
    NULL,
    0,
    'Revise syllabi to encorparte new lessons',
    NULL,
    0,
    '2020-02-28'
  ),(
    8,
    4,
    2,
    'Update faculty listing',
    NULL,
    0,
    'update faculty listing to encorporate new tittles',
    NULL,
    0,
    '2020-02-28'
  );

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

INSERT INTO
  `cycle` (
    `cycle_ID`,
    `cycle_Name`,
    `start_Date`,
    `end_Date`,
    `status`,
    `goal_ID`,
    `termnum`,
    `totalterm`
  )
VALUES
  (
    1,
    'TERM 1 AY 2020-2021',
    '2019-11-01',
    '2025-11-25',
    4,
    1,
    '1',
    '1'
  ),(
    2,
    'Term 2 2019-2020',
    '2019-11-01',
    '2025-11-25',
    4,
    1,
    '1',
    '2'
  ),(
    3,
    'Term 3 2019-2020',
    '2019-11-01',
    '2025-11-25',
    0,
    1,
    '2',
    '2'
  ),(
    4,
    'Year 1 - Term 1',
    '2019-12-07',
    '2019-12-08',
    2,
    2,
    '1',
    '1'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: documents
# ------------------------------------------------------------

INSERT INTO
  `documents` (
    `Document_ID`,
    `Document_Name`,
    `Document_Route`,
    `Document_Desc`,
    `Document_Ext`,
    `InDrive`,
    `DriveID`,
    `isaversionof`,
    `version`,
    `md5`,
    `upload_id`
  )
VALUES
  (
    1,
    '04-19-04-35-15-2019.jpg',
    'uploads/04-19-04-35-15-2019.jpg',
    NULL,
    '.jpg',
    1,
    '1LsHKcOx555Xx4iJJpuZY_yohhvuH7jcW',
    NULL,
    1,
    '933f5ad27efca18d1b16a6a016566b9b',
    0
  ),(
    2,
    '04-19-04-39-33-2019.png',
    'uploads/04-19-04-39-33-2019.png',
    NULL,
    '.png',
    1,
    '1ey6QnCJYdsXToMAfnd7ZV3wZNqwBgGDP',
    NULL,
    1,
    'ec7ee7444229726e5fa2e11cce4291c8',
    0
  ),(
    3,
    '04-19-04-40-40-2019.png',
    'uploads/04-19-04-40-40-2019.png',
    NULL,
    '.png',
    1,
    '1JsOdmSraCLB6RMRUEU-etz2_TMd3_Ngh',
    NULL,
    1,
    'e1f80060f13c043db7f8decba2c814f7',
    0
  ),(
    4,
    '04-19-04-46-11-2019.png',
    'uploads/04-19-04-46-11-2019.png',
    NULL,
    '.png',
    1,
    '1Zxkh2NI-UeWLnNWTr8NB8qFDE_eFLjXD',
    NULL,
    1,
    'def4c2d6360cf9161b282095907c7fda',
    0
  ),(
    5,
    '04-19-04-46-21-2019.png',
    'uploads/04-19-04-46-21-2019.png',
    NULL,
    '.png',
    1,
    '1j8kHCZhqtYL1Wa7YayLnhd3OqSXyiEXQ',
    NULL,
    1,
    '433e69e67b71349aee1e6b1b2257444e',
    0
  ),(
    6,
    '04-19-04-47-42-2019.png',
    'uploads/04-19-04-47-42-2019.png',
    NULL,
    '.png',
    1,
    '1m3cFdoHwdMScjdOf2_aqkCA5N0CSFBs5',
    NULL,
    1,
    '4422da9277238aca6ff2d31fd13b54b9',
    0
  ),(
    7,
    '04-19-05-08-09-2019.jpg',
    'uploads/04-19-05-08-09-2019.jpg',
    NULL,
    '.jpg',
    1,
    '1aR5Dht_HcBjrlpxP3e93kfXvPCZh2n6n',
    NULL,
    1,
    '3fef713b797a17b574dea17d5a16791b',
    0
  ),(
    8,
    '04-19-05-25-11-2019.png',
    'uploads/04-19-05-25-11-2019.png',
    NULL,
    '.png',
    1,
    '1najR-LmJDg1RsT1U1L9aU5f3pSlICsRh',
    NULL,
    1,
    '316666b8704a11cbb52b42a959ec92e1',
    0
  ),(
    9,
    '04-19-05-29-45-2019.jpg',
    'uploads/04-19-05-29-45-2019.jpg',
    NULL,
    '.jpg',
    1,
    '1X76gkwwpfpC6h5e5MEsDbMQMOPabHDIV',
    NULL,
    1,
    '82fb6038207b4c9fac530e88d27dfb98',
    0
  ),(
    10,
    '04-19-05-32-38-2019.png',
    'uploads/04-19-05-32-38-2019.png',
    NULL,
    '.png',
    1,
    '1T0yPqlHUwug5AXKgPHfgWDA0tMZd9Y8t',
    NULL,
    1,
    'aea75005b5eef88ebeb0ac092fdd9e8b',
    0
  ),(
    11,
    '04-19-06-10-58-2019.png',
    'uploads/04-19-06-10-58-2019.png',
    NULL,
    '.png',
    1,
    '1Uum9CsmfIPmwSnnAoi3lchEYPTzkNsSH',
    NULL,
    1,
    '153ddf1974aebaf687f0fc2c1e899137',
    0
  ),(
    12,
    '04-19-06-19-39-2019.jpg',
    'uploads/04-19-06-19-39-2019.jpg',
    NULL,
    '.jpg',
    1,
    '1uN-NXPwGK2OTo2PsNTLeJlPLmwnouM2a',
    NULL,
    1,
    'ed3a9078ca8209ac5d4bb6fed192093c',
    0
  ),(
    13,
    '04-19-06-31-58-2019.png',
    'uploads/04-19-06-31-58-2019.png',
    NULL,
    '.png',
    1,
    '1stu27NBE6IXU_H-Ianx5pYZZDT73_v7x',
    NULL,
    1,
    'badc5e4ea1fe2a227de37d6a5be0d411',
    0
  ),(
    14,
    '04-19-06-34-46-2019.jpg',
    'uploads/04-19-06-34-46-2019.jpg',
    NULL,
    '.jpg',
    1,
    '1kMTaTa_64P2DgsuDrRD82KeUIzjDx7Gu',
    NULL,
    1,
    '6e2442ae51ce2d19635f49344b45449e',
    0
  ),(
    15,
    '04-19-06-36-49-2019.png',
    'uploads/04-19-06-36-49-2019.png',
    NULL,
    '.png',
    1,
    '1HzkMd4jf7-XIV8P9OnK-Vglc7hhaqYKP',
    NULL,
    1,
    '3a3cdc65a5420a330abef4894c585af8',
    0
  ),(
    16,
    '04-20-05-59-37-2019.png',
    'uploads/04-20-05-59-37-2019.png',
    NULL,
    '.png',
    1,
    '1orOUE-pgi-Udqy_TCa9ixD__Ml7gILu-',
    NULL,
    1,
    '61823ba04e83b93b4be8ccb68446395a',
    0
  ),(
    17,
    '04-20-05-50-55-2019.png',
    'uploads/04-20-05-50-55-2019.png',
    NULL,
    '.png',
    1,
    '1KpS6jSrH2zrBXavrw-7vCcGzYXMLggdL',
    NULL,
    1,
    '5e342587a66576a38ff1a14a6d922389',
    0
  ),(
    18,
    '04-20-05-59-45-2019.png',
    'uploads/04-20-05-59-45-2019.png',
    NULL,
    '.png',
    1,
    '10XqVXymFw1imuGtL-XusTPkyE78MGxxO',
    NULL,
    1,
    '9adbfa1f46072fcf291ea4712b998209',
    0
  ),(
    19,
    '04-20-06-04-32-2019.jpg',
    'uploads/04-20-06-04-32-2019.jpg',
    NULL,
    '.jpg',
    1,
    '1TAI84abjFx_1eS2QkMCVSqKUkeGgZDzk',
    NULL,
    1,
    'a2b054faac988c2ed057313561446536',
    0
  ),(
    20,
    '04-20-06-06-30-2019.jpg',
    'uploads/04-20-06-06-30-2019.jpg',
    NULL,
    '.jpg',
    1,
    '1w4tfVEgASJ8Y14A8ltn4oM5eD4stxfct',
    NULL,
    1,
    '76e0f2b03256f2df41b049edf8c9df88',
    0
  ),(
    21,
    '04-20-06-09-06-2019.png',
    'uploads/04-20-06-09-06-2019.png',
    NULL,
    '.png',
    1,
    '1TnzPmkFnNjgdh-H5hnq_gPVgIcgO1SGX',
    NULL,
    1,
    'cdf00110307c1664778d251684c10ce8',
    0
  ),(
    22,
    '04-20-05-54-29-2019.png',
    'uploads/04-20-05-54-29-2019.png',
    NULL,
    '.png',
    1,
    '1glRBt4-0C_HophEAC1pew6ZyBH13TCN1',
    NULL,
    1,
    'ccd0b2ba053134d54391fe47aed03ba9',
    0
  ),(
    23,
    '04-19-06-06-47-2019.jpg',
    'uploads/04-19-06-06-47-2019.jpg',
    NULL,
    '.jpg',
    1,
    '10zN_w50fZQU2yt3ZmM7Wy4Bf5IMtoCie',
    NULL,
    1,
    '9b8b15f2e6ca2da09f5b993d93d35c3b',
    0
  ),(
    24,
    '04-19-05-20-00-2019.png',
    'uploads/04-19-05-20-00-2019.png',
    NULL,
    '.png',
    1,
    '1ZlTsNbu1ooWdwXaAZN4yVp0xgRaP8cBS',
    NULL,
    1,
    '01c9587f3923c8b30f3fc1ca13fc8c5a',
    0
  ),(
    25,
    '04-25-07-54-08-2019.png',
    'uploads/04-25-07-54-08-2019.png',
    NULL,
    '.png',
    1,
    '1fga6e-xFuPL9t6Ki4S405nCKMz_MxAqV',
    NULL,
    1,
    '671ab054475670dc2bfe66ce5e3a3c12',
    0
  ),(
    26,
    '55882235_262140041384676_4449226861821558784_n.jpg',
    'uploads/55882235_262140041384676_4449226861821558784_n.jpg',
    NULL,
    '.jpg',
    1,
    '12acNpL6-65sHhhN5_I05tSIe1yZeIICV',
    NULL,
    1,
    '57a4ac6f9d9696cda95c71d3a25678a3',
    0
  ),(
    27,
    '49509434_2307031812669727_8847166844851716096_n.jpg',
    'uploads/49509434_2307031812669727_8847166844851716096_n.jpg',
    NULL,
    '.jpg',
    1,
    '1QPzfXhVjGy5k1wvcmq1SBjHiGfZk8M95',
    NULL,
    1,
    'c659d829c042ddcb1ed79b36fa6cd14e',
    0
  ),(
    28,
    '67102526_2915274415167534_3305999850021060608_n.jpg',
    'uploads/67102526_2915274415167534_3305999850021060608_n.jpg',
    NULL,
    '.jpg',
    1,
    '1uVfvBRyw0UBxsebVJEDsPsyh7548WErT',
    NULL,
    1,
    '41a4467720478860012d45ff7fb69c25',
    0
  ),(
    29,
    '66587876_454551508713195_6701762356159971328_n.jpg',
    'uploads/66587876_454551508713195_6701762356159971328_n.jpg',
    NULL,
    '.jpg',
    1,
    '1AURZApjoKj_uoZekkO28N6tTowy22h3x',
    NULL,
    1,
    '9e80c408269953fd4f3bdbaf072898de',
    0
  ),(
    30,
    'D-3MWjWUwAEhOGt.png',
    'uploads/D-3MWjWUwAEhOGt.png',
    NULL,
    '.png',
    1,
    '1IrbKSaxO3-GnAIoDwzlpkK1_5cB7ucXG',
    NULL,
    1,
    '8d7cee9be061bbc349b469dc5407941a',
    0
  ),(
    31,
    'LITEPOPRI.docx',
    'uploads/LITEPOPRI.docx',
    NULL,
    '.docx',
    1,
    '1KEcaBlnfTur9lkogefsyZY7PetXtv0cN',
    NULL,
    1,
    '32e463820d950437d15e390e7dbc05b1',
    0
  ),(
    32,
    'ONEDECISIONCANCHANGETHEFUTURE.png',
    'uploads/ONEDECISIONCANCHANGETHEFUTURE.png',
    NULL,
    '.png',
    1,
    '1BwfHCDUoGbJ6fI450jY3du2w_vFenwe5',
    NULL,
    1,
    '470b7404ca6f23ba3706c508903d840b',
    0
  ),(
    57,
    '11-16-00-39-07-2019.png',
    'uploads/11-16-00-39-07-2019.png',
    NULL,
    '.png',
    1,
    '1YcV_oZUaY10NX5Ql5iBsUG_pToEoCvhQ',
    NULL,
    1,
    '8bb64f4be1e6ee66d654211933c691f8',
    0
  ),(
    58,
    '11-16-00-39-26-2019.png',
    'uploads/11-16-00-39-26-2019.png',
    NULL,
    '.png',
    1,
    '1bBJ45QZZoNK5pA1wHbg686JPViHtf2Rr',
    NULL,
    1,
    'cb5067426885224443184debc25ebe7b',
    0
  ),(
    59,
    '11-16-00-39-15-2019.png',
    'uploads/11-16-00-39-15-2019.png',
    NULL,
    '.png',
    1,
    '1l-JvT3IJQoRILObNMJl2I4Qpt1LJJm1Q',
    NULL,
    1,
    '698e5a58715806ecd34026eba3bac3d2',
    0
  ),(
    60,
    '15d90584baf6486614edf6a5d4544ecf.jpg',
    'uploads/15d90584baf6486614edf6a5d4544ecf.jpg',
    NULL,
    '.jpg',
    1,
    '1zlFgh8MxWv5hFf8EYqWr6KLjI5gl-NYn',
    NULL,
    1,
    'a7c3ac0a00e0d980c561a582a3ceeb22',
    0
  ),(
    61,
    '6291325026_a9670aeb0b.jpg',
    'uploads/6291325026_a9670aeb0b.jpg',
    NULL,
    '.jpg',
    1,
    '1hLHKIjJ5l0L3jAMTBCPo1TESOX-e-JzE',
    NULL,
    1,
    '2bd6fc61a9584b5e22f295df86b5c0a6',
    0
  ),(
    62,
    '806205.jpg',
    'uploads/806205.jpg',
    NULL,
    '.jpg',
    1,
    '1tiCCrUNeimMI0sndE_rS_7_okzeJLCNX',
    NULL,
    1,
    '5e095c18a832412d15e9233ed5cab574',
    0
  ),(
    63,
    '95a.gif',
    'uploads/95a.gif',
    NULL,
    '.gif',
    1,
    '1KMMs6-IsQgXnBEEva64mdHUYuBpQO8dr',
    NULL,
    1,
    '75d69d69fa3b8a9cd79327c26742608f',
    0
  ),(
    64,
    'Blair_vs_Mizune.png',
    'uploads/Blair_vs_Mizune.png',
    NULL,
    '.png',
    1,
    '1AXKpmFCtUmkmPgAObDk2KQj6X6RRBhtf',
    NULL,
    1,
    '1d447315c817054ab36223cfdd44065e',
    0
  ),(
    65,
    'MHGU-Bloodbath_Diablos_Render_002.png',
    'uploads/MHGU-Bloodbath_Diablos_Render_002.png',
    NULL,
    '.png',
    1,
    '1g1Q6UGzS6yBVbIG7GinQzu3fdTXrYDrV',
    NULL,
    1,
    '73a9f48c608508c1ffab76cfc8a0c422',
    0
  ),(
    66,
    'hqdefault.jpg',
    'uploads/hqdefault.jpg',
    NULL,
    '.jpg',
    1,
    '1GZRcdIP1Tizp4jQo1gIxjd7HbfRDDrCf',
    NULL,
    1,
    'bb4146628dd94988ed48508be0d51ab2',
    0
  ),(
    67,
    'maxresdefault.jpg',
    'uploads/maxresdefault.jpg',
    NULL,
    '.jpg',
    1,
    '1ZtwU3i99L8apQrc3-Nh1YTmc43O5yj9g',
    NULL,
    1,
    '7d8f90c51ac70a392b398417cdff7d33',
    0
  ),(
    68,
    'Death_Note_In_A_Nutshell.jpg',
    'uploads/Death_Note_In_A_Nutshell.jpg',
    NULL,
    '.jpg',
    1,
    '1odZmUl0CEfQL477W_9uXKUgZuWkdSciV',
    NULL,
    1,
    '768ac2260234fc2f6e68f1c20ae394ff',
    0
  ),(
    69,
    'img-soul-eater-halloween-kitty-717.jpg',
    'uploads/img-soul-eater-halloween-kitty-717.jpg',
    NULL,
    '.jpg',
    1,
    '1xhOyUUf9JwofW2I3SEEnvAR5WX1dkWEw',
    NULL,
    1,
    '512a81b84bdbbba975de0892aa4a0182',
    0
  ),(
    70,
    'images.jpg',
    'uploads/images.jpg',
    NULL,
    '.jpg',
    1,
    '1kKemkkVgAwq7ZLCe_7eU2sYlvrTKf2sy',
    NULL,
    1,
    '68a4483c89a26464f4a6e709efcf4cf9',
    0
  ),(
    71,
    '11-02-18-27-33-2019.png',
    'uploads/11-02-18-27-33-2019.png',
    'No Description Given.',
    '.png',
    1,
    '1HfPjBNr7ftbeknx0VzklUsIHEIld_05_',
    57,
    2,
    '832109366053eb08738e51bcc804221c',
    0
  ),(
    72,
    '11-01-00-09-25-2019.png',
    'uploads/11-01-00-09-25-2019.png',
    'No Description Given.',
    '.png',
    1,
    '15PnZBlw0tmUF58_10-wNwz6Dolua-5UK',
    58,
    2,
    '5c63c1dfff12371c841dfae955c2344a',
    0
  ),(
    73,
    '11-01-00-09-25-20193.png',
    'uploads/11-01-00-09-25-20193.png',
    'No Description Given.',
    '.png',
    0,
    '0',
    72,
    3,
    '695a02ef00271b2190c223b73e4ce57d',
    0
  ),(
    74,
    'images2.jpg',
    'uploads/images2.jpg',
    'No Description Given.',
    '.jpg',
    0,
    '0',
    70,
    2,
    '1e153227a3c7e6c9294dffea40edbd6d',
    0
  ),(
    75,
    '11-02-19-50-47-2019.png',
    'uploads/11-02-19-50-47-2019.png',
    'No Description Given.',
    '.png',
    1,
    '1kHpMDPLMVmcYHQN0QFOdxk5Hs1DjXYvq',
    59,
    2,
    '76229ff5c382e18c6d29e534489fc538',
    0
  ),(
    76,
    'hqdefault2.jpg',
    'uploads/hqdefault2.jpg',
    'No Description Given.',
    '.jpg',
    0,
    '0',
    66,
    2,
    'e481d044a27af6bfc82eea263f71a54d',
    0
  ),(
    77,
    'images2.jpg',
    'uploads/images2.jpg',
    'No Description Given.',
    '.jpg',
    0,
    '0',
    70,
    2,
    'b349c9f1480cddbd11aa6bdaac8383e8',
    0
  ),(
    78,
    '12-04-19-43-41-2018.jpg',
    'uploads/12-04-19-43-41-2018.jpg',
    NULL,
    '.jpg',
    1,
    '1jcPTfY60a3QD8U7Mj_czf8KXsrk_N9kA',
    NULL,
    1,
    '8cfb182b41ba94ee48c1de5d14f30c07',
    0
  ),(
    79,
    '-you-are-my-sky-beautiful-cloud-9303812.png',
    'uploads/-you-are-my-sky-beautiful-cloud-9303812.png',
    NULL,
    '.png',
    1,
    '1vU5iHbAFnUsTrLbZczdIdiC-vCCngvth',
    NULL,
    1,
    '26b30d6a98275eceff62423322630018',
    0
  ),(
    80,
    '12-01-19-46-35-2018.png',
    'uploads/12-01-19-46-35-2018.png',
    'No Description Given.',
    '.png',
    1,
    '1DQiCKxffs_L-o7ExNEXxu86_26Z4r9sd',
    79,
    2,
    'b3c8ebd0748931896c5046944f31bfcc',
    0
  ),(
    81,
    '12-01-19-46-35-2018v3.png',
    'uploads/12-01-19-46-35-20183.png',
    'No Description Given.',
    '.png',
    0,
    '0',
    80,
    3,
    '8c05b3d5292f50d586836ce969c611bb',
    0
  ),(
    82,
    '01.jpg',
    'uploads/01.jpg',
    'No Description Given.',
    '.jpg',
    1,
    '11Js3_EUJIIUMZ8tf_8hDuuDjq5I78dJ3',
    81,
    4,
    '2ecd9ba50f50bc114563ecf55e2106d0',
    0
  ),(
    83,
    '01v5.jpg',
    'uploads/015.jpg',
    'No Description Given.',
    '.jpg',
    0,
    '0',
    82,
    5,
    '6e4de19ebf6619e4be20dcfe0fa74d1f',
    0
  ),(
    84,
    '11-01-14-51-56-2019.png',
    'uploads/11-01-14-51-56-2019.png',
    'No Description Given.',
    '.png',
    1,
    '1mOjSeyQbXePTinjDzbiRTUD340X-n7l1',
    83,
    6,
    '39d24c530e5225cc7fe7a52b3bdd5bcc',
    0
  ),(
    85,
    '11-01-14-51-56-2019v7.png',
    'uploads/11-01-14-51-56-2019v7.png',
    'No Description Given.',
    '.png',
    1,
    '1V9Hktwl309U4jNcQlveXfdrhvrbWSs-q',
    84,
    7,
    '0524f1c9d5f1c04d27b16080561198c9',
    0
  ),(
    86,
    'DDUtiPxUIAAJsB7.jpg',
    'uploads/DDUtiPxUIAAJsB7.jpg',
    NULL,
    '.jpg',
    1,
    '1dOZFZoshT8XCSlIhCQxdfXGV2h2oRQMs',
    NULL,
    1,
    'a500c70189aa7f215331c66f92f40c84',
    0
  ),(
    87,
    '20638106_1511402742231407_7362186879422136344_n.jpg',
    'uploads/20638106_1511402742231407_7362186879422136344_n.jpg',
    NULL,
    '.jpg',
    1,
    '13GKKo9scIdVahLa_KPZ4YD2il4_tJJSC',
    NULL,
    1,
    '786fd58022d7076b676cfdc633c77d00',
    0
  ),(
    88,
    'CODESFORBRIANWITHWHERETOPUTEM.txt',
    'uploads/CODESFORBRIANWITHWHERETOPUTEM.txt',
    NULL,
    '.txt',
    1,
    '1wf72vwdrzDe4aMz3TQ3DtbJzv9MYM-_A',
    NULL,
    1,
    '069bf03d8f1dbddc6e97714df1c37ad1',
    0
  ),(
    89,
    'CODESFORBRIANWITHWHERETOPUTEM.txt',
    'uploads/CODESFORBRIANWITHWHERETOPUTEM.txt',
    NULL,
    '.txt',
    1,
    '1wf72vwdrzDe4aMz3TQ3DtbJzv9MYM-_A',
    NULL,
    1,
    '069bf03d8f1dbddc6e97714df1c37ad1',
    0
  ),(
    90,
    'CreateSource.ejs',
    'uploads/CreateSource.ejs',
    NULL,
    '.ejs',
    1,
    '1lnaSHN_MW1fzWqaexs9r8szlP4ElnDhw',
    NULL,
    1,
    '19d6bd617a36b52b8ee759140a129303',
    0
  ),(
    91,
    'ONEDECISIONCANCHANGETHEFUTURE.png',
    'uploads/ONEDECISIONCANCHANGETHEFUTURE.png',
    NULL,
    '.png',
    1,
    '1BwfHCDUoGbJ6fI450jY3du2w_vFenwe5',
    NULL,
    1,
    '470b7404ca6f23ba3706c508903d840b',
    0
  ),(
    92,
    'ResidentEvil2RemakeWallpaper.jpg',
    'uploads/ResidentEvil2RemakeWallpaper.jpg',
    NULL,
    '.jpg',
    1,
    '14--hGk859vKnJSeq2n-76WsXxztqvcbz',
    NULL,
    1,
    'df503da3901a1432817ea155e2247742',
    0
  ),(
    93,
    'Resident-Evil-2-Remake.jpg',
    'uploads/Resident-Evil-2-Remake.jpg',
    NULL,
    '.jpg',
    1,
    '1mynX7xsw20kQ5U3qWKesS_C3gvERpxlM',
    NULL,
    1,
    '43e42436f5a45600cddc57ea02577287',
    0
  ),(
    94,
    'ONEDECISIONCANCHANGETHEFUTURE.png',
    'uploads/ONEDECISIONCANCHANGETHEFUTURE.png',
    NULL,
    '.png',
    1,
    '1BwfHCDUoGbJ6fI450jY3du2w_vFenwe5',
    NULL,
    1,
    '470b7404ca6f23ba3706c508903d840b',
    0
  ),(
    95,
    'DDUtiPxUIAAJsB7.html',
    'uploads/DDUtiPxUIAAJsB7.html',
    NULL,
    '.html',
    1,
    '1i6NitzbMhIqZzrQsaZcPnTFM3LYTv18o',
    NULL,
    1,
    'f57c7acc2cf08f78f89e6bbaf260ebe2',
    0
  ),(
    96,
    'EchoNov19.sql',
    'uploads/EchoNov19.sql',
    NULL,
    '.sql',
    1,
    '1yorXBDz6KHmgc0bDGTbjXv1hquaSGEVz',
    NULL,
    1,
    'eb61dbd4e129f9a910e93126da334ad2',
    0
  );

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

INSERT INTO
  `group` (`Group_ID`, `Group_Name`, `Area_ID`)
VALUES
  (0, 'No Group Assigned', 0),(1, 'Analysis', 1),(2, 'Evaluation', 1),(3, 'Analysis', 2),(4, 'Evaluation', 2),(5, 'Analysis', 3),(6, 'Evaluation', 3),(7, 'Analysis', 4),(8, 'Evaluation', 4),(9, 'Analysis', 5),(10, 'Evaluation', 5),(11, 'Analysis', 6),(12, 'Evaluation', 6),(13, 'Analysis', 7),(14, 'Evaluation', 7),(15, 'Analysis', 8),(16, 'Evaluation', 8),(17, 'Analysis', 9),(18, 'Evaluation', 9),(19, 'Test Area', 1),(20, 'TESTING', 2),(21, 'RESEARCH GROUP', 1);

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: groupdetails
# ------------------------------------------------------------

INSERT INTO
  `groupdetails` (
    `Groupdetails_ID`,
    `Groupdetails_UserID`,
    `Groupdetails_Position`
  )
VALUES
  (1, 35, 'Member'),(1, 47, 'Member'),(1, 51, 'Member'),(1, 57, 'Member'),(1, 56, 'Member'),(1, 46, 'Member'),(1, 52, 'Member'),(1, 49, 'Member'),(1, 53, 'Member'),(1, 48, 'Member'),(1, 73, 'Member'),(1, 54, 'Member'),(1, 50, 'Member'),(1, 55, 'Member'),(1, 58, 'Member'),(1, 59, 'Member'),(1, 69, 'Member'),(1, 63, 'Member'),(1, 68, 'Member'),(1, 62, 'Member'),(1, 61, 'Member'),(1, 67, 'Member'),(1, 60, 'Member'),(1, 74, 'Member'),(1, 71, 'Member'),(1, 72, 'Member'),(1, 66, 'Member'),(1, 65, 'Member'),(1, 70, 'Member'),(1, 75, 'Member'),(1, 77, 'Member'),(1, 64, 'Member'),(1, 76, 'Member'),(1, 81, 'Member'),(1, 79, 'Member'),(1, 80, 'Member'),(1, 78, 'Member'),(2, 82, 'Leader'),(2, 83, 'Member'),(2, 84, 'Member'),(19, 85, 'Member'),(19, 87, 'Member'),(19, 86, 'Member'),(19, 88, 'Member'),(19, 89, 'Member'),(21, 91, 'Member'),(21, 93, 'Member'),(21, 92, 'Member'),(3, 94, 'Leader'),(3, 90, 'Member'),(5, 98, 'Member'),(5, 99, 'Member'),(5, 97, 'Member'),(5, 96, 'Member'),(5, 95, 'Member'),(7, 100, 'Member'),(7, 103, 'Member'),(7, 104, 'Member'),(7, 102, 'Member'),(7, 101, 'Member'),(18, 120, 'Member'),(18, 121, 'Member'),(20, 122, 'Leader'),(20, 123, 'Member');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: measurement
# ------------------------------------------------------------

INSERT INTO
  `measurement` (
    `measurement_ID`,
    `QualityTarget`,
    `Procedures`,
    `GroupAssigned`,
    `metric_ID`,
    `measurement_Name`,
    `measurement_Description`,
    `Deadline`,
    `cycle_ID`,
    `priority_Level`
  )
VALUES
  (1, NULL, NULL, 21, NULL, 'adsfsa', 'fagsasg', NULL, 2, 5),(3, NULL, NULL, NULL, NULL, '123', '123', NULL, 2, 4),(4, NULL, NULL, NULL, NULL, '123', '123', NULL, 3, 1),(
    5,
    NULL,
    NULL,
    NULL,
    NULL,
    'adsfsa',
    'fagsasg',
    NULL,
    3,
    1
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: measurement_audit
# ------------------------------------------------------------

INSERT INTO
  `measurement_audit` (
    `measurement_auditID`,
    `measurement_ID`,
    `QualityTarget`,
    `Procedures`,
    `GroupAssigned`,
    `metric_ID`,
    `measurement_Name`,
    `measurement_Description`,
    `Deadline`,
    `cycle_ID`,
    `audit_date`,
    `priority_Level`
  )
VALUES
  (
    1,
    1,
    NULL,
    NULL,
    20,
    NULL,
    'testing',
    'kekchanged',
    NULL,
    1,
    '2019-11-19',
    1
  ),(
    2,
    1,
    NULL,
    NULL,
    20,
    NULL,
    'testing',
    'kekchanged',
    NULL,
    1,
    '2019-11-23',
    2
  ),(
    3,
    1,
    NULL,
    NULL,
    20,
    NULL,
    'testing',
    'kekchanged',
    NULL,
    2,
    '2019-11-23',
    3
  ),(
    4,
    1,
    NULL,
    NULL,
    20,
    NULL,
    'testing',
    'kekchanged',
    NULL,
    1,
    '2019-11-25',
    1
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: measurements_activities
# ------------------------------------------------------------

INSERT INTO
  `measurements_activities` (`measurement_ID`, `activity_ID`)
VALUES
  (1, 1),(1, 2),(1, 3),(3, 3),(4, 3);

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: measurements_activities_audit
# ------------------------------------------------------------

INSERT INTO
  `measurements_activities_audit` (
    `measurement_activities_audit_ID`,
    `measurements_auditID`,
    `measurement_ID`,
    `activity_ID`
  )
VALUES
  (1, 1, 1, 1),(2, 1, 1, 2),(3, 2, 1, 1),(4, 2, 1, 2),(5, 3, 1, 1),(6, 3, 1, 2),(7, 4, 1, 2),(8, 4, 1, 1);

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: measurements_targets
# ------------------------------------------------------------

INSERT INTO
  `measurements_targets` (
    `measurementID`,
    `target`,
    `progress`,
    `target_ID`,
    `target_Type`,
    `target_Desc`
  )
VALUES
  (1, 12, 12, 1, 0, 'asddasdasdad'),(1, 30, 41, 2, 0, 'qweqwfqwfqfqgqwg'),(
    3,
    100,
    NULL,
    3,
    1,
    'COMPUTERS CONTAIN ANDROID STUDIO IN GOKONGWEI'
  ),(
    3,
    85,
    NULL,
    4,
    0,
    'CS COURSES THAT CONTAIN NEW GE SUBJECTS OF PROGRAMMING'
  ),(4, 12, NULL, 5, 0, 'asd'),(5, 20, NULL, 6, 1, 'qsfq');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: measurements_targets_audit
# ------------------------------------------------------------

INSERT INTO
  `measurements_targets_audit` (
    `measurements_targets_auditID`,
    `measurements_auditID`,
    `measurementID`,
    `target`,
    `progress`,
    `target_ID`,
    `target_Type`,
    `target_Desc`
  )
VALUES
  (1, 1, 1, 12, 12, 1, NULL, NULL),(2, 1, 1, 18, 14, 2, NULL, NULL),(3, 2, 1, 57, 56, 1, NULL, NULL),(4, 2, 1, 13, 78, 2, NULL, NULL),(5, 3, 1, 14, 34, 1, NULL, NULL),(6, 3, 1, 15, 23, 2, NULL, NULL),(7, 4, 1, 12, 12, 1, 0, 'asddasdasdad'),(8, 4, 1, 30, 41, 2, 0, 'qweqwfqwfqfqgqwg');

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

INSERT INTO
  `activity_evidences` (`activityID`, `documentID`, `pendingID`)
VALUES
  (1, 3, 1),(1, 1, 1),(1, 5, 1),(1, 4, 1),(1, 2, 1),(1, 94, 1),(1, 95, 1),(1, 96, 1),(1, 1, 5),(1, 10, 5);

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: metric
# ------------------------------------------------------------

INSERT INTO
  `metric` (
    `metric_ID`,
    `metric_Name`,
    `metric_Desc`,
    `priority_Level`,
    `date_insert`,
    `group_ID`,
    `source_ID`,
    `cycle_ID`,
    `duration`,
    `cycle_Status`,
    `source_Type`,
    `cycle_Created`
  )
VALUES
  (
    1,
    'To Provide State of the art facilities for learning and research',
    'oisjfiosfd',
    NULL,
    NULL,
    0,
    1,
    0,
    '2026',
    'Active',
    'Quality Assurance Goals',
    1
  ),(
    2,
    'testing',
    'testing',
    NULL,
    NULL,
    0,
    1,
    0,
    '2025',
    'Active',
    'University Goals',
    1
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: notifications
# ------------------------------------------------------------

INSERT INTO
  `notifications` (
    `Notifications_ID`,
    `message`,
    `sender`,
    `receiver`,
    `group_id`,
    `range`,
    `admin`,
    `sysadmin`,
    `triggerdate`,
    `isactivity`
  )
VALUES
  (1, 'test', 46, 46, 1, 2, 0, 0, NULL, 0),(2, 'test', 46, 46, 1, 2, 0, 0, NULL, 0),(3, 'test', 46, 46, 1, 2, 0, 0, NULL, 0),(4, 'test', 46, 46, 1, 2, 0, 0, NULL, 0),(5, 'test', 46, 46, 1, 2, 0, 0, NULL, 0),(6, 'test', 46, 46, 1, 2, 0, 0, NULL, 0),(7, 'test', 46, 46, 1, 2, 0, 0, NULL, 0),(8, 'test', 46, 46, 1, 2, 0, 0, NULL, 0),(9, 'test', 46, 46, 1, 2, 0, 0, NULL, 0),(10, 'test', 46, 46, 1, 2, 0, 0, NULL, 0),(11, 'test', 46, 46, 1, 2, 0, 0, NULL, 0),(12, 'test', 46, 46, 1, 2, 0, 0, NULL, 0),(13, 'test', 46, 46, 1, 2, 0, 0, NULL, 0),(14, 'test', 46, 46, 1, 2, 0, 0, NULL, 0),(15, 'test', 46, 47, 1, 2, 0, 0, NULL, 0),(16, 'test', 46, 47, 1, 2, 0, 0, NULL, 0),(17, 'test', 46, 47, 1, 3, 0, 0, NULL, 0),(18, 'test', 46, 47, 1, 3, 0, 0, NULL, 0),(19, 'test', 46, 47, 1, 3, 0, 0, NULL, 0),(20, 'test', 46, 47, 1, 3, 0, 0, NULL, 0),(21, 'test', 46, 47, 1, 3, 0, 0, NULL, 0),(22, 'test', 46, 47, 1, 3, 0, 0, NULL, 0),(23, 'test', 46, 47, 1, 3, 1, 1, NULL, 0),(24, 'test', 46, 47, 1, 3, 1, 1, NULL, 0),(25, 'test', 46, 47, 1, 3, 1, 1, NULL, 0),(26, 'test', 46, 47, 1, 4, 1, 1, NULL, 0),(27, 'test', 46, 47, 1, 4, 1, 1, NULL, 0),(28, 'test', 46, 47, 1, 4, 1, 1, NULL, 0),(29, 'test', 46, 47, 1, 4, 1, 1, NULL, 0),(30, 'test', 46, 47, 1, 4, 1, 1, NULL, 0),(31, 'test', 46, 47, 1, 4, 1, 1, NULL, 0),(32, 'test', 46, 47, 1, 4, 1, 1, NULL, 0),(33, 'test', 46, 47, 1, 4, 1, 1, NULL, 0),(34, 'test', 46, 47, 1, 4, 1, 1, NULL, 0),(35, 'test', 46, 47, 1, 4, 1, 1, NULL, 0),(36, 'test', 46, 47, 1, 4, 1, 1, NULL, 0),(37, 'test', 46, 47, 1, 4, 1, 1, NULL, 0),(38, 'test', 46, 47, 1, 4, 1, 1, NULL, 0),(39, 'test', 46, 47, 1, 4, 1, 1, '2020-01-15', 0),(40, 'test', 46, 47, 1, 4, 1, 1, '2020-01-15', 0),(41, 'test', 46, 47, 1, 4, 1, 1, '2020-01-15', 0),(42, 'test', 46, 47, 1, 4, 1, 1, '2020-01-15', 0),(43, 'test', 46, 47, 1, 4, 1, 1, '2020-01-15', 0),(44, 'test', 46, 47, 1, 4, 1, 1, '2020-01-15', 0),(45, 'test', 46, 47, 1, 4, 1, 1, '2020-01-15', 0),(46, 'test', 46, 47, 1, 4, 1, 1, '2020-01-15', 0),(47, 'test', 46, 47, 1, 4, 1, 1, '2020-01-15', 0),(48, 'test', 46, 47, 1, 4, 1, 1, '2020-01-15', 0),(49, 'test', 46, 47, 1, 4, 1, 1, '2020-01-15', 0),(50, 'test', 46, 47, 1, 4, 1, 1, '2020-01-15', 0),(51, 'test', 46, 47, 1, 4, 1, 1, '2020-01-15', 0),(
    52,
    'User Look Forme has been created',
    46,
    125,
    1,
    4,
    1,
    1,
    '2020-02-05',
    0
  ),(
    53,
    'User 12412 6643524 has been created',
    46,
    126,
    1,
    4,
    1,
    1,
    '2020-02-05',
    0
  ),(
    54,
    'User 5423 4623456 has been created',
    46,
    127,
    1,
    4,
    1,
    1,
    '2020-02-05',
    0
  ),(
    55,
    'User 12412545 634734 has been created',
    46,
    128,
    1,
    1,
    1,
    1,
    '2020-02-05',
    0
  ),(
    56,
    'User 3251 2`14`123`12 has been created',
    46,
    129,
    1,
    1,
    1,
    1,
    '2020-02-05',
    0
  ),(57, 'test', 46, 47, 1, 4, 1, 1, '2020-02-09', 0),(58, 'test', 46, 47, 1, 4, 1, 1, '2020-02-09', 1),(
    59,
    'User 123 52346 has been created',
    46,
    130,
    1,
    1,
    1,
    1,
    '2020-03-09',
    0
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: notifications_read
# ------------------------------------------------------------

INSERT INTO
  `notifications_read` (`Notifications_ID`, `Recipient_ID`, `notif_read`)
VALUES
  (56, 129, 0),(57, 35, 0),(57, 47, 0),(57, 46, 1),(57, 74, 0),(57, 48, 0),(57, 49, 0),(57, 51, 0),(57, 50, 0),(57, 52, 0),(57, 56, 0),(57, 55, 0),(57, 63, 0),(57, 54, 0),(57, 73, 0),(57, 65, 0),(57, 77, 0),(57, 76, 0),(57, 70, 0),(57, 61, 0),(57, 62, 0),(57, 69, 0),(57, 78, 0),(57, 58, 0),(57, 64, 0),(57, 57, 0),(57, 80, 0),(57, 68, 0),(57, 66, 0),(57, 53, 0),(57, 79, 0),(57, 60, 0),(57, 71, 0),(57, 67, 0),(57, 59, 0),(57, 81, 0),(57, 72, 0),(57, 75, 0),(58, 73, 0),(58, 74, 0),(58, 35, 0),(58, 46, 0),(58, 47, 0),(58, 48, 0),(58, 49, 0),(58, 50, 0),(58, 51, 0),(58, 57, 0),(58, 71, 0),(58, 56, 0),(58, 67, 0),(58, 60, 0),(58, 64, 0),(58, 62, 0),(58, 58, 0),(58, 75, 0),(58, 55, 0),(58, 54, 0),(58, 78, 0),(58, 76, 0),(58, 63, 0),(58, 65, 0),(58, 81, 0),(58, 59, 0),(58, 72, 0),(58, 77, 0),(58, 66, 0),(58, 61, 0),(58, 52, 0),(58, 68, 0),(58, 79, 0),(58, 53, 0),(58, 70, 0),(58, 69, 0),(58, 80, 0),(59, 130, 0);

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: pending_activities
# ------------------------------------------------------------

INSERT INTO
  `pending_activities` (
    `pending_ID`,
    `activity_ID`,
    `activity_name`,
    `target`,
    `code`,
    `description`,
    `measurement_ID`,
    `current_Score`,
    `status`,
    `suggested_Score`,
    `dateupdated`,
    `active`,
    `user_ID`,
    `comment`,
    `cycle_ID`
  )
VALUES
  (
    1,
    1,
    'Revision of syllabi',
    NULL,
    0,
    'Napasa ko yung hotdog',
    NULL,
    NULL,
    1,
    90,
    '2019-11-19',
    1,
    123,
    'Ok na yan',
    1
  ),(
    2,
    1,
    'Revision of syllabi',
    NULL,
    0,
    'qwe',
    NULL,
    NULL,
    0,
    0,
    '2019-12-03',
    1,
    35,
    NULL,
    2
  ),(
    3,
    1,
    'Revision of syllabi',
    NULL,
    0,
    '123',
    NULL,
    NULL,
    0,
    0,
    '2019-12-03',
    1,
    35,
    NULL,
    2
  ),(
    4,
    1,
    'Revision of syllabi',
    NULL,
    0,
    'testing working?',
    NULL,
    NULL,
    0,
    0,
    '2019-12-03',
    1,
    35,
    NULL,
    2
  ),(
    5,
    1,
    'Revision of syllabi',
    NULL,
    0,
    'asasvasvasagas',
    NULL,
    NULL,
    0,
    0,
    '2019-12-03',
    1,
    35,
    NULL,
    2
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: pending_activities_audit
# ------------------------------------------------------------

INSERT INTO
  `pending_activities_audit` (
    `pending_activities_auditID`,
    `measurement_activities_auditID`,
    `measurement_auditID`,
    `pending_ID`,
    `activity_ID`,
    `activity_name`,
    `target`,
    `code`,
    `description`,
    `measurement_ID`,
    `current_Score`,
    `status`,
    `suggested_Score`,
    `dateupdated`,
    `active`,
    `user_ID`,
    `comment`,
    `cycle_ID`
  )
VALUES
  (
    1,
    1,
    1,
    1,
    1,
    'Revision of syllabi',
    NULL,
    0,
    'Napasa ko yung hotdog',
    NULL,
    NULL,
    1,
    90,
    '2019-11-18',
    1,
    123,
    'Ok na yan',
    1
  ),(
    2,
    3,
    2,
    1,
    1,
    'Revision of syllabi',
    NULL,
    0,
    'Napasa ko yung hotdog',
    NULL,
    NULL,
    1,
    90,
    '2019-11-18',
    1,
    123,
    'Ok na yan',
    1
  ),(
    3,
    8,
    4,
    1,
    1,
    'Revision of syllabi',
    NULL,
    0,
    'Napasa ko yung hotdog',
    NULL,
    NULL,
    1,
    90,
    '2019-11-18',
    1,
    123,
    'Ok na yan',
    1
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: pending_outputs
# ------------------------------------------------------------

INSERT INTO
  `pending_outputs` (`activityID`, `outputID`, `pendingID`)
VALUES
  (1, 1, 5),(1, 3, 5);

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
