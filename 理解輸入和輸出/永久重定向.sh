#!/bin/bash
# testing STDERR messages
# redirecting all to a file

# 腳本執行期間，用exec命令告訴shell重定向某個特定文件描述符
exec 2>test

ls badtest
echo "This is test of redirecting all output"
echo "from a script to another file"

exec 1>test1
echo "This is the end of the script"
echo "but this should go to the testerror file" >&2
