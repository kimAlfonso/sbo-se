/*
SQLyog Ultimate v13.1.1 (64 bit)
MySQL - 10.1.37-MariaDB : Database - sbo
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`sbo` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `sbo`;

/*Table structure for table `attendance` */

DROP TABLE IF EXISTS `attendance`;

CREATE TABLE `attendance` (
  `attendance_id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `type` varchar(45) DEFAULT NULL,
  `start` time DEFAULT NULL,
  `end` time DEFAULT NULL,
  PRIMARY KEY (`attendance_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `attendance` */

insert  into `attendance`(`attendance_id`,`date`,`type`,`start`,`end`) values 
(1,'2019-12-04','morning',NULL,NULL),
(2,'2019-12-05','morning',NULL,NULL),
(3,'2019-12-18','afternoon',NULL,NULL),
(4,'2019-12-17','morning',NULL,NULL),
(5,'2019-12-09','morning',NULL,NULL);

/*Table structure for table `emergency` */

DROP TABLE IF EXISTS `emergency`;

CREATE TABLE `emergency` (
  `em_id` int(11) NOT NULL AUTO_INCREMENT,
  `last_name` varchar(45) DEFAULT NULL,
  `first_name` varchar(45) DEFAULT NULL,
  `middle_name` varchar(45) DEFAULT NULL,
  `contact_num` varchar(45) DEFAULT NULL,
  `address` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`em_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `emergency` */

insert  into `emergency`(`em_id`,`last_name`,`first_name`,`middle_name`,`contact_num`,`address`) values 
(1,'Rosario','Delia','Alvar','09293460538','400 Cantingan, Quinavite, Bauang, La Union'),
(2,'Rosario','Daniel','Salomon','09983136591','400 Cantingan, Quinavite, Bauang, La Union'),
(3,'Francisco','Firmo Rico','','09277054399','San Fernando City');

/*Table structure for table `events` */

DROP TABLE IF EXISTS `events`;

CREATE TABLE `events` (
  `event_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `create_date` date DEFAULT NULL,
  `description` varchar(5000) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  PRIMARY KEY (`event_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `events` */

insert  into `events`(`event_id`,`title`,`create_date`,`description`,`start_date`,`end_date`) values 
(2,'CIT Night','2019-11-24','Lalatina oohlala','2019-01-01','2019-01-02'),
(3,'CIT Night','2019-11-24','NULL','2019-01-01','2019-01-02'),
(4,'CIT Night','2019-11-24','Lalatina oohlala','2019-01-01','2019-01-02');

/*Table structure for table `section` */

DROP TABLE IF EXISTS `section`;

CREATE TABLE `section` (
  `section_id` int(11) NOT NULL AUTO_INCREMENT,
  `year` tinyint(4) DEFAULT NULL,
  `section` tinytext,
  `sy` tinytext,
  `term` tinytext,
  PRIMARY KEY (`section_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `section` */

insert  into `section`(`section_id`,`year`,`section`,`sy`,`term`) values 
(1,3,'A','2019-2020','First Semester');

/*Table structure for table `student` */

DROP TABLE IF EXISTS `student`;

CREATE TABLE `student` (
  `student_id` varchar(10) NOT NULL,
  `last_name` varchar(45) DEFAULT NULL,
  `first_name` varchar(45) DEFAULT NULL,
  `middle_name` varchar(45) DEFAULT NULL,
  `address` varchar(45) DEFAULT NULL,
  `contact_num` varchar(45) DEFAULT NULL,
  `em_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`student_id`),
  KEY `st_em_id_fk_idx` (`em_id`),
  CONSTRAINT `st_em_id_fk` FOREIGN KEY (`em_id`) REFERENCES `emergency` (`em_id`) ON DELETE SET NULL ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `student` */

insert  into `student`(`student_id`,`last_name`,`first_name`,`middle_name`,`address`,`contact_num`,`em_id`) values 
('131-4578-1','Khan','Gengis','Mongol','Mongol','9081239874',1),
('151-1547-4','de la Cruz','Juan','Garcia','San Fernando, La Union','09123941234',1),
('171-0104-2','Alfonso','Kimberly','Bautista','Nalvo Sur, Luna, La Union','09498876254',1),
('171-0115-2','Francisco','Rica','Oafericua','San Fernando City','09121117780',1),
('171-0135-2','dabatos','christian','balahay','san francisco','09957695761',1),
('171-0192-2','Rosario','Mivien Anne','Alvar','400 Cantingan, Quinavite, Bauang, La Union','09219698035',1),
('171-0266-2','Renzal','Daniel Joshua','Mosuela','Maria Cristina East, Bangar, La Union','09498309428',1);

/*Table structure for table `student_attendance` */

DROP TABLE IF EXISTS `student_attendance`;

CREATE TABLE `student_attendance` (
  `att_id` int(11) NOT NULL,
  `student_id` varchar(10) NOT NULL,
  `event_id` int(11) NOT NULL,
  `sign_in` time DEFAULT NULL,
  `sign_out` time DEFAULT NULL,
  PRIMARY KEY (`att_id`,`student_id`,`event_id`),
  KEY `sa_student_fk_idx` (`student_id`),
  KEY `sa_attendance_fk_idx` (`att_id`),
  KEY `sa_event_fk_idx` (`event_id`),
  CONSTRAINT `sa_attendance_fk` FOREIGN KEY (`att_id`) REFERENCES `attendance` (`attendance_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `sa_event_fk` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `sa_student_fk` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `student_attendance` */

insert  into `student_attendance`(`att_id`,`student_id`,`event_id`,`sign_in`,`sign_out`) values 
(1,'171-0192-2',2,'07:30:00','11:30:00');

/*Table structure for table `student_section` */

DROP TABLE IF EXISTS `student_section`;

CREATE TABLE `student_section` (
  `student_id` varchar(10) NOT NULL,
  `section_id` int(11) NOT NULL,
  PRIMARY KEY (`student_id`,`section_id`),
  KEY `ss_sect_idx` (`section_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `student_section` */

insert  into `student_section`(`student_id`,`section_id`) values 
('171-0104-2',1),
('171-0192-2',1),
('171-0266-2',1);

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `username` varchar(45) NOT NULL,
  `password` text,
  `stud_id` varchar(10) NOT NULL,
  `type_id` int(11) NOT NULL,
  PRIMARY KEY (`username`,`stud_id`,`type_id`),
  KEY `stud_id_idx` (`stud_id`),
  KEY `type_id_idx` (`type_id`),
  CONSTRAINT `stud_id` FOREIGN KEY (`stud_id`) REFERENCES `student` (`student_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `type_id` FOREIGN KEY (`type_id`) REFERENCES `user_type` (`type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `user` */

insert  into `user`(`username`,`password`,`stud_id`,`type_id`) values 
('123','$2y$10$spBPvTs66eo85v2N3sPbme12Sll/UQtJlaQMtYYBnu8dmA61BLcRy','171-0192-2',1),
('admin','$2y$10$dJkMcN6Z94Rmy5ZgAjHXb.l0ARZLLWzaLkcinWdFSXfSdDh5sRhmq','171-0192-2',3),
('kimmy','$2y$10$9ZBTyaZN/pJS2K6s7AzfgOCRq0GN4fxlpgu8AlVaOp7hXbUIVf6ca','171-0104-2',3),
('root','$2y$10$gU7bxCuekpEc74Rkkh0qPuPsU3u7s/cfAU9Sne8ZOo0381G3FOwf.','171-0192-2',1),
('rumple','$2y$10$eI1Hy.S8Kr8Nxk8qNv/nKukO0iIkll/XXhwDfBpRMdOHDZPVTBIA.','171-0135-2',1);

/*Table structure for table `user_type` */

DROP TABLE IF EXISTS `user_type`;

CREATE TABLE `user_type` (
  `type_id` int(11) NOT NULL,
  `type_desc` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `user_type` */

insert  into `user_type`(`type_id`,`type_desc`) values 
(1,'root'),
(2,'officer'),
(3,'student');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
