-- Create tsf_route schema
DROP SCHEMA IF EXISTS `tsf_route`;
CREATE SCHEMA `tsf_route` ;

-- Create Account
DROP USER IF EXISTS `tsf_route`;
CREATE USER `tsf_route`@'%' IDENTIFIED BY 'Tcdn@2007';
GRANT ALL PRIVILEGES ON tsf_route.* TO 'tsf_route'@'%' IDENTIFIED BY 'Tcdn@2007';
FLUSH PRIVILEGES;

-- Create Table in TSF_ROUTE
-- TSF_COMMON_ID
DROP TABLE IF EXISTS `tsf_route`.`tsf_common_id`;
CREATE TABLE `tsf_route`.`tsf_common_id` (
  `id_type` varchar(20) NOT NULL COMMENT 'ID类型',
  `id_value` bigint(20) NOT NULL DEFAULT '0' COMMENT 'ID值',
  PRIMARY KEY (`id_type`)
) COMMENT='TSF通用基础模块ID表';
INSERT INTO `tsf_route`.`tsf_common_id` (id_type) values ("hashId");


-- TSF_ROUTE_RULE
DROP TABLE IF EXISTS `tsf_route`.`tsf_route_rule`;
CREATE TABLE `tsf_route`.`tsf_route_rule` (
  `id` varchar(20) NOT NULL COMMENT '主键ID，全局唯一',
  `route_name` varchar(60) NOT NULL COMMENT '路由规则名称',
  `route_type` varchar(1) NOT NULL COMMENT '路由规则类型， T: TAG路由；W：权重路由',
  `route_desc` varchar(200) DEFAULT NULL COMMENT '路由规则描述',
  `ms_id` varchar(20) DEFAULT NULL COMMENT '微服务Id',
  `create_time` timestamp NOT NULL COMMENT '路由规则创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '路由规则更新时间',
  `app_id` varchar(60) NOT NULL DEFAULT '0' COMMENT '公有云账户appid',
  `uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '公有云账户uin',
  `sub_account_uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '公有云账户subAccountUin',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='路由规则表';


-- TSF_ROUTE_TAG_ITEM
DROP TABLE IF EXISTS `tsf_route`.`tsf_route_tag_item`;
CREATE TABLE `tsf_route`.`tsf_route_tag_item` (
  `id` varchar(20) NOT NULL COMMENT '标签路由ID，全局唯一',
  `source_type` varchar(1) NOT NULL DEFAULT 'S' COMMENT '标签类型, S: 系统标签； U:自定义标签',
  `source_field` varchar(60) NOT NULL COMMENT '路由匹配源字段',
  `source_match_rule` varchar(30) NOT NULL COMMENT '路由匹配规则',
  `source_value` varchar(200) DEFAULT NULL COMMENT '路由匹配源取值',
  `target_field` varchar(60) NOT NULL COMMENT '路由匹配目标字段',
  `target_value` varchar(200) NOT NULL COMMENT '路由匹配目标取值',
  `route_rule_id` varchar(20) DEFAULT NULL COMMENT '所属路由规则id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='TAG路由表';

-- TSF_ROUTE_WEIGHT_ITEM
DROP TABLE IF EXISTS `tsf_route`.`tsf_route_weight_item`;
CREATE TABLE `tsf_route`.`tsf_route_weight_item` (
  `id` varchar(20) NOT NULL COMMENT '权重路由ID，全局唯一',
  `source_percent` int(11) NOT NULL COMMENT '权重百分比',
  `target_field` varchar(60) DEFAULT NULL COMMENT '路由目标字段',
  `target_value` varchar(200) NOT NULL COMMENT '路由目标字段',
  `route_rule_id` varchar(20) DEFAULT NULL COMMENT '所属路由规则id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='权重路由表';

-- TSF_ROUTE_RELEASE
DROP TABLE IF EXISTS `tsf_route`.`tsf_route_release`;
CREATE TABLE `tsf_route`.`tsf_route_release` (
  `id` varchar(20) NOT NULL COMMENT '路由规则部署ID，全局ID',
  `ms_id` varchar(20) NOT NULL COMMENT '微服务ID',
  `route_rule_id` varchar(20) NOT NULL COMMENT '路由规则ID',
  `enable_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '路由规则部署时间',
  `release_log_id` varchar(20) NOT NULL DEFAULT '' COMMENT '路由发布日志ID',
  `app_id` varchar(60) NOT NULL DEFAULT '0' COMMENT '公有云账户appid',
  `uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '公有云账户uin',
  `sub_account_uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '公有云账户subAccountUin',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='路由规则部署状态表';

-- TSF_ROUTE_RELEASE_LOG
DROP TABLE IF EXISTS `tsf_route`.`tsf_route_release_log`;
CREATE TABLE `tsf_route`.`tsf_route_release_log` (
  `id` varchar(20) NOT NULL COMMENT '路由发布日志ID，全局ID',
  `ms_id` varchar(20) DEFAULT NULL COMMENT '微服务ID',
  `route_rule_id` varchar(20) NOT NULL COMMENT '路由规则ID',
  `enable_time` timestamp NOT NULL COMMENT '路由规则部署生效时间',
  `disable_time` timestamp NULL DEFAULT NULL COMMENT '路由规则部署结束时间',
  `release_desc` varchar(200) DEFAULT NULL COMMENT '路由规则发布描述',
  `app_id` varchar(60) NOT NULL DEFAULT '0' COMMENT '公有云账户appid',
  `uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '公有云账户uin',
  `sub_account_uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '公有云账户subAccountUin',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='路由规则部署日志表';