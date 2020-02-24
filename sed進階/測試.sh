#!/bin/bash

#測試，如果測試成功，如果沒有標籤，sed會跳轉到結尾，如果有標籤，就跳轉到標籤，如果測試失敗，則不會跳轉
sed -n '{s/first/matched/; t; s/This is the/No match on/}' test
