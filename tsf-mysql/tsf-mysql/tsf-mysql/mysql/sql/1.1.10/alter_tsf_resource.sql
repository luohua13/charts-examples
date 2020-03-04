-- extends length of column 'namespace_name' for the default namespace in cluster
ALTER TABLE `tsf_resource`.`tsf_resource_namespace` 
CHANGE COLUMN `namespace_name` `namespace_name` VARCHAR(70) NOT NULL COMMENT '命名空间名称信息' ;
