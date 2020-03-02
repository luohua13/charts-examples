-- BACKUP tsf_resource_token to tsf_resource_token_old
CREATE TABLE `tsf_resource`.`tsf_resource_token_old` LIKE `tsf_resource`.`tsf_resource_token`;
INSERT INTO `tsf_resource`.`tsf_resource_token_old` SELECT * FROM `tsf_resource`.`tsf_resource_token`;
-- DROP TABLE
DROP TABLE IF EXISTS `tsf_resource`.`tsf_resource_token`;
-- CREATE TABLE
CREATE TABLE `tsf_resource`.`tsf_resource_token` (
  `token` VARCHAR(255) NOT NULL COMMENT 'token值',
  `token_type` VARCHAR(10) NOT NULL COMMENT 'token类型',
  `content` VARCHAR(60) NOT NULL COMMENT 'token原文',
  `namespace_id` VARCHAR(60) NULL COMMENT '命名空间ID',
  `app_id` VARCHAR(60) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`token`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'TSF Token表';
ALTER TABLE `tsf_resource`.`tsf_resource_token` 
ADD UNIQUE INDEX `UK_TOKEN_TYPE_CONTENT` (`token_type` ASC, `content` ASC);
-- INIT DATA
INSERT INTO `tsf_resource`.`tsf_resource_token` SELECT `token`, 'App', `app_id`, 'common', `app_id` FROM `tsf_resource`.`tsf_resource_token_old`;