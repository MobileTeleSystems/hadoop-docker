#!/bin/bash

set -e

echo "---------------- STARTING SSHD ----------------"
/usr/sbin/sshd
echo "---------------- SSHD READY ----------------"
