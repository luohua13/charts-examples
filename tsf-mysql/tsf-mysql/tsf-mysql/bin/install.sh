#!/bin/bash
set -e

if [ $# != 2 ]
then
        echo "usage: sh install.sh local_ip mysql_master_ip,mysql_slave_ip"
        echo "example: sh install.sh 172.30.0.34 172.30.0.34,172.30.0.37"
        exit 1
fi

# 接收本地ip参数
local_ip=$1
# mysql_master_ip,mysql_slave_ip
mysql_ips=$2

echo "local_ip: $local_ip"
echo "mysql_ips: $mysql_ips"

# tsf-mysql.user 参数
tsf_mysql_user=root

# tsf_yum_repo_ip
# tsf-mysql.password 参数
tsf_mysql_password=qcloudAdmin@123
# tsf-mysql.port 参数
tsf_mysql_port=3306


# 获取当前脚本所在目录， 即 **/tsf-mysql/bin目录
workdir=$(cd $(dirname $0); pwd)

# 进入 **/tsf-mysql/mysql 物料目录
cd  $workdir
cd ../mysql

echo "cp -rf conf /root/tsf-mysql/conf/"
mkdir -p /root/tsf-mysql/conf/
cp -rf conf/* /root/tsf-mysql/conf/
echo "cp -rf sql /root/tsf-mysql/sql/"
mkdir -p /root/tsf-mysql/sql/
cp -rf sql/* /root/tsf-mysql/sql/

# 开始执行 mysql 安装

# 卸载可能存在的 mariadb-libs， 避免 mysql 安装冲突失败

# 进入 mysql 配置文件目录
echo "cd /root/tsf-mysql/conf/"
cd /root/tsf-mysql/conf/

mysql_ip_array=(${mysql_ips//,/ }) 
mysql_ip_length=${#mysql_ip_array[@]}

is_master=1
mysql_cnf=/root/tsf-mysql/conf/my.cnf.master
mysql_init=/root/tsf-mysql/conf/master.sql

if [ $mysql_ip_length -gt 1 ]
then
    if [ "$local_ip" = "${mysql_ip_array[1]}" ]
    then
    	is_master=0
        mysql_cnf=/root/tsf-mysql/conf/my.cnf.slave
        mysql_init=/root/tsf-mysql/conf/slave.sql
    fi
fi

echo "is_master: 1表示为mysql master， 0表示为mysql slave"
echo "is_master: $is_master"
echo "mysql_cnf: $mysql_cnf"
echo "mysql_init: $mysql_init"

# 设置 mysql 端口号
echo "$mysql_cnf -- set mysql port: $tsf_mysql_port"
sed -i 's/^port =.*/port = '$tsf_mysql_port'/g' $mysql_cnf

# innodb_buffer_pool_size 为当前机器内存的 50%
mem_total=`free | awk '/Mem/ {print $2}'`
mem_half=22222K
echo "$mysql_cnf -- set mysql innodb_buffer_pool_size: ${mem_half}K"
sed -i 's/^innodb_buffer_pool_size =.*/innodb_buffer_pool_size = '$mem_half'K/g' $mysql_cnf

# 替换 mysql 配置文件
echo "\cp -f $mysql_cnf /etc/my.cnf && chmod 644 /etc/my.cnf"
\cp -f $mysql_cnf /etc/my.cnf && chmod 644 /etc/my.cnf

# 启动mysql
echo "systemctl start mysqld"
systemctl start mysqld

# 添加 mysql 开机自动运行
echo "systemctl enable mysqld"
systemctl enable mysqld

# journalctl -xe --unit=mysqld  查看mysql错误日志
# rm -fr /var/lib/mysql 如执行启动失败，修改配置后，重启失败，则删除此mysql目录

# 查询临时密码
password_temporary=`grep 'temporary password' /var/log/mysqld.log |awk '{print $(NF)}'`
if [ ! $password_temporary ]
then
#echo "journalctl --unit=mysqld | grep 'temporary password'"
password_string=`journalctl --unit=mysqld | grep 'temporary password'`
#echo "$password_string"
password_temporary=${password_string##*root@localhost: }
#echo "$password_temporary"
fi
# 获取输出字符串的空格分割的最后一个字符即为临时密码
# Nov 01 16:51:45 VM_0_13_centos mysqld_pre_systemd[30460]: 2018-11-01T08:51:45.291052Z 1 [Note] A temporary password is generated for root@localhost: u:k:0>ugypf

# 设置 数据库用户名和密码 sql语句
#echo "sed -i 's/tsf_mysql_user/'$tsf_mysql_user'/g' $mysql_init)"
sed -i 's/tsf_mysql_user/'$tsf_mysql_user'/g' $mysql_init
#echo "sed -i 's/tsf_mysql_password/'$tsf_mysql_password'/g' $mysql_init"
sed -i 's/tsf_mysql_password/'$tsf_mysql_password'/g' $mysql_init

# 执行mysql语句创建用户和密码
mysql --connect-expired-password -uroot -p''$password_temporary'' < $mysql_init

