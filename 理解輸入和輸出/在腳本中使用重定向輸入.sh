#!/bin/bash
# redirecting the inpiut

# 從test中讀取數據，而不是從STDIN中讀取數據
exec 0< test
count=1
while read line
do
	echo "Line #$count : $line "
	count=$[ $count +1 ]
done

