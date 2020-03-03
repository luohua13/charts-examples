ALTER TABLE `tsf_ms`.`tsf_ms_microservice`
ADD UNIQUE INDEX `unique_ns_service` (`namespace_id`, `service_name`);