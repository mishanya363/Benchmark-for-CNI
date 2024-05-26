#!/bin/bash
if [ "$1" = "tcp" ];then
        iperf3 -c worker-node-1 -O 1 -f m -t 10
elif [ "$1" = "udp" ]; then
        iperf3 -u -b 0 -c worker-node-1 -O 1 -f m -t 10
else
        echo "Неизвестный тип бенчмарка"
fi

