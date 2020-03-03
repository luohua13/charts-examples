ALTER TABLE `tsf_resource`.`tsf_resource_namespace` 
ADD COLUMN `code` VARCHAR(128) NULL COMMENT '命名空间编码code,全局唯一' AFTER `isdefault`;


ALTER TABLE `tsf_resource`.`tsf_resource_pod` 
CHANGE COLUMN `access_type` `access_type` VARCHAR(1) NULL DEFAULT NULL COMMENT '访问方式0:公网，1:集群内访问，2:NodePort' ;

ALTER TABLE `tsf_resource`.`tsf_resource_group` 
ADD COLUMN `is_stop` VARCHAR(1) NOT NULL DEFAULT '0' COMMENT '是否已停止,0:没有 1:停止' AFTER `sub_account_uin`;
