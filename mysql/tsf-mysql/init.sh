#!/bin/bash
parameter=$*
mkdir -p /root/tsf/common/tsf-storage/tsf-mysql/
cp -r /opt/tsf-mysql /root/tsf/common/tsf-storage/tsf-mysql/
cd /root/tsf/common/tsf-storage/tsf-mysql//*/bin
bash install.sh $parameter
cd /root/tsf/common/tsf-storage/tsf-mysql//*/bin
bash postProcess.sh $parameter
