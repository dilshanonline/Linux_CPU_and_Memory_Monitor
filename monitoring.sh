#!/bin/bash

#- Linux CPU and Memory Monitor
#- Author : Dilshan Wijesooriya

cpu_load=$(top -b -n  1  | awk '/load average/ { printf "%s %s %s\n", $10, $11, $12 }')
cpu_load_last1min=$(top -b -n  1  | awk '/load average/ { printf "%s %s %s\n", $10, $11, $12 }' | cut -d ' ' -f1)
cpu_load_last5min=$(top -b -n  1  | awk '/load average/ { printf "%s %s %s\n", $10, $11, $12 }' | cut -d ' ' -f2)
cpu_load_last15min=$(top -b -n  1  | awk '/load average/ { printf "%s %s %s\n", $10, $11, $12 }' | cut -d ' ' -f3)
c_time=$(date +%Y.%m.%d-%H:%M)
total_mem=$(free -g | grep ^Mem | tr -s ' ' | cut -d ' ' -f2)
used_mem=$(free -g | grep ^Mem | tr -s ' ' | cut -d ' ' -f3)
free_mem=$(free -g | grep ^Mem | tr -s ' ' | cut -d ' ' -f4)
cached_mem=$(free -g | grep ^Mem | tr -s ' ' | cut -d ' ' -f6)
echo '------------------------------'
echo 'Timestamp: ' $c_time
echo '------------------------------'
echo '-----CPU Load-----'
echo 'Load for Last 01 Minutes: '$cpu_load_last1min
echo 'Load for Last 05 Minutes: '$cpu_load_last5min
echo 'Load for Last 15 Minutes: '$cpu_load_last15min
echo '------------------------------'
echo '----Memory Usage----'
echo 'Total : ' $total_mem
echo 'Used  : ' $used_mem
echo 'Free  : ' $free_mem
echo 'Cache : ' $cached_mem
echo '------------------------------'
echo " "
