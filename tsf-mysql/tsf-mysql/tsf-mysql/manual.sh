#!/bin/bash
set -e
if (grep master-0 -q  <<<  "$HOSTNAME");
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

else
  echo  "This is slave, nothing to do"
fi
