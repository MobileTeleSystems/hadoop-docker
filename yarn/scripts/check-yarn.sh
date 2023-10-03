#!/bin/bash

set -e

curl -s -f "http://localhost:8042/jmx?qry=Hadoop:*"
