-- Create tsf_auth schema
DROP SCHEMA IF EXISTS `tsf_auth`;
CREATE SCHEMA `tsf_auth` ;

-- Create Account
DROP USER IF EXISTS `tsf_auth`;
CREATE USER `tsf_auth`@'%' IDENTIFIED BY 'Tcdn@2007';
GRANT ALL PRIVILEGES ON tsf_auth.* TO 'tsf_auth'@'%' IDENTIFIED BY 'Tcdn@2007';
FLUSH PRIVILEGES;

-- Create Tables of tsf_auth
-- TSF_COMMON_ID
DROP TABLE IF EXISTS `tsf_auth`.`tsf_common_id`;
CREATE TABLE `tsf_auth`.`tsf_common_id` (
  `id_type` varchar(20) NOT NULL COMMENT 'ID类型',
  `id_value` bigint(20) NOT NULL DEFAULT '0' COMMENT 'ID值',
  PRIMARY KEY (`id_type`)
) COMMENT='TSF通用基础模块ID表';
INSERT INTO `tsf_auth`.`tsf_common_id` (id_type) values ("hashId");


-- TSF_AUTH_AUTHORIZATION
DROP TABLE IF EXISTS `tsf_auth`.`tsf_auth_authorization`;
CREATE TABLE `tsf_auth`.`tsf_auth_authorization` (
  `source_service_id` varchar(20) NOT NULL COMMENT '源微服务ID（发起调用方），从tsf-ms取数',
  `target_service_id` varchar(20) NOT NULL COMMENT '目标微服务ID（被调用方），从tsf-ms取数',
  `auth_type` varchar(1) NOT NULL COMMENT '权限类型：B：黑名单；W：白名单',
  `namespace_id` varchar(20) NOT NULL COMMENT '命名空间ID，从tsf-resource取数',
  `app_id` varchar(60) NOT NULL DEFAULT '0' COMMENT '账号appId信息',
  `uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '账号uin信息',
  `sub_account_uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '账号sub account uin信息',
  PRIMARY KEY (`target_service_id`,`source_service_id`)
) COMMENT='TSF服务权限，使用联合主键'