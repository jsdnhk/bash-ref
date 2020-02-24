#!/bin/bash

#跳轉到指定腳本
sed '{/first/b jump1; s/This is the/No jump on/; :jump1; s/This is the/Jump here on/}' test

#跳轉到開頭,刪除每一個逗號，並保證刪除最後一個逗號之後，跳出循環
sed -n '{:start; s/,//1p; /,/b start}' test
