#!/bin/bash

set -e

test -f /scripts/prepare-hadoop-conf.sh && /scripts/prepare-hadoop-conf.sh

/scripts/start-sshd.sh
/scripts/start-hdfs.sh
/scripts/init-hdfs.sh

if [[ "x$1" != "x" ]]; then
    exec "$@"
else
    # Hadoop services are started in the background.
    # So we need to start something that runs forever
    tail -F /dev/null
fi
