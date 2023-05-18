#!/bin/bash

set -e

echo "-------------- STARTING HIVE2 SERVER --------------"
$HIVE_HOME/bin/hiveserver2 &

/wait-for-it.sh -h localhost -p 10000 -t $WAIT_TIMEOUT_SECONDS
echo "--------------- HIVE2 SERVER READY ---------------"
