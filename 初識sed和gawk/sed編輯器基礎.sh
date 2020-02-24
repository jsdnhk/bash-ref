#!/bin/bash
#sed編輯器基礎

#替換標記
sed 's/lazy/ht/' ./test

echo -e "next\n"

#可用的替換標記
#1.數字 表明新聞本將替換第幾處模式匹配的地方
sed 's/lazy/ht/2' ./test
#2.g 表明新文件將會替換所有已有文本出現的地方
sed 's/lazy/ht/g' ./test
#3.p 表明原來行的內容要打印出來,替換後的
sed 's/lazy/ht/p' ./test
#4.w file 將替換的結果寫到文件中
sed 's/lazy/ht/w test1' ./test

echo -e "next\n"

#替換字符
sed 's/\/bin\/bash/\/bin\/csh/' /etc/passwd
#或者
sed 's!/bin/bash!/bin/csh!' /etc/passwd

echo -e "next\n"

#使用地址
#1.數字方式的行尋址
sed '2s/lazy/cat/' ./test
sed '2,3s/lazy/cat/' ./test
sed '2,$s/lazy/cat/' ./test
#2.使用文本模式過濾器
sed '/tiandi/s/bash/csh/' /etc/passwd

echo -e "next\n"

#組合命令
sed '2{
s/fox/elephant/
s/dog/cat/
}' test
sed '2,${
s/fox/elephant/
s/dog/cat/
}' test

echo -e "next\n"

#刪除行
sed '3d' ./test
sed '2,$d' ./test
sed '/number 1/d' ./test
#刪除兩個文本模式來刪除某個範圍的行，第一個開啓刪除功能，第二個關閉刪除功能
sed '/1/,/3/d' ./test

echo -e "next\n"

#插入和附加文本
sed '3i\
This is an appended line.' ./test

sed '$a\
This is a new line of text.' ./test

#修改行
sed '3c\
This a changed line of text.' ./test
sed '/number 1/c\
This a changed line of text.' ./test
#替換兩行文本
#sed '2,3c\
#This a changed line of text.' ./test

#轉換命令，處理單個字符
#sed 'y/123/789/' ./test

echo -e "next\n"

#回顧打印
# p 打印文本行
# -n 禁止其他行，只打印包含匹配文本模式的行
sed -n '/number 3/p' ./test

#查看修改之前的行和修改之後的行
#sed -n '/3/{
#p
#s/line/test/p
#}' ./test

echo -e "next\n"

# 打印行號
sed '=' ./test

#打印指定的行和行號
#sed -n '/lazy/{
#=
#p
#}' ./test

#列出行 打印數據流中的文本和不可打印的ASCII字符，任何不可打印的字符都用它們的八進制值前加一個反斜線或標準C風格的命名法，比如用\t來代表製表符
sed -n 'l' ./test

