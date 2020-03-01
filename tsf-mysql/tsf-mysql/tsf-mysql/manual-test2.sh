#!/bin/bash
set -e

if (grep -q "master-0" <<<  "$HOSTNAME");
then
  echo  "this is master, begin to import sql files"
            mysql -uroot -p"$MYSQL_ROOT_PASSWORD" -e "select 1;"
else
  echo  "This is slave, nothing to do"
fi
