-- TSF_RESOURCE_PROJECT_APPLICATION
DROP TABLE IF EXISTS `tsf_resource`.`tsf_resource_project_application`;
CREATE TABLE `tsf_resource`.`tsf_resource_project_application` (
  `id` varchar(20) NOT NULL COMMENT '主键ID，全局唯一',
  `project_id` varchar(20) NOT NULL DEFAULT '' COMMENT '项目ID',
  `application_id` varchar(20) NOT NULL DEFAULT '' COMMENT '应用ID',
  `app_id` varchar(60) NOT NULL DEFAULT '' COMMENT '公有云账户appid',
  `uin` varchar(60) NOT NULL DEFAULT '' COMMENT '公有云账户uin',
  `sub_account_uin` varchar(60) NOT NULL DEFAULT '' COMMENT '公有云账户subAccountUin',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='项目-应用关系表';
