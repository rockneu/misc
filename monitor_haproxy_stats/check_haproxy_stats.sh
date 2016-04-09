#!/bin/bash

# This script is designed to work as a nagios plugin, monitoring HAProxy service statistics.
#
# Precondition
# 1) need socat to be installed at the haproxy server to be monitored
# 2) need to configure socket at haproxy.cfg, default at /var/run/haproxy.sock
#
#
# Usage:
#	./check_haproxy_stats.sh type service_name
#		type could be frontend or backend
#		service_name is the frontend name or backend name, not the server name.
#	eg:		./check_haproxy_stats.sh frontend web-service
#
#
# Author: Rock Liu 20160409
#
# Updating history
#
#


ptype="$1"
pname="$2"
pct="$#"

temp_file='/tmp/ha_stat.txt'
stat_file='/var/run/haproxy.sock'

#msg
msg=""

# for HAProxy frontend only 
# cat /tmp/ha_stat.txt | awk -F: '/Uptime_sec/' | awk -F: '{print $2}'
time_up_ft="0"

# byte in for frontend only
# cat /tmp/ha_stat.txt | awk -F: '/web-service/' | awk -F, '{print $9}'
byte_in_ft="0"
# cat /tmp/ha_stat.txt | awk -F: '/web-service/' | awk -F, '{print $10}'
byte_out_ft="0"

status="0"		# $18

time_up="0"		# $24
time_down="0"	# $25
byte_in="0"		# $9
byte_out="0"	# $10

# request number for frontend only
# cat /tmp/ha_stat.txt | awk -F, '/web-service/' | awk -F, '{print $8}'
request_in="0"	# $8

# response number for backend and server node
# cat /tmp/ha_stat.txt | awk -F, '/app-cs/' | awk -F, '{print $8}'
# cat /tmp/ha_stat.txt | awk -F, '/node.57/' | awk -F, '{print $8}'
response_out="0"


# get haproxy stats info and dump to local file
dump_info() {
	#/bin/echo "show info;show stat" | /usr/bin/nc -U /var/run/haproxy.sock  > $temp_file
	#/bin/echo "show info;show stat" | /usr/local/bin/socat unix-connect:/var/run/haproxy.sock stdio > /tmp/ha_stat.txt
	/bin/echo "show info;show stat" | /usr/local/bin/socat unix-connect:$stat_file stdio > $temp_file
}




judge() {

	unit=""
	
	if [ $status = "OPEN" ] || [ $status = "UP" ]; then
		msg="HAProxy Service OK: "
	else
		msg="haproxy Server Critical:"
	fi

	if [ "$ptype" = "frontend" ]; then
		rate_in=`echo "$byte_in / $time_up" | bc`
		rate_out=`echo "$byte_out / $time_up" | bc`
		rate_req=`echo "$request_in / $time_up" |bc`
	fi

	#echo "$rate_in $rate_out $rate_req"
	
	if [ "$rate_in" -lt "1024" ];then
		unit="bps"
		rate_in="$rate_in$unit"
	elif [ "$rate_in" -lt "1024000" ];then
		unit="kbps"
		rate_in=`echo "$rate_in / 1024" | bc`
		rate_in="$rate_in$unit"
	else
		unit="mbps"
		rate_in=`echo "$rate_in / 1024000" | bc`
		rate_in="$rate_in$unit"
	fi

	if [ "$rate_out" -lt "1024" ];then
		unit="bps"
		rate_out="$rate_out$unit"
	elif [ "$rate_out" -lt "1024000" ];then
		unit="kbps"
		rate_out=`echo "$rate_out / 1024" | bc`
		rate_out="$rate_out$unit"
	else
		unit="mbps"
		rate_out=`echo "$rate_out / 1024000" | bc`
		rate_out="$rate_out$unit"
	fi

	msg="$msg | rate_byte_in=$rate_in rate_byte_out=$rate_out rate_request=$rate_req"

	echo $msg
}

extract_data() {

#	cat $temp_file | awk -F: '/app-sso/' | awk -F: '/BACKEND/'
#	time_up=`cat $temp_file | awk -F, '{print $24}'`
#	/bin/echo "show stat" | /usr/bin/nc -U  /var/run/haproxy.sock | awk -F, '{print $24}'

	if [ "$ptype" = "frontend" ]; then
		status=`cat $temp_file | awk -F, /"$pname"/ | awk -F, '{print $18}'`
		time_up=`cat $temp_file | awk -F: /'Uptime_sec'/ | awk -F: '{print $2}'`
		byte_in=`cat $temp_file | awk -F, /"$pname"/ | awk -F, '{print $9}'`
		byte_out=`cat $temp_file | awk -F, /"$pname"/ | awk -F, '{print $10}'`
		request_in=`cat $temp_file | awk -F, /"$pname"/ | awk -F, '{print $49}'`
	else
		echo "not in if branch"
	fi

	
}

check_input() {

	if [ "$pct" != 2 ];then
		echo "Incorrect parameter count. 2 parameter needed!"
		return 2
	fi

	if [ "$ptype" != "frontend" -a "$ptype" != "backend" ];then
		echo "Incorrect type parameter. 'frontend' or 'backend' needed!"
		return 2
	fi

	return 1
}


dump_info

check_input
ret=$?
#echo "ret=$ret"

if [ "$ret" == "1" ];then
	# extract some data here
	extract_data
	judge	
else
	echo "check_input failed!"
fi
       
