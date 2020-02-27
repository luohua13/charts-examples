-- Create tsf_apm schema
DROP SCHEMA IF EXISTS `tsf_apm`;
CREATE SCHEMA `tsf_apm` ;

-- Create Account
DROP USER IF EXISTS `tsf_apm`;
CREATE USER `tsf_apm`@'%' IDENTIFIED BY 'Tcdn@2007';
GRANT ALL PRIVILEGES ON tsf_apm.* TO 'tsf_apm'@'%' IDENTIFIED BY 'Tcdn@2007';
FLUSH PRIVILEGES;

-- Create Tables of tsf_apm
-- TSF_COMMON_ID
DROP TABLE IF EXISTS `tsf_apm`.`tsf_common_id`;
CREATE TABLE `tsf_apm`.`tsf_common_id` (
  `id_type` varchar(20) NOT NULL COMMENT 'ID类型',
  `id_value` bigint(20) NOT NULL DEFAULT '0' COMMENT 'ID值',
  PRIMARY KEY (`id_type`)
) COMMENT='TSF通用基础模块ID表';
INSERT INTO `tsf_apm`.`tsf_common_id` (id_type) values ("hashId");


-- TSF_APM_ELASICSEARCH_AUTH
DROP TABLE IF EXISTS `tsf_apm`.`tsf_apm_elasticsearch_auth`;
CREATE TABLE `tsf_apm`.`tsf_apm_elasticsearch_auth` (
	`auth_id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT 'auth identifier',
	`app_id` varchar(60) NOT NULL COMMENT 'tsf account app id',
	`auth_username` varchar(32) NOT NULL COMMENT 'auth user name',
	`auth_password` varchar(32) NOT NULL COMMENT 'auth pass word',
	`auth_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'auth create time',
	UNIQUE INDEX unique_app(`app_id`)
) COMMENT='TSF APM 初始化 ES 权限';

-- TSF_APM_BUSINESS_LOG_CONFIG
DROP TABLE IF EXISTS `tsf_apm`.`tsf_apm_busi_log_cfg`;
CREATE TABLE `tsf_apm`.`tsf_apm_busi_log_cfg` (
  `cfg_id` varchar(32) NOT NULL PRIMARY KEY COMMENT 'business log config identifier',
	`app_id` varchar(60) NOT NULL COMMENT 'tsf account app id',
	`cloud_uin` varchar(60) NOT NULL COMMENT 'tsf account owner uin',
	`cloud_sub_uin` varchar(60) NOT NULL COMMENT 'tsf account create uin',
  `cfg_name` varchar(64) NOT NULL COMMENT 'business log config name',
	`cfg_desc` varchar(256) NOT NULL COMMENT 'business log config description',
	`cfg_path` varchar(256) NOT NULL COMMENT 'business log config path',
	`cfg_tags` varchar(128) COMMENT 'business log config tag',
	`cfg_schema` varchar(256) COMMENT 'business log config schema',
	`cfg_pipeline` varchar(128) COMMENT 'business log config related es pipeline',
	`cfg_create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'business log config create time',
	UNIQUE INDEX unique_name(`app_id`, `cfg_name`)
) COMMENT='TSF APM 日志配置项';

-- TSF_APM_BUSINESS_LOG_CONFIG_APP_RELATION
DROP TABLE IF EXISTS `tsf_apm`.`tsf_apm_busi_log_cfg_application_relation`;
CREATE TABLE `tsf_apm`.`tsf_apm_busi_log_cfg_application_relation` (
	`relation_id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT 'relation identifier',
	`busi_log_cfg_id` varchar(32) NOT NULL COMMENT 'log config identifier',
	`application_id` varchar(20) NOT NULL COMMENT 'application identifier',
	`relation_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'relation create/operate time',
	UNIQUE INDEX unique_application(`application_id`)
) COMMENT='TSF APM 日志配置项与应用关联';

-- TSF_APM_BUSINESS_LOG_CONFIG_GROUP_RELATION
DROP TABLE IF EXISTS `tsf_apm`.`tsf_apm_busi_log_cfg_group_relation`;
CREATE TABLE `tsf_apm`.`tsf_apm_busi_log_cfg_group_relation` (
	`relation_id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT 'relation identifier',
	`busi_log_cfg_id` varchar(32) NOT NULL COMMENT 'log config identifier',
	`application_id` varchar(20) NOT NULL COMMENT 'application identifier',
	`group_id` varchar(20) NOT NULL COMMENT 'group identifier',
	`relation_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'relation create/operate time',
	UNIQUE INDEX unique_relation(`busi_log_cfg_id`, `application_id`, `group_id`)
) COMMENT='TSF APM 日志配置项与部署组关联';