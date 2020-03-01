
-- store tag condition
CREATE TABLE `tsf_ratelimit`.`tsf_ratelimit_dimension` (
  `rule_id` varchar(16) NOT NULL,
  `type` varchar(16) NOT NULL,
  `field` varchar(64) NOT NULL,
  `operator` varchar(16) NOT NULL,
  `value` varchar(512) NOT NULL,
  KEY `rule_id` (`rule_id`)
);

-- transfer old source service name
INSERT INTO `tsf_ratelimit`.`tsf_ratelimit_dimension` (`rule_id`, `type`, `field`, `operator`, `value`)
SELECT id, 'S', 'source.service.name', 'EQUAL', src_service
FROM `tsf_ratelimit`.`tsf_ratelimit_rule` AS old
WHERE old.src_service <> '';

