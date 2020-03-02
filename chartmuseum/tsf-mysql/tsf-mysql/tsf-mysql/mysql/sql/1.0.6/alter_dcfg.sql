CREATE TABLE `tsf_dcfg`.`tsf_dcfg_pub_config` (
  `id` varchar(20) NOT NULL COMMENT '主键ID，全局唯一',
  `config_name` varchar(60) NOT NULL COMMENT '配置项名称',
  `config_version` varchar(30) NOT NULL COMMENT '配置项版本',
  `config_version_desc` varchar(200) DEFAULT NULL COMMENT '配置项版本描述',
  `config_value` text NOT NULL COMMENT '配置项值',
  `creation_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `app_id` varchar(60) NOT NULL DEFAULT '0' COMMENT '公有云账户appid',
  `uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '公有云账户uin',
  `sub_account_uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '公有云账户subAccountUin',
  PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET = utf8 COMMENT='公共配置项表';

CREATE TABLE `tsf_dcfg`.`tsf_dcfg_pub_config_release` (
  `id` varchar(20) NOT NULL COMMENT '配置项部署信息ID，全局ID',
  `config_id` varchar(20) NOT NULL COMMENT '配置项ID',
  `namespace_id` varchar(20) NOT NULL COMMENT '命名空间ID',
  `app_id` varchar(60) NOT NULL DEFAULT '0' COMMENT '公有云账户appid',
  `uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '公有云账户uin',
  `sub_account_uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '公有云账户subAccountUin',
  PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET = utf8 COMMENT='公共配置项发布表';

CREATE TABLE `tsf_dcfg`.`tsf_dcfg_pub_config_release_log` (
  `id` varchar(20) NOT NULL COMMENT '配置项发布日志ID，全局ID',
  `config_id` varchar(20) DEFAULT NULL COMMENT '配置项ID',
  `namespace_id` varchar(20) NOT NULL COMMENT '命名空间ID',
  `release_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '发布时间',
  `release_desc` varchar(200) DEFAULT NULL COMMENT '发布描述',
  `release_status` varchar(2) NOT NULL DEFAULT 'R' COMMENT '发布状态：S：发布成功；F：发布失败；RS：回滚成功；RF：回滚失败；DS：删除成功；DF：删除失败；',
  `last_config_id` varchar(20) DEFAULT NULL COMMENT '上次发布的配置ID',
  `app_id` varchar(60) NOT NULL DEFAULT '0' COMMENT '公有云账户appid',
  `uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '公有云账户uin',
  `sub_account_uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '公有云账户subAccountUin',
  PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET = utf8 COMMENT='公共配置项发日志布表';