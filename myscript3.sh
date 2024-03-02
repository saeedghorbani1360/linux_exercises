#!/bin/bash
# Write a program that has the IP of a server and its USER/PASS in front of the script name and if it is pingable, send its /etc/passwd file to /home/user path of that server, otherwise a message is displayed that the server is not accessible.
if [ $# -ne 3 ]
then
	echo "Wrong number of arguments. => ./myscript3.sh ip user pass"
	exit 0
fi

ip=$1
user=$2
password=$3

oct1=`echo $ip | cut -d "." -s -f 1 | tr -d [:alpha:]`
oct2=`echo $ip | cut -d "." -s -f 2 | tr -d [:alpha:]`
oct3=`echo $ip | cut -d "." -s -f 3 | tr -d [:alpha:]`
oct4=`echo $ip | cut -d "." -s -f 4 | tr -d [:alpha:]`
oct5=`echo $ip | cut -d "." -s -f 5`

if [ -n "$oct5" ] || [ -z $oct1 ] || [ -z $oct2 ] || [ -z $oct3 ] || [ -z $oct4 ]
then
        echo "IP format error. =>  xxxx.xxxx.xxxx.xxxx"
        exit 0
fi
if [ $oct1 -gt 255 ] || [ $oct2 -gt 255 ] || [ $oct3 -gt 255 ] || [ $oct4 -gt 255 ]
then
	echo "Each IP Octet must be between 0 and 255."
	exit 0
fi
ping -c 1 $ip >> /dev/null

if [ $? -eq 0 ]
then
	echo "Ping Ok. Connectiong to ${ip}..."
	sshpass -p${password} scp /etc/passwd ${user}@${ip}:/home/${user}
	pid=$?
	if [ $pid -eq 0 ]
        then
                echo "File /etc/passwd was successfully sent to ${ip}:/home/${user}"
	elif [ $pid -eq 5 ]
	then
		echo "Password incorrect. Try again"
		exit 0
	fi
else
	echo "$ip is not reachable."
fi
