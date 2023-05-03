-- MariaDB dump 10.19  Distrib 10.11.2-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: default
-- ------------------------------------------------------
-- Server version	10.11.2-MariaDB-1:10.11.2+maria~ubu2204

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `administrators`
--

DROP TABLE IF EXISTS `administrators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `administrators` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cpf` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `formacao_profissional` varchar(255) DEFAULT NULL,
  `documents_0_name` varchar(255) DEFAULT NULL,
  `documents_0_description` varchar(255) DEFAULT NULL,
  `documents_0_number` varchar(255) DEFAULT NULL,
  `documents_1_name` varchar(255) DEFAULT NULL,
  `documents_1_description` varchar(255) DEFAULT NULL,
  `documents_1_number` varchar(255) DEFAULT NULL,
  `documents_2_name` varchar(255) DEFAULT NULL,
  `documents_2_description` varchar(255) DEFAULT NULL,
  `documents_2_number` varchar(255) DEFAULT NULL,
  `documents_3_name` varchar(255) DEFAULT NULL,
  `documents_3_description` varchar(255) DEFAULT NULL,
  `documents_3_number` varchar(255) DEFAULT NULL,
  `documents_4_name` varchar(255) DEFAULT NULL,
  `documents_4_description` varchar(255) DEFAULT NULL,
  `documents_4_number` varchar(255) DEFAULT NULL,
  `documents_5_name` varchar(255) DEFAULT NULL,
  `documents_5_description` varchar(255) DEFAULT NULL,
  `documents_5_number` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `id_hospital` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `administrators`
--

LOCK TABLES `administrators` WRITE;
/*!40000 ALTER TABLE `administrators` DISABLE KEYS */;
INSERT INTO `administrators` VALUES
(1,NULL,'teste',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(2,'000','test2',NULL,NULL,'ABFM',NULL,'conselho','ABFM',NULL,'conselho','ABFM',NULL,'conselho','ABFM',NULL,'conselho','ABFM',NULL,'conselho','ABFM',NULL,'2023-03-28 21:51:46','2023-03-28 23:29:20',NULL,NULL);
/*!40000 ALTER TABLE `administrators` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `order` int(11) NOT NULL DEFAULT 1,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `categories_slug_unique` (`slug`),
  KEY `categories_parent_id_foreign` (`parent_id`),
  CONSTRAINT `categories_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES
(1,NULL,1,'Category 1','category-1','2023-03-28 17:17:13','2023-03-28 17:17:13'),
(2,NULL,1,'Category 2','category-2','2023-03-28 17:17:13','2023-03-28 17:17:13');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_rows`
--

DROP TABLE IF EXISTS `data_rows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_rows` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `data_type_id` int(10) unsigned NOT NULL,
  `field` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `display_name` varchar(255) NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT 0,
  `browse` tinyint(1) NOT NULL DEFAULT 1,
  `read` tinyint(1) NOT NULL DEFAULT 1,
  `edit` tinyint(1) NOT NULL DEFAULT 1,
  `add` tinyint(1) NOT NULL DEFAULT 1,
  `delete` tinyint(1) NOT NULL DEFAULT 1,
  `details` text DEFAULT NULL,
  `order` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `data_rows_data_type_id_foreign` (`data_type_id`),
  CONSTRAINT `data_rows_data_type_id_foreign` FOREIGN KEY (`data_type_id`) REFERENCES `data_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=348 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_rows`
--

LOCK TABLES `data_rows` WRITE;
/*!40000 ALTER TABLE `data_rows` DISABLE KEYS */;
INSERT INTO `data_rows` VALUES
(1,1,'id','number','ID',1,0,0,0,0,0,NULL,1),
(2,1,'name','text','Name',1,1,1,1,1,1,NULL,2),
(3,1,'email','text','Email',1,1,1,1,1,1,NULL,3),
(4,1,'password','password','Password',1,0,0,1,1,0,NULL,4),
(5,1,'remember_token','text','Remember Token',0,0,0,0,0,0,NULL,5),
(6,1,'created_at','timestamp','Created At',0,1,1,0,0,0,NULL,6),
(7,1,'updated_at','timestamp','Updated At',0,0,0,0,0,0,NULL,7),
(8,1,'avatar','image','Avatar',0,1,1,1,1,1,NULL,8),
(9,1,'user_belongsto_role_relationship','relationship','Role',0,1,1,1,1,0,'{\"model\":\"TCG\\\\Voyager\\\\Models\\\\Role\",\"table\":\"roles\",\"type\":\"belongsTo\",\"column\":\"role_id\",\"key\":\"id\",\"label\":\"display_name\",\"pivot_table\":\"roles\",\"pivot\":0}',10),
(10,1,'user_belongstomany_role_relationship','relationship','Roles',0,1,1,1,1,0,'{\"model\":\"TCG\\\\Voyager\\\\Models\\\\Role\",\"table\":\"roles\",\"type\":\"belongsToMany\",\"column\":\"id\",\"key\":\"id\",\"label\":\"display_name\",\"pivot_table\":\"user_roles\",\"pivot\":\"1\",\"taggable\":\"0\"}',11),
(11,1,'settings','hidden','Settings',0,0,0,0,0,0,NULL,12),
(12,2,'id','number','ID',1,0,0,0,0,0,NULL,1),
(13,2,'name','text','Name',1,1,1,1,1,1,NULL,2),
(14,2,'created_at','timestamp','Created At',0,0,0,0,0,0,NULL,3),
(15,2,'updated_at','timestamp','Updated At',0,0,0,0,0,0,NULL,4),
(16,3,'id','number','ID',1,0,0,0,0,0,'{}',1),
(17,3,'name','text','Name',1,1,1,1,1,1,'{}',2),
(18,3,'created_at','timestamp','Created At',0,0,0,0,0,0,'{}',3),
(19,3,'updated_at','timestamp','Updated At',0,0,0,0,0,0,'{}',4),
(20,3,'display_name','text','Display Name',1,1,1,1,1,1,'{}',5),
(21,1,'role_id','text','Role',1,1,1,1,1,1,NULL,9),
(22,4,'id','number','ID',1,0,0,0,0,0,NULL,1),
(23,4,'parent_id','select_dropdown','Parent',0,0,1,1,1,1,'{\"default\":\"\",\"null\":\"\",\"options\":{\"\":\"-- None --\"},\"relationship\":{\"key\":\"id\",\"label\":\"name\"}}',2),
(24,4,'order','text','Order',1,1,1,1,1,1,'{\"default\":1}',3),
(25,4,'name','text','Name',1,1,1,1,1,1,NULL,4),
(26,4,'slug','text','Slug',1,1,1,1,1,1,'{\"slugify\":{\"origin\":\"name\"}}',5),
(27,4,'created_at','timestamp','Created At',0,0,1,0,0,0,NULL,6),
(28,4,'updated_at','timestamp','Updated At',0,0,0,0,0,0,NULL,7),
(29,5,'id','number','ID',1,0,0,0,0,0,'{}',1),
(30,5,'author_id','text','Author',1,0,1,1,0,1,'{}',2),
(31,5,'category_id','text','Category',0,0,1,1,1,0,'{}',3),
(32,5,'title','text','Title',1,1,1,1,1,1,'{}',4),
(33,5,'excerpt','text_area','Excerpt',0,0,1,1,1,1,'{}',5),
(34,5,'body','rich_text_box','Body',1,0,1,1,1,1,'{}',6),
(35,5,'image','image','Post Image',0,1,1,1,1,1,'{\"resize\":{\"width\":\"1000\",\"height\":\"null\"},\"quality\":\"70%\",\"upsize\":true,\"thumbnails\":[{\"name\":\"medium\",\"scale\":\"50%\"},{\"name\":\"small\",\"scale\":\"25%\"},{\"name\":\"cropped\",\"crop\":{\"width\":\"300\",\"height\":\"250\"}}]}',7),
(36,5,'slug','text','Slug',1,0,0,0,0,0,'{\"slugify\":{\"origin\":\"title\",\"forceUpdate\":true},\"validation\":{\"rule\":\"unique:posts,slug\"}}',8),
(37,5,'meta_description','text_area','Meta Description',0,0,0,0,0,0,'{}',9),
(38,5,'meta_keywords','text_area','Meta Keywords',0,0,0,0,0,0,'{}',10),
(39,5,'status','select_dropdown','Status',1,1,1,1,1,1,'{\"default\":\"DRAFT\",\"options\":{\"PUBLISHED\":\"published\",\"DRAFT\":\"draft\",\"PENDING\":\"pending\"}}',11),
(40,5,'created_at','timestamp','Created At',0,1,1,0,0,0,'{}',12),
(41,5,'updated_at','timestamp','Updated At',0,0,0,0,0,0,'{}',13),
(42,5,'seo_title','text','SEO Title',0,0,0,0,0,0,'{}',14),
(43,5,'featured','checkbox','Featured',1,0,0,0,0,0,'{}',15),
(44,6,'id','number','ID',1,0,0,0,0,0,'{}',1),
(45,6,'author_id','text','Author',1,0,0,0,0,0,'{}',2),
(46,6,'title','text','Título',1,1,1,1,1,1,'{}',3),
(47,6,'excerpt','text_area','Excerpt',0,0,0,0,0,0,'{}',4),
(48,6,'body','rich_text_box','Descrição',0,0,1,1,1,1,'{}',5),
(49,6,'slug','text','Slug',1,0,0,0,0,0,'{\"slugify\":{\"origin\":\"title\"},\"validation\":{\"rule\":\"unique:pages,slug\"}}',6),
(50,6,'meta_description','text','Meta Description',0,0,0,0,0,0,'{}',7),
(51,6,'meta_keywords','text','Meta Keywords',0,0,0,0,0,0,'{}',8),
(52,6,'status','select_dropdown','Status',1,1,1,1,1,1,'{\"default\":\"RASCUNHO\",\"options\":{\"RASCUNHO\":\"RASCUNHO\",\"PUBLICADA\":\"PUBLICADA\"}}',9),
(53,6,'created_at','timestamp','Data da Criação',0,1,1,0,0,0,'{}',10),
(54,6,'updated_at','timestamp','Updated At',0,0,0,0,0,0,'{}',11),
(55,6,'image','file','Anexo',0,1,1,1,1,1,'{}',12),
(56,11,'id','text','Id',1,0,0,0,0,0,'{}',1),
(57,11,'cpf','text','CPF',0,1,1,1,1,1,'{}',2),
(58,11,'name','text','Nome',0,1,1,1,1,1,'{}',3),
(59,11,'formacao_profissional','text','Formação',0,1,1,1,1,1,'{\"display\":{\"width\":\"12\"},\"default\":\"\",\"options\":{\"\":\"Selecione uma op\\u00e7\\u00e3o\",\"Medicina\":\"Medicina\",\"Administra\\u00e7\\u00e3o\":\"Administra\\u00e7\\u00e3o\",\"F\\u00edsica\":\"F\\u00edsica\",\"Enfermagem\":\"Enfermagem\",\"Odontologia\":\"Odontologia\",\"Tecn\\u00f3logo em Radiologia\":\"Tecn\\u00f3logo em Radiologia\",\"Sa\\u00fade Coletiva\":\"Sa\\u00fade Coletiva\",\"Educa\\u00e7\\u00e3o F\\u00edsica\":\"Educa\\u00e7\\u00e3o F\\u00edsica\",\"Biomedicina\":\"Biomedicina\",\"Terapia Ocupacional\":\"Terapia Ocupacional\",\"Psicologia\":\"Psicologia\",\"Fisioterapia\":\"Fisioterapia\",\"Nutri\\u00e7\\u00e3o\":\"Nutri\\u00e7\\u00e3o\",\"Farm\\u00e1cia\":\"Farm\\u00e1cia\",\"Fonoaudiologia\":\"Fonoaudiologia\",\"Gest\\u00e3o Hospitalar\":\"Gest\\u00e3o Hospitalar\",\"Oftalmologia\":\"Oftalmologia\",\"Servi\\u00e7o Social\":\"Servi\\u00e7o Social\",\"Outro\":\"Outro\"}}',4),
(60,11,'documents_0_name','text','Tipo de documento',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"},\"default\":\"conselho\",\"options\":{\"\":\"Selecione uma op\\u00e7\\u00e3o\",\"rg\":\"Registro Geral - RG\",\"conselho\":\"Conselho Profissional (CRM, CRO, CREA etc.)\"}}',5),
(61,11,'documents_0_number','text','Número',0,1,1,1,1,1,'{}',6),
(62,11,'documents_0_description','text','Conselho',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"},\"default\":\"1\",\"options\":{\"ABFM\":\"ABFM\",\"CAU\":\"CAU\",\"CNEN\":\"CNEN\",\"CONFERP\":\"CONFERP\",\"CONRE\":\"CONRE\",\"CORECON\":\"CORECON\",\"COREN\":\"COREN\",\"CRB\":\"CRB\",\"CRBIO\":\"CRBIO\",\"CRBM\":\"CRBM\",\"CRC\":\"CRC\",\"CRECI\":\"CRECI\",\"CREF\":\"CREF\",\"CREFITO\":\"CREFITO\",\"CRESS\":\"CRESS\",\"CRF\":\"CRF\",\"CRFA\":\"CRFA\",\"CRM\":\"CRM\",\"CRMV\":\"CRMV\",\"CRN\":\"CRN\",\"CRO\":\"CRO\",\"CRP\":\"CRP\",\"CRQ\":\"CRQ\",\"CRTR\":\"CRTR\",\"CTRT\":\"CTRT\",\"Outro\":\"Outro\"}}',7),
(63,11,'documents_1_name','text','Tipo de documento',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"},\"default\":\"conselho\",\"options\":{\"\":\"Selecione uma op\\u00e7\\u00e3o\",\"rg\":\"Registro Geral - RG\",\"conselho\":\"Conselho Profissional (CRM, CRO, CREA etc.)\"}}',8),
(64,11,'documents_1_number','text','Número',0,1,1,1,1,1,'{}',9),
(65,11,'documents_1_description','text','Conselho',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"},\"default\":\"1\",\"options\":{\"ABFM\":\"ABFM\",\"CAU\":\"CAU\",\"CNEN\":\"CNEN\",\"CONFERP\":\"CONFERP\",\"CONRE\":\"CONRE\",\"CORECON\":\"CORECON\",\"COREN\":\"COREN\",\"CRB\":\"CRB\",\"CRBIO\":\"CRBIO\",\"CRBM\":\"CRBM\",\"CRC\":\"CRC\",\"CRECI\":\"CRECI\",\"CREF\":\"CREF\",\"CREFITO\":\"CREFITO\",\"CRESS\":\"CRESS\",\"CRF\":\"CRF\",\"CRFA\":\"CRFA\",\"CRM\":\"CRM\",\"CRMV\":\"CRMV\",\"CRN\":\"CRN\",\"CRO\":\"CRO\",\"CRP\":\"CRP\",\"CRQ\":\"CRQ\",\"CRTR\":\"CRTR\",\"CTRT\":\"CTRT\",\"Outro\":\"Outro\"}}',10),
(66,11,'documents_2_name','text','Tipo de documento',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"},\"default\":\"conselho\",\"options\":{\"\":\"Selecione uma op\\u00e7\\u00e3o\",\"rg\":\"Registro Geral - RG\",\"conselho\":\"Conselho Profissional (CRM, CRO, CREA etc.)\"}}',11),
(67,11,'documents_2_number','text','Número',0,1,1,1,1,1,'{}',12),
(68,11,'documents_2_description','text','Conselho',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"},\"default\":\"1\",\"options\":{\"ABFM\":\"ABFM\",\"CAU\":\"CAU\",\"CNEN\":\"CNEN\",\"CONFERP\":\"CONFERP\",\"CONRE\":\"CONRE\",\"CORECON\":\"CORECON\",\"COREN\":\"COREN\",\"CRB\":\"CRB\",\"CRBIO\":\"CRBIO\",\"CRBM\":\"CRBM\",\"CRC\":\"CRC\",\"CRECI\":\"CRECI\",\"CREF\":\"CREF\",\"CREFITO\":\"CREFITO\",\"CRESS\":\"CRESS\",\"CRF\":\"CRF\",\"CRFA\":\"CRFA\",\"CRM\":\"CRM\",\"CRMV\":\"CRMV\",\"CRN\":\"CRN\",\"CRO\":\"CRO\",\"CRP\":\"CRP\",\"CRQ\":\"CRQ\",\"CRTR\":\"CRTR\",\"CTRT\":\"CTRT\",\"Outro\":\"Outro\"}}',13),
(69,11,'documents_3_name','text','Tipo de documento',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"},\"default\":\"conselho\",\"options\":{\"\":\"Selecione uma op\\u00e7\\u00e3o\",\"rg\":\"Registro Geral - RG\",\"conselho\":\"Conselho Profissional (CRM, CRO, CREA etc.)\"}}',14),
(70,11,'documents_3_number','text','Número',0,1,1,1,1,1,'{}',15),
(71,11,'documents_3_description','text','Conselho',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"},\"default\":\"1\",\"options\":{\"ABFM\":\"ABFM\",\"CAU\":\"CAU\",\"CNEN\":\"CNEN\",\"CONFERP\":\"CONFERP\",\"CONRE\":\"CONRE\",\"CORECON\":\"CORECON\",\"COREN\":\"COREN\",\"CRB\":\"CRB\",\"CRBIO\":\"CRBIO\",\"CRBM\":\"CRBM\",\"CRC\":\"CRC\",\"CRECI\":\"CRECI\",\"CREF\":\"CREF\",\"CREFITO\":\"CREFITO\",\"CRESS\":\"CRESS\",\"CRF\":\"CRF\",\"CRFA\":\"CRFA\",\"CRM\":\"CRM\",\"CRMV\":\"CRMV\",\"CRN\":\"CRN\",\"CRO\":\"CRO\",\"CRP\":\"CRP\",\"CRQ\":\"CRQ\",\"CRTR\":\"CRTR\",\"CTRT\":\"CTRT\",\"Outro\":\"Outro\"}}',16),
(72,11,'documents_4_name','text','Tipo de documento',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"},\"default\":\"conselho\",\"options\":{\"\":\"Selecione uma op\\u00e7\\u00e3o\",\"rg\":\"Registro Geral - RG\",\"conselho\":\"Conselho Profissional (CRM, CRO, CREA etc.)\"}}',17),
(73,11,'documents_4_number','text','Número',0,1,1,1,1,1,'{}',18),
(74,11,'documents_4_description','text','Conselho',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"},\"default\":\"1\",\"options\":{\"ABFM\":\"ABFM\",\"CAU\":\"CAU\",\"CNEN\":\"CNEN\",\"CONFERP\":\"CONFERP\",\"CONRE\":\"CONRE\",\"CORECON\":\"CORECON\",\"COREN\":\"COREN\",\"CRB\":\"CRB\",\"CRBIO\":\"CRBIO\",\"CRBM\":\"CRBM\",\"CRC\":\"CRC\",\"CRECI\":\"CRECI\",\"CREF\":\"CREF\",\"CREFITO\":\"CREFITO\",\"CRESS\":\"CRESS\",\"CRF\":\"CRF\",\"CRFA\":\"CRFA\",\"CRM\":\"CRM\",\"CRMV\":\"CRMV\",\"CRN\":\"CRN\",\"CRO\":\"CRO\",\"CRP\":\"CRP\",\"CRQ\":\"CRQ\",\"CRTR\":\"CRTR\",\"CTRT\":\"CTRT\",\"Outro\":\"Outro\"}}',19),
(75,11,'documents_5_name','text','Tipo de documento',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"},\"default\":\"conselho\",\"options\":{\"\":\"Selecione uma op\\u00e7\\u00e3o\",\"rg\":\"Registro Geral - RG\",\"conselho\":\"Conselho Profissional (CRM, CRO, CREA etc.)\"}}',20),
(76,11,'documents_5_number','text','Número',0,1,1,1,1,1,'{}',21),
(77,11,'documents_5_description','text','Conselho',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"},\"default\":\"1\",\"options\":{\"ABFM\":\"ABFM\",\"CAU\":\"CAU\",\"CNEN\":\"CNEN\",\"CONFERP\":\"CONFERP\",\"CONRE\":\"CONRE\",\"CORECON\":\"CORECON\",\"COREN\":\"COREN\",\"CRB\":\"CRB\",\"CRBIO\":\"CRBIO\",\"CRBM\":\"CRBM\",\"CRC\":\"CRC\",\"CRECI\":\"CRECI\",\"CREF\":\"CREF\",\"CREFITO\":\"CREFITO\",\"CRESS\":\"CRESS\",\"CRF\":\"CRF\",\"CRFA\":\"CRFA\",\"CRM\":\"CRM\",\"CRMV\":\"CRMV\",\"CRN\":\"CRN\",\"CRO\":\"CRO\",\"CRP\":\"CRP\",\"CRQ\":\"CRQ\",\"CRTR\":\"CRTR\",\"CTRT\":\"CTRT\",\"Outro\":\"Outro\"}}',22),
(78,11,'deleted_at','timestamp','Deleted At',0,0,0,0,0,0,'{}',23),
(79,11,'created_at','timestamp','Created At',0,0,0,0,0,0,'{}',24),
(80,11,'updated_at','timestamp','Updated At',0,0,0,0,0,0,'{}',25),
(86,20,'id','text','Id',1,0,0,0,0,0,'{\"display\":{\"width\":\"4\"}}',1),
(87,20,'cpf','text','CPF',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"}}',2),
(88,20,'name','text','Nome',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"}}',3),
(89,20,'formacao_profissional','select_dropdown','Formação',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"},\"default\":\"\",\"options\":{\"\":\"Selecione uma op\\u00e7\\u00e3o\",\"Medicina\":\"Medicina\",\"Administra\\u00e7\\u00e3o\":\"Administra\\u00e7\\u00e3o\",\"F\\u00edsica\":\"F\\u00edsica\",\"Enfermagem\":\"Enfermagem\",\"Odontologia\":\"Odontologia\",\"Tecn\\u00f3logo em Radiologia\":\"Tecn\\u00f3logo em Radiologia\",\"Sa\\u00fade Coletiva\":\"Sa\\u00fade Coletiva\",\"Educa\\u00e7\\u00e3o F\\u00edsica\":\"Educa\\u00e7\\u00e3o F\\u00edsica\",\"Biomedicina\":\"Biomedicina\",\"Terapia Ocupacional\":\"Terapia Ocupacional\",\"Psicologia\":\"Psicologia\",\"Fisioterapia\":\"Fisioterapia\",\"Nutri\\u00e7\\u00e3o\":\"Nutri\\u00e7\\u00e3o\",\"Farm\\u00e1cia\":\"Farm\\u00e1cia\",\"Fonoaudiologia\":\"Fonoaudiologia\",\"Gest\\u00e3o Hospitalar\":\"Gest\\u00e3o Hospitalar\",\"Oftalmologia\":\"Oftalmologia\",\"Servi\\u00e7o Social\":\"Servi\\u00e7o Social\",\"Outro\":\"Outro\"}}',4),
(90,20,'documents_0_name','select_dropdown','Tipo de documento',0,0,1,1,1,1,'{\"display\":{\"width\":\"4\"},\"default\":\"\",\"options\":{\"\":\"Selecione uma op\\u00e7\\u00e3o\",\"rg\":\"Registro Geral - RG\",\"conselho\":\"Conselho Profissional (CRM, CRO, CREA etc.)\"}}',5),
(91,20,'documents_0_description','select_dropdown','Conselho',0,0,1,1,1,1,'{\"display\":{\"width\":\"4\"},\"default\":\"1\",\"options\":{\"ABFM\":\"ABFM\",\"CAU\":\"CAU\",\"CNEN\":\"CNEN\",\"CONFERP\":\"CONFERP\",\"CONRE\":\"CONRE\",\"CORECON\":\"CORECON\",\"COREN\":\"COREN\",\"CRB\":\"CRB\",\"CRBIO\":\"CRBIO\",\"CRBM\":\"CRBM\",\"CRC\":\"CRC\",\"CRECI\":\"CRECI\",\"CREF\":\"CREF\",\"CREFITO\":\"CREFITO\",\"CRESS\":\"CRESS\",\"CRF\":\"CRF\",\"CRFA\":\"CRFA\",\"CRM\":\"CRM\",\"CRMV\":\"CRMV\",\"CRN\":\"CRN\",\"CRO\":\"CRO\",\"CRP\":\"CRP\",\"CRQ\":\"CRQ\",\"CRTR\":\"CRTR\",\"CTRT\":\"CTRT\",\"Outro\":\"Outro\"}}',6),
(92,20,'documents_0_number','text','Número',0,0,1,1,1,1,'{\"display\":{\"width\":\"4\"}}',7),
(93,20,'documents_1_name','select_dropdown','Tipo de documento',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"},\"default\":\"conselho\",\"options\":{\"\":\"Selecione uma op\\u00e7\\u00e3o\",\"rg\":\"Registro Geral - RG\",\"conselho\":\"Conselho Profissional (CRM, CRO, CREA etc.)\"}}',8),
(94,20,'documents_1_description','select_dropdown','Conselho',0,0,1,1,1,1,'{\"display\":{\"width\":\"4\"},\"default\":\"1\",\"options\":{\"ABFM\":\"ABFM\",\"CAU\":\"CAU\",\"CNEN\":\"CNEN\",\"CONFERP\":\"CONFERP\",\"CONRE\":\"CONRE\",\"CORECON\":\"CORECON\",\"COREN\":\"COREN\",\"CRB\":\"CRB\",\"CRBIO\":\"CRBIO\",\"CRBM\":\"CRBM\",\"CRC\":\"CRC\",\"CRECI\":\"CRECI\",\"CREF\":\"CREF\",\"CREFITO\":\"CREFITO\",\"CRESS\":\"CRESS\",\"CRF\":\"CRF\",\"CRFA\":\"CRFA\",\"CRM\":\"CRM\",\"CRMV\":\"CRMV\",\"CRN\":\"CRN\",\"CRO\":\"CRO\",\"CRP\":\"CRP\",\"CRQ\":\"CRQ\",\"CRTR\":\"CRTR\",\"CTRT\":\"CTRT\",\"Outro\":\"Outro\"}}',9),
(95,20,'documents_1_number','text','Número',0,0,1,1,1,1,'{\"display\":{\"width\":\"4\"}}',10),
(96,20,'documents_2_name','select_dropdown','Tipo de documento',0,0,1,1,1,1,'{\"display\":{\"width\":\"4\"},\"default\":\"conselho\",\"options\":{\"\":\"Selecione uma op\\u00e7\\u00e3o\",\"rg\":\"Registro Geral - RG\",\"conselho\":\"Conselho Profissional (CRM, CRO, CREA etc.)\"}}',11),
(97,20,'documents_2_description','select_dropdown','Conselho',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"},\"default\":\"1\",\"options\":{\"ABFM\":\"ABFM\",\"CAU\":\"CAU\",\"CNEN\":\"CNEN\",\"CONFERP\":\"CONFERP\",\"CONRE\":\"CONRE\",\"CORECON\":\"CORECON\",\"COREN\":\"COREN\",\"CRB\":\"CRB\",\"CRBIO\":\"CRBIO\",\"CRBM\":\"CRBM\",\"CRC\":\"CRC\",\"CRECI\":\"CRECI\",\"CREF\":\"CREF\",\"CREFITO\":\"CREFITO\",\"CRESS\":\"CRESS\",\"CRF\":\"CRF\",\"CRFA\":\"CRFA\",\"CRM\":\"CRM\",\"CRMV\":\"CRMV\",\"CRN\":\"CRN\",\"CRO\":\"CRO\",\"CRP\":\"CRP\",\"CRQ\":\"CRQ\",\"CRTR\":\"CRTR\",\"CTRT\":\"CTRT\",\"Outro\":\"Outro\"}}',12),
(98,20,'documents_2_number','text','Número',0,0,1,1,1,1,'{\"display\":{\"width\":\"4\"}}',13),
(99,20,'documents_3_name','select_dropdown','Tipo de documento',0,0,1,1,1,1,'{\"display\":{\"width\":\"4\"},\"default\":\"conselho\",\"options\":{\"\":\"Selecione uma op\\u00e7\\u00e3o\",\"rg\":\"Registro Geral - RG\",\"conselho\":\"Conselho Profissional (CRM, CRO, CREA etc.)\"}}',14),
(100,20,'documents_3_description','select_dropdown','Conselho',0,0,1,1,1,1,'{\"display\":{\"width\":\"4\"},\"default\":\"1\",\"options\":{\"ABFM\":\"ABFM\",\"CAU\":\"CAU\",\"CNEN\":\"CNEN\",\"CONFERP\":\"CONFERP\",\"CONRE\":\"CONRE\",\"CORECON\":\"CORECON\",\"COREN\":\"COREN\",\"CRB\":\"CRB\",\"CRBIO\":\"CRBIO\",\"CRBM\":\"CRBM\",\"CRC\":\"CRC\",\"CRECI\":\"CRECI\",\"CREF\":\"CREF\",\"CREFITO\":\"CREFITO\",\"CRESS\":\"CRESS\",\"CRF\":\"CRF\",\"CRFA\":\"CRFA\",\"CRM\":\"CRM\",\"CRMV\":\"CRMV\",\"CRN\":\"CRN\",\"CRO\":\"CRO\",\"CRP\":\"CRP\",\"CRQ\":\"CRQ\",\"CRTR\":\"CRTR\",\"CTRT\":\"CTRT\",\"Outro\":\"Outro\"}}',15),
(101,20,'documents_3_number','text','Número',0,0,1,1,1,1,'{\"display\":{\"width\":\"4\"}}',16),
(102,20,'documents_4_name','select_dropdown','Tipo de documento',0,0,1,1,1,1,'{\"display\":{\"width\":\"4\"},\"default\":\"conselho\",\"options\":{\"\":\"Selecione uma op\\u00e7\\u00e3o\",\"rg\":\"Registro Geral - RG\",\"conselho\":\"Conselho Profissional (CRM, CRO, CREA etc.)\"}}',17),
(103,20,'documents_4_description','select_dropdown','Conselho',0,0,1,1,1,1,'{\"display\":{\"width\":\"4\"},\"default\":\"1\",\"options\":{\"ABFM\":\"ABFM\",\"CAU\":\"CAU\",\"CNEN\":\"CNEN\",\"CONFERP\":\"CONFERP\",\"CONRE\":\"CONRE\",\"CORECON\":\"CORECON\",\"COREN\":\"COREN\",\"CRB\":\"CRB\",\"CRBIO\":\"CRBIO\",\"CRBM\":\"CRBM\",\"CRC\":\"CRC\",\"CRECI\":\"CRECI\",\"CREF\":\"CREF\",\"CREFITO\":\"CREFITO\",\"CRESS\":\"CRESS\",\"CRF\":\"CRF\",\"CRFA\":\"CRFA\",\"CRM\":\"CRM\",\"CRMV\":\"CRMV\",\"CRN\":\"CRN\",\"CRO\":\"CRO\",\"CRP\":\"CRP\",\"CRQ\":\"CRQ\",\"CRTR\":\"CRTR\",\"CTRT\":\"CTRT\",\"Outro\":\"Outro\"}}',18),
(104,20,'documents_4_number','text','Número',0,0,1,1,1,1,'{\"display\":{\"width\":\"4\"}}',19),
(105,20,'documents_5_name','select_dropdown','Tipo de documento',0,0,1,1,1,1,'{\"display\":{\"width\":\"4\"},\"default\":\"conselho\",\"options\":{\"\":\"Selecione uma op\\u00e7\\u00e3o\",\"rg\":\"Registro Geral - RG\",\"conselho\":\"Conselho Profissional (CRM, CRO, CREA etc.)\"}}',20),
(106,20,'documents_5_description','select_dropdown','Conselho',0,0,1,1,1,1,'{\"display\":{\"width\":\"4\"},\"default\":\"1\",\"options\":{\"ABFM\":\"ABFM\",\"CAU\":\"CAU\",\"CNEN\":\"CNEN\",\"CONFERP\":\"CONFERP\",\"CONRE\":\"CONRE\",\"CORECON\":\"CORECON\",\"COREN\":\"COREN\",\"CRB\":\"CRB\",\"CRBIO\":\"CRBIO\",\"CRBM\":\"CRBM\",\"CRC\":\"CRC\",\"CRECI\":\"CRECI\",\"CREF\":\"CREF\",\"CREFITO\":\"CREFITO\",\"CRESS\":\"CRESS\",\"CRF\":\"CRF\",\"CRFA\":\"CRFA\",\"CRM\":\"CRM\",\"CRMV\":\"CRMV\",\"CRN\":\"CRN\",\"CRO\":\"CRO\",\"CRP\":\"CRP\",\"CRQ\":\"CRQ\",\"CRTR\":\"CRTR\",\"CTRT\":\"CTRT\",\"Outro\":\"Outro\"}}',21),
(107,20,'documents_5_number','text','Número',0,0,1,1,1,1,'{\"display\":{\"width\":\"4\"}}',22),
(108,20,'created_at','timestamp','Criado em',0,0,0,0,0,0,'{\"display\":{\"width\":\"4\"}}',23),
(109,20,'updated_at','timestamp','Atualizado em',0,0,0,0,0,0,'{\"display\":{\"width\":\"4\"}}',24),
(110,20,'deleted_at','timestamp','Excluido em',0,0,0,0,0,0,'{\"display\":{\"width\":\"4\"}}',25),
(111,21,'id','text','Id',1,0,0,0,0,0,'{}',1),
(112,21,'area_atuacao','select_dropdown','Tipo de Instituição',0,0,1,1,1,1,'{\"display\":{\"width\":\"4\"},\"default\":\"\",\"options\":{\"\":\"Selecione uma op\\u00e7\\u00e3o\",\"Empresa Prestadora\":\"Empresa Prestadora\",\"Empresa Manuten\\u00e7\\u00e3o e Vendas\":\"Empresa Manuten\\u00e7\\u00e3o e Vendas\",\"Profissional Liberal\":\"Profissional Liberal\",\"Sa\\u00fade\":\"Sa\\u00fade\"}}',2),
(113,21,'razaoSocial','text','Razão Social',0,0,1,1,1,1,'{\"display\":{\"width\":\"4\"}}',3),
(114,21,'nomeFantasia','text','Nome Fantasia',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"}}',4),
(115,21,'cnpj','text','CNPJ',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"}}',5),
(116,21,'cep','text','CEP *',0,0,1,1,1,1,'{\"display\":{\"width\":\"4\"}}',6),
(117,21,'endereco','text','Endereço *',0,0,1,1,1,1,'{\"display\":{\"width\":\"4\"}}',7),
(118,21,'bairro','text','Bairro *',0,0,1,1,1,1,'{\"display\":{\"width\":\"4\"}}',8),
(119,21,'uf','select_dropdown','UF *',0,0,1,1,1,1,'{\"display\":{\"width\":\"4\"},\"default\":\"\",\"options\":{\"AC\":\"AC\",\"AL\":\"AL\",\"AP\":\"AP\",\"AM\":\"AM\",\"BA\":\"BA\",\"CE\":\"CE\",\"DF\":\"DF\",\"ES\":\"ES\",\"GO\":\"GO\",\"MA\":\"MA\",\"MT\":\"MT\",\"MS\":\"MS\",\"MG\":\"MG\",\"PA\":\"PA\",\"PB\":\"PB\",\"PR\":\"PR\",\"PE\":\"PE\",\"PI\":\"PI\",\"RJ\":\"RJ\",\"RN\":\"RN\",\"RS\":\"RS\",\"RO\":\"RO\",\"RR\":\"RR\",\"SC\":\"SC\",\"SP\":\"SP\",\"SE\":\"SE\",\"TO\":\"TO\"}}',9),
(120,21,'ciadade','text','Cidade',0,0,1,1,1,1,'{\"display\":{\"width\":\"4\"}}',10),
(121,21,'telefone','text','Telefone',0,0,1,1,1,1,'{\"display\":{\"width\":\"4\"}}',11),
(122,21,'fax','text','Fax',0,0,1,1,1,1,'{\"display\":{\"width\":\"4\"}}',12),
(123,21,'email','text','Email',0,0,1,1,1,1,'{\"display\":{\"width\":\"4\"}}',13),
(124,21,'status','text','Status',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"},\"default\":\"\",\"options\":{\"\":\"Selecione uma op\\u00e7\\u00e3o\",\"Ativa\":\"Ativa\",\"Inativa\":\"Inativa\"}}',14),
(125,21,'cnes','text','CNES',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"}}',15),
(126,21,'entity_type','text','Tipo de Entidade',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"},\"default\":\"\",\"options\":{\"P\\u00fablica\":\"P\\u00fablica\",\"Filantr\\u00f3pica\":\"Filantr\\u00f3pica\",\"Privada\":\"Privada\"}}',16),
(127,21,'types_of_care','text','Entidade',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"},\"default\":\"\",\"options\":{\"SUS\":\"SUS\",\"Particular\":\"Particular\",\"Conv\\u00eanio\":\"Conv\\u00eanio\"}}',17),
(128,21,'empresas_prestadoras','select_dropdown','Empresas Prestadoras',0,0,0,0,0,0,'{\"display\":{\"width\":\"4\"}}',18),
(129,21,'created_at','timestamp','Created At',0,0,0,0,0,0,'{\"display\":{\"width\":\"4\"}}',19),
(130,21,'updated_at','timestamp','Updated At',0,0,0,0,0,0,'{\"display\":{\"width\":\"4\"}}',20),
(131,21,'deleted_at','timestamp','Deleted At',0,0,0,0,0,0,'{\"display\":{\"width\":\"4\"}}',21),
(135,20,'id_hospital','number','Id Hospital',0,0,0,0,0,0,'{}',26),
(137,21,'hospital_belongsto_administrator_relationship','relationship','Responsável Legal',0,1,1,1,1,1,'{\"display\":{\"width\":\"12\"},\"model\":\"App\\\\Administrator\",\"table\":\"administrators\",\"type\":\"belongsToMany\",\"column\":\"id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"hospital_administrators\",\"pivot\":\"1\",\"taggable\":\"0\"}',22),
(138,22,'id','text','Id',1,0,0,0,0,0,'{}',1),
(140,22,'service_type','select_dropdown','Serviço',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"},\"default\":\"\",\"options\":{\"RV\":\"Radiologia Veterinaria\",\"RT\":\"Radioterapia\",\"RO\":\"Radiologia Odontol\\u00f3gica\",\"RM\":\"Radiologia M\\u00e9dica\",\"RI\":\"Radiologia Intervencionista\",\"MN\":\"Medicina Nuclear\"}}',3),
(141,22,'service_type_id','select_dropdown','Especialidade',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"},\"default\":\"\",\"options\":{\"RV-RADC\":\"Radiografia convencional\",\"RV-FLUO\":\"Fluoroscopia\",\"RV-TOCP\":\"Tomografia Computadorizada\",\"RT-BRAQ\":\"Braquiterapia\",\"RT-HDR1\":\"HDR\",\"RT-TELE\":\"Teleterapia\",\"RT-COLB\":\"Colbato\",\"RT-BETA\":\"Betaterapia\",\"RT-ACEL\":\"Acelerador\",\"RO-EXTP\":\"Radiologia Odontol\\u00f3gica Extraoral - Panor\\u00e2mico\",\"RO-EXTT\":\"Radiologia Odontol\\u00f3gica Extraoral - Tomografia Feixe C\\u00f4nico\",\"RO-OINT\":\"Radiologia Odontol\\u00f3gica Intraoral\",\"RM-MAMO\":\"Mamografia\",\"RM-FLUO\":\"Fluoroscopia\",\"RM-RADC\":\"Radiografia Convencional\",\"RM-TOCP\":\"Tomografia Computadorizada\",\"RI-INTE\":\"Radiologia Intervencionista\",\"MN-CAMC\":\"Diagn\\u00f3stico C\\u00e2mara de Cintila\\u00e7\\u00e3o\",\"MN-TERA\":\"Terapia\",\"MN-DPET\":\"Diagn\\u00f3stico PET\",\"MN-CAMT\":\"Diagn\\u00f3stico C\\u00e2mara Transport\\u00e1vel\"}}',4),
(142,22,'location_name','text','Nome da Unidade deste Serviço',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"}}',5),
(143,22,'nao_usa_dosimetro','checkbox','Não faz uso de dosímetro Realiza menos de 10 radiografias odontológicas intraorais/dia',0,0,1,1,1,1,'{\"on\":\"Utiliza Dosimetro\",\"off\":\"N\\u00e3o utiliza Dosimetro\",\"checked\":true}',6),
(144,22,'fornecedor_dosimetro','select_dropdown','Fornecedor Dosímetro',0,0,1,1,1,1,'{\"display\":{\"width\":\"4\"},\"default\":\"\",\"options\":{\"SAPRA LANDAUER\":\"SAPRA LANDAUER\",\"PRORAD\":\"PRORAD\",\"TECRAD\":\"TECRAD\",\"IRD\":\"IRD\",\"METROBRAS\":\"METROBRAS\"}}',7),
(145,22,'numero_total_dosimetros','number','Número total de Dosímetros',0,0,1,1,1,1,'{\"display\":{\"width\":\"4\"}}',8),
(148,22,'num_protoloco_processo_renovacao','text','Alvará em processo de renovação',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"}}',12),
(149,22,'numero_alvara','text','Número do Alvará Sanitário *',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"}}',13),
(150,22,'vencimento_alvara','date','Validade do Alvará *',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"}}',14),
(151,22,'obs','rich_text_box','Observações sobre este Serviço',0,0,1,1,1,1,'null',15),
(152,22,'created_at','timestamp','Created At',0,0,0,0,0,0,'{}',16),
(153,22,'updated_at','timestamp','Updated At',0,0,0,0,0,0,'{}',17),
(154,22,'deleted_at','timestamp','Deleted At',0,0,0,0,0,0,'{}',18),
(158,22,'sector_belongsto_administrator_relationship','relationship','Responsável Técnico',0,1,1,1,1,1,'{\"model\":\"App\\\\Administrator\",\"table\":\"administrators\",\"type\":\"belongsTo\",\"column\":\"id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"administrators\",\"pivot\":\"0\",\"taggable\":\"0\"}',9),
(159,22,'sector_belongsto_administrator_relationship_1','relationship','Substituto do Responsável Técnico',0,1,1,1,1,1,'{\"model\":\"App\\\\Administrator\",\"table\":\"administrators\",\"type\":\"belongsTo\",\"column\":\"id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"administrators\",\"pivot\":\"0\",\"taggable\":\"0\"}',10),
(160,22,'sector_belongsto_administrator_relationship_2','relationship','Supervisor de Radioproteção',0,1,1,1,1,1,'{\"model\":\"App\\\\Administrator\",\"table\":\"administrators\",\"type\":\"belongsTo\",\"column\":\"id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"administrators\",\"pivot\":\"0\",\"taggable\":\"0\"}',11),
(162,22,'sector_belongsto_hospital_relationship','relationship','Instituição',0,1,1,1,1,1,'{\"model\":\"App\\\\Hospital\",\"table\":\"hospitals\",\"type\":\"belongsTo\",\"column\":\"id\",\"key\":\"id\",\"label\":\"nomefantasia\",\"pivot_table\":\"administrators\",\"pivot\":\"0\",\"taggable\":\"0\"}',2),
(163,26,'id','text','Id',1,0,0,0,0,0,'{}',1),
(164,26,'person_cpf','text','CPF',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"}}',3),
(165,26,'person_name','text','Nome do Trabalhador *',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"}}',4),
(166,26,'person_gender','select_dropdown','Sexo do Trabalhador *',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"},\"default\":\"\",\"options\":{\"Feminino\":\"Feminino\",\"Masculino\":\"Masculino\",\"Outro\":\"Outro\"}}',5),
(167,26,'person_birthdate','date','Data de nascimento',0,1,1,1,1,1,'{\"display\":{\"width\":\"3\"}}',6),
(168,26,'service_person_link_role','select_dropdown','Função *',0,1,1,1,1,1,'{\"display\":{\"width\":\"3\"},\"default\":\"\",\"options\":{\"Auxiliar de Servi\\u00e7os Gerais\":\"Auxiliar de Servi\\u00e7os Gerais\",\"Auxiliar em Enfermagem\":\"Auxiliar em Enfermagem\",\"Dentista\":\"Dentista\",\"Dosimetrista\":\"Dosimetrista\",\"Enfermeiro\":\"Enfermeiro\",\"Estagi\\u00e1rio\":\"Estagi\\u00e1rio\",\"F\\u00edsico\":\"F\\u00edsico\",\"M\\u00e9dico\":\"M\\u00e9dico\",\"Outros\":\"Outros\",\"Prof\":\"Prof\",\"Residente\":\"Residente\",\"Respons\\u00e1vel Pelo Transporte do Material Radioativo\":\"Respons\\u00e1vel Pelo Transporte do Material Radioativo\",\"Respons\\u00e1vel Legal\":\"Respons\\u00e1vel Legal\",\"Respons\\u00e1vel M\\u00e9dico\":\"Respons\\u00e1vel M\\u00e9dico\",\"Respons\\u00e1vel Sistema\":\"Respons\\u00e1vel Sistema\",\"Respons\\u00e1vel T\\u00e9cnico\":\"Respons\\u00e1vel T\\u00e9cnico\",\"Respons\\u00e1vel T\\u00e9cnico Substituto\":\"Respons\\u00e1vel T\\u00e9cnico Substituto\",\"Substituto do Supervisor de Prote\\u00e7\\u00e3o Radiol\\u00f3gica\":\"Substituto do Supervisor de Prote\\u00e7\\u00e3o Radiol\\u00f3gica\",\"Supervisor de radioprote\\u00e7\\u00e3o\":\"Supervisor de radioprote\\u00e7\\u00e3o\",\"TAA\":\"TAA\",\"Tecn\\u00f3logo em Radiologia\":\"Tecn\\u00f3logo em Radiologia\",\"T\\u00e9cnico Radiologia\":\"T\\u00e9cnico Radiologia\",\"T\\u00e9cnico em Enfermagem\":\"T\\u00e9cnico em Enfermagem\"}}',7),
(169,26,'service_person_link_description','text','Cargo *',0,1,1,1,1,1,'{\"display\":{\"width\":\"3\"}}',8),
(170,26,'service_person_link_work_start_date','date','Data de admissão *',0,1,1,1,1,1,'{\"display\":{\"width\":\"3\"}}',9),
(171,26,'service_person_link_employment_bond','select_dropdown','Vínculo',0,1,1,1,1,1,'{\"display\":{\"width\":\"2\"},\"default\":\"\",\"options\":{\"Terceirizado\":\"Terceirizado\",\"Funcion\\u00e1rio P\\u00fablico\":\"Funcion\\u00e1rio P\\u00fablico\",\"Estagi\\u00e1rio\":\"Estagi\\u00e1rio\",\"S\\u00f3cio\":\"S\\u00f3cio\",\"Celetista\":\"Celetista\"}}',10),
(172,26,'service_person_link_workload','select_dropdown','Carga horária semanal *',0,1,1,1,1,1,'{\"display\":{\"width\":\"2\"},\"default\":\"\",\"options\":{\"20\":\"20 horas semanais\",\"25\":\"25 horas semanais\",\"30\":\"30 horas semanais\",\"40\":\"40 horas semanais\",\"44\":\"44 horas semanais\"}}',11),
(173,26,'person_doc_name','select_dropdown','Sigla de conselho de trabalho *',0,1,1,1,1,1,'{\"display\":{\"width\":\"6\"},\"default\":\"1\",\"options\":{\"ABFM\":\"ABFM\",\"CAU\":\"CAU\",\"CNEN\":\"CNEN\",\"CONFERP\":\"CONFERP\",\"CONRE\":\"CONRE\",\"CORECON\":\"CORECON\",\"COREN\":\"COREN\",\"CRB\":\"CRB\",\"CRBIO\":\"CRBIO\",\"CRBM\":\"CRBM\",\"CRC\":\"CRC\",\"CRECI\":\"CRECI\",\"CREF\":\"CREF\",\"CREFITO\":\"CREFITO\",\"CRESS\":\"CRESS\",\"CRF\":\"CRF\",\"CRFA\":\"CRFA\",\"CRM\":\"CRM\",\"CRMV\":\"CRMV\",\"CRN\":\"CRN\",\"CRO\":\"CRO\",\"CRP\":\"CRP\",\"CRQ\":\"CRQ\",\"CRTR\":\"CRTR\",\"CTRT\":\"CTRT\",\"Outro\":\"Outro\"}}',12),
(174,26,'person_doc_number','text','Número de registro no conselho *',0,1,1,1,1,1,'{\"display\":{\"width\":\"6\"}}',13),
(175,26,'created_at','timestamp','Created At',0,0,0,0,0,0,'{}',14),
(176,26,'updated_at','timestamp','Updated At',0,0,0,0,0,0,'{}',15),
(177,26,'deleted_at','timestamp','Deleted At',0,0,0,0,0,0,'{}',16),
(178,26,'professional_belongsto_sector_relationship','relationship','Setor',0,1,1,1,1,1,'{\"model\":\"App\\\\Sector\",\"table\":\"sectors\",\"type\":\"belongsTo\",\"column\":\"id\",\"key\":\"id\",\"label\":\"location_name\",\"pivot_table\":\"administrators\",\"pivot\":\"0\",\"taggable\":\"0\"}',2),
(179,29,'id','text','Id',1,0,0,0,0,0,'{}',1),
(180,29,'equipment_modality','select_dropdown','Equipamento',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"},\"default\":\"\",\"options\":{\"RV-RADC\":\"Radiografia convencional\",\"RV-FLUO\":\"Fluoroscopia\",\"RV-TOCP\":\"Tomografia Computadorizada\",\"RT-BRAQ\":\"Braquiterapia\",\"RT-HDR1\":\"HDR\",\"RT-TELE\":\"Teleterapia\",\"RT-COLB\":\"Colbato\",\"RT-BETA\":\"Betaterapia\",\"RT-ACEL\":\"Acelerador\",\"RO-EXTP\":\"Radiologia Odontol\\u00f3gica Extraoral - Panor\\u00e2mico\",\"RO-EXTT\":\"Radiologia Odontol\\u00f3gica Extraoral - Tomografia Feixe C\\u00f4nico\",\"RO-OINT\":\"Radiologia Odontol\\u00f3gica Intraoral\",\"RM-MAMO\":\"Mamografia\",\"RM-FLUO\":\"Fluoroscopia\",\"RM-RADC\":\"Radiografia Convencional\",\"RM-TOCP\":\"Tomografia Computadorizada\",\"RI-INTE\":\"Radiologia Intervencionista\",\"MN-CAMC\":\"Diagn\\u00f3stico C\\u00e2mara de Cintila\\u00e7\\u00e3o\",\"MN-TERA\":\"Terapia\",\"MN-DPET\":\"Diagn\\u00f3stico PET\",\"MN-CAMT\":\"Diagn\\u00f3stico C\\u00e2mara Transport\\u00e1vel\"}}',3),
(181,29,'equipment_manufacturer','text','Fabricante',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"}}',4),
(182,29,'equipment_model','text','Modelo',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"}}',5),
(183,29,'equipment_serial_number','text','Nº de Série *',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"}}',6),
(184,29,'equipment_health_ministry_register_number','text','Nº de registro na Anvisa *',0,0,1,1,1,1,'{\"display\":{\"width\":\"2\"}}',7),
(185,29,'equipment_room_name','text','Local de Instalação',0,1,1,1,1,1,'{\"display\":{\"width\":\"2\"}}',8),
(186,29,'equipment_pka_unit_measure','select_dropdown','Unidade medida Pka *',0,0,1,1,1,1,'{\"display\":{\"width\":\"2\"},\"default\":\"\",\"options\":{\"Gy.cm\\u00b2\":\"Gy.cm\\u00b2\",\"cGy.cm\\u00b2\":\"cGy.cm\\u00b2\",\"\\u03bcGy.cm\\u00b2\":\"\\u03bcGy.cm\\u00b2\",\"mGy.cm\\u00b2\":\"mGy.cm\\u00b2\",\"Gy.m\\u00b2\":\"Gy.m\\u00b2\",\"cGy.m\\u00b2\":\"cGy.m\\u00b2\",\"\\u03bcGy.m\\u00b2\":\"\\u03bcGy.m\\u00b2\",\"mGy.m\\u00b2\":\"mGy.m\\u00b2\",\"dGy.cm\\u00b2\":\"dGy.cm\\u00b2\",\"dGy.m\\u00b2\":\"dGy.m\\u00b2\"}}',9),
(187,29,'equipment_kerma_unit_measure','select_dropdown','Unidade medida Kerma *',0,0,1,1,1,1,'{\"display\":{\"width\":\"2\"},\"default\":\"\",\"options\":{\"Gy\":\"Gy\",\"cGy\":\"cGy\",\"\\u03bcGy\":\"\\u03bcGy\",\"mGy\":\"mGy\",\"dGy\":\"dGy\"}}',10),
(188,29,'equipment_tension_max_kv','text','Tensão máx.(kV)',0,0,1,1,1,1,'{\"display\":{\"width\":\"2\"}}',11),
(189,29,'equipment_tension_max_ma','text','Corrente máx.(mA)',0,0,1,1,1,1,'{\"display\":{\"width\":\"2\"}}',12),
(190,29,'equipment_manufacturing_year','text','Ano de fabricação *',0,0,1,1,1,1,'{\"display\":{\"width\":\"2\"}}',13),
(191,29,'equipment_comments','rich_text_box','Observações',0,0,1,1,1,1,'{\"display\":{\"width\":\"12\"}}',28),
(192,29,'created_at','timestamp','Created At',0,0,0,0,0,0,'{}',14),
(193,29,'updated_at','timestamp','Updated At',0,0,0,0,0,0,'{}',15),
(194,29,'deleted_at','timestamp','Deleted At',0,0,0,0,0,0,'{}',17),
(195,29,'equipment_belongsto_sector_relationship','relationship','Setor',0,1,1,1,1,1,'{\"model\":\"App\\\\Sector\",\"table\":\"sectors\",\"type\":\"belongsTo\",\"column\":\"id\",\"key\":\"id\",\"label\":\"location_name\",\"pivot_table\":\"administrators\",\"pivot\":\"0\",\"taggable\":\"0\"}',2),
(196,30,'id','text','Id',1,0,0,0,0,0,'{}',1),
(197,30,'simulator_name','text','Descrição *',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"}}',3),
(198,30,'simulator_manufacturer','text','Fabricante *',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"}}',4),
(199,30,'simulator_model','text','Modelo *',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"}}',5),
(200,30,'simulator_serial_number','text','Nº de Série *',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"}}',6),
(201,30,'simulator_equivalent_thickness','text','Expessura equivalente (cm) *',0,0,1,1,1,1,'{\"display\":{\"width\":\"4\"}}',7),
(202,30,'simulator_comments','text','Observações',0,0,1,1,1,1,'{\"display\":{\"width\":\"12\"}}',8),
(203,30,'created_at','timestamp','Created At',0,0,0,0,0,0,'{}',9),
(204,30,'updated_at','timestamp','Updated At',0,0,0,0,0,0,'{}',10),
(205,30,'deleted_at','timestamp','Deleted At',0,0,0,0,0,0,'{}',11),
(206,30,'simulator_belongsto_sector_relationship','relationship','Serviço',0,1,1,1,1,1,'{\"model\":\"App\\\\Sector\",\"table\":\"sectors\",\"type\":\"belongsTo\",\"column\":\"id\",\"key\":\"id\",\"label\":\"location_name\",\"pivot_table\":\"administrators\",\"pivot\":\"0\",\"taggable\":\"0\"}',2),
(207,31,'id','text','Id',1,0,0,0,0,0,'{}',1),
(208,31,'data','date','Data',0,0,0,0,0,0,'{}',4),
(209,31,'nationality1','text','Nacionalidade do Paciente *',0,0,1,1,1,1,'{\"display\":{\"width\":\"4\"},\"default\":\"Brasileiro\",\"options\":{\"Brasileiro\":\"Brasileiro\",\"Estrangeiro\":\"Estrangeiro\"}}',5),
(210,31,'cpf1','text','CPF *',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"}}',6),
(211,31,'passport1','text','Passaporte / ID (Caso seja Estrangeiro) *',0,0,1,1,1,1,'{\"display\":{\"width\":\"4\"}}',7),
(212,31,'birthdate1','date','Data de nascimento *',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"}}',8),
(213,31,'weight1','number','Peso (Kg) *',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"}}',9),
(214,31,'height1','number','Altura (cm) *',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"}}',10),
(215,31,'gender1','select_dropdown','Sexo *',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"},\"default\":\"\",\"options\":{\"Feminino\":\"Feminino\",\"Masculino\":\"Masculino\",\"Outro\":\"Outro\"}}',11),
(216,31,'exam_number1','text','Nº de registro do Exame *',0,1,1,1,1,1,'{\"display\":{\"width\":\"3\"}}',12),
(217,31,'exam_date1','date','Data do Exame *',0,1,1,1,1,1,'{\"display\":{\"width\":\"3\"}}',13),
(218,31,'total_kerma1','text','Kerma total',0,1,1,1,1,1,'{\"display\":{\"width\":\"2\"}}',14),
(219,31,'total_pka1','text','PKa total',0,1,1,1,1,1,'{\"display\":{\"width\":\"2\"}}',15),
(220,31,'total_time1','number','Tempo total (minutos)',0,0,1,1,1,1,'{\"display\":{\"width\":\"2\"}}',16),
(221,31,'created_at','timestamp','Created At',0,0,0,0,0,0,'{}',17),
(222,31,'updated_at','timestamp','Updated At',0,0,0,0,0,0,'{}',18),
(223,31,'deleted_at','timestamp','Deleted At',0,0,0,0,0,0,'{}',19),
(224,31,'dose_belongsto_sector_relationship','relationship','Setor',0,1,1,1,1,1,'{\"display\":{\"width\":\"6\"},\"model\":\"App\\\\Sector\",\"table\":\"sectors\",\"type\":\"belongsTo\",\"column\":\"id\",\"key\":\"id\",\"label\":\"location_name\",\"pivot_table\":\"administrators\",\"pivot\":\"0\",\"taggable\":\"0\"}',2),
(225,31,'dose_belongsto_equipment_relationship','relationship','Equipamento',0,1,1,1,1,1,'{\"display\":{\"width\":\"6\"},\"model\":\"App\\\\Equipment\",\"table\":\"equipment\",\"type\":\"belongsTo\",\"column\":\"id\",\"key\":\"id\",\"label\":\"equipment_model\",\"pivot_table\":\"administrators\",\"pivot\":\"0\",\"taggable\":\"0\"}',3),
(226,32,'id','text','Id',1,0,0,0,0,0,'{}',1),
(227,32,'exam_type','text','Descrição do Exame *',0,1,1,1,1,1,'{\"display\":{\"width\":\"6\"}}',3),
(228,32,'average_at_month','text','Média de Exames realizados no mês *',0,1,1,1,1,1,'{\"display\":{\"width\":\"6\"}}',4),
(229,32,'exam_comments','rich_text_box','Observações',0,1,1,1,1,1,'{}',5),
(230,32,'created_at','timestamp','Created At',0,0,0,0,0,0,'{}',6),
(231,32,'updated_at','timestamp','Updated At',0,0,0,0,0,0,'{}',7),
(232,32,'deleted_at','timestamp','Deleted At',0,0,0,0,0,0,'{}',8),
(233,32,'procedure_belongsto_sector_relationship','relationship','Serviço',0,1,1,1,1,1,'{\"model\":\"App\\\\Sector\",\"table\":\"sectors\",\"type\":\"belongsTo\",\"column\":\"id\",\"key\":\"id\",\"label\":\"location_name\",\"pivot_table\":\"administrators\",\"pivot\":\"0\",\"taggable\":\"0\"}',2),
(237,31,'dose_belongstomany_procedure_relationship','relationship','Procedimentos aplicados',0,1,1,1,1,1,'{\"model\":\"App\\\\Procedure\",\"table\":\"procedures\",\"type\":\"belongsToMany\",\"column\":\"id\",\"key\":\"id\",\"label\":\"exam_type\",\"pivot_table\":\"doses_procedures\",\"pivot\":\"1\",\"taggable\":\"0\"}',20),
(238,31,'dose_belongstomany_professional_relationship','relationship','Profissionais do Procedimento',0,1,1,1,1,1,'{\"model\":\"App\\\\Professional\",\"table\":\"professionals\",\"type\":\"belongsToMany\",\"column\":\"id\",\"key\":\"id\",\"label\":\"person_name\",\"pivot_table\":\"doses_professionals\",\"pivot\":\"1\",\"taggable\":\"0\"}',21),
(239,33,'id','text','Num. Evento',1,1,1,0,0,0,'{\"display\":{\"width\":\"2\"}}',1),
(240,33,'data_ocorrencia','date','Data do Evento',0,1,1,1,1,1,'{\"display\":{\"width\":\"3\"}}',2),
(241,33,'local_ocorrencia','text','Local',0,1,1,1,1,1,'{\"display\":{\"width\":\"6\"}}',4),
(242,33,'setor_departamento','text','Setor/Departamento',0,1,1,1,1,1,'{\"display\":{\"width\":\"6\"}}',5),
(243,33,'descricao_ocorrencia','rich_text_box','Descrição do Ocorrido',0,1,1,1,1,1,'{\"display\":{\"width\":\"12\"}}',6),
(244,33,'acoes_corretivas','rich_text_box','Ações Corretivas',0,1,1,1,1,1,'{\"display\":{\"width\":\"12\"}}',7),
(245,33,'acoes_preventivas','rich_text_box','Ações Preventivas',0,1,1,1,1,1,'{\"display\":{\"width\":\"12\"}}',8),
(246,33,'gravidade_ocorrencia','select_dropdown','Gravidade',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"},\"default\":\"Baixa gravidade\",\"options\":{\"Baixa gravidade\":\"Baixa gravidade\",\"M\\u00e9dia gravidade\":\"M\\u00e9dia gravidade\",\"Alta gravidade\":\"Alta gravidade\"}}',9),
(247,33,'impacto_ocorrencia','select_dropdown','Impacto Ocorrencia',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"},\"default\":\"Baixo impacto\",\"options\":{\"Baixo impacto\":\"Baixo impacto\",\"M\\u00e9dio impacto\":\"M\\u00e9dio impacto\",\"Alto impacto\":\"Alto impacto\"}}',10),
(248,33,'created_at','timestamp','Created At',0,0,0,0,0,0,'{}',11),
(249,33,'updated_at','timestamp','Updated At',0,0,0,0,0,0,'{}',12),
(250,33,'deleted_at','timestamp','Deleted At',0,0,0,0,0,0,'{}',13),
(251,33,'horario_ocorrencia','time','Horario',0,1,1,1,1,1,'{\"display\":{\"width\":\"3\"}}',3),
(252,33,'event_belongsto_professional_relationship','relationship','Responsável por implementar as ações corretivas',0,1,1,1,1,1,'{\"model\":\"App\\\\Professional\",\"table\":\"professionals\",\"type\":\"belongsTo\",\"column\":\"id\",\"key\":\"id\",\"label\":\"person_name\",\"pivot_table\":\"administrators\",\"pivot\":\"0\",\"taggable\":\"0\"}',14),
(253,33,'event_belongsto_professional_relationship_1','relationship','esponsável por monitorar a eficácia das ações',0,1,1,1,1,1,'{\"model\":\"App\\\\Professional\",\"table\":\"professionals\",\"type\":\"belongsTo\",\"column\":\"id\",\"key\":\"id\",\"label\":\"person_name\",\"pivot_table\":\"administrators\",\"pivot\":\"0\",\"taggable\":\"0\"}',15),
(254,29,'RFID','text','RFID',0,1,1,1,1,1,'{\"display\":{\"width\":\"2\"}}',16),
(255,29,'patrimonio','text','Patrimonio',0,1,1,1,1,1,'{\"display\":{\"width\":\"2\"}}',18),
(256,29,'data_instalacao','date','Data Instalacao',0,1,1,1,1,1,'{\"display\":{\"width\":\"2\"}}',19),
(257,29,'data_aquisicao','date','Data Aquisicao',0,1,1,1,1,1,'{\"display\":{\"width\":\"2\"}}',20),
(258,29,'manual','file','Manual',0,1,1,1,1,1,'{\"display\":{\"width\":\"2\"}}',21),
(259,29,'documentos_adicionais','file','Documentos Adicionais',0,1,1,1,1,1,'{\"display\":{\"width\":\"2\"}}',22),
(260,29,'acessorios','rich_text_box','Acessórios',0,1,1,1,1,1,'{}',23),
(261,29,'ultima_manutencao_preventiva','date','Ultima Manutencao Preventiva',0,1,1,1,1,1,'{\"display\":{\"width\":\"6\"}}',24),
(262,29,'proxima_manutencao_preventiva','date','Proxima Manutencao Preventiva',0,1,1,1,1,1,'{\"display\":{\"width\":\"6\"}}',25),
(263,29,'descricao_ultima_manutencao','rich_text_box','Descrição Ultima Manutenção',0,1,1,1,1,1,'{}',26),
(264,29,'eventos_adversos','rich_text_box','Eventos Adversos',0,1,1,1,1,1,'{}',27),
(265,26,'estado_civil','text','Estado Civil',0,1,1,1,1,1,'{\"display\":{\"width\":\"3\"},\"default\":\"Solteiro\",\"options\":{\"Solteiro\":\"Solteiro\",\"Casado\":\"Casado\",\"Divorciado\":\"Divorciado\",\"Vi\\u00favo\":\"Vi\\u00favo\",\"Uni\\u00e3o Est\\u00e1vel\":\"Uni\\u00e3o Est\\u00e1vel\",\"Separado\":\"Separado\"}}',16),
(266,26,'endereco_residencial','text_area','Endereco Residencial',0,0,1,1,1,1,'{}',17),
(267,26,'telefone','text','Telefone',0,0,1,1,1,1,'{\"display\":{\"width\":\"3\"}}',18),
(268,26,'email','text','Email',0,0,1,1,1,1,'{\"display\":{\"width\":\"3\"}}',19),
(269,26,'historico_medico','rich_text_box','Histórico Médico',0,0,1,1,1,1,'{}',20),
(270,26,'exames_medicos','file','Exames Médicos',0,0,1,1,1,1,'{\"display\":{\"width\":\"3\"}}',21),
(271,26,'habilidades','rich_text_box','Habilidades',0,0,1,1,1,1,'{}',22),
(272,26,'historico_profissional','rich_text_box','Historico Profissional',0,0,1,1,1,1,'{}',23),
(273,26,'contato_emergencia','text_area','Contato Emergência',0,0,1,1,1,1,'{}',24),
(274,26,'historico_seguranca','rich_text_box','Histórico de acidentes de trabalho ou lesões',0,0,1,1,1,1,'{}',25),
(275,26,'PCMSO','file','PCMSO',0,0,1,1,1,1,'{\"display\":{\"width\":\"3\"}}',26),
(276,26,'ASO','file','ASO',0,0,1,1,1,1,'{\"display\":{\"width\":\"3\"}}',27),
(277,26,'VACINAS','rich_text_box','Histórico de Vacinação',0,0,1,1,1,1,'{}',28),
(278,34,'id','text','Id',1,0,0,0,0,0,'{}',1),
(279,34,'data_pericia','date','Data Perícia',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"}}',3),
(280,34,'tipo_pericia','select_dropdown','Tipo Perícia',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"},\"default\":\"Exame m\\u00e9dico\",\"options\":{\"Exame m\\u00e9dico\":\"Exame m\\u00e9dico\",\"Exame laboratorial\":\"Exame laboratorial\",\"Exame psicol\\u00f3gico\":\"Exame psicol\\u00f3gico\",\"Avalia\\u00e7\\u00e3o audiom\\u00e9trica\":\"Avalia\\u00e7\\u00e3o audiom\\u00e9trica\",\"Avalia\\u00e7\\u00e3o oftalmol\\u00f3gica\":\"Avalia\\u00e7\\u00e3o oftalmol\\u00f3gica\",\"Avalia\\u00e7\\u00e3o postural\":\"Avalia\\u00e7\\u00e3o postural\",\"Avalia\\u00e7\\u00e3o cardiol\\u00f3gica\":\"Avalia\\u00e7\\u00e3o cardiol\\u00f3gica\",\"Avalia\\u00e7\\u00e3o pulmonar\":\"Avalia\\u00e7\\u00e3o pulmonar\",\"Avalia\\u00e7\\u00e3o dermatol\\u00f3gica\":\"Avalia\\u00e7\\u00e3o dermatol\\u00f3gica\",\"Avalia\\u00e7\\u00e3o neurol\\u00f3gica\":\"Avalia\\u00e7\\u00e3o neurol\\u00f3gica\",\"Avalia\\u00e7\\u00e3o de aptid\\u00e3o f\\u00edsica\":\"Avalia\\u00e7\\u00e3o de aptid\\u00e3o f\\u00edsica\",\"Avalia\\u00e7\\u00e3o de capacidade laborativa\":\"Avalia\\u00e7\\u00e3o de capacidade laborativa\"}}',4),
(281,34,'descricao_pericia','rich_text_box','Descrição Perícia',0,0,1,1,1,1,'{}',5),
(282,34,'resultado_pericia','rich_text_box','Resultado Perícia',0,0,1,1,1,1,'{}',6),
(283,34,'acoes_recomendadas','rich_text_box','Ações Recomendadas',0,0,1,1,1,1,'{}',7),
(284,34,'created_at','timestamp','Cadastrado em:',0,1,0,0,0,0,'{}',8),
(285,34,'updated_at','timestamp','Updated At',0,0,0,0,0,0,'{}',9),
(286,34,'deleted_at','timestamp','Deleted At',0,0,0,0,0,0,'{}',10),
(287,34,'pericia_belongsto_professional_relationship','relationship','Funcionário',0,1,1,1,1,1,'{\"model\":\"App\\\\Professional\",\"table\":\"professionals\",\"type\":\"belongsTo\",\"column\":\"id\",\"key\":\"id\",\"label\":\"person_name\",\"pivot_table\":\"administrators\",\"pivot\":\"0\",\"taggable\":\"0\"}',2),
(288,35,'id','text','Id',1,0,0,0,0,0,'{}',1),
(289,35,'data_acao','date','Data da Ação',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"}}',3),
(290,35,'descricao_acao','rich_text_box','Descrição da  Ação',0,0,1,1,1,1,'{}',4),
(291,35,'tipo_acao','select_dropdown','Tipo Ação',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"},\"default\":\"Processo trabalhista\",\"options\":{\"Processo trabalhista\":\"Processo trabalhista\",\"Reclama\\u00e7\\u00e3o trabalhista\":\"Reclama\\u00e7\\u00e3o trabalhista\",\"Den\\u00fancia ao Minist\\u00e9rio do Trabalho\":\"Den\\u00fancia ao Minist\\u00e9rio do Trabalho\",\"Inqu\\u00e9rito civil\":\"Inqu\\u00e9rito civil\",\"Termo de ajustamento de conduta\":\"Termo de ajustamento de conduta\",\"Mandado de seguran\\u00e7a\":\"Mandado de seguran\\u00e7a\",\"Habeas corpus\":\"Habeas corpus\",\"A\\u00e7\\u00e3o rescis\\u00f3ria\":\"A\\u00e7\\u00e3o rescis\\u00f3ria\",\"A\\u00e7\\u00e3o anulat\\u00f3ria\":\"A\\u00e7\\u00e3o anulat\\u00f3ria\",\"A\\u00e7\\u00e3o cautelar\":\"A\\u00e7\\u00e3o cautelar\",\"A\\u00e7\\u00e3o de consigna\\u00e7\\u00e3o em pagamento\":\"A\\u00e7\\u00e3o de consigna\\u00e7\\u00e3o em pagamento\",\"A\\u00e7\\u00e3o declarat\\u00f3ria\":\"A\\u00e7\\u00e3o declarat\\u00f3ria\",\"A\\u00e7\\u00e3o monit\\u00f3ria\":\"A\\u00e7\\u00e3o monit\\u00f3ria\",\"A\\u00e7\\u00e3o revisional de contrato\":\"A\\u00e7\\u00e3o revisional de contrato\",\"Embargos \\u00e0 execu\\u00e7\\u00e3o\":\"Embargos \\u00e0 execu\\u00e7\\u00e3o\",\"Embargos de terceiro\":\"Embargos de terceiro\",\"Recurso ordin\\u00e1rio\":\"Recurso ordin\\u00e1rio\",\"Recurso de revista\":\"Recurso de revista\",\"Recurso de embargos\":\"Recurso de embargos\",\"Outro\":\"Outro\"}}',5),
(292,35,'status_acao','select_dropdown','Status da Ação',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"},\"default\":\"Pendente\",\"options\":{\"Pendente\":\"Pendente\",\"Em andamento\":\"Em andamento\",\"Arquivado\":\"Arquivado\",\"Resolvido\":\"Resolvido\",\"Suspenso\":\"Suspenso\",\"Cancelado\":\"Cancelado\",\"Abandonado\":\"Abandonado\",\"Conclu\\u00eddo com acordo\":\"Conclu\\u00eddo com acordo\",\"Conclu\\u00eddo com decis\\u00e3o judicial\":\"Conclu\\u00eddo com decis\\u00e3o judicial\",\"Conclu\\u00eddo com desist\\u00eancia\":\"Conclu\\u00eddo com desist\\u00eancia\",\"Conclu\\u00eddo com concilia\\u00e7\\u00e3o\":\"Conclu\\u00eddo com concilia\\u00e7\\u00e3o\",\"Conclu\\u00eddo com improced\\u00eancia\":\"Conclu\\u00eddo com improced\\u00eancia\",\"Conclu\\u00eddo com proced\\u00eancia parcial\":\"Conclu\\u00eddo com proced\\u00eancia parcial\",\"Conclu\\u00eddo com proced\\u00eancia total\":\"Conclu\\u00eddo com proced\\u00eancia total\",\"Outro\":\"Outro\"}}',6),
(293,35,'resultado_acao','rich_text_box','Resultado da ação',0,0,1,1,1,1,'{}',7),
(294,35,'acoes_recomendadas','rich_text_box','Ações recomendadas',0,0,1,1,1,1,'{}',8),
(295,35,'created_at','timestamp','Created At',0,0,0,0,0,0,'{}',9),
(296,35,'updated_at','timestamp','Updated At',0,0,0,0,0,0,'{}',10),
(297,35,'deleted_at','timestamp','Deleted At',0,0,0,0,0,0,'{}',11),
(298,35,'trabalhista_belongsto_professional_relationship','relationship','Funcionário',0,1,1,1,1,1,'{\"model\":\"App\\\\Professional\",\"table\":\"professionals\",\"type\":\"belongsTo\",\"column\":\"id\",\"key\":\"id\",\"label\":\"person_name\",\"pivot_table\":\"administrators\",\"pivot\":\"0\",\"taggable\":\"0\"}',2),
(299,36,'id','text','Id',1,0,0,0,0,0,'{}',2),
(300,36,'tipo','select_dropdown','Tipo de Treinamento',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"},\"default\":\"Treinamento de seguran\\u00e7a\",\"options\":{\"Treinamento de opera\\u00e7\\u00e3o de aparelhos\":\"Treinamento de opera\\u00e7\\u00e3o de aparelhos\",\"Treinamento de prote\\u00e7\\u00e3o radiol\\u00f3gica\":\"Treinamento de prote\\u00e7\\u00e3o radiol\\u00f3gica\",\"Treinamento de uso de dosimetria pessoal\":\"Treinamento de uso de dosimetria pessoal\",\"Treinamento de uso de EPI\":\"Treinamento de uso de EPI\",\"Treinamento de desinfec\\u00e7\\u00e3o\":\"Treinamento de desinfec\\u00e7\\u00e3o\",\"Treinamento administrativo\":\"Treinamento administrativo\",\"Treinamento de compras\":\"Treinamento de compras\",\"Treinamento de seguran\\u00e7a biol\\u00f3gica\":\"Treinamento de seguran\\u00e7a biol\\u00f3gica\",\"Treinamento de primeiros socorros\":\"Treinamento de primeiros socorros\",\"Treinamento de preven\\u00e7\\u00e3o de inc\\u00eandios\":\"Treinamento de preven\\u00e7\\u00e3o de inc\\u00eandios\",\"Treinamento de ergonomia\":\"Treinamento de ergonomia\",\"Treinamento de preven\\u00e7\\u00e3o de acidentes\":\"Treinamento de preven\\u00e7\\u00e3o de acidentes\",\"Treinamento de cuidados com pacientes especiais\":\"Treinamento de cuidados com pacientes especiais\",\"Treinamento de biosseguran\\u00e7a\":\"Treinamento de biosseguran\\u00e7a\",\"Treinamento de gest\\u00e3o de res\\u00edduos\":\"Treinamento de gest\\u00e3o de res\\u00edduos\",\"Treinamento de sa\\u00fade mental\":\"Treinamento de sa\\u00fade mental\",\"Treinamento de comunica\\u00e7\\u00e3o em sa\\u00fade\":\"Treinamento de comunica\\u00e7\\u00e3o em sa\\u00fade\",\"Treinamento de qualidade em sa\\u00fade\":\"Treinamento de qualidade em sa\\u00fade\",\"Treinamento de lideran\\u00e7a em sa\\u00fade\":\"Treinamento de lideran\\u00e7a em sa\\u00fade\",\"Treinamento de preven\\u00e7\\u00e3o de doen\\u00e7as infectocontagiosas\":\"Treinamento de preven\\u00e7\\u00e3o de doen\\u00e7as infectocontagiosas\",\"Treinamento de higiene pessoal\":\"Treinamento de higiene pessoal\",\"Treinamento de cuidados com idosos\":\"Treinamento de cuidados com idosos\",\"Treinamento de cuidados com crian\\u00e7as\":\"Treinamento de cuidados com crian\\u00e7as\",\"Treinamento de cuidados com animais de estima\\u00e7\\u00e3o\":\"Treinamento de cuidados com animais de estima\\u00e7\\u00e3o\",\"Treinamento de nutri\\u00e7\\u00e3o em sa\\u00fade\":\"Treinamento de nutri\\u00e7\\u00e3o em sa\\u00fade\",\"Treinamento de fisioterapia\":\"Treinamento de fisioterapia\",\"Treinamento de terapia ocupacional\":\"Treinamento de terapia ocupacional\",\"Treinamento de psicologia em sa\\u00fade\":\"Treinamento de psicologia em sa\\u00fade\",\"Treinamento de odontologia em sa\\u00fade\":\"Treinamento de odontologia em sa\\u00fade\",\"Treinamento de enfermagem em sa\\u00fade\":\"Treinamento de enfermagem em sa\\u00fade\",\"Treinamento de medicina em sa\\u00fade\":\"Treinamento de medicina em sa\\u00fade\"}}',3),
(301,36,'data','date','Data do Treinamento',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"}}',4),
(302,36,'inicio','time','Início',0,0,1,1,1,1,'{\"display\":{\"width\":\"2\"}}',5),
(303,36,'fim','time','Fim',0,0,1,1,1,1,'{\"display\":{\"width\":\"2\"}}',6),
(304,36,'observacoes','rich_text_box','Observações',0,0,1,1,1,1,'{}',7),
(305,36,'created_at','timestamp','Created At',0,0,0,0,0,0,'{}',9),
(306,36,'updated_at','timestamp','Updated At',0,0,0,0,0,0,'{}',10),
(307,36,'deleted_at','timestamp','Deleted At',0,0,0,0,0,0,'{}',11),
(309,36,'Anexo','file','Anexo',0,0,1,1,1,1,'{\"display\":{\"width\":\"2\"}}',8),
(310,36,'treinamento_belongsto_equipment_relationship','relationship','Treino sobre Equipamento?',0,0,1,1,1,1,'{\"model\":\"App\\\\Equipment\",\"table\":\"equipment\",\"type\":\"belongsTo\",\"column\":\"id\",\"key\":\"id\",\"label\":\"equipment_model\",\"pivot_table\":\"administrators\",\"pivot\":\"0\",\"taggable\":\"0\"}',12),
(311,37,'id','text','Id',1,0,0,0,0,0,'{}',2),
(312,37,'data','date','Data do Relatório',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"}}',3),
(313,37,'vencimento','date','Data de Vencimento',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"}}',4),
(314,37,'tipo','select_dropdown','Tipo de Relatório',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"},\"default\":\"\",\"options\":{\"Controle de Qualidade\":\"Controle de Qualidade\",\"Levantamento Radiom\\u00e9trico\":\"Levantamento Radiom\\u00e9trico\",\"C\\u00e1lculo de Blindagem\":\"C\\u00e1lculo de Blindagem\",\"Memorial Descritivo\":\"Memorial Descritivo\"}}',5),
(315,37,'status','select_dropdown','Status',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"},\"default\":\"Conforme\",\"options\":{\"Conforme\":\"Conforme\",\"N\\u00e3o Conforme\":\"N\\u00e3o Conforme\",\"N\\u00edvel de Suspens\\u00e3o\":\"N\\u00edvel de Suspens\\u00e3o\",\"Linha de Base\":\"Linha de Base\"}}',6),
(316,37,'observacoes','rich_text_box','Observacoes',0,1,1,1,1,1,'{}',7),
(317,37,'anexo','file','Anexo',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"}}',8),
(318,37,'created_at','timestamp','Created At',0,0,0,0,0,0,'{}',9),
(319,37,'updated_at','timestamp','Updated At',0,0,0,0,0,0,'{}',10),
(320,37,'deleted_at','timestamp','Deleted At',0,0,0,0,0,0,'{}',11),
(321,37,'relatorio_belongsto_equipment_relationship','relationship','Equipamento',0,1,1,1,1,1,'{\"model\":\"App\\\\Equipment\",\"table\":\"equipment\",\"type\":\"belongsTo\",\"column\":\"id\",\"key\":\"id\",\"label\":\"equipment_model\",\"pivot_table\":\"administrators\",\"pivot\":\"0\",\"taggable\":\"0\"}',1),
(322,38,'id','text','Id',1,0,0,0,0,0,'{}',1),
(323,38,'titulo','text','Título',0,1,1,1,1,1,'{\"display\":{\"width\":\"8\"}}',2),
(324,38,'numero','text','Número',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"}}',3),
(325,38,'data','date','Data de Publicação',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"}}',4),
(326,38,'status','select_dropdown','Status',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"},\"default\":\"Conforme\",\"options\":{\"Ativa\":\"Ativa\",\"Revogada\":\"Revogada\"}}',5),
(327,38,'anexo','file','Anexo',0,1,1,1,1,1,'{}',7),
(328,38,'link','text','Link',0,1,1,1,1,1,'{}',6),
(329,38,'observacoes','rich_text_box','Observações',0,1,1,1,1,1,'{}',8),
(330,38,'created_at','timestamp','Created At',0,0,0,0,0,0,'{}',9),
(331,38,'updated_at','timestamp','Updated At',0,0,0,0,0,0,'{}',10),
(332,38,'deleted_at','timestamp','Deleted At',0,0,0,0,0,0,'{}',11),
(333,39,'id','text','Id',1,0,0,0,0,0,'{}',1),
(334,39,'data','date','Data',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"}}',3),
(335,39,'micro','number','Micro',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"}}',7),
(336,39,'massa','number','Massa',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"}}',8),
(337,39,'kVp','number','KVp',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"}}',4),
(338,39,'mAs','number','mAs',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"}}',5),
(339,39,'DEP','text','DEP',0,1,1,1,1,1,'{\"display\":{\"width\":\"6\"}}',9),
(340,39,'DGM','text','DGM',0,1,1,1,1,1,'{\"display\":{\"width\":\"6\"}}',10),
(341,39,'fibra','number','Fibra',0,1,1,1,1,1,'{\"display\":{\"width\":\"4\"}}',6),
(342,39,'observacao','rich_text_box','Observacao',0,1,1,1,1,1,'{}',11),
(343,39,'created_at','timestamp','Created At',0,0,0,0,0,0,'{}',12),
(344,39,'updated_at','timestamp','Updated At',0,0,0,0,0,0,'{}',13),
(345,39,'deleted_at','timestamp','Deleted At',0,0,0,0,0,0,'{}',14),
(346,39,'mamo_belongsto_equipment_relationship','relationship','Equipamento',0,1,1,1,1,1,'{\"model\":\"App\\\\Equipment\",\"table\":\"equipment\",\"type\":\"belongsTo\",\"column\":\"id\",\"key\":\"id\",\"label\":\"equipment_model\",\"pivot_table\":\"administrators\",\"pivot\":\"0\",\"taggable\":\"0\"}',2),
(347,36,'treinamento_belongstomany_professional_relationship','relationship','professionals',0,1,1,1,1,1,'{\"model\":\"App\\\\Professional\",\"table\":\"professionals\",\"type\":\"belongsToMany\",\"column\":\"id\",\"key\":\"id\",\"label\":\"person_name\",\"pivot_table\":\"treinamentos_professionals\",\"pivot\":\"1\",\"taggable\":\"0\"}',13);
/*!40000 ALTER TABLE `data_rows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_types`
--

DROP TABLE IF EXISTS `data_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `display_name_singular` varchar(255) NOT NULL,
  `display_name_plural` varchar(255) NOT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `model_name` varchar(255) DEFAULT NULL,
  `policy_name` varchar(255) DEFAULT NULL,
  `controller` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `generate_permissions` tinyint(1) NOT NULL DEFAULT 0,
  `server_side` tinyint(4) NOT NULL DEFAULT 0,
  `details` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `data_types_name_unique` (`name`),
  UNIQUE KEY `data_types_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_types`
--

LOCK TABLES `data_types` WRITE;
/*!40000 ALTER TABLE `data_types` DISABLE KEYS */;
INSERT INTO `data_types` VALUES
(1,'users','users','User','Users','voyager-person','TCG\\Voyager\\Models\\User','TCG\\Voyager\\Policies\\UserPolicy','TCG\\Voyager\\Http\\Controllers\\VoyagerUserController','',1,0,NULL,'2023-03-28 17:16:43','2023-03-28 17:16:43'),
(2,'menus','menus','Menu','Menus','voyager-list','TCG\\Voyager\\Models\\Menu',NULL,'','',1,0,NULL,'2023-03-28 17:16:43','2023-03-28 17:16:43'),
(3,'roles','roles','Role','Roles','voyager-lock','TCG\\Voyager\\Models\\Role',NULL,'TCG\\Voyager\\Http\\Controllers\\VoyagerRoleController',NULL,1,0,'{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"desc\",\"default_search_key\":null,\"scope\":null}','2023-03-28 17:16:43','2023-03-28 23:02:42'),
(4,'categories','categories','Category','Categories','voyager-categories','TCG\\Voyager\\Models\\Category',NULL,'','',1,0,NULL,'2023-03-28 17:17:13','2023-03-28 17:17:13'),
(5,'posts','posts','Notícia','Notícias','voyager-news','TCG\\Voyager\\Models\\Post','TCG\\Voyager\\Policies\\PostPolicy',NULL,NULL,1,0,'{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"desc\",\"default_search_key\":null,\"scope\":null}','2023-03-28 17:17:13','2023-03-29 04:45:46'),
(6,'pages','pages','Ata da reunião','Atas de reuniões','voyager-file-text','TCG\\Voyager\\Models\\Page',NULL,NULL,NULL,1,0,'{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"desc\",\"default_search_key\":null,\"scope\":null}','2023-03-28 17:17:13','2023-03-29 04:51:45'),
(11,'usuarios_responsaveis','usuarios-responsaveis','Usuário Responsavel','Usuários Responsáveis','voyager-people',NULL,NULL,NULL,NULL,1,1,'{\"order_column\":\"id\",\"order_display_column\":\"name\",\"order_direction\":\"asc\",\"default_search_key\":\"name\"}','2023-03-28 19:19:29','2023-03-28 19:19:29'),
(20,'administrators','administrators','Responsavel','Responsaveis','voyager-people','App\\Administrator',NULL,NULL,NULL,1,1,'{\"order_column\":\"name\",\"order_display_column\":\"name\",\"order_direction\":\"asc\",\"default_search_key\":\"name\",\"scope\":null}','2023-03-28 21:23:15','2023-03-28 22:28:25'),
(21,'hospitals','hospitals','Instituição','Instituições','voyager-company','App\\Hospital',NULL,NULL,NULL,1,1,'{\"order_column\":\"nomeFantasia\",\"order_display_column\":\"nomeFantasia\",\"order_direction\":\"asc\",\"default_search_key\":\"nomeFantasia\",\"scope\":null}','2023-03-28 22:17:12','2023-03-28 22:37:48'),
(22,'sectors','sectors','Serviço','Serviços','voyager-home','App\\Sector',NULL,NULL,NULL,1,0,'{\"order_column\":\"location_name\",\"order_display_column\":\"location_name\",\"order_direction\":\"asc\",\"default_search_key\":\"location_name\",\"scope\":null}','2023-03-28 23:00:06','2023-03-28 23:50:10'),
(26,'professionals','professionals','Profissional','Profissionais','voyager-watch','App\\Professional',NULL,NULL,NULL,1,1,'{\"order_column\":\"person_name\",\"order_display_column\":\"person_name\",\"order_direction\":\"asc\",\"default_search_key\":\"person_name\",\"scope\":null}','2023-03-29 00:10:28','2023-03-29 03:25:18'),
(29,'equipment','equipment','Equipamento','Equipamentos','voyager-laptop','App\\Equipment',NULL,NULL,NULL,1,1,'{\"order_column\":\"id\",\"order_display_column\":\"equipment_manufacturer\",\"order_direction\":\"asc\",\"default_search_key\":\"equipment_model\",\"scope\":null}','2023-03-29 00:51:46','2023-03-29 03:02:44'),
(30,'simulators','simulators','Simulador','Simuladores','voyager-backpack','App\\Simulator',NULL,NULL,NULL,1,0,'{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}','2023-03-29 01:06:16','2023-03-29 01:09:39'),
(31,'doses','doses','Dose do Paciente','Doses dos Pacientes',NULL,'App\\Dose',NULL,NULL,NULL,1,1,'{\"order_column\":\"data\",\"order_display_column\":\"data\",\"order_direction\":\"asc\",\"default_search_key\":\"data\",\"scope\":null}','2023-03-29 01:19:52','2023-03-29 01:52:00'),
(32,'procedures','procedures','Procedimento','Procedimentos',NULL,'App\\Procedure',NULL,NULL,NULL,1,0,'{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}','2023-03-29 01:33:33','2023-03-29 01:36:42'),
(33,'events','events','Evento Adverso','Eventos Adiversos',NULL,'App\\Event',NULL,NULL,NULL,1,1,'{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}','2023-03-29 02:14:12','2023-03-29 02:26:56'),
(34,'pericias','pericias','Pericia','Pericias','voyager-heart','App\\Pericia',NULL,NULL,NULL,1,1,'{\"order_column\":\"data_pericia\",\"order_display_column\":\"data_pericia\",\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}','2023-03-29 03:37:16','2023-03-29 03:39:00'),
(35,'trabalhistas','trabalhistas','Trabalhista','Trabalhistas','voyager-warning','App\\Trabalhista',NULL,NULL,NULL,1,1,'{\"order_column\":\"data_acao\",\"order_display_column\":\"data_acao\",\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}','2023-03-29 03:50:35','2023-03-29 03:51:30'),
(36,'treinamentos','treinamentos','Treinamento','Treinamentos',NULL,'App\\Treinamento',NULL,NULL,NULL,1,1,'{\"order_column\":\"data\",\"order_display_column\":\"data\",\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}','2023-03-29 04:29:08','2023-03-29 18:33:28'),
(37,'relatorios','relatorios','Relatorio','Relatorios',NULL,'App\\Relatorio',NULL,NULL,NULL,1,1,'{\"order_column\":\"data\",\"order_display_column\":\"data\",\"order_direction\":\"asc\",\"default_search_key\":\"vencimento\",\"scope\":null}','2023-03-29 05:21:23','2023-03-29 05:23:40'),
(38,'normas','normas','Norma','Normas','voyager-book','App\\Norma',NULL,NULL,NULL,1,1,'{\"order_column\":\"titulo\",\"order_display_column\":\"titulo\",\"order_direction\":\"asc\",\"default_search_key\":\"numero\",\"scope\":null}','2023-03-29 05:32:00','2023-03-29 18:25:38'),
(39,'mamos','mamos','CQ Mamo','CQs Mamos',NULL,'App\\Mamo',NULL,NULL,NULL,1,0,'{\"order_column\":\"data\",\"order_display_column\":\"data\",\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}','2023-03-29 05:42:43','2023-03-29 05:43:49');
/*!40000 ALTER TABLE `data_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doses`
--

DROP TABLE IF EXISTS `doses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doses` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `data` date DEFAULT NULL,
  `nationality1` varchar(255) DEFAULT NULL,
  `cpf1` varchar(255) DEFAULT NULL,
  `passport1` varchar(255) DEFAULT NULL,
  `birthdate1` date DEFAULT NULL,
  `weight1` varchar(255) DEFAULT NULL,
  `height1` varchar(255) DEFAULT NULL,
  `gender1` varchar(255) DEFAULT NULL,
  `exam_number1` varchar(255) DEFAULT NULL,
  `exam_date1` date DEFAULT NULL,
  `total_kerma1` varchar(255) DEFAULT NULL,
  `total_pka1` varchar(255) DEFAULT NULL,
  `total_time1` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doses`
--

LOCK TABLES `doses` WRITE;
/*!40000 ALTER TABLE `doses` DISABLE KEYS */;
INSERT INTO `doses` VALUES
(1,NULL,'Brasileiro',NULL,NULL,NULL,NULL,NULL,'Feminino',NULL,NULL,NULL,NULL,NULL,'2023-03-29 01:46:25','2023-03-29 01:46:25',NULL),
(2,NULL,'Brasileiro',NULL,NULL,NULL,NULL,NULL,'Feminino',NULL,NULL,NULL,NULL,NULL,'2023-03-29 01:50:37','2023-03-29 01:50:37',NULL),
(3,NULL,'Brasileiro',NULL,NULL,NULL,NULL,NULL,'Feminino',NULL,NULL,NULL,NULL,NULL,'2023-03-29 01:52:55','2023-03-29 01:52:55',NULL),
(4,NULL,'Brasileiro',NULL,NULL,NULL,NULL,NULL,'Feminino',NULL,NULL,NULL,NULL,NULL,'2023-03-29 18:12:48','2023-03-29 18:12:48',NULL);
/*!40000 ALTER TABLE `doses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doses_procedures`
--

DROP TABLE IF EXISTS `doses_procedures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doses_procedures` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dose_id` int(11) DEFAULT NULL,
  `procedure_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doses_procedures`
--

LOCK TABLES `doses_procedures` WRITE;
/*!40000 ALTER TABLE `doses_procedures` DISABLE KEYS */;
INSERT INTO `doses_procedures` VALUES
(1,2,1),
(2,3,1),
(3,4,1);
/*!40000 ALTER TABLE `doses_procedures` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doses_professionals`
--

DROP TABLE IF EXISTS `doses_professionals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doses_professionals` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dose_id` int(11) DEFAULT NULL,
  `professional_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doses_professionals`
--

LOCK TABLES `doses_professionals` WRITE;
/*!40000 ALTER TABLE `doses_professionals` DISABLE KEYS */;
INSERT INTO `doses_professionals` VALUES
(1,3,1),
(2,4,1);
/*!40000 ALTER TABLE `doses_professionals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `equipment`
--

DROP TABLE IF EXISTS `equipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `equipment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `equipment_modality` varchar(255) DEFAULT NULL,
  `equipment_manufacturer` varchar(255) DEFAULT NULL,
  `equipment_model` varchar(255) DEFAULT NULL,
  `equipment_serial_number` varchar(255) DEFAULT NULL,
  `equipment_health_ministry_register_number` varchar(255) DEFAULT NULL,
  `equipment_room_name` varchar(255) DEFAULT NULL,
  `equipment_pka_unit_measure` varchar(255) DEFAULT NULL,
  `equipment_kerma_unit_measure` varchar(255) DEFAULT NULL,
  `equipment_tension_max_kv` varchar(255) DEFAULT NULL,
  `equipment_tension_max_ma` varchar(255) DEFAULT NULL,
  `equipment_manufacturing_year` varchar(255) DEFAULT NULL,
  `equipment_comments` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `RFID` varchar(255) DEFAULT NULL,
  `patrimonio` varchar(255) DEFAULT NULL,
  `data_instalacao` date DEFAULT NULL,
  `data_aquisicao` date DEFAULT NULL,
  `manual` varchar(255) DEFAULT NULL,
  `documentos_adicionais` varchar(255) DEFAULT NULL,
  `acessorios` text DEFAULT NULL,
  `ultima_manutencao_preventiva` date DEFAULT NULL,
  `proxima_manutencao_preventiva` date DEFAULT NULL,
  `descricao_ultima_manutencao` text DEFAULT NULL,
  `eventos_adversos` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipment`
--

LOCK TABLES `equipment` WRITE;
/*!40000 ALTER TABLE `equipment` DISABLE KEYS */;
INSERT INTO `equipment` VALUES
(1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2023-03-29 00:51:54','2023-03-29 00:51:54',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `equipment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `events` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `data_ocorrencia` date DEFAULT NULL,
  `local_ocorrencia` varchar(255) DEFAULT NULL,
  `setor_departamento` varchar(255) DEFAULT NULL,
  `descricao_ocorrencia` text DEFAULT NULL,
  `acoes_corretivas` text DEFAULT NULL,
  `acoes_preventivas` text DEFAULT NULL,
  `gravidade_ocorrencia` varchar(255) DEFAULT NULL,
  `impacto_ocorrencia` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `horario_ocorrencia` time DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hospital_administrators`
--

DROP TABLE IF EXISTS `hospital_administrators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hospital_administrators` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `hospital_id` int(11) DEFAULT NULL,
  `administrator_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hospital_administrators`
--

LOCK TABLES `hospital_administrators` WRITE;
/*!40000 ALTER TABLE `hospital_administrators` DISABLE KEYS */;
INSERT INTO `hospital_administrators` VALUES
(1,1,1);
/*!40000 ALTER TABLE `hospital_administrators` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hospitals`
--

DROP TABLE IF EXISTS `hospitals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hospitals` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `area_atuacao` varchar(255) DEFAULT NULL,
  `razaoSocial` varchar(255) DEFAULT NULL,
  `nomeFantasia` varchar(255) DEFAULT NULL,
  `cnpj` varchar(255) DEFAULT NULL,
  `cep` varchar(255) DEFAULT NULL,
  `endereco` varchar(255) DEFAULT NULL,
  `bairro` varchar(255) DEFAULT NULL,
  `uf` varchar(255) DEFAULT NULL,
  `ciadade` varchar(255) DEFAULT NULL,
  `telefone` varchar(255) DEFAULT NULL,
  `fax` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `cnes` varchar(255) DEFAULT NULL,
  `entity_type` varchar(255) DEFAULT NULL,
  `types_of_care` varchar(255) DEFAULT NULL,
  `empresas_prestadoras` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hospitals`
--

LOCK TABLES `hospitals` WRITE;
/*!40000 ALTER TABLE `hospitals` DISABLE KEYS */;
INSERT INTO `hospitals` VALUES
(1,'Empresa Prestadora','Fantaria','fantasia',NULL,NULL,NULL,NULL,'AC',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2023-03-28 22:17:23','2023-03-28 22:17:37',NULL),
(2,'Empresa Prestadora','fan','fasfas',NULL,NULL,NULL,NULL,'AC',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2023-03-28 23:04:38','2023-03-28 23:04:38',NULL);
/*!40000 ALTER TABLE `hospitals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mamos`
--

DROP TABLE IF EXISTS `mamos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mamos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `data` date DEFAULT NULL,
  `micro` varchar(255) DEFAULT NULL,
  `massa` varchar(255) DEFAULT NULL,
  `kVp` varchar(255) DEFAULT NULL,
  `mAs` varchar(255) DEFAULT NULL,
  `DEP` varchar(255) DEFAULT NULL,
  `DGM` varchar(255) DEFAULT NULL,
  `fibra` varchar(255) DEFAULT NULL,
  `observacao` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mamos`
--

LOCK TABLES `mamos` WRITE;
/*!40000 ALTER TABLE `mamos` DISABLE KEYS */;
/*!40000 ALTER TABLE `mamos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_items`
--

DROP TABLE IF EXISTS `menu_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `menu_id` int(10) unsigned DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `target` varchar(255) NOT NULL DEFAULT '_self',
  `icon_class` varchar(255) DEFAULT NULL,
  `color` varchar(255) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `order` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `route` varchar(255) DEFAULT NULL,
  `parameters` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `menu_items_menu_id_foreign` (`menu_id`),
  CONSTRAINT `menu_items_menu_id_foreign` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_items`
--

LOCK TABLES `menu_items` WRITE;
/*!40000 ALTER TABLE `menu_items` DISABLE KEYS */;
INSERT INTO `menu_items` VALUES
(1,1,'Dashboard','','_self','voyager-boat',NULL,NULL,1,'2023-03-28 17:16:44','2023-03-28 17:16:44','voyager.dashboard',NULL),
(2,1,'Media','','_self','voyager-images',NULL,NULL,5,'2023-03-28 17:16:44','2023-03-28 17:16:44','voyager.media.index',NULL),
(3,1,'Users','','_self','voyager-person',NULL,NULL,3,'2023-03-28 17:16:44','2023-03-28 17:16:44','voyager.users.index',NULL),
(4,1,'Roles','','_self','voyager-lock',NULL,NULL,2,'2023-03-28 17:16:44','2023-03-28 17:16:44','voyager.roles.index',NULL),
(5,1,'Tools','','_self','voyager-tools',NULL,NULL,9,'2023-03-28 17:16:44','2023-03-28 17:16:44',NULL,NULL),
(6,1,'Menu Builder','','_self','voyager-list',NULL,5,10,'2023-03-28 17:16:44','2023-03-28 17:16:44','voyager.menus.index',NULL),
(7,1,'Database','','_self','voyager-data',NULL,5,11,'2023-03-28 17:16:44','2023-03-28 17:16:44','voyager.database.index',NULL),
(8,1,'Compass','','_self','voyager-compass',NULL,5,12,'2023-03-28 17:16:44','2023-03-28 17:16:44','voyager.compass.index',NULL),
(9,1,'BREAD','','_self','voyager-bread',NULL,5,13,'2023-03-28 17:16:44','2023-03-28 17:16:44','voyager.bread.index',NULL),
(10,1,'Settings','','_self','voyager-settings',NULL,NULL,14,'2023-03-28 17:16:44','2023-03-28 17:16:44','voyager.settings.index',NULL),
(11,1,'Categories','','_self','voyager-categories',NULL,NULL,8,'2023-03-28 17:17:13','2023-03-28 17:17:13','voyager.categories.index',NULL),
(12,1,'Posts','','_self','voyager-news',NULL,NULL,6,'2023-03-28 17:17:13','2023-03-28 17:17:13','voyager.posts.index',NULL),
(13,1,'Pages','','_self','voyager-file-text',NULL,NULL,7,'2023-03-28 17:17:13','2023-03-28 17:17:13','voyager.pages.index',NULL),
(14,3,'Sierbp','https://sierbp.saude.sc.gov.br/sieri','_blank',NULL,'#000000',NULL,15,'2023-03-28 18:21:37','2023-03-28 18:21:37',NULL,''),
(21,1,'Responsaveis','','_self','voyager-people',NULL,NULL,16,'2023-03-28 21:23:15','2023-03-28 21:23:15','voyager.administrators.index',NULL),
(22,1,'Instituições','','_self','voyager-company',NULL,NULL,17,'2023-03-28 22:17:12','2023-03-28 22:17:12','voyager.hospitals.index',NULL),
(23,1,'Serviços','','_self','voyager-home',NULL,NULL,18,'2023-03-28 23:00:06','2023-03-28 23:00:06','voyager.sectors.index',NULL),
(26,1,'Professionals','','_self',NULL,NULL,NULL,19,'2023-03-29 00:10:28','2023-03-29 00:10:28','voyager.professionals.index',NULL),
(29,1,'Equipment','','_self',NULL,NULL,NULL,20,'2023-03-29 00:51:46','2023-03-29 00:51:46','voyager.equipment.index',NULL),
(30,1,'Simuladores','','_self','voyager-backpack',NULL,NULL,21,'2023-03-29 01:06:17','2023-03-29 01:06:17','voyager.simulators.index',NULL),
(31,1,'Doses dos Pacientes','','_self',NULL,NULL,NULL,22,'2023-03-29 01:19:52','2023-03-29 01:19:52','voyager.doses.index',NULL),
(32,1,'Procedimentos','','_self',NULL,NULL,NULL,23,'2023-03-29 01:33:33','2023-03-29 01:33:33','voyager.procedures.index',NULL),
(33,1,'Arquivos','admin/media','_self','area-chart','#000000',NULL,24,'2023-03-29 02:00:05','2023-03-29 02:00:29',NULL,''),
(34,1,'Events','','_self',NULL,NULL,NULL,25,'2023-03-29 02:14:12','2023-03-29 02:14:12','voyager.events.index',NULL),
(35,1,'Pericias','','_self','voyager-heart',NULL,NULL,26,'2023-03-29 03:37:16','2023-03-29 03:37:16','voyager.pericias.index',NULL),
(36,1,'Trabalhistas','','_self','voyager-warning',NULL,NULL,27,'2023-03-29 03:50:35','2023-03-29 03:50:35','voyager.trabalhistas.index',NULL),
(37,1,'Treinamentos','','_self',NULL,NULL,NULL,28,'2023-03-29 04:29:08','2023-03-29 04:29:08','voyager.treinamentos.index',NULL),
(38,4,'Treinamentos','/admin/treinamentos','_self','voyager-megaphone','#000000',NULL,1,'2023-03-29 04:59:00','2023-03-29 05:00:08',NULL,''),
(39,4,'Perícias','/admin/pericias','_self','voyager-heart','#000000',NULL,29,'2023-03-29 05:00:56','2023-03-29 05:00:56',NULL,''),
(40,4,'Processos Trabalhistas','/admin/trabalhistas','_self','voyager-receipt','#000000',NULL,30,'2023-03-29 05:02:04','2023-03-29 05:02:04',NULL,''),
(41,4,'Profissionais','/admin/professionals','_self','voyager-people','#000000',NULL,31,'2023-03-29 05:02:59','2023-03-29 05:02:59',NULL,''),
(42,1,'Relatorios','','_self',NULL,NULL,NULL,32,'2023-03-29 05:21:23','2023-03-29 05:21:23','voyager.relatorios.index',NULL),
(43,1,'Normas','','_self','voyager-book',NULL,NULL,33,'2023-03-29 05:32:00','2023-03-29 05:32:00','voyager.normas.index',NULL),
(44,1,'CQs Mamos','','_self',NULL,NULL,NULL,34,'2023-03-29 05:42:43','2023-03-29 05:42:43','voyager.mamos.index',NULL),
(45,4,'Midia','admin/media','_self',NULL,'#000000',NULL,35,'2023-03-29 18:05:06','2023-03-29 18:05:06',NULL,'');
/*!40000 ALTER TABLE `menu_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menus`
--

DROP TABLE IF EXISTS `menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menus` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `menus_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menus`
--

LOCK TABLES `menus` WRITE;
/*!40000 ALTER TABLE `menus` DISABLE KEYS */;
INSERT INTO `menus` VALUES
(1,'admin','2023-03-28 17:16:44','2023-03-28 17:16:44'),
(2,'Engenharia Clínica','2023-03-28 18:20:21','2023-03-28 18:20:21'),
(3,'Física Médica','2023-03-28 18:21:18','2023-03-29 04:57:35'),
(4,'Segurança do Trabalho','2023-03-29 04:57:22','2023-03-29 04:57:22');
/*!40000 ALTER TABLE `menus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES
(1,'2014_10_12_000000_create_users_table',1),
(2,'2014_10_12_100000_create_password_resets_table',1),
(3,'2016_01_01_000000_add_voyager_user_fields',1),
(4,'2016_01_01_000000_create_data_types_table',1),
(5,'2016_05_19_173453_create_menu_table',1),
(6,'2016_10_21_190000_create_roles_table',1),
(7,'2016_10_21_190000_create_settings_table',1),
(8,'2016_11_30_135954_create_permission_table',1),
(9,'2016_11_30_141208_create_permission_role_table',1),
(10,'2016_12_26_201236_data_types__add__server_side',1),
(11,'2017_01_13_000000_add_route_to_menu_items_table',1),
(12,'2017_01_14_005015_create_translations_table',1),
(13,'2017_01_15_000000_make_table_name_nullable_in_permissions_table',1),
(14,'2017_03_06_000000_add_controller_to_data_types_table',1),
(15,'2017_04_21_000000_add_order_to_data_rows_table',1),
(16,'2017_07_05_210000_add_policyname_to_data_types_table',1),
(17,'2017_08_05_000000_add_group_to_settings_table',1),
(18,'2017_11_26_013050_add_user_role_relationship',1),
(19,'2017_11_26_015000_create_user_roles_table',1),
(20,'2018_03_11_000000_add_user_settings',1),
(21,'2018_03_14_000000_add_details_to_data_types_table',1),
(22,'2018_03_16_000000_make_settings_value_nullable',1),
(23,'2019_08_19_000000_create_failed_jobs_table',1),
(24,'2019_12_14_000001_create_personal_access_tokens_table',1),
(25,'2016_01_01_000000_create_pages_table',2),
(26,'2016_01_01_000000_create_posts_table',2),
(27,'2016_02_15_204651_create_categories_table',2),
(28,'2017_04_11_000000_alter_post_nullable_fields_table',2);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `normas`
--

DROP TABLE IF EXISTS `normas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `normas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `titulo` varchar(255) DEFAULT NULL,
  `numero` varchar(255) DEFAULT NULL,
  `data` date DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `anexo` varchar(255) DEFAULT NULL,
  `link` varchar(255) DEFAULT NULL,
  `observacoes` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `normas`
--

LOCK TABLES `normas` WRITE;
/*!40000 ALTER TABLE `normas` DISABLE KEYS */;
INSERT INTO `normas` VALUES
(1,'RESOLUÇÃO RDC Nº 611, DE 9 DE Março DE 2022','RDC 611','2022-03-09','Ativa','[{\"download_link\":\"normas\\/March2023\\/5OjvBDgNW1TpJkMnyJtH.pdf\",\"original_name\":\"611.pdf\"}]','https://www.in.gov.br/en/web/dou/-/resolucao-rdc-n-611-de-9-de-marco-de-2022-386107075','<p class=\"ementa\">Estabelece os requisitos sanit&aacute;rios para a organiza&ccedil;&atilde;o e o funcionamento de servi&ccedil;os de radiologia diagn&oacute;stica ou intervencionista e regulamenta o controle das exposi&ccedil;&otilde;es m&eacute;dicas, ocupacionais e do p&uacute;blico decorrentes do uso de tecnologias radiol&oacute;gicas diagn&oacute;sticas ou intervencionistas.</p>','2023-03-29 18:27:21','2023-03-29 18:27:21',NULL);
/*!40000 ALTER TABLE `normas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pages`
--

DROP TABLE IF EXISTS `pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `author_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `excerpt` text DEFAULT NULL,
  `body` text DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `slug` varchar(255) NOT NULL,
  `meta_description` text DEFAULT NULL,
  `meta_keywords` text DEFAULT NULL,
  `status` enum('ACTIVE','INACTIVE') NOT NULL DEFAULT 'INACTIVE',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pages_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pages`
--

LOCK TABLES `pages` WRITE;
/*!40000 ALTER TABLE `pages` DISABLE KEYS */;
INSERT INTO `pages` VALUES
(1,1,'Hello World','Hang the jib grog grog blossom grapple dance the hempen jig gangway pressgang bilge rat to go on account lugger. Nelsons folly gabion line draught scallywag fire ship gaff fluke fathom case shot. Sea Legs bilge rat sloop matey gabion long clothes run a shot across the bow Gold Road cog league.','<p>Hello World. Scallywag grog swab Cat o\'nine tails scuttle rigging hardtack cable nipper Yellow Jack. Handsomely spirits knave lad killick landlubber or just lubber deadlights chantey pinnace crack Jennys tea cup. Provost long clothes black spot Yellow Jack bilged on her anchor league lateen sail case shot lee tackle.</p>\n<p>Ballast spirits fluke topmast me quarterdeck schooner landlubber or just lubber gabion belaying pin. Pinnace stern galleon starboard warp carouser to go on account dance the hempen jig jolly boat measured fer yer chains. Man-of-war fire in the hole nipperkin handsomely doubloon barkadeer Brethren of the Coast gibbet driver squiffy.</p>',NULL,'hello-world','Yar Meta Description','Keyword1, Keyword2','ACTIVE','2023-03-28 17:17:13','2023-03-29 04:50:00');
/*!40000 ALTER TABLE `pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_resets`
--

LOCK TABLES `password_resets` WRITE;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pericias`
--

DROP TABLE IF EXISTS `pericias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pericias` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `data_pericia` date DEFAULT NULL,
  `tipo_pericia` varchar(255) DEFAULT NULL,
  `descricao_pericia` text DEFAULT NULL,
  `resultado_pericia` text DEFAULT NULL,
  `acoes_recomendadas` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pericias`
--

LOCK TABLES `pericias` WRITE;
/*!40000 ALTER TABLE `pericias` DISABLE KEYS */;
/*!40000 ALTER TABLE `pericias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permission_role`
--

DROP TABLE IF EXISTS `permission_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permission_role` (
  `permission_id` bigint(20) unsigned NOT NULL,
  `role_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `permission_role_permission_id_index` (`permission_id`),
  KEY `permission_role_role_id_index` (`role_id`),
  CONSTRAINT `permission_role_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `permission_role_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permission_role`
--

LOCK TABLES `permission_role` WRITE;
/*!40000 ALTER TABLE `permission_role` DISABLE KEYS */;
INSERT INTO `permission_role` VALUES
(1,1),
(1,5),
(1,6),
(2,1),
(3,1),
(4,1),
(4,5),
(5,1),
(6,1),
(7,1),
(8,1),
(9,1),
(10,1),
(11,1),
(12,1),
(13,1),
(14,1),
(15,1),
(16,1),
(17,1),
(18,1),
(19,1),
(20,1),
(21,1),
(22,1),
(23,1),
(24,1),
(25,1),
(26,1),
(27,1),
(28,1),
(29,1),
(30,1),
(31,1),
(31,3),
(31,4),
(32,1),
(32,3),
(32,4),
(33,1),
(33,3),
(33,4),
(34,1),
(34,3),
(34,4),
(35,1),
(35,3),
(35,4),
(36,1),
(36,3),
(36,4),
(37,1),
(37,3),
(37,4),
(38,1),
(38,3),
(38,4),
(39,1),
(39,3),
(39,4),
(40,1),
(40,3),
(40,4),
(41,1),
(41,3),
(42,1),
(43,1),
(44,1),
(45,1),
(71,1),
(72,1),
(73,1),
(74,1),
(75,1),
(76,1),
(76,3),
(76,4),
(77,1),
(77,3),
(78,1),
(78,3),
(79,1),
(79,3),
(80,1),
(80,3),
(81,1),
(81,3),
(81,4),
(82,1),
(82,3),
(83,1),
(83,3),
(84,1),
(84,3),
(85,1),
(85,3),
(96,1),
(96,3),
(96,4),
(96,5),
(97,1),
(97,3),
(97,5),
(98,1),
(98,3),
(98,5),
(99,1),
(99,3),
(99,5),
(100,1),
(100,3),
(100,5),
(111,1),
(111,3),
(111,4),
(111,6),
(112,1),
(112,3),
(112,4),
(112,6),
(113,1),
(113,3),
(113,4),
(114,1),
(114,3),
(114,4),
(115,1),
(115,3),
(115,4),
(116,1),
(116,3),
(116,4),
(117,1),
(117,3),
(117,4),
(118,1),
(118,3),
(118,4),
(119,1),
(119,3),
(119,4),
(120,1),
(120,3),
(120,4),
(121,1),
(121,3),
(121,4),
(121,5),
(121,6),
(122,1),
(122,3),
(122,4),
(122,5),
(122,6),
(123,1),
(123,3),
(123,4),
(123,5),
(123,6),
(124,1),
(124,3),
(124,4),
(124,5),
(124,6),
(125,1),
(125,3),
(125,4),
(125,5),
(126,1),
(126,3),
(127,1),
(127,3),
(128,1),
(128,3),
(129,1),
(129,3),
(130,1),
(130,3),
(131,1),
(131,3),
(131,4),
(131,5),
(131,6),
(132,1),
(132,3),
(132,4),
(132,5),
(132,6),
(133,1),
(133,3),
(133,4),
(133,5),
(134,1),
(134,3),
(134,4),
(134,5),
(134,6),
(135,1),
(135,3),
(135,4),
(135,5),
(136,1),
(136,5),
(137,1),
(137,5),
(138,1),
(138,5),
(139,1),
(139,5),
(140,1),
(140,5),
(141,1),
(141,5),
(142,1),
(142,5),
(143,1),
(143,5),
(144,1),
(144,5),
(145,1),
(145,5),
(146,1),
(146,3),
(146,4),
(146,5),
(147,1),
(147,3),
(147,4),
(147,5),
(148,1),
(148,3),
(148,4),
(148,5),
(149,1),
(149,3),
(149,4),
(149,5),
(150,1),
(150,3),
(150,4),
(150,5),
(151,1),
(151,3),
(152,1),
(152,3),
(153,1),
(153,3),
(154,1),
(154,3),
(155,1),
(155,3),
(156,1),
(156,3),
(156,5),
(157,1),
(157,3),
(157,5),
(158,1),
(158,3),
(158,5),
(159,1),
(159,3),
(159,5),
(160,1),
(160,3),
(160,5),
(161,1),
(161,3),
(161,6),
(162,1),
(162,3),
(162,6),
(163,1),
(163,3),
(163,6),
(164,1),
(164,3),
(164,6),
(165,1),
(165,3);
/*!40000 ALTER TABLE `permission_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `table_name` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `permissions_key_index` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=166 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES
(1,'browse_admin',NULL,'2023-03-28 17:16:44','2023-03-28 17:16:44'),
(2,'browse_bread',NULL,'2023-03-28 17:16:44','2023-03-28 17:16:44'),
(3,'browse_database',NULL,'2023-03-28 17:16:44','2023-03-28 17:16:44'),
(4,'browse_media',NULL,'2023-03-28 17:16:44','2023-03-28 17:16:44'),
(5,'browse_compass',NULL,'2023-03-28 17:16:44','2023-03-28 17:16:44'),
(6,'browse_menus','menus','2023-03-28 17:16:44','2023-03-28 17:16:44'),
(7,'read_menus','menus','2023-03-28 17:16:44','2023-03-28 17:16:44'),
(8,'edit_menus','menus','2023-03-28 17:16:44','2023-03-28 17:16:44'),
(9,'add_menus','menus','2023-03-28 17:16:44','2023-03-28 17:16:44'),
(10,'delete_menus','menus','2023-03-28 17:16:44','2023-03-28 17:16:44'),
(11,'browse_roles','roles','2023-03-28 17:16:44','2023-03-28 17:16:44'),
(12,'read_roles','roles','2023-03-28 17:16:44','2023-03-28 17:16:44'),
(13,'edit_roles','roles','2023-03-28 17:16:44','2023-03-28 17:16:44'),
(14,'add_roles','roles','2023-03-28 17:16:44','2023-03-28 17:16:44'),
(15,'delete_roles','roles','2023-03-28 17:16:44','2023-03-28 17:16:44'),
(16,'browse_users','users','2023-03-28 17:16:44','2023-03-28 17:16:44'),
(17,'read_users','users','2023-03-28 17:16:44','2023-03-28 17:16:44'),
(18,'edit_users','users','2023-03-28 17:16:44','2023-03-28 17:16:44'),
(19,'add_users','users','2023-03-28 17:16:44','2023-03-28 17:16:44'),
(20,'delete_users','users','2023-03-28 17:16:44','2023-03-28 17:16:44'),
(21,'browse_settings','settings','2023-03-28 17:16:44','2023-03-28 17:16:44'),
(22,'read_settings','settings','2023-03-28 17:16:44','2023-03-28 17:16:44'),
(23,'edit_settings','settings','2023-03-28 17:16:44','2023-03-28 17:16:44'),
(24,'add_settings','settings','2023-03-28 17:16:44','2023-03-28 17:16:44'),
(25,'delete_settings','settings','2023-03-28 17:16:44','2023-03-28 17:16:44'),
(26,'browse_categories','categories','2023-03-28 17:17:13','2023-03-28 17:17:13'),
(27,'read_categories','categories','2023-03-28 17:17:13','2023-03-28 17:17:13'),
(28,'edit_categories','categories','2023-03-28 17:17:13','2023-03-28 17:17:13'),
(29,'add_categories','categories','2023-03-28 17:17:13','2023-03-28 17:17:13'),
(30,'delete_categories','categories','2023-03-28 17:17:13','2023-03-28 17:17:13'),
(31,'browse_posts','posts','2023-03-28 17:17:13','2023-03-28 17:17:13'),
(32,'read_posts','posts','2023-03-28 17:17:13','2023-03-28 17:17:13'),
(33,'edit_posts','posts','2023-03-28 17:17:13','2023-03-28 17:17:13'),
(34,'add_posts','posts','2023-03-28 17:17:13','2023-03-28 17:17:13'),
(35,'delete_posts','posts','2023-03-28 17:17:13','2023-03-28 17:17:13'),
(36,'browse_pages','pages','2023-03-28 17:17:13','2023-03-28 17:17:13'),
(37,'read_pages','pages','2023-03-28 17:17:13','2023-03-28 17:17:13'),
(38,'edit_pages','pages','2023-03-28 17:17:13','2023-03-28 17:17:13'),
(39,'add_pages','pages','2023-03-28 17:17:13','2023-03-28 17:17:13'),
(40,'delete_pages','pages','2023-03-28 17:17:13','2023-03-28 17:17:13'),
(41,'browse_usuarios_responsaveis','usuarios_responsaveis','2023-03-28 19:19:29','2023-03-28 19:19:29'),
(42,'read_usuarios_responsaveis','usuarios_responsaveis','2023-03-28 19:19:29','2023-03-28 19:19:29'),
(43,'edit_usuarios_responsaveis','usuarios_responsaveis','2023-03-28 19:19:29','2023-03-28 19:19:29'),
(44,'add_usuarios_responsaveis','usuarios_responsaveis','2023-03-28 19:19:29','2023-03-28 19:19:29'),
(45,'delete_usuarios_responsaveis','usuarios_responsaveis','2023-03-28 19:19:29','2023-03-28 19:19:29'),
(71,'browse_administrators','administrators','2023-03-28 21:23:15','2023-03-28 21:23:15'),
(72,'read_administrators','administrators','2023-03-28 21:23:15','2023-03-28 21:23:15'),
(73,'edit_administrators','administrators','2023-03-28 21:23:15','2023-03-28 21:23:15'),
(74,'add_administrators','administrators','2023-03-28 21:23:15','2023-03-28 21:23:15'),
(75,'delete_administrators','administrators','2023-03-28 21:23:15','2023-03-28 21:23:15'),
(76,'browse_hospitals','hospitals','2023-03-28 22:17:12','2023-03-28 22:17:12'),
(77,'read_hospitals','hospitals','2023-03-28 22:17:12','2023-03-28 22:17:12'),
(78,'edit_hospitals','hospitals','2023-03-28 22:17:12','2023-03-28 22:17:12'),
(79,'add_hospitals','hospitals','2023-03-28 22:17:12','2023-03-28 22:17:12'),
(80,'delete_hospitals','hospitals','2023-03-28 22:17:12','2023-03-28 22:17:12'),
(81,'browse_sectors','sectors','2023-03-28 23:00:06','2023-03-28 23:00:06'),
(82,'read_sectors','sectors','2023-03-28 23:00:06','2023-03-28 23:00:06'),
(83,'edit_sectors','sectors','2023-03-28 23:00:06','2023-03-28 23:00:06'),
(84,'add_sectors','sectors','2023-03-28 23:00:06','2023-03-28 23:00:06'),
(85,'delete_sectors','sectors','2023-03-28 23:00:06','2023-03-28 23:00:06'),
(96,'browse_professionals','professionals','2023-03-29 00:10:28','2023-03-29 00:10:28'),
(97,'read_professionals','professionals','2023-03-29 00:10:28','2023-03-29 00:10:28'),
(98,'edit_professionals','professionals','2023-03-29 00:10:28','2023-03-29 00:10:28'),
(99,'add_professionals','professionals','2023-03-29 00:10:28','2023-03-29 00:10:28'),
(100,'delete_professionals','professionals','2023-03-29 00:10:28','2023-03-29 00:10:28'),
(111,'browse_equipment','equipment','2023-03-29 00:51:46','2023-03-29 00:51:46'),
(112,'read_equipment','equipment','2023-03-29 00:51:46','2023-03-29 00:51:46'),
(113,'edit_equipment','equipment','2023-03-29 00:51:46','2023-03-29 00:51:46'),
(114,'add_equipment','equipment','2023-03-29 00:51:46','2023-03-29 00:51:46'),
(115,'delete_equipment','equipment','2023-03-29 00:51:46','2023-03-29 00:51:46'),
(116,'browse_simulators','simulators','2023-03-29 01:06:17','2023-03-29 01:06:17'),
(117,'read_simulators','simulators','2023-03-29 01:06:17','2023-03-29 01:06:17'),
(118,'edit_simulators','simulators','2023-03-29 01:06:17','2023-03-29 01:06:17'),
(119,'add_simulators','simulators','2023-03-29 01:06:17','2023-03-29 01:06:17'),
(120,'delete_simulators','simulators','2023-03-29 01:06:17','2023-03-29 01:06:17'),
(121,'browse_doses','doses','2023-03-29 01:19:52','2023-03-29 01:19:52'),
(122,'read_doses','doses','2023-03-29 01:19:52','2023-03-29 01:19:52'),
(123,'edit_doses','doses','2023-03-29 01:19:52','2023-03-29 01:19:52'),
(124,'add_doses','doses','2023-03-29 01:19:52','2023-03-29 01:19:52'),
(125,'delete_doses','doses','2023-03-29 01:19:52','2023-03-29 01:19:52'),
(126,'browse_procedures','procedures','2023-03-29 01:33:33','2023-03-29 01:33:33'),
(127,'read_procedures','procedures','2023-03-29 01:33:33','2023-03-29 01:33:33'),
(128,'edit_procedures','procedures','2023-03-29 01:33:33','2023-03-29 01:33:33'),
(129,'add_procedures','procedures','2023-03-29 01:33:33','2023-03-29 01:33:33'),
(130,'delete_procedures','procedures','2023-03-29 01:33:33','2023-03-29 01:33:33'),
(131,'browse_events','events','2023-03-29 02:14:12','2023-03-29 02:14:12'),
(132,'read_events','events','2023-03-29 02:14:12','2023-03-29 02:14:12'),
(133,'edit_events','events','2023-03-29 02:14:12','2023-03-29 02:14:12'),
(134,'add_events','events','2023-03-29 02:14:12','2023-03-29 02:14:12'),
(135,'delete_events','events','2023-03-29 02:14:12','2023-03-29 02:14:12'),
(136,'browse_pericias','pericias','2023-03-29 03:37:16','2023-03-29 03:37:16'),
(137,'read_pericias','pericias','2023-03-29 03:37:16','2023-03-29 03:37:16'),
(138,'edit_pericias','pericias','2023-03-29 03:37:16','2023-03-29 03:37:16'),
(139,'add_pericias','pericias','2023-03-29 03:37:16','2023-03-29 03:37:16'),
(140,'delete_pericias','pericias','2023-03-29 03:37:16','2023-03-29 03:37:16'),
(141,'browse_trabalhistas','trabalhistas','2023-03-29 03:50:35','2023-03-29 03:50:35'),
(142,'read_trabalhistas','trabalhistas','2023-03-29 03:50:35','2023-03-29 03:50:35'),
(143,'edit_trabalhistas','trabalhistas','2023-03-29 03:50:35','2023-03-29 03:50:35'),
(144,'add_trabalhistas','trabalhistas','2023-03-29 03:50:35','2023-03-29 03:50:35'),
(145,'delete_trabalhistas','trabalhistas','2023-03-29 03:50:35','2023-03-29 03:50:35'),
(146,'browse_treinamentos','treinamentos','2023-03-29 04:29:08','2023-03-29 04:29:08'),
(147,'read_treinamentos','treinamentos','2023-03-29 04:29:08','2023-03-29 04:29:08'),
(148,'edit_treinamentos','treinamentos','2023-03-29 04:29:08','2023-03-29 04:29:08'),
(149,'add_treinamentos','treinamentos','2023-03-29 04:29:08','2023-03-29 04:29:08'),
(150,'delete_treinamentos','treinamentos','2023-03-29 04:29:08','2023-03-29 04:29:08'),
(151,'browse_relatorios','relatorios','2023-03-29 05:21:23','2023-03-29 05:21:23'),
(152,'read_relatorios','relatorios','2023-03-29 05:21:23','2023-03-29 05:21:23'),
(153,'edit_relatorios','relatorios','2023-03-29 05:21:23','2023-03-29 05:21:23'),
(154,'add_relatorios','relatorios','2023-03-29 05:21:23','2023-03-29 05:21:23'),
(155,'delete_relatorios','relatorios','2023-03-29 05:21:23','2023-03-29 05:21:23'),
(156,'browse_normas','normas','2023-03-29 05:32:00','2023-03-29 05:32:00'),
(157,'read_normas','normas','2023-03-29 05:32:00','2023-03-29 05:32:00'),
(158,'edit_normas','normas','2023-03-29 05:32:00','2023-03-29 05:32:00'),
(159,'add_normas','normas','2023-03-29 05:32:00','2023-03-29 05:32:00'),
(160,'delete_normas','normas','2023-03-29 05:32:00','2023-03-29 05:32:00'),
(161,'browse_mamos','mamos','2023-03-29 05:42:43','2023-03-29 05:42:43'),
(162,'read_mamos','mamos','2023-03-29 05:42:43','2023-03-29 05:42:43'),
(163,'edit_mamos','mamos','2023-03-29 05:42:43','2023-03-29 05:42:43'),
(164,'add_mamos','mamos','2023-03-29 05:42:43','2023-03-29 05:42:43'),
(165,'delete_mamos','mamos','2023-03-29 05:42:43','2023-03-29 05:42:43');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `posts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `author_id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `seo_title` varchar(255) DEFAULT NULL,
  `excerpt` text DEFAULT NULL,
  `body` text NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `slug` varchar(255) NOT NULL,
  `meta_description` text DEFAULT NULL,
  `meta_keywords` text DEFAULT NULL,
  `status` enum('PUBLISHED','DRAFT','PENDING') NOT NULL DEFAULT 'DRAFT',
  `featured` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `posts_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES
(3,0,NULL,'Latest Post',NULL,'This is the excerpt for the latest post','<p>This is the body for the latest post</p>','posts/post3.jpg','latest-post','This is the meta description','keyword1, keyword2, keyword3','PUBLISHED',0,'2023-03-28 17:17:13','2023-03-28 17:17:13'),
(4,0,NULL,'Yarr Post',NULL,'Reef sails nipperkin bring a spring upon her cable coffer jury mast spike marooned Pieces of Eight poop deck pillage. Clipper driver coxswain galleon hempen halter come about pressgang gangplank boatswain swing the lead. Nipperkin yard skysail swab lanyard Blimey bilge water ho quarter Buccaneer.','<p>Swab deadlights Buccaneer fire ship square-rigged dance the hempen jig weigh anchor cackle fruit grog furl. Crack Jennys tea cup chase guns pressgang hearties spirits hogshead Gold Road six pounders fathom measured fer yer chains. Main sheet provost come about trysail barkadeer crimp scuttle mizzenmast brig plunder.</p>\n<p>Mizzen league keelhaul galleon tender cog chase Barbary Coast doubloon crack Jennys tea cup. Blow the man down lugsail fire ship pinnace cackle fruit line warp Admiral of the Black strike colors doubloon. Tackle Jack Ketch come about crimp rum draft scuppers run a shot across the bow haul wind maroon.</p>\n<p>Interloper heave down list driver pressgang holystone scuppers tackle scallywag bilged on her anchor. Jack Tar interloper draught grapple mizzenmast hulk knave cable transom hogshead. Gaff pillage to go on account grog aft chase guns piracy yardarm knave clap of thunder.</p>','posts/post4.jpg','yarr-post','this be a meta descript','keyword1, keyword2, keyword3','PUBLISHED',0,'2023-03-28 17:17:13','2023-03-28 17:17:13');
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `procedures`
--

DROP TABLE IF EXISTS `procedures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `procedures` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `exam_type` varchar(255) DEFAULT NULL,
  `average_at_month` varchar(255) DEFAULT NULL,
  `exam_comments` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `procedures`
--

LOCK TABLES `procedures` WRITE;
/*!40000 ALTER TABLE `procedures` DISABLE KEYS */;
INSERT INTO `procedures` VALUES
(1,'Procedimento1`','10',NULL,'2023-03-29 01:42:19','2023-03-29 01:42:19',NULL);
/*!40000 ALTER TABLE `procedures` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `professionals`
--

DROP TABLE IF EXISTS `professionals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `professionals` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `person_cpf` varchar(255) DEFAULT NULL,
  `person_name` varchar(255) DEFAULT NULL,
  `person_gender` varchar(255) DEFAULT NULL,
  `person_birthdate` date DEFAULT NULL,
  `service_person_link_role` varchar(255) DEFAULT NULL,
  `service_person_link_description` varchar(255) DEFAULT NULL,
  `service_person_link_work_start_date` date DEFAULT NULL,
  `service_person_link_employment_bond` varchar(255) DEFAULT NULL,
  `service_person_link_workload` varchar(255) DEFAULT NULL,
  `person_doc_name` varchar(255) DEFAULT NULL,
  `person_doc_number` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `estado_civil` varchar(255) DEFAULT NULL,
  `endereco_residencial` varchar(255) DEFAULT NULL,
  `telefone` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `historico_medico` text DEFAULT NULL,
  `exames_medicos` varchar(255) DEFAULT NULL,
  `habilidades` text DEFAULT NULL,
  `historico_profissional` text DEFAULT NULL,
  `contato_emergencia` text DEFAULT NULL,
  `historico_seguranca` text DEFAULT NULL,
  `PCMSO` varchar(255) DEFAULT NULL,
  `ASO` varchar(255) DEFAULT NULL,
  `VACINAS` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `professionals`
--

LOCK TABLES `professionals` WRITE;
/*!40000 ALTER TABLE `professionals` DISABLE KEYS */;
INSERT INTO `professionals` VALUES
(1,NULL,'Carlos Eduardo','Feminino',NULL,'Auxiliar de Serviços Gerais',NULL,NULL,'Terceirizado','20','ABFM',NULL,'2023-03-29 01:46:15','2023-03-29 18:36:39',NULL,'Solteiro',NULL,NULL,NULL,NULL,'[]',NULL,NULL,NULL,NULL,'[]','[]',NULL);
/*!40000 ALTER TABLE `professionals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `relatorios`
--

DROP TABLE IF EXISTS `relatorios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `relatorios` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `data` date DEFAULT NULL,
  `vencimento` date DEFAULT NULL,
  `tipo` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `observacoes` text DEFAULT NULL,
  `anexo` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relatorios`
--

LOCK TABLES `relatorios` WRITE;
/*!40000 ALTER TABLE `relatorios` DISABLE KEYS */;
INSERT INTO `relatorios` VALUES
(1,'2023-03-29','2023-03-31','Controle de Qualidade','Conforme',NULL,'[{\"download_link\":\"relatorios\\/March2023\\/tbcptg79jiNMbY9frtzK.pdf\",\"original_name\":\"611.pdf\"}]','2023-03-29 18:39:46','2023-03-29 18:39:46',NULL);
/*!40000 ALTER TABLE `relatorios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `display_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES
(1,'admin','Administrator','2023-03-28 17:16:44','2023-03-28 17:16:44'),
(2,'user','Normal User','2023-03-28 17:16:44','2023-03-28 17:16:44'),
(3,'Fisica Médica','Física Médica','2023-03-28 18:22:14','2023-03-28 18:22:14'),
(4,'Engenharia Clínica','Engenharia Clínica','2023-03-29 05:05:19','2023-03-29 05:05:19'),
(5,'Segurança do Trabalho','Segurança do Trabalho','2023-03-29 05:06:43','2023-03-29 05:06:43'),
(6,'Técnicos em Radiologia','Técnicos em Radiologia','2023-03-29 05:08:20','2023-03-29 05:08:20');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sectors`
--

DROP TABLE IF EXISTS `sectors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sectors` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `service_type` varchar(255) DEFAULT NULL,
  `service_type_id` varchar(255) DEFAULT NULL,
  `location_name` varchar(255) DEFAULT NULL,
  `nao_usa_dosimetro` varchar(255) DEFAULT NULL,
  `fornecedor_dosimetro` varchar(255) DEFAULT NULL,
  `numero_total_dosimetros` varchar(255) DEFAULT NULL,
  `num_protoloco_processo_renovacao` varchar(255) DEFAULT NULL,
  `numero_alvara` varchar(255) DEFAULT NULL,
  `vencimento_alvara` date DEFAULT NULL,
  `obs` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sectors`
--

LOCK TABLES `sectors` WRITE;
/*!40000 ALTER TABLE `sectors` DISABLE KEYS */;
/*!40000 ALTER TABLE `sectors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `display_name` varchar(255) NOT NULL,
  `value` text DEFAULT NULL,
  `details` text DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `order` int(11) NOT NULL DEFAULT 1,
  `group` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `settings_key_unique` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` VALUES
(1,'site.title','Site Title','SISPRAD','','text',1,'Site'),
(2,'site.description','Site Description','Gestão da Proteção Radiológica','','text',2,'Site'),
(3,'site.logo','Site Logo','settings/March2023/TOZ11OqV8RCfJ1UeJrVg.png','','image',3,'Site'),
(4,'site.google_analytics_tracking_id','Google Analytics Tracking ID',NULL,'','text',4,'Site'),
(5,'admin.bg_image','Admin Background Image','','','image',5,'Admin'),
(6,'admin.title','Admin Title','SISPRAD','','text',1,'Admin'),
(7,'admin.description','Admin Description','Gestão da Proteção Radiológica','','text',2,'Admin'),
(8,'admin.loader','Admin Loader','','','image',3,'Admin'),
(9,'admin.icon_image','Admin Icon Image','','','image',4,'Admin'),
(10,'admin.google_analytics_client_id','Google Analytics Client ID (used for admin dashboard)',NULL,'','text',1,'Admin');
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `simulators`
--

DROP TABLE IF EXISTS `simulators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `simulators` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `simulator_name` varchar(255) DEFAULT NULL,
  `simulator_manufacturer` varchar(255) DEFAULT NULL,
  `simulator_model` varchar(255) DEFAULT NULL,
  `simulator_serial_number` varchar(255) DEFAULT NULL,
  `simulator_equivalent_thickness` varchar(255) DEFAULT NULL,
  `simulator_comments` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `simulators`
--

LOCK TABLES `simulators` WRITE;
/*!40000 ALTER TABLE `simulators` DISABLE KEYS */;
/*!40000 ALTER TABLE `simulators` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trabalhistas`
--

DROP TABLE IF EXISTS `trabalhistas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trabalhistas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `data_acao` date DEFAULT NULL,
  `descricao_acao` text DEFAULT NULL,
  `tipo_acao` varchar(255) DEFAULT NULL,
  `status_acao` varchar(255) DEFAULT NULL,
  `resultado_acao` text DEFAULT NULL,
  `acoes_recomendadas` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trabalhistas`
--

LOCK TABLES `trabalhistas` WRITE;
/*!40000 ALTER TABLE `trabalhistas` DISABLE KEYS */;
/*!40000 ALTER TABLE `trabalhistas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `translations`
--

DROP TABLE IF EXISTS `translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `translations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `table_name` varchar(255) NOT NULL,
  `column_name` varchar(255) NOT NULL,
  `foreign_key` int(10) unsigned NOT NULL,
  `locale` varchar(255) NOT NULL,
  `value` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `translations_table_name_column_name_foreign_key_locale_unique` (`table_name`,`column_name`,`foreign_key`,`locale`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `translations`
--

LOCK TABLES `translations` WRITE;
/*!40000 ALTER TABLE `translations` DISABLE KEYS */;
INSERT INTO `translations` VALUES
(1,'data_types','display_name_singular',5,'pt','Post','2023-03-28 17:17:13','2023-03-28 17:17:13'),
(2,'data_types','display_name_singular',6,'pt','Página','2023-03-28 17:17:13','2023-03-28 17:17:13'),
(3,'data_types','display_name_singular',1,'pt','Utilizador','2023-03-28 17:17:13','2023-03-28 17:17:13'),
(4,'data_types','display_name_singular',4,'pt','Categoria','2023-03-28 17:17:13','2023-03-28 17:17:13'),
(5,'data_types','display_name_singular',2,'pt','Menu','2023-03-28 17:17:13','2023-03-28 17:17:13'),
(6,'data_types','display_name_singular',3,'pt','Função','2023-03-28 17:17:13','2023-03-28 17:17:13'),
(7,'data_types','display_name_plural',5,'pt','Posts','2023-03-28 17:17:13','2023-03-28 17:17:13'),
(8,'data_types','display_name_plural',6,'pt','Páginas','2023-03-28 17:17:13','2023-03-28 17:17:13'),
(9,'data_types','display_name_plural',1,'pt','Utilizadores','2023-03-28 17:17:13','2023-03-28 17:17:13'),
(10,'data_types','display_name_plural',4,'pt','Categorias','2023-03-28 17:17:13','2023-03-28 17:17:13'),
(11,'data_types','display_name_plural',2,'pt','Menus','2023-03-28 17:17:13','2023-03-28 17:17:13'),
(12,'data_types','display_name_plural',3,'pt','Funções','2023-03-28 17:17:13','2023-03-28 17:17:13'),
(13,'categories','slug',1,'pt','categoria-1','2023-03-28 17:17:13','2023-03-28 17:17:13'),
(14,'categories','name',1,'pt','Categoria 1','2023-03-28 17:17:13','2023-03-28 17:17:13'),
(15,'categories','slug',2,'pt','categoria-2','2023-03-28 17:17:13','2023-03-28 17:17:13'),
(16,'categories','name',2,'pt','Categoria 2','2023-03-28 17:17:13','2023-03-28 17:17:13'),
(17,'pages','title',1,'pt','Olá Mundo','2023-03-28 17:17:13','2023-03-28 17:17:13'),
(18,'pages','slug',1,'pt','ola-mundo','2023-03-28 17:17:13','2023-03-28 17:17:13'),
(19,'pages','body',1,'pt','<p>Olá Mundo. Scallywag grog swab Cat o\'nine tails scuttle rigging hardtack cable nipper Yellow Jack. Handsomely spirits knave lad killick landlubber or just lubber deadlights chantey pinnace crack Jennys tea cup. Provost long clothes black spot Yellow Jack bilged on her anchor league lateen sail case shot lee tackle.</p>\r\n<p>Ballast spirits fluke topmast me quarterdeck schooner landlubber or just lubber gabion belaying pin. Pinnace stern galleon starboard warp carouser to go on account dance the hempen jig jolly boat measured fer yer chains. Man-of-war fire in the hole nipperkin handsomely doubloon barkadeer Brethren of the Coast gibbet driver squiffy.</p>','2023-03-28 17:17:13','2023-03-28 17:17:13'),
(20,'menu_items','title',1,'pt','Painel de Controle','2023-03-28 17:17:13','2023-03-28 17:17:13'),
(21,'menu_items','title',2,'pt','Media','2023-03-28 17:17:13','2023-03-28 17:17:13'),
(22,'menu_items','title',12,'pt','Publicações','2023-03-28 17:17:13','2023-03-28 17:17:13'),
(23,'menu_items','title',3,'pt','Utilizadores','2023-03-28 17:17:13','2023-03-28 17:17:13'),
(24,'menu_items','title',11,'pt','Categorias','2023-03-28 17:17:13','2023-03-28 17:17:13'),
(25,'menu_items','title',13,'pt','Páginas','2023-03-28 17:17:13','2023-03-28 17:17:13'),
(26,'menu_items','title',4,'pt','Funções','2023-03-28 17:17:13','2023-03-28 17:17:13'),
(27,'menu_items','title',5,'pt','Ferramentas','2023-03-28 17:17:13','2023-03-28 17:17:13'),
(28,'menu_items','title',6,'pt','Menus','2023-03-28 17:17:13','2023-03-28 17:17:13'),
(29,'menu_items','title',7,'pt','Base de dados','2023-03-28 17:17:13','2023-03-28 17:17:13'),
(30,'menu_items','title',10,'pt','Configurações','2023-03-28 17:17:13','2023-03-28 17:17:13');
/*!40000 ALTER TABLE `translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `treinamentos`
--

DROP TABLE IF EXISTS `treinamentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `treinamentos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tipo` varchar(255) DEFAULT NULL,
  `data` date DEFAULT NULL,
  `inicio` time DEFAULT NULL,
  `fim` time DEFAULT NULL,
  `observacoes` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `Anexo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `treinamentos`
--

LOCK TABLES `treinamentos` WRITE;
/*!40000 ALTER TABLE `treinamentos` DISABLE KEYS */;
INSERT INTO `treinamentos` VALUES
(1,'Treinamento de uso de EPI',NULL,NULL,NULL,NULL,'2023-03-29 18:07:34','2023-03-29 18:07:34',NULL,'[]'),
(2,'Treinamento de uso de EPI','2023-03-29','10:18:00','11:00:00','<p>Treinamento abordou os topicos de utiliza&ccedil;&atilde;o de EPIS...</p>\r\n<p>...</p>\r\n<p>..</p>\r\n<p>&nbsp;</p>','2023-03-29 18:36:08','2023-03-29 18:36:08',NULL,'[{\"download_link\":\"treinamentos\\/March2023\\/ffInPuboNiItTfXOeE6K.pdf\",\"original_name\":\"611.pdf\"}]');
/*!40000 ALTER TABLE `treinamentos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `treinamentos_professionals`
--

DROP TABLE IF EXISTS `treinamentos_professionals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `treinamentos_professionals` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `treinamento_id` int(11) DEFAULT NULL,
  `professional_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `treinamentos_professionals`
--

LOCK TABLES `treinamentos_professionals` WRITE;
/*!40000 ALTER TABLE `treinamentos_professionals` DISABLE KEYS */;
INSERT INTO `treinamentos_professionals` VALUES
(1,2,1);
/*!40000 ALTER TABLE `treinamentos_professionals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_roles` (
  `user_id` bigint(20) unsigned NOT NULL,
  `role_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `user_roles_user_id_index` (`user_id`),
  KEY `user_roles_role_id_index` (`role_id`),
  CONSTRAINT `user_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_roles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_roles`
--

LOCK TABLES `user_roles` WRITE;
/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;
INSERT INTO `user_roles` VALUES
(2,3),
(3,5),
(4,6);
/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `avatar` varchar(255) DEFAULT 'users/default.png',
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `settings` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `users_role_id_foreign` (`role_id`),
  CONSTRAINT `users_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES
(1,1,'Admin','carlosqueiroz@live.com','users/default.png',NULL,'$2y$10$zFuOeHYcCTwXDIOu5mJfNe36Qt6ei3w1QppyAhb6ufNCDC/0BQrVm','yCWRm0lFuw5PW1uCKW4P7kbuaUvkhQDJGE72NEUMtFJ3Qg8VrqgxQ4pwSls0','{\"locale\":\"pt_br\"}','2023-03-28 17:17:13','2023-03-29 05:57:45'),
(2,3,'Física Médica','teste@teste','users/default.png',NULL,'$2y$10$8/R22zSJgFYozKWm9soxgO5AVUlSzYkugLT51o8wyZCO9UG0Amssm',NULL,'{\"locale\":\"pt_br\"}','2023-03-28 18:22:57','2023-03-29 05:58:12'),
(3,5,'trabalho','trabalho@trabalho.com','users/default.png',NULL,'$2y$10$hYa0yl2N5WhlSb1LKKqM3e9n3zAdBt78Ltl/1BmlKgEooi9NMA3We',NULL,'{\"locale\":\"pt_br\"}','2023-03-29 17:57:15','2023-03-29 17:57:15'),
(4,6,'tecnico','tecnico@tecnico','users/default.png',NULL,'$2y$10$fPXNQAyVI1BUal79qUhtfe78metNAdOtWs01lRhKhzmeODtjfqduq',NULL,'{\"locale\":\"pt_br\"}','2023-03-29 18:09:42','2023-03-29 18:09:42');
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

-- Dump completed on 2023-04-04 18:32:07
