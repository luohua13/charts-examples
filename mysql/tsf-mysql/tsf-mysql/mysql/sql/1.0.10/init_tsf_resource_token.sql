-- token表
DROP TABLE IF EXISTS `tsf_resource`.`tsf_resource_token`;
CREATE TABLE `tsf_resource`.`tsf_resource_token` (
  `id` varchar(20) NOT NULL COMMENT '主键ID，全局唯一',
  `app_id` varchar(60) NOT NULL COMMENT '租户id',
  `token` varchar(512) NOT NULL COMMENT 'token',
  PRIMARY KEY (`id`),
  UNIQUE INDEX idx_resource_token_appid(`app_id`)
)  COMMENT='token表';