-- Create tsf_record schema
DROP SCHEMA IF EXISTS `tsf_record`;
CREATE SCHEMA `tsf_record` ;

-- Create Account
DROP USER IF EXISTS `tsf_record`;
CREATE USER `tsf_record`@'%' IDENTIFIED BY 'Tcdn@2007';
GRANT ALL PRIVILEGES ON tsf_record.* TO 'tsf_record'@'%' IDENTIFIED BY 'Tcdn@2007';
FLUSH PRIVILEGES;

-- Create Table in tsf_record
-- TSF_COMMON_ID
DROP TABLE IF EXISTS `tsf_record`.`tsf_common_id`;
CREATE TABLE `tsf_record`.`tsf_common_id` (
  `id_type` varchar(20) NOT NULL COMMENT 'ID类型',
  `id_value` bigint(20) NOT NULL DEFAULT '0' COMMENT 'ID值',
  PRIMARY KEY (`id_type`)
) COMMENT='TSF通用基础模块ID表';
INSERT INTO `tsf_record`.`tsf_common_id` (id_type) values ("hashId");


-- TSF_OPERATION_RECORD
DROP TABLE IF EXISTS `tsf_record`.`tsf_operation_record`;
CREATE TABLE `tsf_record`.`tsf_operation_record` (
  `id` varchar(20) NOT NULL COMMENT '主键ID，全局唯一',
  `module_type` varchar(32) NOT NULL COMMENT '功能模块，例如：应用、分布式配置',
  `operation_type` varchar(64) NOT NULL COMMENT '操作类型，例如：新建应用',
  `operation_msg` varchar(1024) DEFAULT NULL COMMENT '操作描述，例如：创建类型:SpringCloud,应用名称:x,版本号:1',
  `operation_resource` text DEFAULT NULL COMMENT '操作实体标识ID、名称,例如：application-or1x',
  `operation_time` timestamp NOT NULL COMMENT '操作记录时间',
  `operation_status` varchar(32) DEFAULT 'success' COMMENT '操作状态，成功：success; 失败: error',
  `app_id` varchar(64) NOT NULL DEFAULT '0' COMMENT '公有云账户appid',
  `uin` varchar(64) NOT NULL DEFAULT '0' COMMENT '公有云账户uin',
  `sub_account_uin` varchar(64) NOT NULL DEFAULT '0' COMMENT '公有云账户subAccountUin',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='操作记录表';

ALTER TABLE tsf_record.tsf_operation_record ADD COLUMN operator varchar(64) DEFAULT  NULL COMMENT '操作发起方,例如user,system, scalable, cicd 等' AFTER operation_resource;



