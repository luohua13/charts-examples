use tsf_core;

create unique index unique_name on region(name);
alter table zone add unique unique_name_region_id (name, region_id);
alter table `consul_server` add `used` int not null default '1' after `status`;
ALTER TABLE appserver_real MODIFY COLUMN real_status_info varchar(3072);
alter table appserver_real modify id varchar(128);
insert into region (id, name) values (0, '');
insert into zone (id, name, region_id) values (0, '', 0);
update region set id=0 where id=2;
update zone set id=0 where id=2;

