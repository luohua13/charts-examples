#!/bin/bash
set -e
if ( grep master-0 -q  <<<  "$HOSTNAME"  && [[  ! -f /bitnami/mysql/import.done.lock ]] );
then
  echo  "this is master, begin to import sql files"
#sleep 60 
    # 调用初始化数据库脚本
    echo "init sql..."
    cd /opt/mysql/sql
    
    touch /bitnami/mysql/import.done.lock

else
  echo  "This is slave, nothing to do. OR already imported"
fi
