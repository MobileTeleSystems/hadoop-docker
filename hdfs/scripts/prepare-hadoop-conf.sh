#!/bin/bash
echo "#################################"
echo "##     PATCHING HADOOP CONF    ##"
echo "#################################"

cp /var/hadoop/conf/* ${HADOOP_CONF_DIR}/ || true
sed -i "s/{{hostname}}/$(hostname)/g" ${HADOOP_CONF_DIR}/* || true
