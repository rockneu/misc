#!/bin/bash


 
#variables
ptype="$1"
pname="$2"
tmp_file='/tmp/ha_stat.txt'
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
	#/bin/echo "show info;show stat" | /usr/bin/nc -U /var/run/haproxy.sock  > $tmp_file
	#/bin/echo "show info;show stat" | /usr/local/bin/socat unix-connect:/var/run/haproxy.sock stdio > /tmp/ha_stat.txt
	/bin/echo "show info;show stat" | /usr/local/bin/socat unix-connect:$stat_file stdio > $tmp_file
}

print_help() {
#	echo "Usage: $0 {byte_in|byte_out|curr_conns|cum_conns|cum_http|http_1xx|http_2xx|http_3xx|http_4xx|http_5xx}"

#	to get data: status, byte_in/s, byte_out/s, [request/s response/s]
#	frontend: 		status,uptime, byte_in/s, byte_out/s, request/s
#	backend:		status,uptime, byte_in/s, byte_out/s, response/s
	#backend.node	status,uptime, byte_in/s, byte_out/s, response/s

	
	echo "Usage: ./check_haproxy_stat.sh node_type node_name"
	echo " node_type: frontend | backend"
	echo " node_name: the name of nodes" 
	echo " 		./check_haproxy_stat.sh frontend mail-web"
	echo " 		./check_haproxy_stat.sh frontend web-service"
	echo " 		./check_haproxy_stat.sh backend node.51"

	
	}

judge() {

	unit=""
	
	if [ $status = "OPEN" ] || [ $status = "UP" ]; then
		msg="HAProxy Service OK : "
	else
		msg="haproxy Server Critical :"
	fi

	if [ "$p1" = "frontend" ]; then
		rate_in=`echo "$byte_in / $time_up" | bc`
		rate_out=`echo "$byte_out / $time_up" | bc`
		rate_req=`echo "$request_in / $time_up" |bc`
	fi

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

#	cat $tmp_file | awk -F: '/app-sso/' | awk -F: '/BACKEND/'
#	time_up=`cat $tmp_file | awk -F, '{print $24}'`
#	/bin/echo "show stat" | /usr/bin/nc -U  /var/run/haproxy.sock | awk -F, '{print $24}'

	if [ "$p1" = "frontend" ]; then
		status=`cat $tmp_file | awk -F, '/web-service/' | awk -F, '{print $18}'`
		time_up=`cat $tmp_file | awk -F: '/Uptime_sec/' | awk -F: '{print $2}'`
		byte_in=`cat $tmp_file | awk -F, '/web-service/' | awk -F, '{print $9}'`
		byte_out=`cat $tmp_file | awk -F, '/web-service/' | awk -F, '{print $10}'`
		request_in=`cat $tmp_file | awk -F, '/web-service/' | awk -F, '{print $8}'`
	else
		echo "not in if branch"
	fi
	
}

dump_info
       
# extract some data here
extract_data

judge
