ALTER TABLE `tsf_alarm`.`tsf_alarm_policy` ADD COLUMN `enabled` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '告警启停;1:启用;0:停用' AFTER `update_time`;

-- --------------------------------------------------------
-- Table structure for `tsf_alarm`.`tsf_alarm_event_definition`
-- --------------------------------------------------------
DROP TABLE IF EXISTS `tsf_alarm`.`tsf_alarm_event_definition`;
CREATE TABLE `tsf_alarm`.`tsf_alarm_event_definition` (
  `id` VARCHAR(64) NOT NULL,
  `policy_type_id` VARCHAR(64) NOT NULL COMMENT '关联策略类型表tsf_alarm_policy_type的id',
  `policy_type` VARCHAR(64) NOT NULL COMMENT '关联策略类型表tsf_alarm_policy_type',
  `event_name` VARCHAR(64) NOT NULL COMMENT '事件名',
  `event_desc` VARCHAR(64) NULL COMMENT '事件中文',
  `unit` VARCHAR(20) NOT NULL COMMENT '单位',
  `agg_type` INT NOT NULL COMMENT '聚集操作类型, 1:sum, 2:avg, 3:max, 4:min',
  PRIMARY KEY (`id`),
  KEY `idx_tsf_alarm_event_type` (`policy_type_id`)
)
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8
  COMMENT = '告警事件表定义';

INSERT INTO `tsf_alarm`.`tsf_alarm_event_definition` VALUES ('service_offline_event', '2', 'tsf', 'service_offline', '服务离线','次',1);
  
 
 -- --------------------------------------------------------
-- Table structure for `tsf_alarm`.`tsf_alarm_policy_event_detail`
-- --------------------------------------------------------
DROP TABLE IF EXISTS `tsf_alarm`.`tsf_alarm_policy_event_detail`;
CREATE TABLE `tsf_alarm`.`tsf_alarm_policy_event_detail` (
  `id` varchar(64) NOT NULL COMMENT '主键',
  `policy_id` varchar(64) NOT NULL COMMENT '关联tsf_alarm_policy表主键id',
  `event_id` VARCHAR(64)  NOT NULL COMMENT '事件id',
  `event_name` VARCHAR(64) NOT NULL COMMENT '事件名',
  `event_desc` VARCHAR(64) NULL COMMENT '事件中文',
  `stat_periods` int(11) NOT NULL DEFAULT '1' COMMENT '统计周期(1分钟,5分钟; 默认1分钟)',
  `conditions` int(11) NOT NULL COMMENT '比较条件(1: >, 2: >=, 3: <, 4: <=, 5: =, 6: !=)',
  `val` double NOT NULL COMMENT '指标值',
  `durations` int(11) NOT NULL COMMENT '持续周期数 (连续durations个周期告警触发,则告警生效)',
  `recovers` int(11) NOT NULL COMMENT '持续周期数 (连续recovers个周期告警未触发,则告警恢复)',
  `frequency` int(11) NOT NULL COMMENT '告警频率(例如每5分钟、10分钟、15分钟、30分钟、1小时、2小时、3小时、6小时、12小时、一天告警一次)',
  PRIMARY KEY (`id`),
  KEY `idx_policy_event_detail_policy_id` (`policy_id`)

)
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8
  COMMENT='告警策略事件详情表';