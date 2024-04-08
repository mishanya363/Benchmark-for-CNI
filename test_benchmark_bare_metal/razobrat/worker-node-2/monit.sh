#!/bin/bash
for i in {1..11}; do
sar 1 1 | awk 'NR==4''{printf $6" "}' && free -m | awk 'NR==2''{print $3 " "}'
done

