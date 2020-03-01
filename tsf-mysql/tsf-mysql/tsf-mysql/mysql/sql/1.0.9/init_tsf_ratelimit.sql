-- Create tsf_ratelimit schema
DROP SCHEMA IF EXISTS `tsf_ratelimit`;
CREATE SCHEMA `tsf_ratelimit` ;

-- Create Account
DROP USER IF EXISTS `tsf_ratelimit`;
CREATE USER `tsf_ratelimit`@'%' IDENTIFIED BY 'Tcdn@2007';
GRANT ALL PRIVILEGES ON tsf_ratelimit.* TO 'tsf_ratelimit'@'%' IDENTIFIED BY 'Tcdn@2007';
FLUSH PRIVILEGES;

-- Create Table in TSF_ROUTE
-- TSF_COMMON_ID
DROP TABLE IF EXISTS `tsf_ratelimit`.`tsf_common_id`;
CREATE TABLE `tsf_ratelimit`.`tsf_common_id` (
  `id_type` varchar(20) NOT NULL,
  `id_value` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_type`)
);
INSERT INTO `tsf_ratelimit`.`tsf_common_id` (id_type) values ("hashId");

DROP TABLE IF EXISTS `tsf_ratelimit`.`tsf_ratelimit_rule`;
CREATE TABLE `tsf_ratelimit`.`tsf_ratelimit_rule` (
  `id` varchar(20) NOT NULL,
  `rule_name` varchar(60) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `app_id` varchar(60) NOT NULL DEFAULT '0',
  `namespace_id` varchar(20) NOT NULL,
  `service_name` varchar(60) NOT NULL,
  `src_service` varchar(60) NOT NULL DEFAULT '',
  `duration_second` int(11) NOT NULL DEFAULT '1',
  `duration_quota` int(11) NOT NULL,
  `description` varchar(200) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `prim_index` (`app_id`,`namespace_id`,`service_name`)
);
