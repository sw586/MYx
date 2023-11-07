#!/bin/bash

# 检查jq是否已安装
if ! command -v jq &> /dev/null; then
    echo "未发现jq，现在开始安装..."
    # 根据您的系统选择合适的安装命令
    # 以下是在基于Debian的系统上安装jq的命令
    sudo apt-get update && sudo apt-get install -y jq
fi

# 现在jq应该已经安装了，接下来执行更新config.json的命令
PORT=$(curl -s https://raw.githubusercontent.com/sw586/MYx/master/port.txt)
if jq '.inbounds[0].port = $newport' --argjson newport $PORT /root/Xray/config.json > /root/Xray/config.json.tmp; then
    if [ -s /root/Xray/config.json.tmp ]; then
        mv /root/Xray/config.json.tmp /root/Xray/config.json
        echo "端口更新成功。"

        # 结束xray进程
        pkill -f xray

        # 等待一秒钟，确保xray进程已经完全停止
        sleep 1

        # 重新启动xray服务并在后台运行
        iptables -F && iptables -X && iptables -F -t nat && iptables -X -t nat && iptables -P FORWARD ACCEPT && iptables -P INPUT ACCEPT && iptables -P OUTPUT ACCEPT
        nohup /root/Xray/xray -config=/root/Xray/config.json &> /dev/null &

        # 输出xray进程信息
        echo "xray进程信息："
        ps aux | grep xray | grep -v grep

    else
        echo "更新端口失败：临时文件为空。"
    fi
else
    echo "更新端口失败：jq命令执行出错。"
fi
