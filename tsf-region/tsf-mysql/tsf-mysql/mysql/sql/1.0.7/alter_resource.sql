DROP TABLE IF EXISTS `tsf_resource`.`tsf_resource_instance_agent`;

CREATE TABLE `tsf_resource`.`tsf_resource_instance_agent` (
  `id` varchar(20) NOT NULL COMMENT '机器instanceId',
  `os_name` varchar(255) NOT NULL DEFAULT '' COMMENT '机器操作系统名称',
  `total_cpu` float NOT NULL DEFAULT '0' COMMENT '机器CPU核数',
  `total_mem` float NOT NULL DEFAULT '0' COMMENT '机器内存大小，单位为G',
  `used_cpu` float DEFAULT '0' COMMENT '已使用CPU核数',
  `used_mem` float DEFAULT '0' COMMENT '机器已使用内存，单位为G',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `tsf_resource`.`tsf_resource_cluster` 
ADD COLUMN `cluster_cidr` VARCHAR(45) NULL COMMENT '集群容器网络';

ALTER TABLE `tsf_resource`.`tsf_resource_cluster` 
ADD COLUMN `init_alauda_k8s` VARCHAR(1) NULL DEFAULT 'N' COMMENT '是否初始化Alauda K8S集群，N为否';

ALTER TABLE `tsf_resource`.`tsf_resource_namespace` 
ADD COLUMN `alauda_id` VARCHAR(50) NULL COMMENT 'Alauda Namespace ID' AFTER `sub_account_uin`;

ALTER TABLE `tsf_resource`.`tsf_resource_cluster` 
ADD COLUMN `alauda_id` VARCHAR(50) NULL COMMENT 'Alauda Cluster ID' AFTER `init_alauda_k8s`;

ALTER TABLE `tsf_resource`.`tsf_resource_group` 
ADD COLUMN `uuid` VARCHAR(100) NULL COMMENT 'uuid' AFTER `is_stop`;
