#!/bin/bash
# getting the number of parameters

echo There were $# parameters supplied

#花括號裏不能使用美元符號
params=$#

echo The last parameter is $params
echo The last parameter is ${!#}
