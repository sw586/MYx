#!/bin/bash

# 1. 更新系统
apt-get update -y

# 2. 安装 unzip 和 screen
apt-get install unzip screen -y

# 3. 创建/root/Xray目录
mkdir -p /root/Xray

# 4. 下载 Xray-linux-64.zip
wget https://github.com/XTLS/Xray-core/releases/download/v1.8.3/Xray-linux-64.zip -O /root/Xray/Xray-linux-64.zip

# 5. 解压 Xray-linux-64.zip
unzip /root/Xray/Xray-linux-64.zip -d /root/Xray

# 6. 下载配置文件 config.json
wget https://raw.githubusercontent.com/sw586/MYx/master/config.json -O /root/Xray/config.json

# 7. 使用 screen 创建会话并执行 Xray
screen -d -m -S v /root/Xray/xray -config=/root/Xray/config.json

# 8. 输出本机ip地址
ip addr show | grep "inet " | grep -v "127.0.0.1" | awk '{print $2}' | cut -d '/' -f 1

echo "脚本执行完成！"
