ALTER USER 'tsf_mysql_user'@'localhost' IDENTIFIED BY 'tsf_mysql_password';
GRANT ALL PRIVILEGES ON *.* to tsf_mysql_user@'localhost' IDENTIFIED BY 'tsf_mysql_password' WITH GRANT OPTION;
FLUSH PRIVILEGES;

CREATE USER 'tsf_mysql_user'@'%' IDENTIFIED by 'tsf_mysql_password';
GRANT ALL PRIVILEGES ON *.* to tsf_mysql_user@'%' IDENTIFIED BY 'tsf_mysql_password' WITH GRANT OPTION;
FLUSH PRIVILEGES;

CREATE USER 'replicator'@'%' IDENTIFIED BY 'tsf_mysql_password';
GRANT REPLICATION SLAVE ON *.* TO 'replicator'@'%';

