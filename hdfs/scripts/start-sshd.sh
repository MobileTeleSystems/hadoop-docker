#!/bin/bash

set -e

echo "---------------- STARTING SSHD ----------------"
/usr/sbin/sshd 2>&1 | sed 's/^/| SSHD | /g'
echo "---------------- SSHD READY ----------------"
