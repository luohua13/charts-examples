-- Create tsf_scalable schema
DROP SCHEMA IF EXISTS `tsf_monitor`;
CREATE SCHEMA `tsf_monitor` ;

-- Create Account
DROP USER IF EXISTS `tsf_monitor`;
CREATE USER `tsf_monitor`@'%' IDENTIFIED BY 'Tcdn@2007';
GRANT ALL PRIVILEGES ON tsf_monitor.* TO 'tsf_monitor'@'%' IDENTIFIED BY 'Tcdn@2007';
FLUSH PRIVILEGES;


-- Create Tables of tsf_monitor
-- TSF_COMMON_ID
DROP TABLE IF EXISTS `tsf_monitor`.`tsf_common_id`;
CREATE TABLE `tsf_monitor`.`tsf_common_id` (
  `id_type` varchar(20) NOT NULL COMMENT 'ID类型',
  `id_value` bigint(20) NOT NULL DEFAULT '0' COMMENT 'ID值',
  PRIMARY KEY (`id_type`)
) COMMENT='TSF通用基础模块ID表';
INSERT INTO `tsf_monitor`.`tsf_common_id` (id_type) values ("hashId");


-- Create Table in tsf_monitor_kv
DROP TABLE IF EXISTS `tsf_monitor`.`tsf_monitor_kv`;
CREATE TABLE `tsf_monitor`.`tsf_monitor_kv` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '主键',
  `busi_type` VARCHAR(64) NOT NULL COMMENT '业务类型',
  `keyname` VARCHAR(64) NOT NULL COMMENT '键名',
  `val` VARCHAR(256) NULL COMMENT '键值',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  UNIQUE  INDEX tsf_monitor_kv_uid(`busi_type`, `keyname`),
  PRIMARY KEY (`id`)
)
COMMENT = '监控kv表';


INSERT INTO `tsf_monitor`.`tsf_monitor_kv` (`busi_type`, `keyname`, `val`, `create_time`) VALUES ('RUN_TASK', 'REPORT_TRACE_CHAIN_TO_BARAD', '0', CURRENT_TIMESTAMP);
INSERT INTO `tsf_monitor`.`tsf_monitor_kv` (`busi_type`, `keyname`, `val`, `create_time`) VALUES ('RUN_TASK', 'REPORT_LOG_TO_BARAD', '0', CURRENT_TIMESTAMP);
INSERT INTO `tsf_monitor`.`tsf_monitor_kv` (`busi_type`, `keyname`, `create_time`) VALUES ('RUN_TASK', 'REPORT_TRACE_CHAIN_TO_BARAD_TIME_OFFSET', CURRENT_TIMESTAMP);
INSERT INTO `tsf_monitor`.`tsf_monitor_kv` (`busi_type`, `keyname`, `create_time`) VALUES ('RUN_TASK', 'REPORT_LOG_TO_BARAD_TIME_OFFSET', CURRENT_TIMESTAMP);





-- Create Table in tsf_monitor_stats_policy
DROP TABLE IF EXISTS `tsf_monitor`.`tsf_monitor_stats_policy`;
CREATE TABLE `tsf_monitor`.`tsf_monitor_stats_policy` (
  `policy_id` VARCHAR(20) NOT NULL COMMENT '主键ID，全局唯一',
  `key_words` VARCHAR(256) NOT NULL COMMENT '监控关键词',
  `group_ids` TEXT NOT NULL COMMENT '关联的部署组id列表; 以‘;’分割',
  `namespace_id` varchar(20) NOT NULL DEFAULT '' COMMENT '监控策略所属命名空间信息',
  `app_id` VARCHAR(60) NOT NULL DEFAULT 0 COMMENT '账号appId信息',
  `uin` VARCHAR(60) NOT NULL DEFAULT 0 COMMENT '账号owner uin信息',
  `sub_account_uin` VARCHAR(60) NOT NULL DEFAULT 0 COMMENT '账号create uin信息',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  INDEX tsf_monitor_stats_policy_idx(`app_id`, `namespace_id`),
  PRIMARY KEY (`policy_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'tsf监控告警统计规则表';