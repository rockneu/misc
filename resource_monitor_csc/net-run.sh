#!/bin/bash

############################################################
# This script is designed to get Cisco router & switch
# resource consuming info(memory, cpu, and input/output data) 
#
# Author: liuwei
# Date:	  2012-10-22
# version:1.0
############################################################

>out.log
cat iplist |while read LINE
     do
	#to read arguments with separator :
	 ip=`echo $LINE | awk -F: '{print $1}'`
     	 port=`echo $LINE | awk -F: '{print $2}'`
     	 pass=`echo $LINE | awk -F: '{print $3}'`
     	 cmd1=`echo $LINE | awk -F: '{print $4}'`
     	 cmd2=`echo $LINE | awk -F: '{print $5}'`
     	 cmd3=`echo $LINE | awk -F: '{print $6}'`
	echo $ip
	nc -T $ip $port >> out.log <<-EOF
	$pass
	$cmd1

	$cmd2

	$cmd3

	quit
	EOF

     done

# Process the monitoring data
# 1. calculate memory usage ratio
echo
echo
echo ===============================================
echo Memory usage ratio"(%)":
sed -n '/Processor/'p out.log | awk '{print $4/$3*100}'
echo ===============================================


# 2. get cpu usage ratio during past five minutes
echo
echo
echo ===============================================
echo CPU usage ratio in five min:
sed -n '/CPU utilization/'p out.log | awk -F: '{print $4}'
echo ===============================================


# 3. get input/output data flow info
echo
echo
echo ===============================================
echo Input/Output data flow info
echo Input data"(MB/S)":
sed -n '/5 minute input rate/'p out.log | awk '{print $5/1024/1024/8}'
echo ====================
echo Output data"(MB/S)":
sed -n '/5 minute output rate/'p out.log | awk '{print $5/1024/1024/8}'
echo ===============================================

