USE tsf_resource;

ALTER TABLE `tsf_resource_group`
ADD COLUMN `startup_parameters`  varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '虚拟机部署组启动参数' AFTER `is_stop`;