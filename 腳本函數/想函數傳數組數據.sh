#!/bin/bash

# trying to pass an array variable

function testit {
	echo "The parameters are : $@"
	
	#函數只會讀取數組變量的第一個值
	thisarray=$1
	echo "The received array is ${thisarray[*]}"

	local newarray
	newarray=(`echo "$@"`)
	echo "The new array value is : ${newarray[*]}"
}

myarray=(1 2 3 4 5)
echo "The original array is : ${myarray[*]}"

#將數組變量當成一個函數參數，函數只會去函數變量第一個值
#testit $myarray

testit ${myarray[*]}
