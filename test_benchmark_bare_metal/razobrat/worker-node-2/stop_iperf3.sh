#!/bin/bash
kill -9 $(ps -aux | grep "iperf3 -s" | awk 'NR==1''{print $2}')
