#!/bin/bash
set -e
if (grep master-0 -q  <<<  "$HOSTNAME");
then
  echo  "this is master, begin to import sql files"
else
  echo  "This is slave, nothing to do"
fi
