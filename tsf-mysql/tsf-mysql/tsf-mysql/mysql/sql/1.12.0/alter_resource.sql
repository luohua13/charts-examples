-- 集群增加 TSF 地域 及 可用区 属性
ALTER TABLE `tsf_resource`.`tsf_resource_cluster`
ADD COLUMN `tsf_region_id`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT
'集群所属TSF地域信息' AFTER `cp_cluster_id`,
ADD COLUMN `tsf_zone_id`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '集群所属TSF可用区'
AFTER `tsf_region_id`;