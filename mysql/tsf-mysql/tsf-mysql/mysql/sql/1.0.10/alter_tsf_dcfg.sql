ALTER TABLE `tsf_dcfg`.`tsf_dcfg_config_release_log` 
ADD COLUMN `application_id` VARCHAR(20) NULL COMMENT '应用ID' AFTER `sub_account_uin`;

ALTER TABLE `tsf_dcfg`.`tsf_dcfg_config_release` 
ADD COLUMN `application_id` VARCHAR(20) NULL COMMENT '应用ID' AFTER `release_desc`;

-- init tsf_dcfg_config_release_log application_id
UPDATE `tsf_dcfg`.`tsf_dcfg_config_release_log` crl SET `application_id` = (SELECT MAX(c.application_id) FROM `tsf_dcfg`.`tsf_dcfg_config` c WHERE c.id = crl.config_id or c.id = crl.last_config_id);
-- init tsf_dcfg_config_release application_id
UPDATE `tsf_dcfg`.`tsf_dcfg_config_release` cr SET `application_id` = (SELECT MAX(c.application_id) FROM `tsf_dcfg`.`tsf_dcfg_config` c WHERE c.id = cr.config_id);

ALTER TABLE `tsf_dcfg`.`tsf_dcfg_config_release` 
CHANGE COLUMN `application_id` `application_id` VARCHAR(20) NOT NULL COMMENT '应用ID' ;
