#!/bin/bash

set -e

# if there is a log file from previous run, remove it
rm -rf /tmp/root/hive.log || true

echo "-------------- STARTING HIVE METASTORE SERVER --------------"
$HIVE_HOME/bin/hive --service metastore 2>&1 | sed 's/^/| HIVE METASTORE SERVER | /g' &
tail -F -n 1000 /tmp/root/hive.log | sed 's/^/| HIVE | /g' &

/wait-for-it.sh -h localhost -p 9083 -t $WAIT_TIMEOUT_SECONDS

echo "--------------- HIVE METASTORE SERVER READY ---------------"
