# 更新包列表
sudo apt update

# 安装必要的依赖
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# 添加Docker官方的GPG密钥
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# 添加Docker存储库
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# 更新包列表（包括新添加的Docker存储库）
sudo apt update

# 安装Docker Engine
sudo apt install -y docker-ce docker-ce-cli containerd.io

# 启动并加入Docker服务
sudo systemctl start docker
sudo systemctl enable docker

# 添加当前用户到docker组，以允许非root用户运行Docker命令
sudo usermod -aG docker $USER

# 重新登录以应用组更改，或运行以下命令使其立即生效
# newgrp docker

# 验证Docker安装是否成功
docker --version

# 输出Docker信息
docker info
