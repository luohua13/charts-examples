-- 创建日志解析规则表
DROP TABLE IF EXISTS `tsf_apm`.`tsf_apm_busi_log_cfg_schema`;
CREATE TABLE `tsf_apm`.`tsf_apm_busi_log_cfg_schema` (
	`schema_id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT 'schema identifier',
	`app_id` varchar(60) NOT NULL COMMENT 'tsf account app id',
	`schema_type` int(11) NOT NULL COMMENT 'schema type',
	`schema_content` varchar(512) COMMENT 'schema content',
	`schema_date_format` varchar(128) COMMENT 'schema date format',
	`schema_pattern_layout` varchar(512) COMMENT 'schema pattern layout',
	`schema_grok_pattern` varchar(512) COMMENT 'schema grok pattern',
	`schema_date_grok_pattern` varchar(128) COMMENT 'schema date grok pattern',
	`schema_multiline_pattern` varchar(128) COMMENT 'schema multiline pattern',
	`schema_create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'schema create time'
) COMMENT='TSF APM 日志配置项解析规则';

-- 修改日志配置表
ALTER TABLE `tsf_apm`.`tsf_apm_busi_log_cfg` DROP `cfg_schema`;
ALTER TABLE `tsf_apm`.`tsf_apm_busi_log_cfg` ADD `cfg_schema_id` int(11) NOT NULL DEFAULT 0 COMMENT 'config schema';
ALTER TABLE `tsf_apm`.`tsf_apm_busi_log_cfg` ADD `cfg_update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'config update time';

-- 更新日志配置表配置更新时间
UPDATE `tsf_apm`.`tsf_apm_busi_log_cfg` SET `cfg_update_time` = `cfg_create_time`;

-- 旧日志配置解析规则初始化存储过程
DROP PROCEDURE IF EXISTS `tsf_apm`.`create_config_schema`;
delimiter $$
CREATE PROCEDURE `tsf_apm`.`create_config_schema`()
BEGIN
	  #定义变量
	  DECLARE config_id VARCHAR(32);
    DECLARE config_app_id VARCHAR(60);
	  #定义光标
    DECLARE m_config_done INT DEFAULT 0;
    DECLARE m_config_cursor CURSOR FOR SELECT `cfg_id`,`app_id` FROM `tsf_apm`.`tsf_apm_busi_log_cfg`;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET m_config_done = 1;
    #打开光标
    OPEN m_config_cursor;
		#循环执行
    REPEAT
      FETCH m_config_cursor INTO config_id, config_app_id;

      IF m_config_done != 1 THEN
        BEGIN
		      DECLARE schema_id INT DEFAULT 0;
		      DECLARE schema_type INT DEFAULT 0;
			    DECLARE schema_content VARCHAR(512) DEFAULT NULL;
			    DECLARE schema_date_format VARCHAR(128) DEFAULT 'YYYY-MM-dd HH:mm:ss.SSS';
			    DECLARE schema_pattern_layout VARCHAR(512) DEFAULT NULL;
		      DECLARE schema_grok_pattern VARCHAR(512) DEFAULT '%{LOGDATE:log-time}\s*%{LOGLEVEL:log-level}\s*(\[(%{NOTSPACE:application-name}|),(%{NOTSPACE:trace-id}|),(%{NOTSPACE:span-id}|),(%{WORD}|)\]|)\s*%{BASE10NUM}\s*---\s*%{GREEDYDATA:log-content}';
			    DECLARE schema_date_grok_pattern VARCHAR(128) DEFAULT '%{TIMESTAMP_ISO8601}';
			    DECLARE schema_multiline_pattern VARCHAR(128) DEFAULT '^[0-9]{4}-[0-9]{2}-[0-9]{2}';

			    #向schema表插入一条记录
			    INSERT INTO tsf_apm_busi_log_cfg_schema (`app_id`,`schema_type`,`schema_content`,`schema_date_format`,`schema_pattern_layout`,`schema_grok_pattern`,`schema_date_grok_pattern`,`schema_multiline_pattern`) VALUES (config_app_id,schema_type,schema_content,schema_date_format,schema_pattern_layout,schema_grok_pattern,schema_date_grok_pattern,schema_multiline_pattern);

					#获取插入记录的ID
			    SELECT LAST_INSERT_ID() INTO schema_id;

					#更新config表的schema_id字段
			    UPDATE `tsf_apm`.`tsf_apm_busi_log_cfg` SET `cfg_schema_id` = schema_id WHERE `cfg_id` = config_id;
			  END;
      END IF;

	  UNTIL m_config_done END REPEAT;
    CLOSE m_config_cursor;
END ;$$
delimiter ;
call `tsf_apm`.`create_config_schema`;
DROP PROCEDURE `tsf_apm`.`create_config_schema`;

-- 修改日志配置部署组关联关系表
ALTER TABLE `tsf_apm`.`tsf_apm_busi_log_cfg_group_relation` DROP INDEX unique_relation;
ALTER TABLE `tsf_apm`.`tsf_apm_busi_log_cfg_group_relation` ADD UNIQUE unique_relation(`busi_log_cfg_id`, `group_id`);
ALTER TABLE `tsf_apm`.`tsf_apm_busi_log_cfg_group_relation` DROP `application_id`;