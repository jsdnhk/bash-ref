#!/bin/bash
# auth:kaliarch
# func:sys info check
# version:v1.0

[ $(id -u) -gt 0 ] && echo "請用root用戶執行此腳本！" && exit 1
sysversion=$(rpm -q centos-release|cut -d- -f3)
line="-------------------------------------------------"


[ -d logs ] || mkdir logs

sys_check_file="logs/$(ip a show dev eth0|grep -w inet|awk '{print $2}'|awk -F '/' '{print $1}')-`date +%Y%m%d`.txt"

# 獲取系統cpu信息
function get_cpu_info() {
    Physical_CPUs=$(grep "physical id" /proc/cpuinfo| sort | uniq | wc -l)
    Virt_CPUs=$(grep "processor" /proc/cpuinfo | wc -l)
    CPU_Kernels=$(grep "cores" /proc/cpuinfo|uniq| awk -F ': ' '{print $2}')
    CPU_Type=$(grep "model name" /proc/cpuinfo | awk -F ': ' '{print $2}' | sort | uniq)
    CPU_Arch=$(uname -m)
cat <<EOF
CPU信息:

物理CPU個數:$Physical_CPUs
邏輯CPU個數:$Virt_CPUs
每CPU核心數:$CPU_Kernels
CPU型號:$CPU_Type
CPU架構:$CPU_Arch
EOF
}

# 獲取系統內存信息
function get_mem_info() {
    check_mem=$(free -m)
    MemTotal=$(grep MemTotal /proc/meminfo| awk '{print $2}')  #KB
    MemFree=$(grep MemFree /proc/meminfo| awk '{print $2}')    #KB
    let MemUsed=MemTotal-MemFree
    MemPercent=$(awk "BEGIN {if($MemTotal==0){printf 100}else{printf \"%.2f\",$MemUsed*100/$MemTotal}}")
    report_MemTotal="$((MemTotal/1024))""MB"        #內存總容量(MB)
    report_MemFree="$((MemFree/1024))""MB"          #內存剩餘(MB)
    report_MemUsedPercent="$(awk "BEGIN {if($MemTotal==0){printf 100}else{printf \"%.2f\",$MemUsed*100/$MemTotal}}")""%"   #內存使用率%

cat <<EOF
內存信息：

${check_mem}
EOF
}

# 獲取系統網絡信息
function get_net_info() {
    pri_ipadd=$(ip a show dev eth0|grep -w inet|awk '{print $2}'|awk -F '/' '{print $1}')
    pub_ipadd=$(curl ifconfig.me -s)
    gateway=$(ip route | grep default | awk '{print $3}')
    mac_info=$(ip link| egrep -v "lo"|grep link|awk '{print $2}')
    dns_config=$(egrep -v "^$|^#" /etc/resolv.conf)
    route_info=$(route -n)
cat <<EOF
IP信息:

系統公網地址:${pub_ipadd}
系統私網地址:${pri_ipadd}
網關地址:${gateway}
MAC地址:${mac_info}

路由信息:
${route_info}

DNS 信息:
${dns_config}
EOF
}

# 獲取系統磁盤信息
function get_disk_info() {
    disk_info=$(fdisk -l|grep "Disk /dev"|cut -d, -f1)
    disk_use=$(df -hTP|awk '$2!="tmpfs"{print}')
    disk_inode=$(df -hiP|awk '$1!="tmpfs"{print}')

cat <<EOF
磁盤信息:

${disk_info}
磁盤使用:

${disk_use}
inode信息:

${disk_inode}
EOF


}

# 獲取系統信息
function get_systatus_info() {
    sys_os=$(uname -o)
    sys_release=$(cat /etc/redhat-release)
    sys_kernel=$(uname -r)
    sys_hostname=$(hostname)
    sys_selinux=$(getenforce)
    sys_lang=$(echo $LANG)
    sys_lastreboot=$(who -b | awk '{print $3,$4}')
    sys_runtime=$(uptime |awk '{print  $3,$4}'|cut -d, -f1)
    sys_time=$(date)
    sys_load=$(uptime |cut -d: -f5)

cat <<EOF
系統信息:

系統: ${sys_os}
發行版本:   ${sys_release}
系統內核:   ${sys_kernel}
主機名:    ${sys_hostname}
selinux狀態:  ${sys_selinux}
系統語言:   ${sys_lang}
系統當前時間: ${sys_time}
系統最後重啓時間:   ${sys_lastreboot}
系統運行時間: ${sys_runtime}
系統負載:   ${sys_load}
EOF
}

# 獲取服務信息
function get_service_info() {
    port_listen=$(netstat -lntup|grep -v "Active Internet")
    kernel_config=$(sysctl -p 2>/dev/null)
    if [ ${sysversion} -gt 6 ];then
        service_config=$(systemctl list-unit-files --type=service --state=enabled|grep "enabled")
        run_service=$(systemctl list-units --type=service --state=running |grep ".service")
    else
        service_config=$(/sbin/chkconfig | grep -E ":on|:啓用" |column -t)
        run_service=$(/sbin/service --status-all|grep -E "running")
    fi
cat <<EOF
服務啓動配置:

${service_config}
${line}
運行的服務:

${run_service}
${line}
監聽端口:

${port_listen}
${line}
內核參考配置:

${kernel_config}
EOF
}


function get_sys_user() {
    login_user=$(awk -F: '{if ($NF=="/bin/bash") print $0}' /etc/passwd)
    ssh_config=$(egrep -v "^#|^$" /etc/ssh/sshd_config)
    sudo_config=$(egrep -v "^#|^$" /etc/sudoers |grep -v "^Defaults")
    host_config=$(egrep -v "^#|^$" /etc/hosts)
    crond_config=$(for cronuser in /var/spool/cron/* ;do ls ${cronuser} 2>/dev/null|cut -d/ -f5;egrep -v "^$|^#" ${cronuser} 2>/dev/null;echo "";done)
cat <<EOF
系統登錄用戶:

${login_user}
${line}
ssh 配置信息:

${ssh_config}
${line}
sudo 配置用戶:

${sudo_config}
${line}
定時任務配置:

${crond_config}
${line}
hosts 信息:

${host_config}
EOF
}


function process_top_info() {

    top_title=$(top -b n1|head -7|tail -1)
    cpu_top10=$(top b -n1 | head -17 | tail -11)
    mem_top10=$(top -b n1|head -17|tail -10|sort -k10 -r)

cat <<EOF
CPU佔用top10:

${top_title}
${cpu_top10}

內存佔用top10:

${top_title}
${mem_top10}
EOF
}


function sys_check() {
    get_cpu_info
    echo ${line}
    get_mem_info
    echo ${line}
    get_net_info
    echo ${line}
    get_disk_info
    echo ${line}
    get_systatus_info
    echo ${line}
    get_service_info
    echo ${line}
    get_sys_user
    echo ${line}
    process_top_info
}


sys_check > ${sys_check_file}
