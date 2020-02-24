#!/bin/bash

#查看殭屍進程
ps -al | gawk '{print $2,$4}' | grep Z
