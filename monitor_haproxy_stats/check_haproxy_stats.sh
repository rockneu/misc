#!/bin/bash

#20150726 by http://ywwd.net
#crontab -l
#* * * * *  /bin/echo "show info;show stat" | /usr/bin/nc -U /var/run/haproxy.sock | awk -F, '/localhost/' > /tmp/ha_stat.txt
#0 0 * * *  /etc/init.d/haproxy reload > /dev/null 2>&1
 
#variables
item="$1"
#disk="$2"
tmp_file='/tmp/ha_stat.txt'

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
	/bin/echo "show info;show stat" | /usr/bin/nc -U /var/run/haproxy.sock  > $tmp_file
}

print_help() {
	echo "Usage: $0 {byte_in|byte_out|curr_conns|cum_conns|cum_http|http_1xx|http_2xx|http_3xx|http_4xx|http_5xx}"

	to get data: status, byte_in/s, byte_out/s, [request/s response/s]
	frontend: 		status,uptime, byte_in/s, byte_out/s, request/s
	backend:		status,uptime, byte_in/s, byte_out/s, response/s
	#backend.node	status,uptime, byte_in/s, byte_out/s, response/s

	
	echo "Usage: check_haproxy_stat.sh frontend"
	echo "Usage: check_haproxy_stat.sh servname BACKEND"
	echo "Usage: check_haproxy_stat.sh servname nodename"
	
	echo "Usage: check_haproxy_stat.sh nodename"
	
	}

extract_data() {
/*
	cat $tmp_file | awk -F: '/app-sso/' | awk -F: '/BACKEND/'
	time_up=`cat $tmp_file | awk -F, '{print $24}'`
	/bin/echo "show stat" | /usr/bin/nc -U  /var/run/haproxy.sock | awk -F, '{print $24}'
*/
	if ["$1"=="frontend"]
		status=`cat $tmp_file | awk -F, '/web-service/' | awk -F, '{print $18}'`
		time_up=`cat $tmp_file | awk -F: '/Uptime_sec/' | awk -F: '{print $2}'`
		byte_in=`cat $tmp_file | awk -F, '/web-service/' | awk -F, '{print $9}'`
		byte_out=`cat $tmp_file | awk -F, '/web-service/' | awk -F, '{print $10}'`
		request_in=`cat $tmp_file | awk -F, '/web-service/' | awk -F, '{print $8}'`
	then
		
	fi
}

dump_info()
       
# extract some data here
extract_data()