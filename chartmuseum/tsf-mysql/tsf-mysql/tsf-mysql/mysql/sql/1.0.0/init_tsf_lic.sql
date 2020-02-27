-- Create tsf_auth schema
DROP SCHEMA IF EXISTS `tsf_lic`;
CREATE SCHEMA `tsf_lic` ;

-- Create Account
DROP USER IF EXISTS `tsf_lic`;
CREATE USER `tsf_lic`@'%' IDENTIFIED BY 'Tcdn@2007';
GRANT ALL PRIVILEGES ON tsf_lic.* TO 'tsf_lic'@'%' IDENTIFIED BY 'Tcdn@2007';
FLUSH PRIVILEGES;

-- Create Tables of tsf_auth
-- TSF_COMMON_ID
DROP TABLE IF EXISTS `tsf_lic`.`tsf_common_id`;
CREATE TABLE `tsf_lic`.`tsf_common_id` (
  `id_type` varchar(20) NOT NULL COMMENT 'ID类型',
  `id_value` bigint(20) NOT NULL DEFAULT '0' COMMENT 'ID值',
  PRIMARY KEY (`id_type`)
) COMMENT='TSF通用基础模块ID表';
INSERT INTO `tsf_lic`.`tsf_common_id` (id_type) values ("hashId");


-- TSF_LIC_LICENCE
DROP TABLE IF EXISTS `tsf_lic`.`tsf_lic_licence`;
CREATE TABLE `tsf_lic`.`tsf_lic_licence` (
  `licence_id` varchar(20) NOT NULL COMMENT 'LicenceID，物理主键',
  `creation_time` timestamp NOT NULL COMMENT '创建时间',
  `app_id` varchar(60) NOT NULL DEFAULT '0' COMMENT '账号appId信息',
  `uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '账号uin信息',
  `sub_account_uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '账号sub account uin信息',
  PRIMARY KEY (`licence_id`)
) COMMENT='TSF Licence主表'