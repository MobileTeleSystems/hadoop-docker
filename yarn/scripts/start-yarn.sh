#!/bin/bash

set -e

echo "--------------- STARTING YARN ---------------"

# if there is a log file from previous run, remove it
rm -rf /opt/hadoop/logs/yarn-*.out || true

$HADOOP_HOME/sbin/start-yarn.sh 2>&1 | sed 's/^/| YARN | /g'
tail -F -n 1000 /opt/hadoop/logs/yarn--resourcemanager-*.out | sed 's/^/| YARN | /g' &

/wait-for-it.sh -h localhost -p 8030 -t $WAIT_TIMEOUT_SECONDS
echo "--------------- YARN READY ---------------"
