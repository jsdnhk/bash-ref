#!/bin/bash
#bash shell 僅能處理浮點數值,test命令無法處理val1變量中存儲的浮點值

#testing floating point numbers 

val1=`echo "scale=4; 10 / 3" | bc`
echo "The test value is $val1"
if [ $val1 -gt 3 ]
then
	echo "The result is larger than 3"
fi
