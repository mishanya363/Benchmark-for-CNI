#!/bin/bash
for run in 1 2 3
do
    RESULT_FILE_PREFIX="test_$run"
    ./knb -v -cn worker-node -sn worker-node-2 -o data -f results/$RESULT_FILE_PREFIX.knbdata --name "Ubuntu $DISTRIBUTION - Kernel $KERNEL - Run $run"
    ./knb -fd results/$RESULT_FILE_PREFIX.knbdata -o ibdbench -f results/tsv/$RESULT_FILE_PREFIX.tsv
    ./knb -fd results/$RESULT_FILE_PREFIX.knbdata
done
