#!/bin/bash

set -e

test -f /scripts/prepare-hadoop-conf.sh && /scripts/prepare-hadoop-conf.sh

if [[ "x$1" != "x" ]]; then
    # CMD is set, executing it without starting services (e.g. hdfs cli)
    exec "$@"
else
    # Starting all the services

    /scripts/start-sshd.sh
    /scripts/start-hdfs.sh
    /scripts/populate-hdfs.sh

    # Hadoop services are started in the background.
    # So we need to start something that runs forever
    tail -F /dev/null
fi
