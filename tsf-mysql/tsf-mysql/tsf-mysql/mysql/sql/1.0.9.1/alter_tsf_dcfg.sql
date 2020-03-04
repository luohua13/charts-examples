-- 更新应用配置
ALTER TABLE `tsf_dcfg`.`tsf_dcfg_config_release` 
ADD COLUMN `release_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP AFTER `sub_account_uin`;

UPDATE `tsf_dcfg`.`tsf_dcfg_config_release` r 
SET 
    release_time = (SELECT 
            MAX(rl.release_time)
        FROM
            `tsf_dcfg`.`tsf_dcfg_config_release_log` rl
        WHERE
            rl.app_id = r.app_id
                AND rl.config_id = r.config_id
                AND rl.group_id = r.group_id);
COMMIT;

-- 更新全局配置
ALTER TABLE `tsf_dcfg`.`tsf_dcfg_pub_config_release` 
ADD COLUMN `release_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP AFTER `sub_account_uin`;

UPDATE `tsf_dcfg`.`tsf_dcfg_pub_config_release` r 
SET 
    release_time = (SELECT 
            MAX(rl.release_time)
        FROM
            `tsf_dcfg`.`tsf_dcfg_pub_config_release_log` rl
        WHERE
            rl.app_id = r.app_id
                AND rl.config_id = r.config_id
                AND rl.namespace_id = r.namespace_id);
COMMIT;

-- 更新应用配置
ALTER TABLE `tsf_dcfg`.`tsf_dcfg_config_release` 
ADD COLUMN `release_desc` varchar(200) DEFAULT NULL COMMENT '发布描述';

UPDATE `tsf_dcfg`.`tsf_dcfg_config_release` r 
SET 
    release_desc = (SELECT rl.release_desc
        FROM
            `tsf_dcfg`.`tsf_dcfg_config_release_log` rl
        WHERE
            rl.app_id = r.app_id
                AND rl.config_id = r.config_id
                AND rl.group_id = r.group_id
				ORDER BY rl.release_time DESC LIMIT 1 OFFSET 0);
COMMIT;

-- 更新全局配置
ALTER TABLE `tsf_dcfg`.`tsf_dcfg_pub_config_release` 
ADD COLUMN `release_desc` varchar(200) DEFAULT NULL COMMENT '发布描述';

UPDATE `tsf_dcfg`.`tsf_dcfg_pub_config_release` r 
SET 
    release_desc = (SELECT rl.release_desc
        FROM
            `tsf_dcfg`.`tsf_dcfg_pub_config_release_log` rl
        WHERE
            rl.app_id = r.app_id
                AND rl.config_id = r.config_id
                AND rl.namespace_id = r.namespace_id
				ORDER BY rl.release_time DESC LIMIT 1 OFFSET 0);
COMMIT;
