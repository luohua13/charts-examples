-- Create tsf_record schema
DROP SCHEMA IF EXISTS `tsf_analyst`;
CREATE SCHEMA `tsf_analyst` ;

-- Create Account
DROP USER IF EXISTS `tsf_analyst`;
CREATE USER `tsf_analyst`@'%' IDENTIFIED BY 'Tcdn@2007';
GRANT ALL PRIVILEGES ON `tsf%`.* TO 'tsf_analyst'@'%' IDENTIFIED BY 'Tcdn@2007';
FLUSH PRIVILEGES;

-- Create Table in tsf_analyst
-- TSF_COMMON_ID
DROP TABLE IF EXISTS `tsf_analyst`.`tsf_common_id`;
CREATE TABLE `tsf_analyst`.`tsf_common_id` (
  `id_type` varchar(20) NOT NULL COMMENT 'ID类型',
  `id_value` bigint(20) NOT NULL DEFAULT '0' COMMENT 'ID值',
  PRIMARY KEY (`id_type`)
) COMMENT='TSF通用基础模块ID表';
INSERT INTO `tsf_analyst`.`tsf_common_id` (id_type) values ("hashId");


-- TSF_GOLDEN_EYE_INVOCATION_RECORD
DROP TABLE IF EXISTS `tsf_analyst`.`tsf_golden_eye_invocation_record`;
CREATE TABLE `tsf_analyst`.`tsf_golden_eye_invocation_record` (
  `record_id` varchar(20) NOT NULL COMMENT '主键ID，全局唯一',
  `app_id` varchar(64) NOT NULL DEFAULT '0' COMMENT '公有云账户appid',
  `trace_cnt` bigint(20) NOT NULL DEFAULT 0 COMMENT '调用trace计数',
  `span_cnt` bigint(20) NOT NULL DEFAULT 0 COMMENT '调用span计数',
  `statistic_date` date NOT NULL COMMENT '统计日期',
  `record_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录时间',
  PRIMARY KEY (`record_id`),
  UNIQUE KEY unique_record(`app_id`, `statistic_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='黄金眼客户调用量记录表';