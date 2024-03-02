#!/bin/bash
#  Write a program that takes 20 number from input, compares them, and states which number is the largest and smallest.
greatest=0
smallest=0

for i in {1..20}
do	
	while true
	do
		read -p "Enter number $i (or 'quit' to Exit): " num
		num=`echo $num | tr  [:upper:] [:lower:] `
		if [ "$num" = 'quit' ]
		then
			echo "Goodbye"
			exit 0
		fi
		num=`echo $num | tr -d [:alpha:]`
		if [ -n "$num" ]
		then
			break
		fi
	done
	if [ $i -eq 1 ]
	then
		greatest=$num
		smallest=$num
	fi
	if [ $num -gt $greatest ]
	then
		greatest=$num
	elif [ $num -lt $smallest ]
	then
		smallest=$num
	fi		
done
echo "The greatest number is $greatest"
echo "The smallest number is $smallest"
