-- Create tsf_tx schema
DROP SCHEMA IF EXISTS `tsf_nameserver`;
CREATE SCHEMA `tsf_nameserver` ;

-- Create Account
DROP USER IF EXISTS `tsf_nameserver`;
CREATE USER `tsf_nameserver`@'%' IDENTIFIED BY 'Tcdn@2007';
GRANT ALL PRIVILEGES ON tsf_nameserver.* TO 'tsf_nameserver'@'%' IDENTIFIED BY 'Tcdn@2007';
FLUSH PRIVILEGES;

-- Create Tables of tsf_nameserver
CREATE TABLE `tsf_nameserver`.`tsf_service_addr_subscribe` (
  `app_id` varchar(60) NOT NULL DEFAULT '0',
  `namespace_id` varchar(20) NOT NULL DEFAULT '',
  `service_name` varchar(60) NOT NULL DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `consul_index` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`namespace_id`,`service_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
