#!/bin/bash

# 卸载旧版本
echo "正在卸载旧版本..."
sudo apt-get remove -y docker.io docker-doc docker-compose podman-docker containerd runc

# 安装依赖
echo "安装依赖..."
sudo apt-get update
apt upgrade -y
sudo apt-get install jq -y
sudo apt-get install -y ca-certificates curl gnupg

# 添加Docker的官方GPG密钥
echo "添加Docker的官方GPG密钥..."
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# 添加Docker的Apt仓库
echo "添加Docker的Apt仓库..."
echo "deb [arch=\"$(dpkg --print-architecture)\" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo \"$VERSION_CODENAME\") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# 安装Docker
echo "安装Docker..."
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# 验证安装
echo "验证安装..."
sudo docker run hello-world

echo "Docker已成功安装！"
