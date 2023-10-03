#!/bin/bash

set -e

/scripts/check-hdfs.sh

if [[ "x$WITH_HIVE_SERVER" == "xtrue" ]]; then
    /scripts/check-hive-server.sh
    /scripts/check-yarn.sh
fi
