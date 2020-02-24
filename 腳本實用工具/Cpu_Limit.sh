#!/bin/bash
# auth:kaliarch
# func:sys info check
# version:v1.0
# sys:centos6.x/7.x

set -e
[ $(id -u) -gt 0 ] && exit 1

# cpu使用超過百分之多少進行限制
PEC_CPU=80

# 限制進程使用百分之多少,如果程序爲多線程，單個cpu限制爲85，如果爲多核心，就需要按照比例寫，例如cpu爲2c，像限制多線程佔比80%，就寫170
LIMIT_CPU=85
# 日誌
LOG_DIR=/var/log/cpulimit/

# 超過閥值進程pid
PIDARG=$(ps -aux |awk -v CPU=${PEC_CPU} '{if($3 > CPU) print $2}')
CPULIMITCMD=$(which cpulimit)

install_cpulimit() {
	[ ! -d /tmp ] && mkdir /tmp || cd /tmp
	wget -c https://github.com/opsengine/cpulimit/archive/v0.2.tar.gz
	tar -zxf v0.2.tar.gz
	cd cpulimit-0.2 && make
	[ $? -eq 0 ] && cp src/cpulimit /usr/bin/
}


do_cpulimit() {
[ ! -d ${LOG_DIR} ] && mkdir -p ${LOG_DIR}
for i in ${PIDARG};
do
        MSG=$(ps -aux |awk -v pid=$i '{if($2 == pid) print $0}')
        echo ${MSG}
	[ ! -d /tmp ] && mkdir /tmp || cd /tmp
	nohup ${CPULIMITCMD} -p $i -l ${LIMIT_CPU} &
        echo "$(date) -- ${MSG}" >> ${LOG_DIR}$(date +%F).log
done
}

main() {

	hash cpulimit 
	if [ $? -eq 0 ];then
		do_cpulimit
	else
		install_cpulimit && do_cpulimit
	fi			
}

main
