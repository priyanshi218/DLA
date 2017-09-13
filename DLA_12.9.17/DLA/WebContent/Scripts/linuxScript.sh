#!/bin/bash
cat /proc/cpuinfo | grep -e "^model name" | cut -f2 -d: | awk '{print $1 " " $2}'
hostname
cat /etc/redhat-release | awk '{print $4}'
uname -s
mem1=`cat /proc/meminfo | grep -i memtotal | awk '{print $2}'` 
expr $mem1 \/ 1024 \/ 1024
lscpu | grep -e "^Socket(s):" | cut -f2 -d: | awk '{print $1}'
cat /proc/cpuinfo | grep -i processor | wc -l
ps -ef | grep pmon | awk '{print $8}'|grep ora_pmon*




