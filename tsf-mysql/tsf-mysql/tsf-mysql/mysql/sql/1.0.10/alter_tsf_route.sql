
-- 重命名服务路由tsf_route服务1.0.9版本数据库表
rename table `tsf_route`.`tsf_route_rule`  to `tsf_route`.`tsf_route_rule_old`;
rename table `tsf_route`.`tsf_route_tag_item` to `tsf_route`.`tsf_route_tag_item_old`;
rename table `tsf_route`.`tsf_route_weight_item` to `tsf_route`.`tsf_route_weight_item_old`;
rename table `tsf_route`.`tsf_route_release` to `tsf_route`.`tsf_route_release_old`;
rename table `tsf_route`.`tsf_route_release_log` to `tsf_route`.`tsf_route_release_log_old`;

-- TSF_ROUTE
DROP TABLE IF EXISTS `tsf_route`.`tsf_route`;
CREATE TABLE `tsf_route`.`tsf_route` (
  `id` varchar(20) NOT NULL COMMENT '主键ID，全局唯一',
  `route_name` varchar(60) NOT NULL COMMENT '路由名称',
  `route_desc` varchar(200) DEFAULT NULL COMMENT '路由描述',
  `ms_id` varchar(20) NOT NULL COMMENT '微服务Id',
  `create_time` timestamp NOT NULL COMMENT '路由创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '路由更新时间',
  `app_id` varchar(60) NOT NULL DEFAULT '0' COMMENT '公有云账户appid',
  `uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '公有云账户uin',
  `sub_account_uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '公有云账户subAccountUin',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='路由信息表';

-- TSF_ROUTE_RULE
DROP TABLE IF EXISTS `tsf_route`.`tsf_route_rule`;
CREATE TABLE `tsf_route`.`tsf_route_rule` (
  `id` varchar(20) NOT NULL COMMENT '主键ID，全局唯一',
  `route_id` varchar(20) NOT NULL COMMENT '路由规则所属路由Id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='路由规则信息表';

-- TSF_ROUTE_TAG
DROP TABLE IF EXISTS `tsf_route`.`tsf_route_tag`;
CREATE TABLE `tsf_route`.`tsf_route_tag` (
  `id` varchar(20) NOT NULL COMMENT '主键ID，全局唯一',
  `tag_type` varchar(1) NOT NULL COMMENT '标签类型， S：系统标签， U：自定义标签',
  `tag_field` varchar(128) NOT NULL COMMENT '标签字段名称',
  `tag_operator` varchar(20) NOT NULL COMMENT '标签匹配规则',
  `tag_value` varchar(1024) NOT NULL COMMENT '标签字段取值',
  `route_rule_id` varchar(20) NOT NULL COMMENT '路由标签所属路由规则Id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='路由标签信息表';


-- TSF_ROUTE_DEST
DROP TABLE IF EXISTS `tsf_route`.`tsf_route_dest`;
CREATE TABLE `tsf_route`.`tsf_route_dest` (
  `id` varchar(20) NOT NULL COMMENT '主键ID，全局唯一',
  `dest_weight` int(11) NOT NULL COMMENT '路由目的权重',
  `route_rule_id` varchar(20) NOT NULL COMMENT '路由目的所属路由规则Id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='路由目的信息表';

-- TSF_ROUTE_DEST_ITEM
DROP TABLE IF EXISTS `tsf_route`.`tsf_route_dest_item`;
CREATE TABLE `tsf_route`.`tsf_route_dest_item` (
  `id` varchar(20) NOT NULL COMMENT '主键ID，全局唯一',
  `dest_item_field` varchar(128) NOT NULL COMMENT '路由目的字段名称',
  `dest_item_value` varchar(1024) NOT NULL COMMENT '路由目的字段取值',
  `route_dest_id` varchar(20) NOT NULL COMMENT '路由目的项所属路由目的Id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='路由目的项信息表';

-- TSF_ROUTE_FALLBACK
DROP TABLE IF EXISTS `tsf_route`.`tsf_route_fallback`;
CREATE TABLE `tsf_route`.`tsf_route_fallback` (
  `id` varchar(20) NOT NULL COMMENT '主键ID，全局唯一',
  `ms_id` varchar(20) NOT NULL COMMENT '标签类型， S：系统标签， U：自定义标签',
  `fallback` boolean NULL COMMENT '是否启用路由保护策略',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '路由规则更新时间',
  `app_id` varchar(60) NOT NULL DEFAULT '0' COMMENT '公有云账户appid',
  `uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '公有云账户uin',
  `sub_account_uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '公有云账户subAccountUin',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='路由规则项TAG信息表';

-- TSF_ROUTE_RELEASE
DROP TABLE IF EXISTS `tsf_route`.`tsf_route_release`;
CREATE TABLE `tsf_route`.`tsf_route_release` (
  `id` varchar(20) NOT NULL COMMENT '路由规则部署ID，全局ID',
  `ms_id` varchar(20) NOT NULL COMMENT '微服务ID',
  `route_id` varchar(20) NOT NULL COMMENT '路由规则ID',
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
  `ms_id` varchar(20) NOT NULL COMMENT '微服务ID',
  `route_id` varchar(20) NOT NULL COMMENT '路由规则ID',
  `enable_time` timestamp NOT NULL COMMENT '路由规则部署生效时间',
  `disable_time` timestamp NULL DEFAULT NULL COMMENT '路由规则部署结束时间',
  `release_desc` varchar(200) DEFAULT NULL COMMENT '路由规则发布描述',
  `app_id` varchar(60) NOT NULL DEFAULT '0' COMMENT '公有云账户appid',
  `uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '公有云账户uin',
  `sub_account_uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '公有云账户subAccountUin',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='路由规则部署日志表';

ALTER TABLE `tsf_route`.`tsf_route_rule`
  ADD COLUMN `route_rule_index`  int(11) NOT NULL COMMENT '路由规则顺序Index' AFTER `route_id`;