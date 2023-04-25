#!/bin/bash

set -e

test -f /scripts/prepare-hadoop-conf.sh && /scripts/prepare-hadoop-conf.sh
test -f /scripts/prepare-hive-conf.sh && /scripts/prepare-hive-conf.sh

if [[ "x$1" != "x" ]]; then
    # CMD is set, executing it without starting services (e.g. hdfs cli)
    exec "$@"
else
    # Starting all the services

    /scripts/start-sshd.sh
    /scripts/start-hdfs.sh
    /scripts/init-hdfs.sh

    /scripts/start-yarn.sh
    /scripts/start-mr-historyserver.sh

    /scripts/init-metastore.sh
    /scripts/start-hiveserver.sh

    # Hadoop services are started in the background.
    # So we need to start something that runs forever
    tail -F /dev/null
fi
