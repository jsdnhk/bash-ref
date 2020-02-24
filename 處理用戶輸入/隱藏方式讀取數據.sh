#!/bin/bash
# hiding input data from monitor

read -s -p "Please enter your password: " pass

#添加了-s選項之後，不會自動換行，不添加-s 會自動換行
echo 
echo "Is your password really $pass?"
