-- 文件配置表
DROP TABLE IF EXISTS `tsf_dcfg`.`tsf_dcfg_file_config`;
CREATE TABLE `tsf_dcfg`.`tsf_dcfg_file_config` (
  `id` varchar(20) NOT NULL COMMENT '主键ID，全局唯一',
  `config_name` varchar(60) NOT NULL COMMENT '配置项名称',
  `config_version` varchar(30) NOT NULL COMMENT '配置项版本',
  `config_version_desc` varchar(200) DEFAULT NULL COMMENT '配置项版本描述',
  `config_file_name` varchar(60) NOT NULL COMMENT '配置项文件名称',
  `config_file_code` varchar(10) NOT NULL DEFAULT 'UTF-8' COMMENT '配置项文件编码',
  `config_file_value` mediumtext NOT NULL COMMENT '配置项文件内容',
  `config_file_path` varchar(100) DEFAULT NULL COMMENT '配置项文件路径',
  `config_post_cmd` varchar(200) DEFAULT NULL COMMENT '配置项后置命令',
  `application_id` varchar(20) DEFAULT NULL COMMENT '配置项归属应用ID',
  `creation_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `app_id` varchar(60) NOT NULL DEFAULT '0' COMMENT '公有云账户appid',
  `uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '公有云账户uin',
  `sub_account_uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '公有云账户subAccountUin',
  PRIMARY KEY (`id`)
)  COMMENT='文件配置项表';

-- 文件配置发布表
DROP TABLE IF EXISTS `tsf_dcfg`.`tsf_dcfg_file_config_release`;
CREATE TABLE `tsf_dcfg`.`tsf_dcfg_file_config_release` (
  `id` varchar(20) NOT NULL COMMENT '配置项发布信息ID，全局ID',
  `application_id` VARCHAR(20) NULL DEFAULT NULL COMMENT '应用ID',
  `config_id` varchar(20) NOT NULL COMMENT '配置项ID',
  `group_id` varchar(20) NOT NULL COMMENT '部署组ID',
  `release_desc` varchar(200) DEFAULT NULL COMMENT '发布描述',
  `release_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发布时间',
  `app_id` varchar(60) NOT NULL DEFAULT '0' COMMENT '公有云账户appid',
  `uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '公有云账户uin',
  `sub_account_uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '公有云账户subAccountUin',
  PRIMARY KEY (`id`)
) COMMENT='文件配置项发布表';

-- 文件配置项发布日志表
DROP TABLE IF EXISTS `tsf_dcfg`.`tsf_dcfg_file_config_release_log`;
CREATE TABLE `tsf_dcfg`.`tsf_dcfg_file_config_release_log` (
  `id` varchar(20) NOT NULL COMMENT '配置项发布日志ID，全局ID',
  `application_id` VARCHAR(20) NULL DEFAULT NULL COMMENT '应用ID',
  `config_id` varchar(20) DEFAULT NULL COMMENT '配置项ID',
  `group_id` varchar(20) NOT NULL COMMENT '部署组ID',
  `release_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '发布时间',
  `release_desc` varchar(200) DEFAULT NULL COMMENT '发布描述',
  `release_status` varchar(2) NOT NULL DEFAULT 'R' COMMENT '发布状态：S：发布成功；F：发布失败；RS：回滚成功；RF：回滚失败；DS：删除成功；DF：删除失败；',
  `last_config_id` varchar(20) DEFAULT NULL COMMENT '上次发布的配置ID',
  `app_id` varchar(60) NOT NULL DEFAULT '0' COMMENT '公有云账户appid',
  `uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '公有云账户uin',
  `sub_account_uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '公有云账户subAccountUin',
  PRIMARY KEY (`id`)
) COMMENT='文件配置项发布日志表';