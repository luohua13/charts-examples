USE tsf_ms;

ALTER TABLE tsf_ms_microservice ADD health_check_url VARCHAR(200) NULL COMMENT '健康检查 URL（仅 Mesh 应用）';
ALTER TABLE tsf_ms_microservice ADD service_listening_port int NULL COMMENT '应用监听端口（仅 Mesh 应用）';
ALTER TABLE tsf_ms_microservice ADD service_protocol VARCHAR(20) NULL COMMENT '应用所使用协议（仅 Mesh 应用）';
ALTER TABLE tsf_ms_microservice ADD associate_application_id varchar(20) NULL COMMENT '关联的应用ID';
ALTER TABLE tsf_ms_microservice ADD service_type varchar(20) NOT NULL COMMENT '微服务类型' DEFAULT 'N';
ALTER TABLE tsf_ms_microservice
  MODIFY COLUMN service_protocol VARCHAR(20) COMMENT '应用所使用协议（仅 Mesh 应用）' AFTER service_cluster_type,
  MODIFY COLUMN service_listening_port int COMMENT '应用监听端口（仅 Mesh 应用）' AFTER service_protocol,
  MODIFY COLUMN health_check_url VARCHAR(128) COMMENT '健康检查 URL（仅 Mesh 应用）' AFTER service_listening_port,
  MODIFY COLUMN associate_application_id varchar(20) COMMENT '关联的应用ID' AFTER service_listening_port;