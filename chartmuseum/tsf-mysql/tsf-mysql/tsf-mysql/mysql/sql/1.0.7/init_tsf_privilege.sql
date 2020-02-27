-- Create tsf_auth schema
DROP SCHEMA IF EXISTS `tsf_privilege`;
CREATE SCHEMA `tsf_privilege` ;

-- Create Account
DROP USER IF EXISTS `tsf_privilege`;
CREATE USER `tsf_privilege`@'%' IDENTIFIED BY 'Tcdn@2007';
GRANT ALL PRIVILEGES ON tsf_privilege.* TO 'tsf_privilege'@'%' IDENTIFIED BY 'Tcdn@2007';
FLUSH PRIVILEGES;

-- Create Tables of tsf_privilege
-- TSF_COMMON_ID
DROP TABLE IF EXISTS `tsf_privilege`.`tsf_common_id`;
CREATE TABLE `tsf_privilege`.`tsf_common_id` (
  `id_type` varchar(20) NOT NULL COMMENT 'ID类型',
  `id_value` bigint(20) NOT NULL DEFAULT '0' COMMENT 'ID值',
  PRIMARY KEY (`id_type`)
) COMMENT='TSF通用基础模块ID表';
INSERT INTO `tsf_privilege`.`tsf_common_id` (id_type) values ("hashId");


-- tsf_privilege_program
DROP TABLE IF EXISTS `tsf_privilege`.`tsf_privilege_program`;
CREATE TABLE `tsf_privilege`.`tsf_privilege_program` (
  `program_id` varchar(20) NOT NULL COMMENT 'Program ID，物理主键',
  `program_name` varchar(50) NOT NULL COMMENT '数据权限名称',
  `program_desc` varchar(200) NULL COMMENT '数据权限描述',
  `creation_time` timestamp NOT NULL COMMENT '创建时间',
  `app_id` varchar(60) NOT NULL DEFAULT '0' COMMENT '账号appId信息',
  `uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '账号uin信息',
  `sub_account_uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '账号sub account uin信息',
  PRIMARY KEY (`program_id`)
) COMMENT='TSF数据权限表';

-- tsf_privilege_program_item
DROP TABLE IF EXISTS `tsf_privilege`.`tsf_privilege_program_item`;
CREATE TABLE `tsf_privilege`.`tsf_privilege_program_item` (
  `program_item_id` varchar(20) NOT NULL COMMENT 'Program Item ID，物理主键',
  `program_id` varchar(20) NOT NULL COMMENT '数据权限ID',
  `item_key` varchar(50) NOT NULL COMMENT '字段名',
  `item_value` varchar(2000) NOT NULL COMMENT '字段值，特殊值@ALL_CONDITION@',
  `url` varchar(1000) NULL COMMENT '字段取值URL',
  `creation_time` timestamp NOT NULL COMMENT '创建时间',
  `app_id` varchar(60) NOT NULL DEFAULT '0' COMMENT '账号appId信息',
  `uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '账号uin信息',
  `sub_account_uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '账号sub account uin信息',
  PRIMARY KEY (`program_item_id`)
) COMMENT='TSF数据权限项表';

-- tsf_privilege_urp
DROP TABLE IF EXISTS `tsf_privilege`.`tsf_privilege_urp`;
CREATE TABLE `tsf_privilege`.`tsf_privilege_urp` (
  `urp_id` varchar(20) NOT NULL COMMENT 'URP ID，物理主键',
  `user_id` varchar(60) NOT NULL COMMENT '用户ID，sub_account_uin',
  `role_id` varchar(20) NOT NULL COMMENT 'Role ID',
  `program_id` varchar(20) NOT NULL COMMENT 'Program ID',
  `enable_flag` varchar(1) NOT NULL DEFAULT 'Y' COMMENT '是否生效，Y生效；N失效',
  `start_time` timestamp NULL COMMENT '权限生效时间，包含当天',
  `expire_time` timestamp NULL COMMENT '权限过期时间，包含当天',
  `creation_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `app_id` varchar(60) NOT NULL DEFAULT '0' COMMENT '账号appId信息',
  `uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '账号uin信息',
  `sub_account_uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '账号sub account uin信息',
  PRIMARY KEY (`urp_id`)
) COMMENT='TSF用户角色权限表';

-- tsf_privilege_role
DROP TABLE IF EXISTS `tsf_privilege`.`tsf_privilege_role`;
CREATE TABLE `tsf_privilege`.`tsf_privilege_role` (
  `role_id` varchar(20) NOT NULL COMMENT 'Role ID，物理主键',
  `role_name` varchar(50) NOT NULL COMMENT '角色名称',
  `role_desc` varchar(200) NULL COMMENT '角色描述',
  `creation_time` timestamp NOT NULL COMMENT '创建时间',
  `app_id` varchar(60) NOT NULL DEFAULT '0' COMMENT '账号appId信息',
  `uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '账号uin信息',
  `sub_account_uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '账号sub account uin信息',
  PRIMARY KEY (`role_id`)
) COMMENT='TSF用户角色权限表';

-- tsf_privilege_permission
DROP TABLE IF EXISTS `tsf_privilege`.`tsf_privilege_permission`;
CREATE TABLE `tsf_privilege`.`tsf_privilege_permission` (
  `permission_id` varchar(20) NOT NULL COMMENT 'Permission ID，物理主键',
  `permission_code` varchar(200) NOT NULL COMMENT '权限点编码',
  `permission_desc` varchar(200) NULL COMMENT '权限点描述',
  `service_id` varchar(20) NOT NULL COMMENT '权限点来源，微服务ID',
  `creation_time` timestamp NOT NULL COMMENT '创建时间',
  `app_id` varchar(60) NOT NULL DEFAULT '0' COMMENT '账号appId信息',
  `uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '账号uin信息',
  `sub_account_uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '账号sub account uin信息',
  PRIMARY KEY (`permission_id`)
) COMMENT='TSF权限点表';

-- tsf_privilege_role_permission
DROP TABLE IF EXISTS `tsf_privilege`.`tsf_privilege_role_permission`;
CREATE TABLE `tsf_privilege`.`tsf_privilege_role_permission` (
  `rp_id` varchar(20) NOT NULL COMMENT 'Role Permission ID，物理主键',
  `permission_id` varchar(20) NOT NULL COMMENT 'Permission ID，物理主键',
  `role_id` varchar(20) NOT NULL COMMENT 'Role ID，tsf_privilege_role表主键',
  `creation_time` timestamp NOT NULL COMMENT '创建时间',
  `app_id` varchar(60) NOT NULL DEFAULT '0' COMMENT '账号appId信息',
  `uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '账号uin信息',
  `sub_account_uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '账号sub account uin信息',
  PRIMARY KEY (`rp_id`)
) COMMENT='TSF角色权限表';