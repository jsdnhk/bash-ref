#!/bin/bash

# testing the reading command

echo -n "Enter your name:"
read name
echo "Hello $name, welcome to my program"

read -p "Please enter your age: " age
days=$[ $age * 365 ]
echo "That makes you over $days days old"

#指定多個變量，輸入的每個數據值都會分配給表中的下一個變量，如果用完了，就全分配各最後一個變量
read -p "Please enter name:" first last
echo "Checking data for $last. $first..."

#如果不指定變量，read命令就會把它收到的任何數據都放到特殊環境變量REPLY中
read -p "Enter a number:"
factorial=1
for (( count=1; count<=$REPLY; count++))
do
	factorial=$[ $factorial * $count ]
done
echo "The factorial of $REPLY is $factorial"



