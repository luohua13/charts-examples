-- Create tsf_scalable schema
DROP SCHEMA IF EXISTS `tsf_scalable`;
CREATE SCHEMA `tsf_scalable` ;

-- Create Account
DROP USER IF EXISTS `tsf_scalable`;
CREATE USER `tsf_scalable`@'%' IDENTIFIED BY 'Tcdn@2007';
GRANT ALL PRIVILEGES ON tsf_scalable.* TO 'tsf_scalable'@'%' IDENTIFIED BY 'Tcdn@2007';
FLUSH PRIVILEGES;

-- Create Table in tsf_scalable

DROP TABLE IF EXISTS `tsf_scalable`.`tsf_common_id`;
CREATE TABLE `tsf_scalable`.`tsf_common_id` (
  `id_type` varchar(20) NOT NULL COMMENT 'ID类型',
  `id_value` bigint(20) NOT NULL DEFAULT '0' COMMENT 'ID值',
  PRIMARY KEY (`id_type`)
) COMMENT='TSF通用基础模块ID表';
INSERT INTO `tsf_scalable`.`tsf_common_id` (id_type) values ("hashId");

DROP TABLE IF EXISTS `tsf_scalable`.`tsf_scalable_rule`;
CREATE TABLE `tsf_scalable`.`tsf_scalable_rule` (
  `rule_id` varchar(20) NOT NULL COMMENT 'tsf_scalable_rule表主键',
  `app_id` varchar(60) NOT NULL COMMENT '腾讯云appid',
  `sub_account_uin` varchar(60) NOT NULL COMMENT '规则创建者',
  `uin` varchar(60) NOT NULL COMMENT '腾讯云ownerUin',
  `region_id` varchar(20) NOT NULL COMMENT '所属地域',
  `name` varchar(128) NOT NULL COMMENT '规则名称',
  `enable_shrink` tinyint(3) unsigned NOT NULL COMMENT '是否包含缩容规则, 0:否 1:是',
  `enable_expand` tinyint(3) unsigned NOT NULL COMMENT '是否包含扩容规则, 0:否 1:是',
  `expand_vm_count` int(10) unsigned NOT NULL COMMENT '单次扩容机器数量',
  `shrink_vm_count` int(10) unsigned NOT NULL COMMENT '单次缩容机器数量',
  `cool_time` int(10) unsigned NOT NULL COMMENT '扩缩容冷却时间, 单位:s',
  `expand_vm_count_limit` smallint(5) unsigned NOT NULL COMMENT '扩容后部署组实例最大数量',
  `shrink_vm_count_limit` smallint(5) unsigned NOT NULL COMMENT '缩容后部署组实例最小数量',
  `expand_period` smallint(5) unsigned NOT NULL COMMENT '扩容规则持续时间，s',
  `shrink_period` smallint(5) unsigned NOT NULL COMMENT '缩容规则持续时间，s',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`rule_id`),
  UNIQUE KEY `user_rule_name` (`app_id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='弹性扩缩容规则表';

DROP TABLE IF EXISTS `tsf_scalable`.`tsf_scalable_rule_group_relation`;
CREATE TABLE `tsf_scalable`.`tsf_scalable_rule_group_relation` (
  `rule_id` varchar(20) NOT NULL COMMENT 'tsf_scalable_rule表主键 ',
  `application_id` varchar(20) NOT NULL COMMENT '应用id',
  `group_id` varchar(20) NOT NULL COMMENT '部署组id',
  `status` tinyint(3) unsigned NOT NULL COMMENT '部署组状态： 1:启用 2:关闭 ',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`rule_id`,`application_id`,`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='弹性扩缩容规则和部署组关联表';

DROP TABLE IF EXISTS `tsf_scalable`.`tsf_scalable_subRule`;
CREATE TABLE `tsf_scalable`.`tsf_scalable_subRule` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id，主键',
  `rule_id` varchar(20) NOT NULL COMMENT 'rule表主键，表明子规则所属rule',
  `indicators_type` tinyint(3) unsigned NOT NULL COMMENT '监控类型：1:CPU, 2:MEM, 3:RT',
  `indicators` int(10) unsigned NOT NULL COMMENT '监控指标，如监控CPU和MEM，则为百分比；监控RT，则为响应时间',
  `rule_type` tinyint(3) unsigned NOT NULL COMMENT '规则类型， 1:扩容 2:缩容',
  PRIMARY KEY (`id`),
  KEY `rule_id` (`rule_id`)
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8 COMMENT='监控子规则表';

