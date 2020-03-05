-- Create tsf_ms schema
DROP SCHEMA IF EXISTS `tsf_ms`;
CREATE SCHEMA `tsf_ms`;

-- Create Account
DROP USER IF EXISTS `tsf_ms`;
CREATE USER `tsf_ms`@'%' IDENTIFIED BY 'Tcdn@2007';
GRANT ALL PRIVILEGES ON tsf_ms.* TO 'tsf_ms'@'%' IDENTIFIED BY 'Tcdn@2007';
FLUSH PRIVILEGES;

-- Create Tables of tsf_ms
-- TSF_COMMON_ID
DROP TABLE IF EXISTS `tsf_ms`.`tsf_common_id`;
CREATE TABLE `tsf_ms`.`tsf_common_id` (
  `id_type` varchar(20) NOT NULL COMMENT 'ID类型',
  `id_value` bigint(20) NOT NULL DEFAULT '0' COMMENT 'ID值',
  PRIMARY KEY (`id_type`)
) COMMENT='TSF通用基础模块ID表';
INSERT INTO `tsf_ms`.`tsf_common_id` (id_type) values ("hashId");

-- TSF_MS_MICROSERVICE
DROP TABLE IF EXISTS `tsf_ms`.`tsf_ms_microservice`;
CREATE TABLE `tsf_ms`.`tsf_ms_microservice` (
  `id` varchar(20) NOT NULL COMMENT '主键ID，全局唯一',
  `namespace_id` varchar(20) NOT NULL DEFAULT '' COMMENT '服务所属命名空间id',
  `service_name` varchar(60) NOT NULL DEFAULT '' COMMENT '服务名称，可通过控制台添加或从consul中同步',
  `service_desc` varchar(200) DEFAULT '' COMMENT '服务描述信息',
  `service_cluster_type` varchar(1) NOT NULL COMMENT '服务所属命名空间所属集群类型',
  `create_time` timestamp NOT NULL COMMENT '微服务记录生成时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '微服务记录更新时间',
  `app_id` varchar(60) NOT NULL DEFAULT '0' COMMENT '账号appId信息',
  `uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '账号owner uin信息',
  `sub_account_uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '账号create uin信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='服务信息表';