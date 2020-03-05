SET FOREIGN_KEY_CHECKS=0;
-- Create tsf_scalable schema
DROP SCHEMA IF EXISTS `tsf_alarm`;
CREATE SCHEMA `tsf_alarm` ;

-- Create Account
DROP USER IF EXISTS `tsf_alarm`;
CREATE USER `tsf_alarm`@'%' IDENTIFIED BY 'Tcdn@2007';
GRANT ALL PRIVILEGES ON tsf_alarm.* TO 'tsf_alarm'@'%' IDENTIFIED BY 'Tcdn@2007';
FLUSH PRIVILEGES;


-- --------------------------------------------------------
-- Table structure for `tsf_alarm`.`tsf_alarm_policy_type`
-- --------------------------------------------------------
DROP TABLE IF EXISTS `tsf_alarm`.`tsf_alarm_policy_type`;
CREATE TABLE `tsf_alarm`.`tsf_alarm_policy_type` (
  `id` VARCHAR(64) NOT NULL COMMENT '主键',
  `name` VARCHAR(64) NOT NULL COMMENT '策略类型名',
  `parent_id` VARCHAR(64) COMMENT '引用主键，树形结构',
  `description` VARCHAR(64) NULL COMMENT '策略类型中文名',
  `transform_url` VARCHAR(1024) NULL COMMENT '对象转换回调接口',
  PRIMARY KEY (`id`)
)
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8
  COMMENT = '告警策略类型';


INSERT INTO `tsf_alarm`.`tsf_alarm_policy_type` VALUES ('1', 'tsf_log', null, '	TSF日志告警','http://127.0.0.1:17500/monitorPolicy/findMonitorObject');
INSERT INTO `tsf_alarm`.`tsf_alarm_policy_type` VALUES ('2', 'tsf', null, '服务指标告警',null);



-- --------------------------------------------------------
-- Table structure for `tsf_alarm`.`tsf_alarm_dimension_definition`
-- --------------------------------------------------------
DROP TABLE IF EXISTS `tsf_alarm`.`tsf_alarm_dimension_definition`;
CREATE TABLE `tsf_alarm`.`tsf_alarm_dimension_definition` (
  `id` varchar(64) NOT NULL,
  `policy_type_id` varchar(64) NOT NULL COMMENT '关联策略类型表tsf_alarm_policy_type',
  `dimension_name` varchar(64) NOT NULL COMMENT '纬度名，用于上报时序数据库',
  `dimension_alias_name` varchar(64) NOT NULL COMMENT '纬度名,用于前端页面',
  `dimension_desc` varchar(128) DEFAULT NULL COMMENT '纬度中文描述',
  `order_no` int(11) NOT NULL COMMENT '该纬度在告警对象中的位置',
  PRIMARY KEY (`id`),
  KEY `idx_tsf_alarm_metric_app_project_type` (`policy_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='告警纬度表,用于定义策略类型和项目的有哪些纬度';

-- ----------------------------
-- Records of tsf_alarm_dimension_definition
-- ----------------------------
INSERT INTO `tsf_alarm`.`tsf_alarm_dimension_definition` VALUES ('1', '1', 'app_id', 'appId', '用户的APP ID', '1');
INSERT INTO `tsf_alarm`.`tsf_alarm_dimension_definition` VALUES ('2', '1', 'group_id', 'groupId', '部署组ID', '2');
INSERT INTO `tsf_alarm`.`tsf_alarm_dimension_definition` VALUES ('3', '1', 'keyword_id', 'keywordsId', '关键词ID', '3');

INSERT INTO `tsf_alarm`.`tsf_alarm_dimension_definition` VALUES ('4', '2', 'app_id', 'appId', '用户的APP ID', '1');
INSERT INTO `tsf_alarm`.`tsf_alarm_dimension_definition` VALUES ('5', '2', 'service_name', 'serviceName', '服务名', '2');
INSERT INTO `tsf_alarm`.`tsf_alarm_dimension_definition` VALUES ('6', '2', 'namespace_id', 'namespaceId', '命名空间id', '3');




-- --------------------------------------------------------
-- Table structure for `tsf_alarm`.`tsf_alarm_metric_definition`
-- --------------------------------------------------------
DROP TABLE IF EXISTS `tsf_alarm`.`tsf_alarm_metric_definition`;
CREATE TABLE `tsf_alarm`.`tsf_alarm_metric_definition` (
  `id` VARCHAR(64) NOT NULL,
  `policy_type_id` VARCHAR(64) NOT NULL COMMENT '关联策略类型表tsf_alarm_policy_type的id',
  `policy_type` VARCHAR(64) NOT NULL COMMENT '关联策略类型表tsf_alarm_policy_type',
  `metric_name` VARCHAR(64) NOT NULL COMMENT '指标名',
  `metric_desc` VARCHAR(64) NULL COMMENT '指标中文',
  `metric_unit` VARCHAR(20) NOT NULL COMMENT '指标单位',
  `agg_type` INT NOT NULL COMMENT '聚集操作类型, 1:sum, 2:avg, 3:max, 4:min',
  PRIMARY KEY (`id`),
  KEY `idx_tsf_alarm_metric_type` (`policy_type_id`)
)
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8
  COMMENT = '告警指标表定义';


INSERT INTO `tsf_alarm`.`tsf_alarm_metric_definition` VALUES ('1', '1', 'tsf_log', 'keyword_count', '关键词出现次数', '次', '1');

INSERT INTO `tsf_alarm`.`tsf_alarm_metric_definition` VALUES ('2', '2', 'tsf', 'req_count', '接收请求量', '次', '1');
INSERT INTO `tsf_alarm`.`tsf_alarm_metric_definition` VALUES ('3', '2', 'tsf', 'avg_duration_ms', '请求平均耗时', '毫秒', '2');
INSERT INTO `tsf_alarm`.`tsf_alarm_metric_definition` VALUES ('4', '2', 'tsf', 'fail_rate', '请求失败率', '%', '2');

-- --------------------------------------------------------
-- Table structure for `tsf_alarm`.`tsf_alarm_object`
-- --------------------------------------------------------
DROP TABLE IF EXISTS `tsf_alarm`.`tsf_alarm_object`;
CREATE TABLE `tsf_alarm`.`tsf_alarm_object` (
  `id` VARCHAR(64) NOT NULL COMMENT '主键',
  `policy_id` VARCHAR(64) NOT NULL COMMENT '关联tsf_alarm_policy表主键id',
  `object_ext1` VARCHAR(64) NOT NULL ,
  `object_ext2` VARCHAR(64) NULL,
  `object_ext3` VARCHAR(64) NULL,
  `object_ext4` VARCHAR(64) NULL,
  `object_ext5` VARCHAR(64) NULL,
  `object_ext6` VARCHAR(64) NULL,
  `object_ext7` VARCHAR(64) NULL,
  `object_ext8` VARCHAR(64) NULL,
  PRIMARY KEY (`id`),
  KEY `idx_tsf_alarm_object_app_project_policy` (`policy_id`)
)
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8
  COMMENT = '告警对象表; 该告警策略配置的告警对象';


-- --------------------------------------------------------
-- Table structure for `tsf_alarm`.`tsf_alarm_policy`
-- --------------------------------------------------------
DROP TABLE IF EXISTS `tsf_alarm`.`tsf_alarm_policy`;
CREATE TABLE `tsf_alarm`.`tsf_alarm_policy` (
  `id` VARCHAR(64) NOT NULL COMMENT '主键',
  `policy_name` VARCHAR(64) NOT NULL COMMENT '策略名',
  `policy_type_id` VARCHAR(64) NOT NULL COMMENT '策略类型',
  `policy_type` VARCHAR(64) NOT NULL COMMENT '策略类型名',
  `email_enabled` TINYINT(1) NOT NULL DEFAULT 0,
  `sms_enabled` TINYINT(1) NOT NULL DEFAULT 0,
  `phone_enabled` TINYINT(1) NOT NULL DEFAULT 0,
  `cluster_id` varchar(20) NOT NULL COMMENT '命名空间所属集群信息',
  `namespace_id` varchar(20) NOT NULL DEFAULT '' COMMENT '分组所属命名空间信息',
  `project_id` VARCHAR(20) NOT NULL DEFAULT '' COMMENT '所属项目',
  `app_id` varchar(60) NOT NULL COMMENT '用户的APP ID',
  `uin` varchar(60) NOT NULL COMMENT '用户的Uin',
  `sub_account_uin` varchar(60) NOT NULL COMMENT '用户的SubAccountUin',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_tsf_alarm_policy_app_project_type` (`app_id`,`project_id`,`policy_type_id`),
  KEY `idx_tsf_alarm_policy_type` (`policy_type_id`)
)
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8
  COMMENT = '告警策略表';


-- --------------------------------------------------------
-- Table structure for `tsf_alarm`.`tsf_alarm_policy_detail`
-- --------------------------------------------------------
DROP TABLE IF EXISTS `tsf_alarm`.`tsf_alarm_policy_detail`;
CREATE TABLE `tsf_alarm`.`tsf_alarm_policy_detail` (
  `id` varchar(64) NOT NULL COMMENT '主键',
  `policy_id` varchar(64) NOT NULL COMMENT '关联tsf_alarm_policy表主键id',
  `metric_id` VARCHAR(64)  NOT NULL COMMENT '指标id',
  `metric_name` VARCHAR(64) NOT NULL COMMENT '指标id',
  `stat_periods` int(11) NOT NULL DEFAULT '1' COMMENT '统计周期(1分钟,5分钟; 默认1分钟)',
  `conditions` int(11) NOT NULL COMMENT '比较条件(1: >, 2: >=, 3: <, 4: <=, 5: =, 6: !=)',
  `val` double NOT NULL COMMENT '指标值',
  `durations` int(11) NOT NULL COMMENT '持续周期数 (连续durations个周期告警触发,则告警生效)',
  `recovers` int(11) NOT NULL COMMENT '持续周期数 (连续recovers个周期告警未触发,则告警恢复)',
  `frequency` int(11) NOT NULL COMMENT '告警频率(例如每5分钟、10分钟、15分钟、30分钟、1小时、2小时、3小时、6小时、12小时、一天告警一次)',
  PRIMARY KEY (`id`),
  KEY `idx_tsf_alarm_policy_detail_app_project_type` (`policy_id`)

)
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8
  COMMENT='告警策略详情表';


-- --------------------------------------------------------
-- Table structure for `tsf_alarm`.`tsf_alarm_event`
-- --------------------------------------------------------
DROP TABLE IF EXISTS `tsf_alarm`.`tsf_alarm_event`;
CREATE TABLE `tsf_alarm`.`tsf_alarm_event` (
  `id` VARCHAR(64) NOT NULL COMMENT '主键id',
  `obj_id` VARCHAR(800) NOT NULL COMMENT '告警对象id',
  `metric_id` VARCHAR(64) NOT NULL,
  `sequence_id` BIGINT NOT NULL,
  `period_type` int(11) NOT NULL COMMENT '周期类型, 1:一分钟, 5:五分钟',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `project_id` VARCHAR(64) NOT NULL DEFAULT '' COMMENT '所属项目',
  `app_id` varchar(60) NOT NULL COMMENT '用户的APP ID',
  `uin` varchar(60) NOT NULL COMMENT '用户的Uin',
  `sub_account_uin` varchar(60) NOT NULL COMMENT '用户的SubAccountUin',
  PRIMARY KEY (`id`),
  KEY `idx_tsf_alarm_event_obj_metric` (`app_id` ASC ,`project_id`ASC ,`obj_id` ASC, `metric_id` ASC, period_type ASC, `sequence_id` ASC)
)
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8
  COMMENT = '告警事件表, 统计周期1分钟';


-- --------------------------------------------------------
-- Table structure for `tsf_alarm`.`tsf_alarm_task`
-- --------------------------------------------------------
DROP TABLE IF EXISTS `tsf_alarm`.`tsf_alarm_task`;
CREATE TABLE `tsf_alarm`.`tsf_alarm_task` (
  `task_id` VARCHAR(64) NOT NULL COMMENT '主键id',
  `ip` VARCHAR(15) NOT NULL COMMENT '任务在该ip上执行',
  `port` int(11) NOT NULL COMMENT '任务在该port上执行',
  `status` int(11) NOT NULL COMMENT '标记任务执行状态。0:初始化;1:已分配;2:执行中;3:成功;4:失败;',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `project_id` VARCHAR(64) NOT NULL COMMENT '所属项目',
  `app_id` varchar(60) NOT NULL COMMENT '用户的APP ID',
  `uin` varchar(60) NOT NULL COMMENT '用户的Uin',
  `sub_account_uin` varchar(60) NOT NULL COMMENT '用户的SubAccountUin',
  PRIMARY KEY (`task_id`),
  KEY `idx_tsf_alarm_event_obj_metric` (`app_id` ASC ,`project_id`ASC ,`status` ASC)
)
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8
  COMMENT = '告警事件表, 统计周期1分钟';


-- --------------------------------------------------------
-- Table structure for `tsf_alarm`.`tsf_alarm_people`
-- --------------------------------------------------------
DROP TABLE IF EXISTS `tsf_alarm`.`tsf_alarm_people`;
CREATE TABLE `tsf_alarm`.`tsf_alarm_people` (
  `id` VARCHAR(64) NOT NULL COMMENT '主键',
  `policy_id` VARCHAR(64) NOT NULL COMMENT '策略id',
  `people_id` VARCHAR(64) NOT NULL COMMENT '告警人员id'
)
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8
  COMMENT = '告警人员表';


-- --------------------------------------------------------
-- Table structure for `tsf_alarm`.`tsf_alarm_list`
-- --------------------------------------------------------
DROP TABLE IF EXISTS `tsf_alarm`.`tsf_alarm_list`;
CREATE TABLE `tsf_alarm`.`tsf_alarm_list` (
  `id` varchar(64) NOT NULL COMMENT '告警id',
  `policy_type_id` varchar(64) NOT NULL COMMENT '告警策略类型id',

  `policy_id` varchar(64) NOT NULL COMMENT '告警策略id',
  `policy_name` varchar(64) NOT NULL COMMENT '告警策略名',
  `first_occur_time` datetime NOT NULL COMMENT '告警首次发生时间',
  `last_occur_time` datetime NOT NULL COMMENT '告警最后发生时间',
  `last_send_time` datetime NULL COMMENT '告警最后发送时间',
  `recovery_time` datetime NULL COMMENT '告警恢复时间',
  `occur_count` int(11) NOT NULL COMMENT '告警发生次数',
  `shield_count` int(11) NOT NULL COMMENT '告警收敛次数',
  `send_count` int(11) NOT NULL COMMENT '告警发送次数',
  `send_status` int(11) NOT NULL COMMENT '标记是否已发送过告警。0 未发送; 1 成功; 2：收敛，3 失败',
  `alarm_level` int(11) NOT NULL COMMENT '告警级别。1 严重；2 异常；3 一般',
  `ok_status` int(11) NOT NULL COMMENT '标记是否恢复。0 未恢复；1 已恢复;2未知状态',
  `email_enabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '告警渠道:邮件',
  `sms_enabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '告警渠道:短信',
  `phone_enabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '告警渠道:电话',
  `obj_id` VARCHAR(800) NOT NULL COMMENT '告警对象ID',
  `metric_id` VARCHAR(64) NOT NULL COMMENT '指标ID',
  `metric_name` varchar(256) DEFAULT NULL,
  `val` double NULL COMMENT '数值',
  `alarm_content` TEXT NOT NULL COMMENT '告警内容',
  `alarm_title` TEXT NOT NULL COMMENT '告警标题',
  `sendlist` TEXT NOT NULL COMMENT '告警接受者',
  `cluster_id` varchar(20) NOT NULL COMMENT '命名空间所属集群信息',
  `namespace_id` varchar(20) NOT NULL DEFAULT '' COMMENT '分组所属命名空间信息',
  `project_id` VARCHAR(64) NOT NULL DEFAULT '' COMMENT '所属项目',
  `app_id` varchar(60) NOT NULL DEFAULT '0' COMMENT '账号appId信息',
  `uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '账号owner uin信息',
  `sub_account_uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '账号 uin信息',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_tsf_alarm_list_app_project_obj_metric` (`policy_type_id`,`app_id`,`obj_id`,`metric_id`),
  KEY `idx_tsf_alarm_list_last_occur_time`(`last_occur_time`)
)
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8
  COMMENT='告警记录表';


-- ----------------------------
-- Table structure for `tsf_common_id`
-- ----------------------------
DROP TABLE IF EXISTS `tsf_alarm`.`tsf_common_id`;
CREATE TABLE `tsf_alarm`.`tsf_common_id` (
  `id_type` varchar(20) NOT NULL COMMENT 'ID类型',
  `id_value` bigint(20) NOT NULL DEFAULT '0' COMMENT 'ID值',
  PRIMARY KEY (`id_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='TSF通用基础模块ID表';

-- ----------------------------
-- Records of tsf_common_id
-- ----------------------------
INSERT INTO `tsf_alarm`.`tsf_common_id` VALUES ('hashId', '1');
