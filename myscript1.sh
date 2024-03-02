#!/bin/bash

while [ -z $num ]
do
	read -p "Enter a number (or 'quit' to Exit): " num
	num=`echo $num | tr  [:upper:] [:lower:] `
	if [ "$num" = 'quit' ]
	then
		echo "Goodbye"
		exit 0
	fi
	num=`echo $num | tr -d [:alpha:]`
done
if [ $num -gt 10 ] 
then
	res="greater than"
elif [ $num -lt 10 ]
then 
	res="less than"
else
	res="equal to"
fi
echo 
echo "Your number is ${num} and is ${res} 10."



