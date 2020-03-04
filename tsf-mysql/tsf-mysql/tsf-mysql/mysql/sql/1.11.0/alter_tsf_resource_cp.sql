# 把 alauda_id 迁移到 cp_cluster_id 来，与标准容器 API 共用一个字段
ALTER TABLE `tsf_resource`.`tsf_resource_cluster`
  ADD COLUMN `cp_cluster_id` VARCHAR(65) NULL COMMENT 'Container platform cluster ID' AFTER `alauda_id`;

UPDATE `tsf_resource`.`tsf_resource_cluster`
  SET `cp_cluster_id` = `alauda_id`;

ALTER TABLE `tsf_resource`.`tsf_resource_cluster`
  DROP COLUMN `alauda_id`;
