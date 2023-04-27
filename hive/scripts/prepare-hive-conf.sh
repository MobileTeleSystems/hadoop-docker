#!/bin/bash

echo "#################################"
echo "##      PATCHING HIVE CONF     ##"
echo "#################################"

cp /var/hive/conf/* /opt/hive/conf/ || true
sed -i "s/{{hostname}}/$(hostname)/g" /opt/hive/conf/* || true
