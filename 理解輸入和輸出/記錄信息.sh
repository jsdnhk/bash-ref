#!/bin/bash

# using the tee command for logging
#將輸入一邊發送到STDOUT，一邊發送到日誌文件
tempfile=test
echo "This is the start of the test" | tee $tempfile
echo "This is the second line of the test" | tee -a $tempfile
echo "This is the end line of the test" | tee -a $tempfile


