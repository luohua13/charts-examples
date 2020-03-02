-- 存放需要异步加入集群的机器列表
DROP TABLE IF EXISTS `tsf_resource`.`tsf_resource_instance_ssh_host`;
CREATE TABLE `tsf_resource`.`tsf_resource_instance_ssh_host`
(
  `id`              varchar(32) NOT NULL COMMENT '主键',
  `instance_id`     varchar(20) NOT NULL COMMENT '机器ID',
  `host`            varchar(64) NOT NULL COMMENT '机器 IP',
  `port`            int(11)     NOT NULL COMMENT '机器端口',
  `username`        varchar(32) NOT NULL COMMENT '机器用户名',
  `password`        varchar(32) NOT NULL COMMENT '机器密码',
  `status`          varchar(32) NOT NULL COMMENT '机器状态，具体数值及含义参考代码',
  `create_time`     timestamp   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time`     timestamp   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `app_id`          varchar(60) NOT NULL DEFAULT '0' COMMENT '账户 appid',
  `uin`             varchar(60) NOT NULL DEFAULT '0' COMMENT '账户 uin',
  `sub_account_uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '账户 subAccountUin',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='使用 SSH 模式加入集群的机器列表';
