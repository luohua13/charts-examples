#!/bin/bash

CHART_DIR=`pwd`

# docker load -i chartmuseum.tar

docker run -d  --restart=always           \
--name chart-repo  -p 8088:8080         \
-e PORT=8080                            \
-e DEBUG=1           -e STORAGE="local"   \
-e STORAGE_LOCAL_ROOTDIR="/data"          \
-v ${CHART_DIR}/chartmuseum:/data         \
index.alauda.cn/chartmuseum:latest

#-e BASIC_AUTH_USER="chartmuseum"          \
#-e BASIC_AUTH_PASS="chartmuseum"          \


