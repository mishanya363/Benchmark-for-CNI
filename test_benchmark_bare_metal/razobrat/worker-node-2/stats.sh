#!/bin/bash
function now { date +%s; }
./monit.sh > abobus
tail -n +2 abobus | awk '{U+=$1;N+=$2;}
                END {printf "%.2f %d\n",U/NR,N/NR}' >> results
