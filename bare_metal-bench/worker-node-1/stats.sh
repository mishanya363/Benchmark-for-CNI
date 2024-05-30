#!/bin/bash
START=$1
STOP=$2
METRICSFILE="$3"
RESULTSFILE="$4"
BANDWIDTHFILE="$5"
tmpfile=$(mktemp)
tmpfile2=$(mktemp)

cat $BANDWIDTHFILE | grep receiver | awk '{printf $7 " "}' >> $RESULTSFILE
awk '$4 >= '$START' && $4 <= '$STOP "$METRICSFILE" >> $tmpfile
cat $tmpfile
awk '{U+=$1;S+=$2;M+=$3; }END{printf "%.2f %.2f %d %d\n",U/NR,S/NR,M/NR,NR}' "$tmpfile" >> $tmpfile2
cat $tmpfile2
awk '{sum=$1+$2; printf "%d %.2f \n", $3,sum}' "$tmpfile2" >> $RESULTSFILE

rm $tmpfile $tmpfile2



