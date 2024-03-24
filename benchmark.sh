#!/bin/bash
for run in $(seq 90 91)
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
if [ -e $res ]; then
        rm $res
        touch $res
else
        touch $res
fi
for run in $(seq 1 100)
do
         awk '{printf $4 " " $5 " "}' test_$run.csv >> $res
         awk -F '+' '{printf $11 " "}' test_$run.csv >> $res
         awk '{printf $7 " "}' test_$run.csv >> $res
         awk -F '+' '{printf $15 " "}' test_$run.csv >> $res
         awk '{printf $9 " " $10 " "}' test_$run.csv >> $res
         awk -F '+' '{printf $19 " "}' test_$run.csv >> $res
         awk '{printf $12 " "}' test_$run.csv >> $res
         awk -F '+' '{print $23}' test_$run.csv >> $res
done
