ALTER TABLE `tsf_resource`.`tsf_resource_cluster_namespace` 
ADD COLUMN `cp_namespace_id` VARCHAR(65) NULL COMMENT 'Other system Container Namespace ID' AFTER `namespace_desc`;

UPDATE `tsf_resource`.`tsf_resource_cluster_namespace` cn 
SET cn.cp_namespace_id = (SELECT n.alauda_id FROM `tsf_resource`.`tsf_resource_namespace` n WHERE n.id = cn.namespace_id);
COMMIT;