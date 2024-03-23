#!/bin/bash
for run in $(seq 1 100)
do
    RESULT_FILE_PREFIX="test_$run"
    ./knb -v -cn worker-node-1 -sn worker-node-2 -ot p2ptcp,p2pudp -o ibdbench -f /root/Benchmark-for-CNI/results/csv/$RESULT_FILE_PREFIX.csv
done
res=/root/Benchmark-for-CNI/results/csv/results.csv
if [ -e $res ]; then
        rm $res
        touch $res
else
        touch $res
fi
for run in $(seq 1 100)
do
        awk '{print $4 " " $5 " " substr($6,12,5) " " $7 " " substr($8,12,5) " " $9 " " $10 " " substr($11,12,5) " " $12 " " substr($13,12,5)}' results/csv/test_$run.csv >> $res
done

