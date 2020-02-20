USE tsf_resource;

-- 更新tsf_resource_task表的task_desc字段长度
ALTER TABLE `tsf_resource`.`tsf_resource_task` 
CHANGE COLUMN `task_desc` `task_desc` VARCHAR(1024) NULL DEFAULT NULL COMMENT '任务描述' ;

-- tsf_resource_group表增加字段
ALTER TABLE `tsf_resource`.`tsf_resource_group` 
ADD COLUMN `cpu_limit` varchar(32)   COMMENT '最大分配CPU核数' AFTER `is_stop`,
ADD COLUMN `mem_limit` varchar(32)   COMMENT '最大内存M数' AFTER `cpu_limit`,
ADD COLUMN `instance_num` varchar(32)   COMMENT '实例数量' AFTER `mem_limit`,
ADD COLUMN `access_type` varchar(1)   COMMENT '访问方式0:公网，1:集群内访问，2:vpc内访问，3:none' AFTER `instance_num`,
ADD COLUMN `protocol_ports` varchar(1024)   COMMENT '协议端口，protocol:port:targetport格式，示例:TCP:80:8080;UDP:8081:9090这种格式' AFTER `access_type`,
ADD COLUMN `update_type` varchar(1)  DEFAULT '0' COMMENT '更新方式0：快速更新 1:滚动更新' AFTER `protocol_ports`,
ADD COLUMN `update_ivl`varchar(32)   COMMENT '更新间隔,单位秒' AFTER `update_type`,
ADD COLUMN `k8s_servicename` varchar(256)   COMMENT 'k8s服务名称' AFTER `update_ivl`;

-- tsf_resource_pod表增加字段
ALTER TABLE `tsf_resource`.`tsf_resource_pod` 
ADD COLUMN `jvm_opts` varchar(1024)   COMMENT 'jvm参数' AFTER `protocol_ports`;

-- 将pod表数据迁移到group表。
UPDATE tsf_resource_group g SET g.cpu_limit = (select p.cpu_limit from tsf_resource_pod p where p.group_id = g.id);
UPDATE tsf_resource_group g SET g.mem_limit = (select p.mem_limit from tsf_resource_pod p where p.group_id = g.id);
UPDATE tsf_resource_group g SET g.instance_num = (select p.instance_num from tsf_resource_pod p where p.group_id = g.id);
UPDATE tsf_resource_group g SET g.access_type = (select p.access_type from tsf_resource_pod p where p.group_id = g.id);
UPDATE tsf_resource_group g SET g.protocol_ports = (select p.protocol_ports from tsf_resource_pod p where p.group_id = g.id);
UPDATE tsf_resource_group g SET g.update_type = (select p.update_type from tsf_resource_pod p where p.group_id = g.id);
UPDATE tsf_resource_group g SET g.update_ivl = (select p.update_ivl from tsf_resource_pod p where p.group_id = g.id);