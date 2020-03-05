#!/bin/bash
set -e


if [ $# != 2 ]
then
        echo "usage: sh postProcess.sh local_ip mysql_master_ip,mysql_slave_ip"
        echo "example: sh postProcess.sh 172.30.0.34 172.30.0.34,172.30.0.37"
        exit 1
fi

# 接收本地ip参数
local_ip=$1
# mysql_master_ip,mysql_slave_ip
mysql_ips=$2

# tsf-mysql.user 参数
tsf_mysql_user=root

echo "get tsf-mysql config from consul config"
# tsf-mysql.password 参数
tsf_mysql_password=qcloudAdmin@123
# tsf-mysql.port 参数
tsf_mysql_port=3306

mysql_ip_array=(${mysql_ips//,/ }) 
mysql_ip_length=${#mysql_ip_array[@]}

is_master=1

if [ $mysql_ip_length -gt 1 ]
then
    if [ "$local_ip" = "${mysql_ip_array[1]}" ]
    then
    	is_master=0
    fi
fi

echo "is_master: 1表示为mysql master， 0表示为mysql slave"
echo "is_master: $is_master"

if [ $is_master -eq 0 ]
then
    # 设置主从同步
    mysqlreplicate --master=root:$tsf_mysql_password@${mysql_ip_array[0]}:$tsf_mysql_port --slave=root:$tsf_mysql_password@${mysql_ip_array[1]}:$tsf_mysql_port --rpl-user=replicator:$tsf_mysql_password
elif [ $is_master -eq 1 ]
then
    sleep 60 
	# 调用初始化数据库脚本
	echo "init sql..."
    cd /root/tsf-mysql/sql/
    versions=($(ls | sort --version-sort))
    for version in "${versions[@]}"; do
        sqlfiles=($(ls $version/*.sql))
        for file in "${sqlfiles[@]}"; do
            echo "Importing $file..."
            mysql -uroot -p"${tsf_mysql_password}" < "$file"
        done
	done
fi
