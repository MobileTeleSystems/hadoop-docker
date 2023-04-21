#!/bin/bash

set -e

echo "--------------- FORMATTING DATA DIRECTORY ---------------"
$HADOOP_HOME/bin/hdfs namenode -format -nonInteractive || true

echo "--------------- STARTING HDFS NODES ---------------"
$HADOOP_HOME/sbin/start-dfs.sh
tail -F -n 1000 /opt/hadoop/logs/hadoop-root-namenode-*.out &
tail -F -n 1000 /opt/hadoop/logs/hadoop-root-datanode-*.out &

/wait-for-it.sh -h localhost -p 9000 -t $WAIT_TIMEOUT_SECONDS
