-- 创建分组与日志配置关联表
DROP TABLE IF EXISTS `tsf_apm`.`tsf_apm_busi_log_cfg_group_relation`;
CREATE TABLE `tsf_apm`.`tsf_apm_busi_log_cfg_group_relation` (
	`relation_id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT 'relation identifier',
	`busi_log_cfg_id` varchar(32) NOT NULL COMMENT 'log config identifier',
	`application_id` varchar(20) NOT NULL COMMENT 'application identifier',
	`group_id` varchar(20) NOT NULL COMMENT 'group identifier',
	`relation_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'relation create/operate time',
	UNIQUE INDEX unique_relation(`busi_log_cfg_id`, `application_id`, `group_id`)
) COMMENT='TSF APM 日志配置项与部署组关联';

-- 关联关系迁移存储过程
DROP PROCEDURE IF EXISTS `tsf_apm`.`transfer_relation`;
delimiter $$
CREATE PROCEDURE `tsf_apm`.`transfer_relation`()
  BEGIN
    #定义变量
    DECLARE m_application_id VARCHAR(20);
    DECLARE m_busi_log_cfg_id VARCHAR(32);
    #定义光标
    DECLARE m_app_done INT DEFAULT 0;
    DECLARE m_app_cursor CURSOR FOR SELECT `application_id`,`busi_log_cfg_id` FROM `tsf_apm`.`tsf_apm_busi_log_cfg_application_relation`;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET m_app_done = 1;
    #打开光标
    OPEN m_app_cursor;
    #循环执行
    REPEAT
      FETCH m_app_cursor INTO m_application_id, m_busi_log_cfg_id;

      IF m_app_done != 1 THEN
        BEGIN
        DECLARE m_group_id VARCHAR(20);
        DECLARE m_group_done INT DEFAULT 0;
        DECLARE m_group_cursor CURSOR FOR SELECT `id` FROM `tsf_resource`.`tsf_resource_group` WHERE `application_id` = m_application_id;
        DECLARE CONTINUE HANDLER FOR NOT FOUND SET m_group_done = 1;
        OPEN m_group_cursor;
        REPEAT
          FETCH m_group_cursor INTO m_group_id;
          IF m_group_done != 1 THEN
            INSERT INTO `tsf_apm`.`tsf_apm_busi_log_cfg_group_relation` (`busi_log_cfg_id`,`application_id`,`group_id`) VALUES (m_busi_log_cfg_id,m_application_id,m_group_id);
          END IF;
        UNTIL m_group_done END REPEAT;
        CLOSE m_group_cursor;
        SET m_group_done = 0;
        END;
      END IF;

    UNTIL m_app_done END REPEAT;
    CLOSE m_app_cursor;
  END$$
delimiter ;
call `tsf_apm`.`transfer_relation`;
DROP PROCEDURE `tsf_apm`.`transfer_relation`;