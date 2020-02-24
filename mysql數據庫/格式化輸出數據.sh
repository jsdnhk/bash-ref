#!/bin/bash

#redirecting SQL output to a variable

MYSQL=`which mysql`
dbs=`$MYSQL emwjs -u test -Bse 'show tables;'`
for db in $dbs
do
	echo $db
done


#使用xml輸出數據
$MYSQL emwjs -u test -X -e 'select * from em_admin'

#使用table標籤輸出數據
$MYSQL emwjs -u test -H -e 'select * from em_admin'

