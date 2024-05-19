#!/bin/sh

START=$1
STOP=$2

METRICSFILE="/data/metrics.log"

echo "cpu-user cpu-system memory-used timestamp"
awk '$4 >= '$START' && $4 <= '$STOP "$METRICSFILE" 
