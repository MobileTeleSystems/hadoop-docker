#!/bin/bash

set -e

echo "--------------- INITIALIZE HDFS ---------------"
$HADOOP_HOME/bin/hdfs dfsadmin -safemode get
$HADOOP_HOME/bin/hdfs dfs -chmod -R 1777 /
$HADOOP_HOME/bin/hdfs dfs -mkdir -p /user/root
$HADOOP_HOME/bin/hdfs dfs -chown root:hadoop /user/root
$HADOOP_HOME/bin/hdfs dfs -chmod 777 /user
