#!/bin/bash
tmpfile=$(mktemp)
for i in $(seq 1 100)
do
        echo "$(sar 1 1 | awk 'NR==4''{sum=$3+$5; printf "%.2f ", sum}') $(free -m | awk 'NR==2''{print $3 " "}')" >> results
done
