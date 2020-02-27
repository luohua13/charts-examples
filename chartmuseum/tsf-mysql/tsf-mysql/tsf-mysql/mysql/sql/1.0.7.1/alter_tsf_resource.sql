-- 调整表结构，暂不删除namespace id字段，下个版本删除
ALTER TABLE `tsf_resource`.`tsf_resource_instance` 
CHANGE COLUMN `namespace_id` `namespace_id` VARCHAR(20) NULL COMMENT '机器所属命名空间id' ,
ADD COLUMN `cluster_id` VARCHAR(20) NOT NULL DEFAULT '' COMMENT '集群ID' AFTER `sub_account_uin`;

-- 更新数据，使用tsf_resource_namespace表的数据将namespace_id更新为cluster_id
UPDATE `tsf_resource`.`tsf_resource_instance` SET cluster_id = (SELECT ns.cluster_id FROM `tsf_resource`.`tsf_resource_namespace` ns WHERE ns.id = namespace_id);

-- 更新tsf_resource_task表的task_desc字段长度
ALTER TABLE `tsf_resource`.`tsf_resource_task` 
CHANGE COLUMN `task_desc` `task_desc` VARCHAR(1024) NULL DEFAULT NULL COMMENT '任务描述' ;