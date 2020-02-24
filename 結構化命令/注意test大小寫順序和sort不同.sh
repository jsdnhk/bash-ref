#!/bin/bash
#test命令中，大小字母會被當成小於小寫字符，而在sort中，小寫字母會先出現,test使用標準的ASCII排序，sort使用本地化語言設置進行排序，對於英語，本地化設置制定了排序順序中小寫字母出現在大寫字母之前

var1=Testing
var2=testing

if [ $val1 \> $val2 ]
then
	echo '$val1 is greater than $val2'
else
	echo '$val1 is less than $val2'
fi
