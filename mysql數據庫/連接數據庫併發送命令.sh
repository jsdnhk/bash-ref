#!/bin/bash

#連接數據庫
mysql=`which mysql
`
#發送單個命令
$mysql emwjs -u test -e "show databases;"

#發送多個命令
$mysql emwjs -u test <<EOF
show tables;
select * from em_admin;
EOF
