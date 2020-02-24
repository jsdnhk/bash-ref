#!/bin/bash
#輸出末尾10行數據

sed '{
:start
$q
N
11,$D
b start
}' /etc/passwd
