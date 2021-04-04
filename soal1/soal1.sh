#!/bin/bash

#1.a
ERROR=$(grep "ticky" syslog.log | cut -f6- -d' ' | grep -E "ERROR")
INFO=$(grep "ticky" syslog.log | cut -f6- -d' ' | grep -E "INFO")

error_count=$(grep -c "ERROR" syslog.log)
info_count=$(grep -c "INFO" syslog.log)

grep "ticky" syslog.log | cut -f6- -d' ' | grep -E "ERROR"
echo
grep "ticky" syslog.log | cut -f6- -d' ' | grep -E "INFO"
echo

#1.b
grep "ERROR" syslog.log | grep -Po "(?<=ERROR )(.*)(?=\()" | sort | uniq -c | sort -nr
error_list=$(grep "ERROR" syslog.log | grep -Po "(?<=ERROR )(.*)(?=\()" | sort | uniq -c | sort -nr)
echo

#1.c
user_list=$(grep -Po "(?<=\()(.*)(?=\))" syslog.log | sort -u)
grep "ERROR" syslog.log | grep -Po "(?<=\()(.*)(?=\))" | sort | uniq -c
echo
grep "INFO" syslog.log | grep -Po "(?<=\()(.*)(?=\))" | sort | uniq -c
echo

#1.d
echo "Error,Count" > error_message.csv
echo "$error_list" | while read baris;
do 
	err=$(echo $baris | cut -d ' ' -f 2-)
	errCount=$(echo $baris | cut -d ' ' -f 1)
	echo "$err,$errCount" >> error_message.csv
done
cat error_message.csv
echo

#1.e
echo "username,INFO,ERROR" > user_statistic.csv
for i in $user_list
do 
	errorCount=$(echo "$ERROR" | grep -E "(ERROR).*(\($i\))" | wc -l)
	infoCount=$(echo "$INFO" | grep -E "(INFO).*(\($i\))" | wc -l)
	echo "$i,$infoCount,$errorCount" >> user_statistic.csv
done
cat user_statistic.csv
echo
