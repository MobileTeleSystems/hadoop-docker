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
    /scripts/populate-hdfs.sh
    /scripts/populate-metastore-db.sh

    if [[ "x$WITH_HIVE_METASTORE_SERVER" == "xtrue" ]]; then
        # Metastore server fails fast if cannot connect to database
        /scripts/start-hive-metastore-server.sh
    fi

    if [[ "x$WITH_HIVE_SERVER" == "xtrue" ]]; then
        /scripts/start-yarn.sh
        /scripts/start-jobhistory-server.sh
        /scripts/start-hive-server.sh
    fi

    # Hadoop services are started in the background.
    # So we need to start something that runs forever
    tail -F /dev/null
fi
