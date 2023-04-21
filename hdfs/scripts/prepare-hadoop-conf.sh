#!/bin/bash
echo "#################################"
echo "##     PATCHING HADOOP CONF    ##"
echo "#################################"

cp /var/hadoop/conf/* /etc/hadoop/ || true
sed -i "s/{{hostname}}/$(hostname)/g" /etc/hadoop/* || true
