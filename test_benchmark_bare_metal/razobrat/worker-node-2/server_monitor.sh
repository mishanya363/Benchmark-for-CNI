#!/bin/bash
function now { date +%s; }
if [ "$1" = "on" ];then
	iperf3 -s > /dev/null &
elif [ "$1" = "off" ]; then
	kill -9 $(ps -aux | grep "iperf3 -s" | awk 'NR==1''{print $2}')
else
	echo "Nothing has been done"
fi

