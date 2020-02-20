# 停止 mysql 服务
echo "systemctl stop mysqld.service"
systemctl stop mysqld.service

# 卸载 mysql
echo "yum -y remove mysql"
yum -y remove mysql

# 删除mysql遗留文件
rm -fr /var/lib/mysql
