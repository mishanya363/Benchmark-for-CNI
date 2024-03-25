!/bin/bash
for run in $(seq 17 18)
do
    RESULT_FILE_PREFIX="test_$run"
    ./knb -v -cn worker-node-1 -sn worker-node-2 -ot p2ptcp,p2pudp -o ibdbench -f /root/Benchmark-for-CNI/results/csv/$RESULT_FILE_PREFIX.csv
done
res=/root/Benchmark-for-CNI/results/csv/results.csv
for run in $(seq 1 100)
do
if [ -e $res ]; then
     rm $res
     touch $res
else
     touch $res
fi
done
for run in $(seq 1 100)
do
     awk '{printf $4 " " $5 " "}' results/csv/test_$run.csv >> $res
     awk -F '+' '{printf $11 " "}' results/csv/test_$run.csv >> $res
     awk '{printf $7 " "}' results/csv/test_$run.csv >> $res
     awk -F '+' '{printf $15 " "}' results/csv/test_$run.csv >> $res
     awk '{printf $9 " " $10 " "}' results/csv/test_$run.csv >> $res
     awk -F '+' '{printf $19 " "}' results/csv/test_$run.csv >> $res
     awk '{printf $12 " "}' results/csv/test_$run.csv >> $res
     awk -F '+' '{print $23}' results/csv/test_$run.csv >> $res
done
