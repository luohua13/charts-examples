-- tsf_resource_group 表增加字段 request
ALTER TABLE `tsf_resource`.`tsf_resource_group`
  ADD COLUMN `cpu_request` varchar(32) COMMENT '初始分配CPU核数' AFTER `mem_limit`,
  ADD COLUMN `mem_request` varchar(32) COMMENT '初始内存M数' AFTER `cpu_request`;
