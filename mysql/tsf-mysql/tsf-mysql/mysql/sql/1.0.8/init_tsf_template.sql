-- Create tsf_auth schema
DROP SCHEMA IF EXISTS `tsf_template`;
CREATE SCHEMA `tsf_template` ;

-- Create Account
DROP USER IF EXISTS `tsf_template`;
CREATE USER `tsf_template`@'%' IDENTIFIED BY 'Tcdn@2007';
GRANT ALL PRIVILEGES ON tsf_template.* TO 'tsf_template'@'%' IDENTIFIED BY 'Tcdn@2007';
FLUSH PRIVILEGES;

USE tsf_template;

-- ----------------------------
-- Table structure for tsf_common_id
-- ----------------------------
DROP TABLE IF EXISTS `tsf_common_id`;
CREATE TABLE `tsf_common_id` (
  `id_type` varchar(20) NOT NULL COMMENT 'ID类型',
  `id_value` bigint(20) NOT NULL DEFAULT '0' COMMENT 'ID值',
  PRIMARY KEY (`id_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='TSF通用基础模块ID表';
INSERT INTO `tsf_template`.`tsf_common_id` (id_type) values ("hashId");

-- ----------------------------
-- Table structure for tsf_template_project
-- ----------------------------
DROP TABLE IF EXISTS `tsf_template_project`;
CREATE TABLE `tsf_template_project` (
  `projectId` varchar(40) NOT NULL COMMENT '工程id',
  `projectName` varchar(255) NOT NULL COMMENT '工程名',
  `basePackage` varchar(255) NOT NULL COMMENT '包路径',
  `lastTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `data` text NOT NULL COMMENT 'json数据',
  `app_id` varchar(60) NOT NULL DEFAULT '0',
  `uin` varchar(60) NOT NULL DEFAULT '0',
  `sub_account_uin` varchar(60) NOT NULL DEFAULT '0',
  PRIMARY KEY (`projectId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;