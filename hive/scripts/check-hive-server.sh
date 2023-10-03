#!/bin/bash

set -e

/opt/hive/bin/beeline -u jdbc:hive2://localhost:10000 -e "show databases"
