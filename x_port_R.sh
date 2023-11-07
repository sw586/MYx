#!/bin/bash

# 第一步：下载port.txt并更新config.json
PORT=$(curl https://raw.githubusercontent.com/sw586/MYx/master/port.txt)
sed -i "22s/\"port\": [0-9]*,/\"port\": $PORT,/" /root/Xray/config.json

