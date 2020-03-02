use tsf_core;

alter table appgroup modify cluster_id varchar(32) not null default '';
alter table appgroup add log_config_index int(11) not null default 0;
alter table appgroup add jvm_param_index int(11) not null default 0;


alter table appserver add mtime timestamp not null default CURRENT_TIMESTAMP;
alter table appserver add app_status varchar(32) not null default '';
alter table appserver add package_version varchar(32) not null default '';
alter table appserver add log_config_index int(11) not null default 0;
alter table appserver add jvm_param_index int(11) not null default 0;


create table appserver_real (
        id varchar(128) not null default '' primary key,
        real_status_info varchar(2048) not null default '',
        appgroup_id varchar(32) not null default '',
        app_status varchar(32) not null default '',
        package_version varchar(32) not null default '',
        log_config_index int(11) not null default 0,
        jvm_param_index int(11) not null default 0
);