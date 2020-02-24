#!/bin/bash

#and符號，代表替換命令中的匹配模式，不管預定義模式是什麼文本，都可以用and符號替換，and符號會提取匹配替換命令中指定替換模式中的所有字符串
echo "The cat sleeps in his hat" | sed 's/.at/"&"/g'

#替換單獨的單詞
echo "The System Administrator manual" | sed 's/\(System\) Administrator/\1 user/'

#在長數字中插入逗號
echo "1234567" | sed '{:start; s/\(.*[0-9]\)\([0-9]\{3\}\)/\1,\2/; t start}'

