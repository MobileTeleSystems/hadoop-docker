#!/bin/bash

set -e

echo "-------------- STARTING HIVE SERVER --------------"
$HIVE_HOME/bin/hiveserver2 | sed 's/^/| HIVE | /g' &

/wait-for-it.sh -h localhost -p 10000 -t $WAIT_TIMEOUT_SECONDS

echo "--------------- HIVE SERVER READY ---------------"
