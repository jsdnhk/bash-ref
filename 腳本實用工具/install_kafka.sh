#!/bin/bash
# auth:kaliarch
# version:v1.0
# func:kafka  0.10.2/0.11.0/1.1.0/2.0.0 安裝

# 定義安裝目錄、及日誌信息
. /etc/init.d/functions
[ $(id -u) != "0" ] && echo "Error: You must be root to run this script" && exit 1
export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
download_path=/tmp/tmpdir/
install_log_name=install_kafka.log
env_file=/etc/profile.d/kafka.sh
install_log_path=/var/log/appinstall/
install_path=/usr/local/
software_config_file=${install_path}kafka/config/server.properties

clear
echo "##########################################"
echo "#                                        #"
echo "# 安裝kafka 0.10.2/0.11.0/1.1.0/2.0.0    #"
echo "#                                        #"
echo "##########################################"
echo "1: Install kafka 0.10.2"
echo "2: Install kafka 0.11.0"
echo "3: Install kafka 1.1.0"
echo "4: Install kafka 2.0.0"
echo "5: EXIT"
# 選擇安裝軟件版本
read -p "Please input your choice:" softversion
if [ "${softversion}" == "1" ];then
        URL="https://anchnet-script.oss-cn-shanghai.aliyuncs.com/kafka/kafka_2.12-0.10.2.2.tgz"
elif [ "${softversion}" == "2" ];then
        URL="https://anchnet-script.oss-cn-shanghai.aliyuncs.com/kafka/kafka_2.12-0.11.0.3.tgz"
elif [ "${softversion}" == "3" ];then
        URL="https://anchnet-script.oss-cn-shanghai.aliyuncs.com/kafka/kafka_2.12-1.1.0.tgz"
elif [ "${softversion}" == "4" ];then
        URL="https://anchnet-script.oss-cn-shanghai.aliyuncs.com/kafka/kafka_2.12-2.0.0.tgz"
elif [ "${softversion}" == "5" ];then
        echo "you choce channel!"
        exit 1;
else
        echo "input Error! Place input{1|2|3|4|5}"
        exit 0;
fi

# 傳入內容,格式化內容輸出,可以傳入多個參數,用空格隔開
output_msg() {
    for msg in $*;do
        action $msg /bin/true
    done
}


# 判斷命令是否存在,第一個參數 $1 爲判斷的命令,第二個參數爲提供該命令的yum 軟件包名稱
check_yum_command() {
        output_msg "命令檢查:$1"
        hash $1 >/dev/null 2>&1
        if [ $? -eq 0 ];then
            echo "`date +%F' '%H:%M:%S` check command $1 ">>${install_log_path}${install_log_name} && return 0
        else
            yum -y install $2 >/dev/null 2>&1
        #    hash $Command || { echo "`date +%F' '%H:%M:%S` $2 is installed fail">>${install_log_path}${install_log_name} ; exit 1 }
        fi
}

# 判斷目錄是否存在,傳入目錄絕對路徑,可以傳入多個目錄
check_dir() {
    output_msg "目錄檢查"
    for dirname in $*;do
        [ -d $dirname ] || mkdir -p $dirname >/dev/null 2>&1
        echo "`date +%F' '%H:%M:%S` $dirname check success!" >> ${install_log_path}${install_log_name}
    done
}

# 下載文件並解壓至安裝目錄,傳入url鏈接地址
download_file() {
    output_msg "下載源碼包"
    mkdir -p $download_path 
    for file in $*;do
        wget $file -c -P $download_path &> /dev/null
        if [ $? -eq 0 ];then
           echo "`date +%F' '%H:%M:%S` $file download success!">>${install_log_path}${install_log_name}
        else
           echo "`date +%F' '%H:%M:%s` $file download fail!">>${install_log_path}${install_log_name} && exit 1
        fi
    done
}


# 解壓文件,可以傳入多個壓縮文件絕對路徑,用空格隔開,解壓至安裝目錄
extract_file() {
   output_msg "解壓源碼"
   for file in $*;do
       if [ "${file##*.}" == "gz" ] || [ "${file##*.}" == "tgz" ];then
           tar -zxf $file -C $install_path && echo "`date +%F' '%H:%M:%S` $file extrac success!,path is $install_path">>${install_log_path}${install_log_name}
       elif [ "${file##*.}" == "zip" ];then
           unzip -q $file -d $install_path && echo "`date +%F' '%H:%M:%S` $file extrac success!,path is $install_path">>${install_log_path}${install_log_name}
       else
           echo "`date +%F' '%H:%M:%S` $file type error, extrac fail!">>${install_log_path}${install_log_name} && exit 1
       fi
    done
}

# 配置環境變量,第一個參數爲添加環境變量的絕對路徑
config_env() {
    output_msg "環境變量配置"
    echo "export PATH=\$PATH:$1" >${env_file}
    source ${env_file} && echo "`date +%F' '%H:%M:%S` 軟件安裝完成!">> ${install_log_path}${install_log_name}

}

# 添加配置文件
add_config() {
cat> $1 <<EOF
broker.id=1                                              #kafka集羣標識，不能相同，第一臺是1以此類推，其他都一樣。
log.dirs=/usr/local/kafka/kafka-logs
host.name=127.0.0.1                                  #主機ip
#zookeeper.connect=127.0.0.1:2181			#zookeeper連接
EOF
}

main() {
check_dir $install_log_path $install_path
check_yum_command wget wget
download_file $URL

software_name=$(echo $URL|awk -F'/' '{print $NF}'|awk -F'.tgz' '{print $1}')
for filename in `ls $download_path`;do
    extract_file ${download_path}$filename
done
rm -fr ${download_path}
ln -s $install_path$software_name ${install_path}kafka
add_config ${software_config_file}
check_dir ${install_path}kafka/kafka-logs
config_env ${install_path}kafka/bin
}

main

