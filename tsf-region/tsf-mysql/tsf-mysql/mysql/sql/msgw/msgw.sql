-- MySQL dump 10.14  Distrib 5.5.60-MariaDB, for Linux (x86_64)
--
-- Host: 172.16.0.14    Database: msgw
-- ------------------------------------------------------
-- Server version	5.7.23

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `msgw`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `msgw` /*!40100 DEFAULT CHARACTER SET utf8 */;

CREATE USER 'msgw_oss'@'%' IDENTIFIED BY 'msgw@FIRST8102';
GRANT ALL PRIVILEGES ON msgw.* TO msgw_oss@'%' IDENTIFIED BY 'msgw@FIRST8102' WITH GRANT OPTION;
FLUSH PRIVILEGES;

USE `msgw`;

--
-- Table structure for table `tb_apigw_api`
--

DROP TABLE IF EXISTS `tb_apigw_api`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_apigw_api` (
  `id` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `api_id` varchar(32) NOT NULL,
  `app_tb_id` int(32) unsigned NOT NULL,
  `path` varchar(255) NOT NULL,
  `method` varchar(32) NOT NULL DEFAULT 'ANY',
  `endpoint_type` varchar(32) NOT NULL DEFAULT 'TSF',
  `validator` tinyint(1) NOT NULL DEFAULT '0',
  `rate_limit` int(32) NOT NULL DEFAULT '-1',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_time` timestamp NOT NULL DEFAULT '1970-08-31 16:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `api_u` (`api_id`) USING BTREE,
  UNIQUE KEY `path_app_method` (`path`,`app_tb_id`,`method`),
  KEY `app_tb_id_k` (`app_tb_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_apigw_api_endpoint_param`
--

DROP TABLE IF EXISTS `tb_apigw_api_endpoint_param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_apigw_api_endpoint_param` (
  `id` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `api_id` varchar(32) NOT NULL,
  `name` varchar(64) NOT NULL,
  `location` varchar(32) NOT NULL,
  `map_from` varchar(64) NOT NULL,
  `default_value` varchar(1000) DEFAULT NULL,
  `descript` varchar(6144) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `tb_apigw_api_endpoint_param_uni1` (`api_id`,`name`,`location`) USING BTREE,
  CONSTRAINT `tb_apigw_api_endpoint_param_ibfk_1` FOREIGN KEY (`api_id`) REFERENCES `tb_apigw_api` (`api_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_apigw_api_oauth`
--

DROP TABLE IF EXISTS `tb_apigw_api_oauth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_apigw_api_oauth` (
  `id` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `oauth_id` varchar(32) NOT NULL,
  `oauth_name` varchar(64) NOT NULL,
  `oauth_type` enum('oauth_tsf','oauth_third_part') NOT NULL DEFAULT 'oauth_third_part',
  `oauth_client_id` varchar(255) NOT NULL,
  `oauth_client_secret` varchar(255) NOT NULL,
  `code_to_token_path` varchar(255) NOT NULL,
  `check_token_path` varchar(255) NOT NULL,
  `login_url` varchar(255) NOT NULL,
  `oauth_data` text NOT NULL,
  `app_id` int(32) unsigned NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `oauth_id_u` (`oauth_id`) USING BTREE,
  UNIQUE KEY `app_oauth_u` (`app_id`,`oauth_name`),
  KEY `app_id_k` (`app_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_apigw_api_oauth_api`
--

DROP TABLE IF EXISTS `tb_apigw_api_oauth_api`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_apigw_api_oauth_api` (
  `id` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `oauth_id` varchar(32) NOT NULL,
  `api_id` varchar(32) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `api_id_u` (`api_id`) USING BTREE,
  KEY `oauth_id_k` (`oauth_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_apigw_api_request_param`
--

DROP TABLE IF EXISTS `tb_apigw_api_request_param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_apigw_api_request_param` (
  `id` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `api_id` varchar(32) NOT NULL,
  `name` varchar(64) NOT NULL,
  `location` varchar(32) NOT NULL,
  `required` tinyint(1) NOT NULL,
  `type` varchar(32) NOT NULL,
  `default_value` varchar(64) NOT NULL,
  `descript` varchar(6144) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `tb_apigw_api_request_param_uni1` (`api_id`,`name`,`location`) USING BTREE,
  CONSTRAINT `tb_apigw_api_request_param_ibfk_1` FOREIGN KEY (`api_id`) REFERENCES `tb_apigw_api` (`api_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_apigw_apikey`
--

DROP TABLE IF EXISTS `tb_apigw_apikey`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_apigw_apikey` (
  `id` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `secret_id` varchar(64) NOT NULL,
  `secret_key` varchar(256) NOT NULL,
  `secret_name` varchar(64) NOT NULL,
  `app_id` int(32) unsigned NOT NULL,
  `enable` tinyint(1) NOT NULL DEFAULT '1',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `secret_id_u` (`secret_id`) USING BTREE,
  UNIQUE KEY `app_key_u` (`app_id`,`secret_name`),
  KEY `app_id_k` (`app_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_apigw_apikey_api`
--

DROP TABLE IF EXISTS `tb_apigw_apikey_api`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_apigw_apikey_api` (
  `id` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `secret_id` varchar(64) NOT NULL,
  `api_id` varchar(32) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `secret_api_u` (`secret_id`,`api_id`) USING BTREE,
  KEY `secret_id_k` (`secret_id`),
  KEY `api_id_k` (`api_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_apigw_app`
--

DROP TABLE IF EXISTS `tb_apigw_app`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_apigw_app` (
  `app_tb_id` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `app_id` int(32) unsigned NOT NULL,
  PRIMARY KEY (`app_tb_id`),
  UNIQUE KEY `app_id_u` (`app_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_apigw_app_set`
--

DROP TABLE IF EXISTS `tb_apigw_app_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_apigw_app_set` (
  `id` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `set_id` int(32) unsigned NOT NULL DEFAULT '0',
  `app_tb_id` int(32) unsigned NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_set_u` (`app_tb_id`,`set_id`),
  KEY `app_tb_id_k` (`app_tb_id`),
  KEY `set_id_k` (`set_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_apigw_assign`
--

DROP TABLE IF EXISTS `tb_apigw_assign`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_apigw_assign` (
  `id` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `type` enum('SET','VIPGROUP') NOT NULL DEFAULT 'VIPGROUP',
  `value` int(32) unsigned NOT NULL DEFAULT '0',
  `assigner` varchar(255) NOT NULL DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `remark` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `value_type` (`type`,`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_apigw_ld`
--

DROP TABLE IF EXISTS `tb_apigw_ld`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_apigw_ld` (
  `id` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `ip` char(36) NOT NULL DEFAULT '',
  `set_id` int(32) unsigned NOT NULL DEFAULT '0',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `remark` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ip` (`ip`),
  KEY `set_id` (`set_id`),
  CONSTRAINT `tb_apigw_ld_ibfk_1` FOREIGN KEY (`set_id`) REFERENCES `tb_apigw_set` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_apigw_port`
--

DROP TABLE IF EXISTS `tb_apigw_port`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_apigw_port` (
  `id` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `port` char(36) NOT NULL DEFAULT '',
  `app_tb_id` int(32) unsigned NOT NULL DEFAULT '0',
  `set_id` int(32) unsigned NOT NULL DEFAULT '0',
  `status` enum('Unusable','Usable') NOT NULL DEFAULT 'Usable',
  `type` enum('HTTP_IN','HTTP_OUT','HTTPS_IN','HTTPS_OUT','CTL') NOT NULL DEFAULT 'HTTP_IN',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `set_port_u` (`set_id`,`port`),
  KEY `app_tb_id_k` (`app_tb_id`),
  KEY `set_id_k` (`set_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_apigw_set`
--

DROP TABLE IF EXISTS `tb_apigw_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_apigw_set` (
  `id` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(255) NOT NULL DEFAULT '',
  `idc` char(255) NOT NULL DEFAULT '',
  `status` enum('Ready','Usable','Busy') NOT NULL DEFAULT 'Ready',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `remark` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_apigw_task`
--

DROP TABLE IF EXISTS `tb_apigw_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_apigw_task` (
  `id` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `task_id` varchar(64) NOT NULL,
  `owner` varchar(64) NOT NULL,
  `input_data` text NOT NULL,
  `response_data` text NOT NULL,
  `task_type` varchar(32) NOT NULL DEFAULT '',
  `status` varchar(32) NOT NULL DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT '1970-08-31 16:00:00',
  PRIMARY KEY (`id`),
  KEY `task_type` (`task_type`),
  KEY `ID_TYPE` (`task_id`,`task_type`),
  KEY `task_id` (`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_lock`
--

DROP TABLE IF EXISTS `tb_lock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_lock` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` char(255) NOT NULL DEFAULT '',
  `key` char(255) NOT NULL DEFAULT '',
  `res_id` varchar(255) NOT NULL DEFAULT '',
  `count` int(32) unsigned NOT NULL DEFAULT '1',
  `owner` varchar(128) NOT NULL DEFAULT '',
  `job_type` varchar(128) NOT NULL DEFAULT '',
  `lock_desc` varchar(128) NOT NULL DEFAULT '',
  `lock_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `type` (`type`,`key`),
  KEY `res_id` (`res_id`),
  KEY `owner` (`owner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_operator`
--

DROP TABLE IF EXISTS `tb_operator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_operator` (
  `user_name` varchar(255) NOT NULL,
  `role` int(32) unsigned NOT NULL DEFAULT '1' COMMENT '1:visitor,2:user,3:operator,4:admin,5:super',
  PRIMARY KEY (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-11-06 15:22:16
