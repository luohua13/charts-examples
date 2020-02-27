USE tsf_auth;

-- 1.0.8.2 开始用新的数据表，删掉老表
DROP TABLE IF EXISTS `tsf_auth`.`tsf_auth_authorization`;

CREATE TABLE tsf_auth_target_service
(
    service_id VARCHAR(32) PRIMARY KEY NOT NULL,
    namespace_id VARCHAR(32) NOT NULL,
    app_id VARCHAR(64) DEFAULT '0' NOT NULL,
    uin VARCHAR(64) DEFAULT '0' NOT NULL,
    sub_account_uin VARCHAR(64) DEFAULT '0' NOT NULL,
    is_enabled int DEFAULT 0 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE tsf_auth_condition
(
    id int PRIMARY KEY NOT NULL AUTO_INCREMENT,
    service_id VARCHAR(32) NOT NULL,
    type VARCHAR(16) NOT NULL COMMENT '条件类型，"meta", "tag"',
    `key` VARCHAR(64),
    operator VARCHAR(16) COMMENT '操作符，"equal", "notEqual", "in", "notIn", "regex"',
    value VARCHAR(2048) COMMENT '条件所匹配的值，如果是 in / notIn，这里是一个 CSV 列表；否则是一个字符串',
    CONSTRAINT fk_target_service FOREIGN KEY (service_id) REFERENCES tsf_auth_target_service (service_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
