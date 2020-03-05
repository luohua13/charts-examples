-- UPDATE DEFAULT LOG CONFIG PATH
UPDATE `tsf_apm`.`tsf_apm_busi_log_cfg` SET cfg_path = "PH_STARTUP_PATH/logs/*.log" WHERE cfg_name = "default-log-config";