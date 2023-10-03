#!/bin/bash

set -e

# if there is a log file from previous run, remove it
rm -rf /opt/hadoop/logs/hadoop-root-namenode-*.out || true
rm -rf /opt/hadoop/logs/hadoop-root-datanode-*.out || true

echo "--------------- FORMATTING DATA DIRECTORY ---------------"
$HADOOP_HOME/bin/hdfs namenode 2>&1 -format -nonInteractive | sed 's/^/| HDFS | /g' || true

echo "--------------- STARTING HDFS NODES ---------------"
$HADOOP_HOME/sbin/start-dfs.sh 2>&1 | sed 's/^/| HDFS | /g'

tail -F -n 1000 /opt/hadoop/logs/hadoop-root-namenode-*.out | sed 's/^/| NAMENODE | /g' &
tail -F -n 1000 /opt/hadoop/logs/hadoop-root-datanode-*.out | sed 's/^/| DATANODE | /g' &

/wait-for-it.sh -h localhost -p 9820 -t $WAIT_TIMEOUT_SECONDS
echo "--------------- HDFS NODES READY ---------------"
