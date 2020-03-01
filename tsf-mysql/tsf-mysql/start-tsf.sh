#!/bin/bash
HOST_IP=`cat /root/tsf/env.txt|grep HOST_IP|awk -F= '{print $2}'`
TSF_NODE1=`cat /root/tsf/env.txt|grep TSF_NODE1|awk -F= '{print $2}'`
TSF_NODE2=`cat /root/tsf/env.txt|grep TSF_NODE2|awk -F= '{print $2}'`
TSF_NODE3=`cat /root/tsf/env.txt|grep TSF_NODE3|awk -F= '{print $2}'`
LAST=`ps -ef|grep "/usr/sbin/mysqld --daemonize --pid-file=/var/run/mysqld/mysqld.pid"|grep -v grep|wc -l`
if [ $LAST -le 0 ];then
  BOOT=False
else
  BOOT=True
fi

if [ $BOOT == False ];then
  if [ $HOST_IP == $TSF_NODE1 ]; then
    parameter="${TSF_NODE1} ${TSF_NODE1},${TSF_NODE2}"
    mkdir -p /root/tsf/common/tsf-storage/tsf-mysql/
    cp -r /opt/tsf-mysql /root/tsf/common/tsf-storage/tsf-mysql/
    cd /root/tsf/common/tsf-storage/tsf-mysql//*/bin
    bash install.sh $parameter
    cd /root/tsf/common/tsf-storage/tsf-mysql//*/bin
    bash postProcess.sh $parameter
  elif [ $HOST_IP == $TSF_NODE2 ]
  then
    parameter="${TSF_NODE2} ${TSF_NODE1},${TSF_NODE2}"
    mkdir -p /root/tsf/common/tsf-storage/tsf-mysql/
    cp -r /opt/tsf-mysql /root/tsf/common/tsf-storage/tsf-mysql/
    cd /root/tsf/common/tsf-storage/tsf-mysql//*/bin
    bash install.sh $parameter
    cd /root/tsf/common/tsf-storage/tsf-mysql//*/bin
    bash postProcess.sh $parameter
fi
