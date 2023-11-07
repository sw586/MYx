#!/bin/bash

# 检查jq是否已安装
if ! command -v jq &> /dev/null
then
    echo "jq could not be found, installing now."
    # 根据您的系统选择合适的安装命令
    # 以下是在基于Debian的系统上安装jq的命令
    sudo apt-get update && sudo apt-get install -y jq
fi

# 现在jq应该已经安装了，接下来执行更新config.json的命令
PORT=$(curl -s https://raw.githubusercontent.com/sw586/MYx/master/port.txt)
jq '.inbounds[0].port = $newport' --argjson newport $PORT /root/Xray/config.json > /root/Xray/config.json.tmp && mv /root/Xray/config.json.tmp /root/Xray/config.json

# 检查命令是否成功
if [ $? -eq 0 ]; then
    echo "Port updated successfully."
else
    echo "Failed to update the port."
fi
