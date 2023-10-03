#!/bin/bash

set -e

# Hive server & metastore write logs to same file
if [[ "x$WITH_HIVE_METASTORE_SERVER" != "xtrue" ]]; then
    # if there is a log file from previous run, remove it
    rm -rf /tmp/root/hive.log || true
fi

echo "-------------- STARTING HIVE SERVER --------------"
$HIVE_HOME/bin/hive --service hiveserver2 2>&1 | sed 's/^/| HIVE SERVER | /g' &

if [[ "x$WITH_HIVE_METASTORE_SERVER" != "xtrue" ]]; then
    tail -F -n 1000 /tmp/root/hive.log | sed 's/^/| HIVE SERVER | /g' &
fi

/wait-for-it.sh -h localhost -p 10000 -t $WAIT_TIMEOUT_SECONDS

echo "--------------- HIVE SERVER READY ---------------"
