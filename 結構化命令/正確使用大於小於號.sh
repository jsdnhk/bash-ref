#!/bin/bash
#正確使用大於小於號

val1=baseball
val2=hocky

if [ $val1 \> $val2 ]
then 
	echo "$val1 is greater than $val2"
else
	echo "$val1 is less than $val2"
fi
