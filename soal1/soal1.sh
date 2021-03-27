#!/bin/bash

#1.a
ERROR=$(grep -E "ERROR" syslog.log)
INFO=$(grep -E "INFO" syslog.log)

error_count=$(grep -c "ERROR" syslog.log)
info_count=$(grep -c "INFO" syslog.log)

#1.b
error_list=$(echo "$ERROR" | grep -Po "(?<=ERROR )(.*)(?=\()" | sort | uniq -c | sort -nr)

#1.c
user_list=$(grep -Po "(?<=\()(.*)(?=\))" syslog.log | sort | uniq)

#1.d
echo "Error,Count" > error_message.csv
echo "$error_list" | while read baris
do 
	err=$(echo $baris | cut -d ' ' -f 2-)
	errCount=$(echo $baris | cut -d ' ' -f 1)
	echo "$err,$errCount" >> error_message.csv
done

#1.e
echo "username,INFO,ERROR" > user_statistic.csv
for i in $user_list
do 
	errorCount=$(echo grep "ERROR" syslog.log | grep -c $i)
	infoCount=$(echo grep "INFO" syslog.log | grep -c $i)
	echo "$i,$infoCount,$errorCount" >> user_statistic.csv
done
