#!/bin/bash

# using a global variable to pass a value

function db1 {
	# $1和$2 不能從命令行中傳遞，只能調用函數時，手動傳遞
	echo $[ $1 * $2 ]
}

if [ $# -eq 2 ]
then
	value=`db1 $1 $2`
	echo "The result is $value"
else
	echo "Usage: badtest1 a b"
fi
