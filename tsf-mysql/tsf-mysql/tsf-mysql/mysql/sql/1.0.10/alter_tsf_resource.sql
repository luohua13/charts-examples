-- ALTER tsf_resource_namespace
ALTER TABLE `tsf_resource`.`tsf_resource_namespace` 
CHANGE COLUMN `cluster_id` `cluster_id` VARCHAR(20) NULL COMMENT '集群ID';

-- ALTER tsf_resource_group
ALTER TABLE `tsf_resource`.`tsf_resource_group` 
ADD COLUMN `cluster_id` VARCHAR(20) NULL COMMENT '集群ID' AFTER `uuid`;

-- UPDATE tsf_resource_group's cluster_id
UPDATE `tsf_resource`.`tsf_resource_group` g SET g.cluster_id = (SELECT ns.cluster_id FROM `tsf_resource`.`tsf_resource_namespace` ns WHERE ns.id = g.namespace_id);

-- CREATE tsf_resource_cluster_namespace
DROP TABLE IF EXISTS `tsf_resource`.`tsf_resource_cluster_namespace`;
CREATE TABLE `tsf_resource`.`tsf_resource_cluster_namespace` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '集群命名空间ID，物理主键，自增',
  `cluster_id` VARCHAR(20) NOT NULL COMMENT '集群ID',
  `namespace_id` VARCHAR(20) NOT NULL COMMENT '命名空间ID',
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `app_id` VARCHAR(60) NOT NULL COMMENT '租户ID',
  `uin` VARCHAR(60) NOT NULL COMMENT '租户Owner UIN',
  `sub_account_uin` VARCHAR(60) NOT NULL COMMENT '用户UIN',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `cluster_namespac_id_UNIQUE` (`cluster_id`, `namespace_id` ASC))
ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=utf8 COMMENT = '集群命名空间关联关系表';

-- Transfer cluster - namespace relationship
INSERT INTO `tsf_resource`.`tsf_resource_cluster_namespace` (`cluster_id`, `namespace_id`, `create_time`, `app_id`, `uin`, `sub_account_uin`) 
SELECT ns.cluster_id, ns.id, ns.create_time, ns.app_id, ns.uin, ns.sub_account_uin FROM `tsf_resource`.`tsf_resource_namespace` ns;

-- Transfer {namespace_name} -> {cluster_name} + '#' + {namespace_name} for default namespace only.
UPDATE `tsf_resource`.`tsf_resource_namespace` ns SET namespace_name = ( SELECT concat(cls.cluster_name, '#' , ns.namespace_name)
 FROM `tsf_resource`.`tsf_resource_cluster` cls WHERE cls.id = ns.cluster_id) WHERE ns.isdefault = '0';
COMMIT;

-- Add column namespace_desc
ALTER TABLE `tsf_resource`.`tsf_resource_cluster_namespace` 
ADD COLUMN `namespace_desc` VARCHAR(200) NULL COMMENT '命名空间描述' AFTER `sub_account_uin`;

-- Transfer namespace desc from tsf_resource_namespace
UPDATE `tsf_resource`.`tsf_resource_cluster_namespace` cn SET cn.namespace_desc = (SELECT ns.namespace_desc FROM `tsf_resource`.`tsf_resource_namespace` ns WHERE ns.id = cn.namespace_id);
COMMIT;

ALTER TABLE `tsf_resource`.`tsf_resource_instance`
ADD COLUMN `import_mode`  varchar(20) NULL DEFAULT 'R' COMMENT '虚拟机集群云主机导入方式， R: 重装TSF系统镜像； M： 手动安装agent' AFTER `cluster_id`;

-- Transfer {namespace_name} -> {cluster_name} + '#' + {namespace_name} for non-default namespace only.
UPDATE `tsf_resource`.`tsf_resource_namespace` ns SET namespace_name = ( SELECT concat(cls.cluster_name, '#' , ns.namespace_name)
 FROM `tsf_resource`.`tsf_resource_cluster` cls WHERE cls.id = ns.cluster_id) WHERE ns.isdefault = '1' AND EXISTS (SELECT 
    1
FROM
    (SELECT 
        namespace_name, COUNT(1) AS qty
    FROM
        `tsf_resource`.`tsf_resource_namespace`
    WHERE
        isdefault = '1'
            AND cluster_id IS NOT NULL
    GROUP BY cluster_id, app_id, namespace_name) AS tmp
WHERE
    tmp.qty > 1 AND tmp.namespace_name = ns.namespace_name);
COMMIT;

-- ALTER tsf_resource_image
ALTER TABLE `tsf_resource`.`tsf_resource_image`
ADD COLUMN `login_name`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'root' COMMENT '默认登录名称' AFTER `create_time`;

-- TSF_RESOURCE_PROJECT_APPLICATION
-- DROP TABLE IF EXISTS `tsf_resource`.`tsf_resource_project_application`;
CREATE TABLE IF NOT EXISTS `tsf_resource`.`tsf_resource_project_application` (
  `id` varchar(20) NOT NULL COMMENT '主键ID，全局唯一',
  `project_id` varchar(20) NOT NULL DEFAULT '' COMMENT '项目ID',
  `application_id` varchar(20) NOT NULL DEFAULT '' COMMENT '应用ID',
  `app_id` varchar(60) NOT NULL DEFAULT '' COMMENT '公有云账户appid',
  `uin` varchar(60) NOT NULL DEFAULT '' COMMENT '公有云账户uin',
  `sub_account_uin` varchar(60) NOT NULL DEFAULT '' COMMENT '公有云账户subAccountUin',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='项目-应用关系表';