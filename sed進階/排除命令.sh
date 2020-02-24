!/bin/bash

#排除命令，使本來起作用的命令不起作用

sed -n '/heade/!p' test

#反轉文本文件
sed -n '{1!G ; h; $p}' test
