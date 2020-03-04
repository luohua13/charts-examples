-- 删掉 Pod 表中重复的数据
-- 因为这个 bug，不得不使用 USE 语句：https://bugs.mysql.com/bug.php?id=23413
USE tsf_resource;
DELETE t1
FROM tsf_resource.tsf_resource_pod t1
       INNER JOIN tsf_resource.tsf_resource_pod t2
WHERE t1.create_time < t2.create_time
  AND t1.group_id = t2.group_id;

-- 给 pod 表加上 group_id 的 UNIQUE KEY
ALTER TABLE tsf_resource.tsf_resource_pod ADD UNIQUE (group_id);
