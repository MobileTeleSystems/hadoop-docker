#!/bin/bash

set -e

echo "--------------- STARTING MAPREDUCE JOBHISTORY SERVER ---------------"
$HADOOP_HOME/sbin/mr-jobhistory-daemon.sh start historyserver
tail -F -n 1000 /opt/hadoop/logs/mapred--historyserver-*.out &

/wait-for-it.sh -h localhost -p 19888 -t $WAIT_TIMEOUT_SECONDS
echo "--------------- MAPREDUCE JOBHISTORY READY SERVER ---------------"
