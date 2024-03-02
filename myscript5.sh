#!/bin/bash
# Write a program that saves the first and third fields of the /etc/passwd file every day in a file with the same date and does not hold it for more than two days.
find . -name "passwd_*.log" -mtime +2 -exec rm -rf {} \;
datev=`date +%Y%m%d%H%M`
filename="/home/saeed/passwd_${datev}.log"
awk -v current_date="$(date +%Y/%m/%d)" -F":" 'BEGIN{print "===========\nDate : " current_date; print "User\tUID\n-----------"} {if (($3>=0)) {print $1 "\t" $3;++cnt}} END {print "-----------\nNumber of users: " cnt}' /etc/passwd >> $filename
