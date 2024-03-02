#!/bin/bash

uhome=~
datev=`date +%Y%m%d%H%M`
tar -cvf ${uhome}/homelog_${datev}.tar * >> /dev/null
echo "Archieving ${uhome} files ..."
