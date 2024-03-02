#!/bin/bash


if [ $# -ne 4 ]
then
        echo "Wrong number of arguments. => ./mySFTP.sh ip user pass file"
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

fname=$4

if [ ! -f "$fname" ]; then
    echo "$fname does not exist."
    exit 0
fi
sshpass -p $3 sftp ${user}@${ip} << EOF
put ${fname}
EOF

