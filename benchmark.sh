#!/bin/bash
rm /root/Benchmark-for-CNI/results/csv/results.csv
touch /root/Benchmark-for-CNI/results/csv/results.csv
for run in $(seq 1 3)
do
    RESULT_FILE_PREFIX="test_$run"
<<<<<<< HEAD
    ./knb -v -cn worker-node -sn worker-node-2 -ot p2ptcp,p2pudp -o data -f /root/Benchmark-for-CNI/results/$RESULT_FILE_PREFIX.knbdata
    ./knb -fd /root/Benchmark-for-CNI/results/$RESULT_FILE_PREFIX.knbdata -o ibdbench >> /root/Benchmark-for-CNI/results/csv/results.csv
    ./knb -fd /root/Benchmark-for-CNI/results/$RESULT_FILE_PREFIX.knbdata
=======
    ./knb -v -cn worker-node -sn worker-node-2 -o data -f results/$RESULT_FILE_PREFIX.knbdata --name "Ubuntu $DISTRIBUTION - Kernel $KERNEL - Run $run"
    ./knb -fd results/$RESULT_FILE_PREFIX.knbdata -o ibdbench -f results/tsv/$RESULT_FILE_PREFIX.tsv
    ./knb -fd results/$RESULT_FILE_PREFIX.knbdata
>>>>>>> c061dd9950e8c2fba119b1945cfd26581c9e4ce0
done
