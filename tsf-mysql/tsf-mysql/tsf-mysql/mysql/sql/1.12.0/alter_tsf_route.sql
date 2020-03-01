-- TSF_ROUTE_AFFINITY
DROP TABLE IF EXISTS `tsf_route`.`tsf_route_affinity`;
CREATE TABLE `tsf_route`.`tsf_route_affinity` (
  `id` varchar(20) NOT NULL COMMENT '主键ID，全局唯一',
  `namespace_id` varchar(20) NOT NULL COMMENT '命名空间ID',
  `affinity` boolean NULL COMMENT '是否启用就近访问策略',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '就近策略更新时间',
  `app_id` varchar(60) NOT NULL DEFAULT '0' COMMENT '公有云账户appid',
  `uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '公有云账户uin',
  `sub_account_uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '公有云账户subAccountUin',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='路由就近访问策略表';