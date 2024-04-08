#!/bin/bash
function now { date +%s; }
for i in $(seq 1 100)
do	
	echo "Работаем, попытка $i"
	ssh worker-node-2 "./server_monitor.sh on > /dev/null 2>&1 &"
	sleep 5
       	./monit.sh > abobus &
        ssh worker-node-2 "./stats.sh on > abobus 2>&1 &"	
	iperf3 -u -b 0 -c worker-node-2 -O 1 -f m -t 10 | awk 'NR==17''{printf $7 " "}' >> results
	tail -n +2 abobus | awk '{U+=$1;N+=$2;} 
		END {printf "%.2f %d\n",U/NR,N/NR}' >> results
	ssh worker-node-2 "./server_monitor.sh off > /dev/null 2>&1 &"
done
echo "Дело сделано"
