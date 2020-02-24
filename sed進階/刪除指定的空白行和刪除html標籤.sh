#!/bin/bash

#多個空格只保留一個
#sed '/./,/^$/!d' test

#刪除開頭的空白行
#sed '/./,$!d' test

#刪除結尾的空白行
sed '{
:start
/^\n*$/{$d; N; b start}
}' test

#刪除html標籤
#有問題
#s/<.*>//g

#sed 's/<[^>]*>//g' test1

#sed 's/<[^>]*>//g;/^$/d' test1
