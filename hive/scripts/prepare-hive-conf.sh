#!/bin/bash

echo "#################################"
echo "##      PATCHING HIVE CONF     ##"
echo "#################################"

cp /var/hive/conf/* ${HIVE_HOME}/conf/ || true
sed -i "s/{{hostname}}/$(hostname)/g" ${HIVE_HOME}/conf/* || true
sed -i "s/{{POSTGRES_HOST}}/${POSTGRES_HOST:-postgres}/g" ${HIVE_HOME}/conf/* || true
sed -i "s/{{POSTGRES_PORT}}/${POSTGRES_PORT:-5432}/g" ${HIVE_HOME}/conf/* || true
sed -i "s/{{POSTGRES_DB}}/${POSTGRES_DB:-metastore}/g" ${HIVE_HOME}/conf/* || true
sed -i "s/{{POSTGRES_USER}}/${POSTGRES_USER:-hive2}/g" ${HIVE_HOME}/conf/* || true
sed -i "s/{{POSTGRES_PASSWORD}}/${POSTGRES_PASSWORD:-hive2}/g" ${HIVE_HOME}/conf/* || true
