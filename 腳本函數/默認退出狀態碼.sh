#!/bin/bash

# testing the exit status of a function

func1() {
	echo "Trying to display a non-existent file"
	ls -l badfile
}

#由於最後一條命令未執行成功，返回的狀態碼非0
echo "testing the function"
func1
echo "The exit status is : $?"

func2() {
	ls -l badfile
	echo "Another test to display a non-existent file"
}

#由於最後一條命令echo執行成功，返回的狀態碼爲0
echo "Another test"
func2
echo "The exit status is : $?"





























