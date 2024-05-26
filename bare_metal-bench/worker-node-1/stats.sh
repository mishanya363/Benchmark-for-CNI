#!/bin/bash
START=$1
STOP=$2
METRICSFILE="$3"
RESULTSFILE="$4"
BANDWIDTHFILE="$5"
tmpfile=$(mktemp)
tmpfile2=$(mktemp)

awk '$4 >= '$START' && $4 <= '$STOP "$METRICSFILE" >> $tmpfile
cat $tmpfile
awk '{U+=$1;S+=$2;M+=$3; }END{printf "%.2f %.2f %d %d\n",U/NR,S/NR,M/NR,NR}' "$tmpfile" >> $tmpfile2
cat $tmpfile2
awk '{sum=$1+$2; printf "%.2f %d ", sum,$3}' "$tmpfile2" >> $RESULTSFILE
cat $BANDWIDTHFILE | grep receiver | awk '{printf $7"\n"}' >> $RESULTSFILE
rm $tmpfile $tmpfile2



