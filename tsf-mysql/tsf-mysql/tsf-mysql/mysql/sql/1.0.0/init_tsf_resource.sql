-- Create tsf_resource schema
DROP SCHEMA IF EXISTS `tsf_resource`;
CREATE SCHEMA `tsf_resource` ;

-- Create Account
DROP USER IF EXISTS `tsf_resource`;
CREATE USER `tsf_resource`@'%' IDENTIFIED BY 'Tcdn@2007';
GRANT ALL PRIVILEGES ON tsf_resource.* TO 'tsf_resource'@'%' IDENTIFIED BY 'Tcdn@2007';
FLUSH PRIVILEGES;

-- Create Tables of tsf_resource
-- TSF_COMMON_ID
DROP TABLE IF EXISTS `tsf_resource`.`tsf_common_id`;
CREATE TABLE `tsf_resource`.`tsf_common_id` (
  `id_type` varchar(20) NOT NULL COMMENT 'ID类型',
  `id_value` bigint(20) NOT NULL DEFAULT '0' COMMENT 'ID值',
  PRIMARY KEY (`id_type`)
) COMMENT='TSF通用基础模块ID表';
INSERT INTO `tsf_resource`.`tsf_common_id` (id_type) values ("hashId");


-- TSF_RESOURCE_APPLICATION
DROP TABLE IF EXISTS `tsf_resource`.`tsf_resource_application`;
CREATE TABLE `tsf_resource`.`tsf_resource_application` (
  `id` varchar(20) NOT NULL COMMENT '主键ID，全局唯一',
  `application_name` varchar(60) NOT NULL DEFAULT '' COMMENT '应用名称信息',
  `application_desc` varchar(200) DEFAULT '' COMMENT '应用描述信息',
  `application_type` varchar(1) NOT NULL DEFAULT '' COMMENT '应用类型，N：普通应用，C：容器应用',
  `application_jvm_arg` varchar(200) DEFAULT '' COMMENT 'java jvm 启动参数',
  `micro_service_type` varchar(1) NOT NULL DEFAULT 'N' COMMENT '应用微服务类型，M：service mesh, P：原生应用',
  `prog_lang` varchar(1) NOT NULL DEFAULT 'J' COMMENT '应用编程语言类型，J：Java应用， P：Python应用',
  `create_time` timestamp NOT NULL COMMENT '应用创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '应用更新时间',
  `app_id` varchar(60) NOT NULL DEFAULT '0' COMMENT '账号appId信息',
  `uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '账号owner uin信息',
  `sub_account_uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '账号create uin信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='应用信息表';

-- TSF_RESOURCE_CLUSTER
DROP TABLE IF EXISTS `tsf_resource`.`tsf_resource_cluster`;
CREATE TABLE `tsf_resource`.`tsf_resource_cluster` (
  `id` varchar(20) NOT NULL,
  `cluster_name` varchar(60) NOT NULL COMMENT '集群名称信息',
  `cluster_desc` varchar(200) DEFAULT NULL COMMENT '集群描述信息',
  `cluster_type` varchar(1) NOT NULL DEFAULT 'C' COMMENT '集群类型，V：CVM集群； C：容器集群',
  `vpc_id` varchar(20) NOT NULL DEFAULT '' COMMENT '集群所属vpc id信息',
  `kubernete_api_server` varchar(128) DEFAULT NULL COMMENT 'k8s集群访问地址',
  `kubernete_user` varchar(60) DEFAULT NULL COMMENT 'k8s集群账户',
  `kubernete_password` varchar(128) DEFAULT NULL COMMENT 'k8s集群密码',
  `create_time` timestamp NOT NULL COMMENT '集群信息创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '集群信息更新时间',
  `app_id` varchar(60) NOT NULL DEFAULT '0' COMMENT '账号appId信息',
  `uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '账号owner uin信息',
  `sub_account_uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '账号create uin信息',
  `ckafka_topicid` varchar(60) DEFAULT NULL,
  `ckafka_instanceid` varchar(60) DEFAULT NULL,
  `ckafka_topicname` varchar(255) DEFAULT NULL,
  `ckafka_vip` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='集群信息表';


-- TSF_RESOURCE_GROUP
DROP TABLE IF EXISTS `tsf_resource`.`tsf_resource_group`;
CREATE TABLE `tsf_resource`.`tsf_resource_group` (
  `id` varchar(20) NOT NULL COMMENT '主键ID，全局唯一',
  `group_name` varchar(60) NOT NULL DEFAULT '' COMMENT '分组名称信息',
  `group_desc` varchar(200) DEFAULT '' COMMENT '分组描述信息',
  `create_time` timestamp NOT NULL COMMENT '分组信息创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '分组信息更新时间',
  `namespace_id` varchar(20) NOT NULL DEFAULT '' COMMENT '分组所属命名空间信息',
  `application_id` varchar(20) NOT NULL DEFAULT '' COMMENT '分组所属应用信息',
  `app_id` varchar(60) NOT NULL DEFAULT '0' COMMENT '账号appId信息',
  `uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '账号owner uin',
  `sub_account_uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '账号create uin信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='分组信息表';


-- TSF_RESOURCE_INSTANCE
DROP TABLE IF EXISTS `tsf_resource`.`tsf_resource_instance`;
CREATE TABLE `tsf_resource`.`tsf_resource_instance` (
  `id` varchar(20) NOT NULL COMMENT '机器ID，全局唯一，非tsf生成',
  `instance_name` varchar(60) DEFAULT '' COMMENT '机器备注名称',
  `lan_ip` varchar(32) NOT NULL DEFAULT '' COMMENT '机器内网ip地址',
  `wan_ip` varchar(32) NOT NULL DEFAULT '' COMMENT '机器外网ip地址',
  `namespace_id` varchar(20) NOT NULL DEFAULT '' COMMENT '机器所属命名空间id',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '机器信息更新时间',
  `instance_desc` varchar(200) DEFAULT '' COMMENT '机器描述信息',
  `app_id` varchar(60) NOT NULL DEFAULT '0' COMMENT '账号appId信息',
  `uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '账号owner uin信息',
  `sub_account_uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '账号create uin信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='机器信息表';

-- TSF_RESOURCE_LICENCE
DROP TABLE IF EXISTS `tsf_resource`.`tsf_resource_licence`;
CREATE TABLE `tsf_resource`.`tsf_resource_licence` (
  `id` varchar(20) NOT NULL DEFAULT '' COMMENT '主键ID，全局唯一',
  `create_time` timestamp NOT NULL COMMENT 'tsf创建时间',
  `expire_time` timestamp NULL COMMENT 'tsf过期时间',
  `app_id` varchar(60) NOT NULL DEFAULT '0' COMMENT '账号appId信息',
  `uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '账号owner uin信息',
  `sub_account_uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '账号create uin信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='tsf开通购买信息';

-- TSF_RESOURCE_NAMESPACE
DROP TABLE IF EXISTS `tsf_resource`.`tsf_resource_namespace`;
CREATE TABLE `tsf_resource`.`tsf_resource_namespace` (
  `id` varchar(20) NOT NULL COMMENT '主键ID，全局唯一',
  `namespace_name` varchar(60) NOT NULL COMMENT '命名空间名称信息',
  `namespace_desc` varchar(200) DEFAULT NULL COMMENT '命名空间描述信息',
  `create_time` timestamp NOT NULL COMMENT '命名空间创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '命名空间更新时间',
  `cluster_id` varchar(20) NOT NULL COMMENT '命名空间所属集群信息',
  `app_id` varchar(60) NOT NULL DEFAULT '0' COMMENT '账号appId信息',
  `isdefault` varchar(1) NOT NULL DEFAULT '1' COMMENT '是否默认,0 是 1:不是',
  `uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '账号owner uin信息',
  `sub_account_uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '账号create uin信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='命名空间信息表';

-- TSF_RESOURCE_GROUP_PKG
DROP TABLE IF EXISTS `tsf_resource`.`tsf_resource_group_pkg`;
CREATE TABLE `tsf_resource`.`tsf_resource_group_pkg` (
  `group_id` varchar(20) NOT NULL DEFAULT '' COMMENT '分组id',
  `pkg_id` varchar(20) NOT NULL DEFAULT '' COMMENT '包id',
  `deploy_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '部署时间',
  `app_id` varchar(60) NOT NULL DEFAULT '0' COMMENT '账号app id信息',
  `uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '账号owner uin信息',
  `sub_account_uin` varchar(60) NOT NULL DEFAULT '0' COMMENT '账号create uin信息',
  PRIMARY KEY (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='分组-包安装关系信息表';

-- ----------------------------
-- Table structure for tsf_resource_pod
-- ----------------------------
DROP TABLE IF EXISTS `tsf_resource`.`tsf_resource_pod`;
CREATE TABLE `tsf_resource`.`tsf_resource_pod` (
  `id` varchar(20)  COMMENT '主键',
  `server` varchar(128)   COMMENT '镜像server',
  `reponame` varchar(256)   COMMENT '镜像名称,如tsfxxx/nginx',
  `tag_name` varchar(64)   COMMENT '镜像版本',
  `image_namespace` varchar(64)   COMMENT '镜像命名空间',
  `create_time` timestamp NOT NULL COMMENT '命名空间创建时间',
  `update_time` timestamp  DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `cpu_request` varchar(32)   COMMENT '预分配CPU核数',
  `cpu_limit` varchar(32)   COMMENT '最大分配CPU核数',
  `mem_request` varchar(32)   COMMENT '预分配内存M数',
  `mem_limit` varchar(32)   COMMENT '最大内存M数',
  `instance_num` varchar(32)   COMMENT '实例数量',
  `access_type` varchar(1)   COMMENT '访问方式0:公网，1:集群内访问，2:vpc内访问，3:none',
   `protocol_ports` varchar(1024)   COMMENT '协议端口，protocol:port:targetport格式，示例:TCP:80:8080;UDP:8081:9090这种格式',
   `update_type` varchar(1)  DEFAULT '0' COMMENT '更新方式0：快速更新 1:滚动更新',
  `update_ivl` varchar(32)   COMMENT '更新间隔,单位秒',
  `group_id` varchar(20)   COMMENT '所属分组id',
  `app_id` varchar(60)  DEFAULT '0' COMMENT '账号appId信息',
  `uin` varchar(60)  DEFAULT '0' COMMENT '账号owner uin信息',
  `sub_account_uin` varchar(60)  DEFAULT '0' COMMENT '账号create uin信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Pod信息表';

DROP TABLE IF EXISTS `tsf_resource`.`tsf_resource_task`;
CREATE TABLE `tsf_resource`.`tsf_resource_task` (
  `id` varchar(32) NOT NULL COMMENT '主键',
  `type` int(11) DEFAULT NULL COMMENT '0：没有任务（在此接口中，不用出现0），1：发布程序包；2.部署操作；3.扩容操作；4.启动操作；5.停止操作；6.缩容操作；7.发布日志配置,8.删除销毁操作',
  `task_desc` varchar(256) DEFAULT NULL COMMENT '任务描述',
  `status` varchar(1) DEFAULT '0' COMMENT '变更状态，0：成功 1:失败 2:执行中',
  `create_time` timestamp NOT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `application_id` varchar(20) NOT NULL DEFAULT '' COMMENT '任务所属应用信息',
  `related_task_id` varchar(60) DEFAULT NULL COMMENT '关联的cvm或ccs内部的任务id',
  `app_id` varchar(32) DEFAULT '0' COMMENT '账号appId信息',
  `uin` varchar(60) DEFAULT '0' COMMENT '账号owner uin信息',
  `sub_account_uin` varchar(60) DEFAULT '0' COMMENT '账号create uin信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `tsf_resource`.`tsf_resource_image`;
CREATE TABLE `tsf_resource`.`tsf_resource_image` (
  `image_id` varchar(255) NOT NULL COMMENT '镜像id',
  `os_name` varchar(255) NOT NULL DEFAULT '' COMMENT '镜像操作系统名称',
  `image_size` float NOT NULL DEFAULT '0' COMMENT '操作系统容量（GiB）',
  `image_type` varchar(1) NOT NULL DEFAULT 'V' COMMENT '镜像类型，C：容器镜像， V：cvm镜像',
  `image_name` varchar(255) NOT NULL DEFAULT '' COMMENT '镜像名称',
  `image_desc` varchar(255) NOT NULL DEFAULT '' COMMENT '镜像备注',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '镜像创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='tsf重装操作系统镜像表';
