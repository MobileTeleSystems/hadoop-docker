#!/bin/bash

echo "#################################"
echo "##      PATCHING HIVE CONF     ##"
echo "#################################"

cp /var/hive/conf/* ${HIVE_HOME}/conf/ || true
sed -i "s/{{hostname}}/$(hostname)/g" ${HIVE_HOME}/conf/* || true
sed -i "s#{{HIVE_METASTORE_DB_URL}}#${HIVE_METASTORE_DB_URL:-jdbc:postgresql://postgres:5432/metastore}#g" ${HIVE_HOME}/conf/* || true
sed -i "s/{{HIVE_METASTORE_DB_DRIVER}}/${HIVE_METASTORE_DB_DRIVER:-org.postgresql.Driver}/g" ${HIVE_HOME}/conf/* || true
sed -i "s/{{HIVE_METASTORE_DB_USER}}/${HIVE_METASTORE_DB_USER:-hive}/g" ${HIVE_HOME}/conf/* || true
sed -i "s/{{HIVE_METASTORE_DB_PASSWORD}}/${HIVE_METASTORE_DB_PASSWORD:-hive}/g" ${HIVE_HOME}/conf/* || true
