#!/bin/bash
#退出狀態碼，最大爲255，超過則進行模運算
#testing the exit status
var1=10
var2=20
var3=$[ $var1 + $var2]
echo The answer is $var3
exit 5

