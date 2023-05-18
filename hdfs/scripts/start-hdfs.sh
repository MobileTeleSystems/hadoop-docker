#!/bin/bash

set -e

echo "--------------- FORMATTING DATA DIRECTORY ---------------"
$HADOOP_HOME/bin/hdfs namenode -format -nonInteractive || true

echo "--------------- STARTING HDFS NODES ---------------"
$HADOOP_HOME/sbin/start-dfs.sh
tail -F -n 1000 /opt/hadoop/logs/hadoop-root-namenode-*.out | sed 's/^/| NAMENODE | /g' &
tail -F -n 1000 /opt/hadoop/logs/hadoop-root-datanode-*.out | sed 's/^/| DATANODE | /g' &

/wait-for-it.sh -h localhost -p 9820 -t $WAIT_TIMEOUT_SECONDS
echo "--------------- HDFS NODES READY ---------------"
