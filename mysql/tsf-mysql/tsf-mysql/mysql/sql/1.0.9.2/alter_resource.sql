ALTER TABLE `tsf_resource`.`tsf_resource_pod` 
CHANGE COLUMN `jvm_opts` `jvm_opts` VARCHAR(4000) NULL DEFAULT NULL COMMENT 'jvm参数' ;

ALTER TABLE `tsf_resource`.`tsf_resource_group`
MODIFY COLUMN `startup_parameters`  varchar(4000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '虚拟机部署组启动参数' AFTER `is_stop`;

