INSERT INTO `tsf_monitor`.`tsf_monitor_kv` (`busi_type`, `keyname`, `val`, `create_time`) VALUES ('RUN_TASK', 'REPORT_EVENT_TO_BARAD', '0', CURRENT_TIMESTAMP);
INSERT INTO `tsf_monitor`.`tsf_monitor_kv` (`busi_type`, `keyname`, `create_time`) VALUES ('RUN_TASK', 'REPORT_EVENT_TO_BARAD_TIME_OFFSET', CURRENT_TIMESTAMP);

ALTER TABLE `tsf_monitor`.`tsf_monitor_stats_policy` ADD COLUMN `cluster_id` VARCHAR(20) NULL COMMENT '集群ID';