#!/bin/bash

set -e

echo "--------------- STARTING MAPREDUCE JOBHISTORY SERVER ---------------"

# if there is a log file from previous run, remove it
rm -rf /opt/hadoop/logs/mapred--historyserver-*.out || true

$HADOOP_HOME/sbin/mr-jobhistory-daemon.sh start historyserver 2>&1 | sed 's/^/| JOBHISTORY SERVER | /g'
tail -F -n 1000 /opt/hadoop/logs/mapred--historyserver-*.out | sed 's/^/| JOBHISTORY SERVER | /g' &

/wait-for-it.sh -h localhost -p 19888 -t $WAIT_TIMEOUT_SECONDS
echo "--------------- MAPREDUCE JOBHISTORY SERVER READY ---------------"
