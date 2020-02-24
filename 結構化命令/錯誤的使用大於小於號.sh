#!/bin/bash
# 大於小於號必須轉義，否則shell會將它們當做重定向符號而把字符串值當做文件名處理
# 大於小於號順序和sort命令所採用的有所不同
# mis-using string comparisons

val1=baseball
val2=hockey

if [ $val1 > $val2 ]
then
	echo "$val1 is greater than $val2"
else
	echo "$val1 is less than $val2"
fi
