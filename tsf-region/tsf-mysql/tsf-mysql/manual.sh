#!/bin/bash
set -e

echo "Waiting mysql to launch on 3306..."

while ! nc -z localhost 3306; do
  sleep 30
done

echo "mysql launched"
sleep 60s

##if (grep master-0 -q  <<<  "$HOSTNAME");
if ( grep master-0 -q  <<<  "$HOSTNAME"  && [[  ! -f /bitnami/mysql/import.done.lock ]] );
then
  echo  "this is master, begin to import sql files"
#sleep 60 
    # 调用初始化数据库脚本
    echo "init sql..."
    cd /opt/mysql/sql
    versions=($(ls | sort --version-sort))
    for version in "${versions[@]}"; do
        sqlfiles=($(ls $version/*.sql))
        for file in "${sqlfiles[@]}"; do
            echo "Importing $file..."
            mysql -uroot -p"$MYSQL_ROOT_PASSWORD" < "$file"
        done
    done

    /usr/bin/touch /bitnami/mysql/import.done.lock

else
  echo  "This is slave, nothing to do"
fi
