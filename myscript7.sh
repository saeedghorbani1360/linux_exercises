#!/bin/bash
if [ $# -ne 1 ]
then
        echo "Enter file containing IPs."
        exit 0
fi

fname=$1

if [ ! -f "$fname" ]; then
    echo "$fname does not exist."
    exit 0
fi
ipcnt=`cat ${fname} | wc -l`
datestr=`date +%Y%m%d`
output=`hostname`"_${datestr}.log"
echo "Saving result in "$output
echo "Date=$datestr" >> ./$output
echo "" >> ./$output
for((i=1;i<=$ipcnt;i++))
do
	ip=`sed -n "${i}p" ${fname}`
	if [ -z "$ip" ]
	then
		continue
	fi
	echo -n "IP=$ip " >> ./$output
	oct1=`echo $ip | cut -d "." -s -f 1 | tr -d [:alpha:]`
	oct2=`echo $ip | cut -d "." -s -f 2 | tr -d [:alpha:]`
	oct3=`echo $ip | cut -d "." -s -f 3 | tr -d [:alpha:]`
	oct4=`echo $ip | cut -d "." -s -f 4 | tr -d [:alpha:]`
	oct5=`echo $ip | cut -d "." -s -f 5`
	
	if [ -n "$oct5" ] || [ -z $oct1 ] || [ -z $oct2 ] || [ -z $oct3 ] || [ -z $oct4 ]
	then
        	echo "IP format error. =>  xxxx.xxxx.xxxx.xxxx" >> ./$output
        	continue
	fi
	if [ $oct1 -gt 255 ] || [ $oct2 -gt 255 ] || [ $oct3 -gt 255 ] || [ $oct4 -gt 255 ]
	then
	        echo "IP Octet must be between 0 and 255." >> ./$output
		continue
	fi	
	ping -c 1 $ip >> /dev/null

	if [ $? -eq 0 ]
	then
	        echo "Ping ${ip} is successful" >> ./$output
	       
	else
	        echo "Ping ${ip} failed" >> ./$output
	fi
	
done
echo "" >> ./$output
echo "=============================" >> ./$output
echo "" >> ./$output
