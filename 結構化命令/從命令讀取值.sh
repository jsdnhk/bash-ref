#!/bin/bash
#reading values from a file

file="state"

#更改字段分隔符，使其只能識別換行符
IFS=$'\n'

#處理長腳本是，在一個地方修改了該值，然後可能忘了修改過該值
#IFS.OLD=$IFS
#IFS=$'\n'
#具體代碼
#IFS=$IFS.OLD

for state in `cat $file`
do
	echo "Visit beautiful $state"
done
