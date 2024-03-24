#!/bin/bash
res=/root/Benchmark-for-CNI/results/flannel_test/results.csv
if [ -e $res ]; then
	rm $res
        touch $res
else
        touch $res
fi
for run in $(seq 1)
do
 	 awk '{printf $4 " " $5 " "}' test_$run.csv >> $res
	 awk -F '+' '{printf $11}' test_$run.csv >> $res
#        awk '{print $4 " " $5 " " substr($6,12,5) " " $7 " " substr($8,12,5) " " $9 " " $10 " " substr($11,12,5) " " $12 " " substr($13,12,5)}' results/csv/test_$run.csv >> $res
done

