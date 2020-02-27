-- Create tsf_auth schema
DROP SCHEMA IF EXISTS `tsf_dispatch`;
CREATE SCHEMA `tsf_dispatch` ;

-- Create Account
DROP USER IF EXISTS `tsf_dispatch`;
CREATE USER `tsf_dispatch`@'%' IDENTIFIED BY 'Tcdn@2007';
GRANT ALL PRIVILEGES ON `tsf_dispatch`.* TO 'tsf_dispatch'@'%' IDENTIFIED BY 'Tcdn@2007';
FLUSH PRIVILEGES;

-- Create Tables of tsf_auth
-- TSF_COMMON_ID
DROP TABLE IF EXISTS `tsf_dispatch`.`tsf_common_id`;
CREATE TABLE `tsf_dispatch`.`tsf_common_id` (
  `id_type` varchar(20) NOT NULL COMMENT 'ID类型',
  `id_value` bigint(20) NOT NULL DEFAULT '0' COMMENT 'ID值',
  PRIMARY KEY (`id_type`)
) COMMENT='TSF通用基础模块ID表';
INSERT INTO `tsf_dispatch`.`tsf_common_id` (id_type) values ("hashId");