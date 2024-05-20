#!/bin/bash
while true
do
	echo "$(sar 1 1 | awk 'NR==4''{printf $3 " " $5" "}') $(free -m | awk 'NR==2''{print $3 " "}') $(date "+%s")" >> /data/metrics.log
done

