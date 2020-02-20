-- Create tsf_record schema
DROP SCHEMA IF EXISTS `tsf_gateway`;
CREATE SCHEMA `tsf_gateway` ;

-- Create Account
DROP USER IF EXISTS `tsf_gateway`;
CREATE USER `tsf_gateway`@'%' IDENTIFIED BY 'Tcdn@2007';
GRANT ALL PRIVILEGES ON tsf_gateway.* TO 'tsf_gateway'@'%' IDENTIFIED BY 'Tcdn@2007';
FLUSH PRIVILEGES;

USE tsf_gateway;

DROP TABLE IF EXISTS `tsf_common_id`;

CREATE TABLE `tsf_common_id` (
  `id_type` varchar(20) NOT NULL,
  `id_value` bigint(20) DEFAULT 0,
  PRIMARY KEY (`id_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `tsf_gateway`.`tsf_common_id` (id_type) values ("hashId");

/*Table structure for table `tsf_ms_gateway` */

DROP TABLE IF EXISTS `tsf_ms_gateway`;

CREATE TABLE `tsf_msgw_instance` (
  `id` varchar(20) NOT NULL,
  `name` varchar(128) DEFAULT NULL COMMENT '网关名称',
  `cluster_id` varchar(32) DEFAULT NULL COMMENT '集群ID',
  `cluster_type` varchar(32) DEFAULT NULL COMMENT '集群类型，容器/cvm. 冗余信息',
  `namespace_id` varchar(32) DEFAULT 'common' COMMENT '命名空间名称',
  `group_id` varchar(32) NOT NULL COMMENT '部署组ID',
  `application_id` varchar(32) DEFAULT NULL COMMENT '容器ID',
  `type` varchar(64) NOT NULL DEFAULT 'msgw_zuul1' COMMENT '网关类型，例如msgw_zuul1/msgw_scg',
  `version` varchar(32) DEFAULT NULL COMMENT '网关当前部署版本',
  `acl_mode` varchar(32) DEFAULT 'none' COMMENT '网关ACL类型，无控制：none; 白名单:whitelist; 黑名单:blacklist',
  `description` text COMMENT '描述',
  `created_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `app_id` varchar(20) NOT NULL COMMENT '租户ID',
  `uin` varchar(20) NOT NULL COMMENT '主账号ID',
  `sub_account_uin` varchar(20) NOT NULL COMMENT '当前账号ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_GRP_INDEX` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='网关基本信息';

/*Table structure for table `tsf_msgw_api` */

DROP TABLE IF EXISTS `tsf_msgw_api`;

CREATE TABLE `tsf_msgw_api` (
  `id` varchar(20) NOT NULL COMMENT 'API ID',
  `path` varchar(128) NOT NULL COMMENT 'API path 信息',
  `method` varchar(16) NOT NULL COMMENT 'API method，例如POST/GET/PUT/DELETE',
  `service_id` varchar(20) DEFAULT NULL COMMENT '微服务ID,冗余数据',
  `service_name` varchar(32) NOT NULL COMMENT '微服务名称',
  `namespace_id` varchar(20) NOT NULL COMMENT '微服务所属命名空间ID',
  `namespace_name` varchar(32) DEFAULT NULL COMMENT '微服务所属命名名称',
  `path_mapping` varchar(128) DEFAULT NULL COMMENT '路径映射',
  `group_id` varchar(32) NOT NULL COMMENT 'API 分组ID',
  `usable_status` varchar(32) DEFAULT 'enabled' COMMENT '是否可用,启用/禁用',
  `release_status` varchar(32) DEFAULT 'drafted' COMMENT '发布状态。drafted/released',
  `ratelimit_status` varchar(32) DEFAULT 'disabled' COMMENT '是否开启限流',
  `mock_status` varchar(32) DEFAULT 'disabled' COMMENT '是否开启MOCK',
  `created_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `released_time` datetime DEFAULT NULL COMMENT '发布时间',
  `app_id` varchar(32) NOT NULL COMMENT '租户ID',
  `uin` varchar(32) NOT NULL COMMENT '主账号ID',
  `sub_account_uin` varchar(32) NOT NULL COMMENT '子账号ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_INDEX` (`path`,`method`,`service_name`,`namespace_id`,`group_id`),
  KEY `path_mapping` (`path_mapping`,`method`,`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='分组 API';

/*Table structure for table `tsf_msgw_common_image` */

DROP TABLE IF EXISTS `tsf_msgw_common_image`;

CREATE TABLE `tsf_msgw_common_image` (
  `id` varchar(32) DEFAULT NULL,
  `repo_server` varchar(128) DEFAULT NULL COMMENT '镜像地址',
  `repo_name` varchar(128) DEFAULT NULL COMMENT '镜像名称',
  `tag_name` varchar(32) DEFAULT NULL COMMENT '镜像Tag名称',
  `gw_type` varchar(32) DEFAULT NULL COMMENT '网关类型，zuul1/sgc',
  `usable_status` varchar(32) DEFAULT 'enabled',
  `owner_app_id` varchar(32) DEFAULT NULL COMMENT '当前镜像是否可用',
  `created_time` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Table structure for table `tsf_msgw_common_pkg` */

DROP TABLE IF EXISTS `tsf_msgw_common_pkg`;

CREATE TABLE `tsf_msgw_common_pkg` (
  `id` varchar(32) NOT NULL,
  `gw_type` varchar(32) DEFAULT NULL COMMENT '网关的类型，zuul/scg',
  `application_id` varchar(32) DEFAULT NULL COMMENT '网关公共应用ID',
  `pkg_id` varchar(32) DEFAULT NULL COMMENT '网关公共包的pkg_id/公共镜像的RepoName',
  `pkg_version` varchar(32) DEFAULT NULL COMMENT '包版本or镜像tagName',
  `usable_status` varchar(32) DEFAULT 'enabled' COMMENT '是否可用',
  `owner_app_id` varchar(32) DEFAULT NULL COMMENT '公共包所属的租户',
  `created_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_INDEX` (`application_id`,`pkg_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Table structure for table `tsf_msgw_domain` */

DROP TABLE IF EXISTS `tsf_msgw_domain`;

CREATE TABLE `tsf_msgw_domain` (
  `id` varchar(32) NOT NULL COMMENT 'ID',
  `gw_id` varchar(32) NOT NULL COMMENT '网关ID',
  `scheme` varchar(32) DEFAULT 'http' COMMENT '协议类型',
  `domain` varchar(128) NOT NULL COMMENT '网关的域名',
  `description` varchar(256) DEFAULT NULL COMMENT '描述信息',
  `created_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `app_id` varchar(32) NOT NULL COMMENT '租户ID',
  `uin` varchar(32) NOT NULL COMMENT '主账号ID',
  `sub_account_uin` varchar(32) NOT NULL COMMENT '子账号ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_GRP_DOMIAN` (`gw_id`,`domain`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='分组域名信息';

/*Table structure for table `tsf_msgw_group` */

DROP TABLE IF EXISTS `tsf_msgw_group`;

CREATE TABLE `tsf_msgw_group` (
  `id` varchar(20) NOT NULL COMMENT '分组ID',
  `gw_id` varchar(32) NOT NULL COMMENT '网关ID',
  `group_name` varchar(64) NOT NULL COMMENT '分组名称',
  `group_context` varchar(128) NOT NULL COMMENT '部署组访问上下文',
  `status` varchar(32) DEFAULT 'drafted' COMMENT 'released/drafted',
  `auth_mode` varchar(32) DEFAULT 'none' COMMENT '鉴权类型: none/secret_key',
  `acl_mode` varchar(32) DEFAULT 'none' COMMENT '访问group的权限控制. none/IP白名单/黑名称',
  `description` text COMMENT '分组描述信息',
  `created_time` date DEFAULT NULL COMMENT '创建时间',
  `updated_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `app_id` varchar(32) DEFAULT NULL COMMENT '租户ID',
  `uin` varchar(32) DEFAULT NULL COMMENT '主账号ID',
  `sub_account_uin` varchar(32) DEFAULT NULL COMMENT '子账号ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_GID_NAME` (`gw_id`,`group_name`),
  UNIQUE KEY `UK_GID_CONTEXT` (`gw_id`,`group_context`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='API 分组基本信息';

/*Table structure for table `tsf_msgw_group_secret` */

DROP TABLE IF EXISTS `tsf_msgw_group_secret`;

CREATE TABLE `tsf_msgw_group_secret` (
  `id` varchar(32) NOT NULL COMMENT 'ID',
  `secret_id` varchar(128) NOT NULL COMMENT '秘钥ID',
  `secret_key` varchar(128) NOT NULL COMMENT '秘钥值',
  `secret_name` varchar(128) NOT NULL COMMENT '秘钥名称',
  `group_id` varchar(32) NOT NULL COMMENT '分组ID',
  `status` varchar(32) DEFAULT 'enabled' COMMENT '可用状态，禁用/启用',
  `expired_time` datetime DEFAULT NULL COMMENT '过期时间',
  `created_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `app_id` varchar(32) DEFAULT NULL COMMENT '租户ID',
  `uin` varchar(32) DEFAULT NULL COMMENT '主账号ID',
  `sub_account_uin` varchar(32) DEFAULT NULL COMMENT '子账号ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_SECRET_ID` (`secret_id`),
  KEY `INDEX_GRP` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='分组秘钥';

/*Table structure for table `tsf_msgw_lock` */

DROP TABLE IF EXISTS `tsf_msgw_lock`;

CREATE TABLE `tsf_msgw_lock` (
  `id` varchar(32) NOT NULL,
  `gw_id` varchar(32) NOT NULL,
  `event_type` varchar(32) NOT NULL,
  `lock_version` int(11) DEFAULT 0 COMMENT '乐观锁版本号',
  `updated_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_INDEX` (`gw_id`,`event_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Table structure for table `tsf_msgw_mock` */

DROP TABLE IF EXISTS `tsf_msgw_mock`;

CREATE TABLE `tsf_msgw_mock` (
  `id` varchar(32) NOT NULL COMMENT 'ID',
  `api_id` varchar(32) DEFAULT NULL COMMENT 'API ID',
  `mock_data` text COMMENT 'API mock数据',
  `created_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `app_id` varchar(32) DEFAULT NULL COMMENT '租户ID',
  `uin` varchar(32) DEFAULT NULL COMMENT '主账号ID',
  `sub_account_uin` varchar(32) DEFAULT NULL COMMENT '子账号ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='API mock 信息';

/*Table structure for table `tsf_msgw_namespace` */

DROP TABLE IF EXISTS `tsf_msgw_namespace`;

CREATE TABLE `tsf_msgw_namespace` (
  `gw_id` varchar(20) NOT NULL COMMENT '网关ID',
  `namespace_id` varchar(20) NOT NULL COMMENT '可访问命名空间ID',
  `namespace_name` varchar(64) DEFAULT NULL COMMENT '可访问命名空间Name',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `app_id` varchar(32) DEFAULT NULL COMMENT '租户ID',
  `uin` varchar(32) DEFAULT NULL COMMENT '主账号ID',
  `sub_account_uin` varchar(32) DEFAULT NULL COMMENT '子账号ID',
  PRIMARY KEY (`gw_id`,`namespace_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='网关授权访问的命名空间';

/*Table structure for table `tsf_msgw_pkg` */

DROP TABLE IF EXISTS `tsf_msgw_pkg`;

CREATE TABLE `tsf_msgw_pkg` (
  `application_id` varchar(64) DEFAULT NULL COMMENT '应用ID',
  `pkg_id` varchar(256) NOT NULL COMMENT '部署包ID，虚机部署时对应的pkgId，容器部署时对应的是RepoName',
  `gw_type` varchar(32) NOT NULL COMMENT '网关类型，例如ZUUL1,spring-cloud-gateway',
  `pkg_version` varchar(32) NOT NULL COMMENT 'gw部署包版本,虚机包对应pkgVersion， 容器镜像对应TagName',
  `usable_status` varchar(32) NOT NULL DEFAULT 'enabled' COMMENT '是否可用',
  `common_pkg_id` varchar(32) DEFAULT NULL COMMENT '源PkgId',
  `created_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `app_id` varchar(32) DEFAULT NULL,
  `uin` varchar(32) DEFAULT NULL,
  `sub_account_uin` varchar(32) DEFAULT NULL,
  KEY `INDEX_PKG_TYPE` (`gw_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='网关部署包信息';

/*Table structure for table `tsf_msgw_ratelimit` */

DROP TABLE IF EXISTS `tsf_msgw_ratelimit`;

CREATE TABLE `tsf_msgw_ratelimit` (
  `id` varchar(20) NOT NULL COMMENT '限流规则记录ID',
  `rule_name` varchar(128) DEFAULT NULL COMMENT '限流规则名称',
  `api_id` varchar(32) NOT NULL COMMENT 'API ID',
  `max_qps` bigint(20) DEFAULT NULL COMMENT 'QPS 限制值',
  `rule_content` text COMMENT '限流的扩展字段',
  `tsf_rule_id` varchar(32) NOT NULL COMMENT 'TSF 限流服务器生成的ID',
  `usable_status` varchar(12) DEFAULT 'enabled' COMMENT '启用/禁用',
  `description` text COMMENT '限流描述',
  `created_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `app_id` varchar(32) NOT NULL COMMENT '租户ID',
  `uin` varchar(32) NOT NULL COMMENT '主账号ID',
  `sub_account_uin` varchar(32) NOT NULL COMMENT '子账号ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_API_QPS_INDEX` (`api_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='API 限流表';

/*Table structure for table `tsf_msgw_sync_data` */

DROP TABLE IF EXISTS `tsf_msgw_sync_data`;

CREATE TABLE `tsf_msgw_sync_data` (
  `id` varchar(32) NOT NULL,
  `gateway_id` varchar(32) NOT NULL,
  `event_type` varchar(20) NOT NULL COMMENT '数据事件类型,api/group/namespace',
  `event_msg` text COMMENT '数据，JSON结构',
  `reversion` int(11) DEFAULT '1' COMMENT '修订版本号',
  `created_time` datetime DEFAULT NULL,
  `updated_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_INDEX` (`gateway_id`,`event_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='网关客户端数据同步表';

/*添加项目字段*/
ALTER TABLE `tsf_gateway`.`tsf_msgw_instance` ADD COLUMN `project_id` VARCHAR(32) DEFAULT NULL COMMENT '项目ID' AFTER `description`;

/*添加项目字段*/
ALTER TABLE `tsf_gateway`.`tsf_msgw_group` ADD COLUMN `project_id` VARCHAR(32) DEFAULT NULL COMMENT '项目ID' AFTER `description`;

/*添加 msgw_zuul1 镜像*/
INSERT INTO `tsf_gateway`.`tsf_msgw_common_image` (id,repo_name,tag_name,gw_type,created_time) VALUE ('cimg-lk0xrn1q','tsf_base/msgw_scg','1.0.0','msgw_scg',NOW());
/*添加 msgw_scg 镜像*/
INSERT INTO `tsf_gateway`.`tsf_msgw_common_image` (id,repo_name,tag_name,gw_type,created_time) VALUE ('cimg-mj9hg691','tsf_base/msgw_zuul1','1.0.0','msgw_zuul1',NOW());

/*变更命名空间长度*/
ALTER TABLE `tsf_gateway`.`tsf_msgw_api` CHANGE COLUMN `namespace_name` `namespace_name` VARCHAR(64) DEFAULT NULL COMMENT '微服务所属命名空间';

/*添加日志配置项ID*/
ALTER TABLE `tsf_gateway`.`tsf_msgw_instance` ADD COLUMN `log_config_id` VARCHAR(32) DEFAULT NULL COMMENT '默认日志配置项ID' AFTER `project_id`;
