#!/bin/bash
for run in 1 2 3
do
    echo "CNI $CNI - Distribution $DISTRIBUTION with kernel $KERNEL - Run $run/3"
    RESULT_FILE_PREFIX="$RESULT_PREFIX-run$run"
    ./knb -v -cn s03 -sn s04 -sbs 256K -t 60 -o data -f $RESULT_FILE_PREFIX.knbdata --name "Ubuntu $DISTRIBUTION - Kernel $KERNEL - $CNI - Run $run"
    ./knb -fd $RESULT_FILE_PREFIX.knbdata -o ibdbench -f $RESULT_FILE_PREFIX.tsv
    ./knb -fd $RESULT_FILE_PREFIX.knbdata
done
