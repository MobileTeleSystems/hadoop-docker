#!/bin/bash

echo "-------------- INITIALIZING METASTORE DB --------------"
$HIVE_HOME/bin/schematool -dbType postgres -initSchema 2>&1 | sed 's/^/| HIVE METASTORE DB | /g' || true
