#!/bin/bash

echo "#################################"
echo "##      PATCHING HIVE CONF     ##"
echo "#################################"

cp /var/hive/conf/* ${HIVE_HOME}/conf/ || true
sed -i "s/{{hostname}}/$(hostname)/g" ${HIVE_HOME}/conf/* || true
