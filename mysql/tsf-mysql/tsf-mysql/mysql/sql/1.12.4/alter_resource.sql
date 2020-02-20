
-- 命名空间增加资源类型字段
ALTER TABLE `tsf_resource`.`tsf_resource_namespace`
ADD COLUMN `ns_resource_type`  varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'DEF'
COMMENT 'TSF命名空间资源类型， DEF: 默认为用户业务资源； GW:微服务网关' AFTER `alauda_id`;

-- 部署组增加资源类型字段
ALTER TABLE `tsf_resource`.`tsf_resource_group`
ADD COLUMN `group_resource_type`  varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'DEF'
COMMENT 'TSF部署组资源类型， DEF: 默认为用户业务资源； GW:微服务网关' AFTER `cluster_id`;

-- 应用增加资源类型字段
ALTER TABLE `tsf_resource`.`tsf_resource_application`
ADD COLUMN `application_resource_type`  varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'DEF'
COMMENT 'TSF部署组资源类型， DEF: 默认为用户业务资源； GW:微服务网关' AFTER `sub_account_uin`;
