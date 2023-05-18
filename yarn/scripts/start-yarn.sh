#!/bin/bash

set -e

echo "--------------- STARTING YARN ---------------"
$HADOOP_HOME/sbin/start-yarn.sh
tail -F -n 1000 /opt/hadoop/logs/yarn--resourcemanager-*.out &

/wait-for-it.sh -h localhost -p 8030 -t $WAIT_TIMEOUT_SECONDS
echo "--------------- YARN READY ---------------"
