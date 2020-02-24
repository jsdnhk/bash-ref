#!/bin/bash
#使用內建變量

# NF 當前記錄的字段個數
# NR 到目前爲止讀的記錄數量
#下面的程序在每行開頭輸出行號，並在最後輸出文件的總字段數
gawk '{ total+=NF; print NR, $0 }END{ print "Total: ", total}'

gawk 'BEGIN {testing="This is a test";  print testing; testing=45;  print testing}'

#處理數字值

gawk 'BEGIN{x=4; x= x*2+3; printx}'

#處理數組
gawk 'BEGIN{capital["Ill"] = "SprintField"; print capital["Ill"]}'

#遍歷數組變量
gawk 'BEGIN{
var["a"] = 1
var["g"] = 2
var["m"] = 3
for( test in var)
{
	print "Index:",test,"- Value:",var[test]
}
}'

print "------"

#刪除數組變量
gawk 'BEGIN{
var["a"] = 1
var["g"] = 2
for (test in var)
{
	print "Index:",test," - Value:", var[test]
}
delete var["g"]

print "----"

for (test in var)
{
	print "Index;",test," - Value:", var[test]
}
}'
