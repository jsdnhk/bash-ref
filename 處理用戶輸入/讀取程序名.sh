#!/bin/bash
# testing the $0 parameter

echo The command entered is $0

#當傳給$0變量的真實字符串是整個腳本的路徑是，程序中就會使用整個路徑，而不僅僅是程序名

name=`basename $0`
echo The command entered is $name
