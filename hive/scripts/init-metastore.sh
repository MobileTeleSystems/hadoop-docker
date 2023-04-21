#!/bin/bash

echo "-------------- INITIALIZING METASTORE DATABASE --------------"
$HIVE_HOME/bin/schematool -dbType postgres -initSchema || true
