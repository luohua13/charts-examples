-- CREATE RULE TABLE
CREATE TABLE `tsf_auth`.`tsf_auth_rule` (
  `rule_id` VARCHAR(20) NOT NULL COMMENT '规则ID，物理主键',
  `rule_name` VARCHAR(60) NOT NULL COMMENT '规则名称',
  `is_enabled` VARCHAR(1) NOT NULL COMMENT '是否启用规则',
  `microservice_id` VARCHAR(20) NOT NULL COMMENT '微服务ID',
  `create_time` DATETIME NOT NULL COMMENT '创建时间',
  `update_time` DATETIME NOT NULL COMMENT '更新时间',
  `app_id` VARCHAR(60) NOT NULL COMMENT '租户ID',
  `uin` VARCHAR(60) NOT NULL COMMENT '租户Owner的用户ID',
  `sub_account_uin` VARCHAR(60) NOT NULL COMMENT '用户ID',
  PRIMARY KEY (`rule_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'TSF鉴权规则表';

-- ALTER CONDITION ADD RULE_ID COLUMN
ALTER TABLE `tsf_auth`.`tsf_auth_condition` 
ADD COLUMN `rule_id` VARCHAR(20) NULL COMMENT '微服务权限规则ID' AFTER `value`;

-- ADD USER INFO COLUMNS
ALTER TABLE `tsf_auth`.`tsf_auth_condition` 
ADD COLUMN `app_id` VARCHAR(60) NULL COMMENT '租户ID' AFTER `rule_id`,
ADD COLUMN `uin` VARCHAR(60) NULL COMMENT '租户OWNER的用户ID' AFTER `app_id`,
ADD COLUMN `sub_account_uin` VARCHAR(60) NULL COMMENT '用户ID' AFTER `uin`;

-- REMOVE service_id
ALTER TABLE `tsf_auth`.`tsf_auth_condition` 
DROP FOREIGN KEY `fk_target_service`;
ALTER TABLE `tsf_auth`.`tsf_auth_condition` 
CHANGE COLUMN `service_id` `service_id` VARCHAR(32) NULL ,
DROP INDEX `fk_target_service` ;

-- INSERT RULES
INSERT INTO `tsf_auth`.`tsf_auth_rule`(`rule_id`, `rule_name`, `is_enabled`, `microservice_id`, `create_time`, `update_time`, `app_id`, `uin`, `sub_account_uin`) 
SELECT DISTINCT CONCAT('auth-rule-',SUBSTR(c.service_id, 4)), 'default', ts.is_enabled, c.service_id, NOW(), NOW(), ms.app_id, ms.uin, ms.sub_account_uin 
FROM `tsf_auth`.`tsf_auth_condition` c, `tsf_ms`.`tsf_ms_microservice` ms, `tsf_auth`.`tsf_auth_target_service` ts
WHERE c.service_id = ms.id AND ts.service_id = c.service_id;

-- MODIFY CONDITION
UPDATE `tsf_auth`.`tsf_auth_condition` c LEFT JOIN `tsf_auth`.`tsf_auth_rule` r 
ON r.microservice_id = c.service_id 
SET c.rule_id = r.rule_id, c.app_id = r.app_id, c.uin = r.uin, c.sub_account_uin = r.sub_account_uin;

-- MODIFY CONDITION2
UPDATE `tsf_auth`.`tsf_auth_condition` SET `type` = 'S' WHERE `type` = 'meta';
UPDATE `tsf_auth`.`tsf_auth_condition` SET `type` = 'U' WHERE `type` = 'tag';
UPDATE `tsf_auth`.`tsf_auth_condition` SET `operator` = 'IN' WHERE `operator` = 'in';
UPDATE `tsf_auth`.`tsf_auth_condition` SET `operator` = 'NOT_IN' WHERE `operator` = 'notIn';
UPDATE `tsf_auth`.`tsf_auth_condition` SET `operator` = 'EQUAL' WHERE `operator` = 'equal';
UPDATE `tsf_auth`.`tsf_auth_condition` SET `operator` = 'NOT_EQUAL' WHERE `operator` = 'notEqual';
UPDATE `tsf_auth`.`tsf_auth_condition` SET `operator` = 'REGEX' WHERE `operator` = 'regex';

-- NEW COLUMN : AUTH TYPE
ALTER TABLE `tsf_auth`.`tsf_auth_target_service` 
ADD COLUMN `type` VARCHAR(20) NULL COMMENT '鉴权类型' AFTER `is_enabled`;

-- INIT COLUMN : AUTH TYPE
UPDATE `tsf_auth`.`tsf_auth_target_service` SET `type` = 'D' WHERE `is_enabled` = '0';
UPDATE `tsf_auth`.`tsf_auth_target_service` SET `type` = 'W' WHERE `is_enabled` = '1';
COMMIT;

-- ALTER TABLE COLUMNS
ALTER TABLE `tsf_auth`.`tsf_auth_target_service` 
CHANGE COLUMN `namespace_id` `namespace_id` VARCHAR(32) NULL ,
CHANGE COLUMN `is_enabled` `is_enabled` INT(11) NULL DEFAULT '0' ,
CHANGE COLUMN `type` `type` VARCHAR(20) NOT NULL COMMENT '鉴权类型' ;
