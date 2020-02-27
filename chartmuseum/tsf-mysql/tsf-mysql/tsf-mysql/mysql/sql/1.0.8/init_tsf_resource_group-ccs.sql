USE tsf_resource;

-- ***************注：此脚本最后执行
-- 将tsf_resource_group表的k8s_servicename填充为groupId(*******************注:仅在公有云环境一次性执行，灵雀云私有云环境无需执行**********************)
UPDATE tsf_resource_group g SET g.k8s_servicename = g.id where g.k8s_servicename is  null and g.id in(select temp.id from (select t.id from  tsf_resource_group t,tsf_resource_application a where a.id = t.application_id and a.application_type ='C') as temp) ;

UPDATE tsf_resource_group g SET g.k8s_servicename = null where g.cpu_limit is  null;

UPDATE tsf_resource_group g 
SET 
    g.k8s_servicename = g.group_name,
    g.cpu_limit = 0.5,
    g.mem_limit = 512,
    g.instance_num = 1,
    g.access_type = 1,
    g.protocol_ports = 'TCP:80:80',
    g.update_type = 0
WHERE
    g.k8s_servicename IS NULL
        AND g.id IN (SELECT 
            temp.id
        FROM
            (SELECT 
                t.id
            FROM
                tsf_resource_group t, tsf_resource_application a
            WHERE
                a.id = t.application_id
                    AND a.application_type = 'C') AS temp);