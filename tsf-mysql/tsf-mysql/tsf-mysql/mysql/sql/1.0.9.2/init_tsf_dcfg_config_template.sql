DROP TABLE IF EXISTS tsf_dcfg.tsf_dcfg_config_template;
CREATE TABLE tsf_dcfg.tsf_dcfg_config_template (
	id varchar(20) NOT NULL COMMENT '主键ID，全局唯一',
	config_template_name varchar(60) NOT NULL COMMENT '配置模板名称',
	config_template_desc varchar(200)	DEFAULT NULL COMMENT '配置模板描述',
	config_template_type varchar(30) NOT NULL COMMENT '配置模板对应的微服务框架，如Hystrix',
	config_template_value text NOT NULL COMMENT '配置模板键值，yaml格式存储',
	create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	update_time timestamp NULL COMMENT '最后更新时间',
	app_id varchar(60) NOT NULL DEFAULT '0'	COMMENT '公有云账户appid',
	uin varchar(60) NOT NULL DEFAULT '0' COMMENT '公有云账户uin',
	sub_account_uin varchar(60) NOT NULL DEFAULT '0' COMMENT '公有云账户subAccountUin',
	PRIMARY KEY(id)
) default charset utf8 COMMENT='配置模板';