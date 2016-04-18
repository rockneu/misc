#!/bin/bash

# This script is designed to work as a nagios plugin, monitoring HAProxy service statistics.
#
# Precondition
# 1) need socat to be installed at the haproxy server to be monitored
# 2) need to configure socket at haproxy.cfg, default at /var/run/haproxy.sock
# 3) need to grant "sudo /usr/local/bin/socat" privilege to the user who runs nrpe service, if this script is invoked by nrpe service.
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
# Updating history:
#
#	1. 20160416  optimize rate related metric(like rate_in,rate_out ) calculation method. Instead of using total_byte / total_time, now try using interval_byte / interval_time.
#	
#	2. 20160418	 remove unit mbps as the return value(mail service) flaps among xx kbps and xxxx kbps
#


ptype="$1"
pname="$2"
pct="$#"

temp_dir="/tmp/"
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
cur_session="0"	# $5

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
	#/bin/echo "show info;show stat" | sudo /usr/local/bin/socat unix-connect:/var/run/haproxy.sock stdio > /tmp/ha_stat.txt
	/bin/echo "show info;show stat" | sudo /usr/local/bin/socat unix-connect:$stat_file stdio > $temp_file 

	#echo `id` > /tmp/nrpe3.txt
	
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
	
	ptype=`echo $ptype | tr a-z A-Z`
	
	#echo "cat $temp_file ..."
	#content=`cat $temp_file`
	#echo "content = $content"
	list=` cat $temp_file | awk -F, /"$ptype"/ | awk -F, '{print $1}'`
	exist=$(echo $list | grep $pname)
	if [ "$exist" != "" ];then
		return 1
	else
		#cat $temp_file
		echo "maybe input parameter invalid! list=$list ptype=$ptype pname=$pname"
		return 2
	fi
}

extract_data() {

#	/bin/echo "show stat" | /usr/bin/nc -U  /var/run/haproxy.sock | awk -F, '{print $24}'
	
	if [ "$ptype" == "FRONTEND" ]; then
		status=`cat $temp_file | awk -F, /"$pname"/ | awk -F, '{print $18}'`
		cur_session=`cat $temp_file | awk -F, /"$pname"/ | awk -F, '{print $5}'`
		time_up=`cat $temp_file | awk -F: /'Uptime_sec'/ | awk -F: '{print $2}'`
		byte_in=`cat $temp_file | awk -F, /"$pname"/ | awk -F, '{print $9}'`
		byte_out=`cat $temp_file | awk -F, /"$pname"/ | awk -F, '{print $10}'`
		request_in=`cat $temp_file | awk -F, /"$pname"/ | awk -F, '{print $49}'`
		#echo "$status $time_up $cur_session $byte_in $byte_out $request_in"
	elif [ "$ptype" == "BACKEND" ]; then
		status=`cat $temp_file | awk -F, /"$pname"/ | awk -F, /"BACKEND"/ | awk -F, '{print $18}'`
		cur_session=`cat $temp_file | awk -F, /"$pname"/ | awk -F, /"BACKEND"/ | awk -F, '{print $5}'`
		time_up=`cat $temp_file | awk -F: /"$pname"/ | awk -F, /"BACKEND"/ | awk -F, '{print $24}'`
		byte_in=`cat $temp_file | awk -F, /"$pname"/ | awk -F, /"BACKEND"/ | awk -F, '{print $9}'`
		byte_out=`cat $temp_file | awk -F, /"$pname"/ | awk -F, /"BACKEND"/ | awk -F, '{print $10}'`
		response_out=`cat $temp_file | awk -F, /"$pname"/ | awk -F, /"BACKEND"/ | awk -F, '{print $8}'`
		#echo "$status $time_up $cur_session $byte_in $byte_out $response_out"
	else
		echo "not in if branch"
	fi	
}


judge() {
	unit=""
	timelast_up="0"
	bytelast_in="0"
	bytelast_out="0"
	reqresplast_inout="0"

	# read last metric data for rate metric calculation
	if [ -f "$temp_dir$ptype$pname.txt" ];then
		# status=`cat $temp_file | awk -F, /"$pname"/ | awk -F, '{print $18}'`
		bytelast_in=` cat $temp_dir$ptype$pname.txt | awk -F, '{print $1}'`
		bytelast_out=` cat $temp_dir$ptype$pname.txt | awk -F, '{print $2}'`
		reqresplast_inout=` cat $temp_dir$ptype$pname.txt | awk -F, '{print $3}'`
		timelast_up=` cat $temp_dir$ptype$pname.txt | awk -F, '{print $4}'`
	else
		echo "found no file!"
		bytelast_in=$byte_in
		bytelast_out=$byte_out
		reqresplast_inout=`expr $request_in + $response_out`
		# to avoid 0/0
		timelast_up=`expr $time_up - 1`
	fi
	
	if [ $status = "OPEN" ] || [ $status = "UP" ]; then
		msg="HAProxy Service OK: "
	else
		msg="HAProxy Service Critical:"
	fi

	# write current metric data to file for next calculation
	if [ "$ptype" == "FRONTEND" ]; then
		echo "$byte_in,$byte_out, $request_in, $time_up" > "$temp_dir$ptype$pname.txt"
	elif [ "$ptype" == "BACKEND" ]; then
		#echo "$byte_in,$byte_out, $response_out,$time_up"
		echo "$byte_in,$byte_out, $response_out,$time_up" > "$temp_dir$ptype$pname.txt"
	fi

	byte_in=`expr $byte_in - $bytelast_in`
	byte_out=`expr $byte_out - $bytelast_out`
	time_up=`expr $time_up - $timelast_up`
	request_in=`expr $request_in - $reqresplast_inout`
	response_out=`expr $response_out - $reqresplast_inout`

	#echo "after reduction: time=$time_up byte_in=$byte_in byte_out=$byte_out request=$request_in response=$response_out"
	
	
	rate_in=`echo "$byte_in / $time_up" | bc`
	rate_out=`echo "$byte_out / $time_up" | bc`
	
	if [ "$ptype" == "FRONTEND" ]; then
		rate_req=`echo "$request_in / $time_up" | bc`
	elif [ "$ptype" == "BACKEND" ]; then
		rate_rsp=`echo "$response_out / $time_up" | bc`
	fi

	#echo "$rate_in $rate_out $rate_req $rate_rsp"
	
	if [ "$rate_in" -lt "1024" ];then
		unit="bps"
		rate_in="$rate_in$unit"
	else
		unit="kbps"
		rate_in=`echo "$rate_in / 1024" | bc`
		rate_in="$rate_in$unit"
	fi

	if [ "$rate_out" -lt "1024" ];then
		unit="bps"
		rate_out="$rate_out$unit"
	else
		unit="kbps"
		rate_out=`echo "$rate_out / 1024" | bc`
		rate_out="$rate_out$unit"
	fi

	if [ "$ptype" == "FRONTEND" ]; then
		msg="$msg status=$status  | current_session.conn=$cur_session rate_byte_in=$rate_in rate_byte_out=$rate_out rate_request=$rate_req"
	elif [ "$ptype" == "BACKEND" ];then
		msg="$msg status=$status  | current_session.conn=$cur_session rate_byte_in=$rate_in rate_byte_out=$rate_out rate_response=$rate_rsp"
	fi
	
	echo $msg
}


dump_info

check_input
ret=$?

if [ "$ret" == "1" ];then
	#echo "check_input succeeded!"
	extract_data
	judge	
else
	echo "check_input failed!"
fi
       
