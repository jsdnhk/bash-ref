#!/bin/bash

#向文件寫入
sed '1,2w test1' test1

echo -e "next\n"

#從文件讀取
sed '3r ./test' ./test

echo -e "next\n"

#從文件讀取，並插入字符流
sed '/lazy/r test' test

#向數據流末尾添加數據
sed '$r test' test

echo -e "next1\n"

sed '/lazy/ {
r test
d
}' test
