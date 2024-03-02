#!/bin/bash
# Write a program that takes a backup from home directory of your user after each timeuser logout.
uhome=~
datev=`date +%Y%m%d%H%M`
tar -cvf ${uhome}/homelog_${datev}.tar * >> /dev/null
echo "Archieving ${uhome} files ..."
