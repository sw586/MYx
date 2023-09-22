#!/bin/bash

# 检查Docker是否已经安装
if ! command -v docker &> /dev/null; then
    echo "Docker未安装，开始自动安装..."
    wget -O - https://raw.githubusercontent.com/sw586/MYx/master/docker.sh | bash
else
    echo "Docker已安装，跳过安装步骤。"
fi

# 启动redroid容器
docker run -itd \
  --memory-swappiness=0 \
  --privileged --pull always \
  -v /root/test/data:/data \
  --rm \
  --name=redroid8 \
  redroid/redroid:8.1.0-latest \
  androidboot.hardware=mt6891 ro.secure=0 ro.boot.hwc=GLOBAL ro.ril.oem.imei=861503068361145 ro.ril.oem.imei1=861503068361145 ro.ril.oem.imei2=861503068361148 ro.ril.miui.imei0=861503068361148 ro.product.manufacturer=Xiaomi ro.build.product=chopin \
  redroid.width=720 redroid.height=1280

# 运行scrcpy-web容器
docker run --rm -itd --privileged -v /root/scrcpy-web/data:/data --name scrcpy-web -p 127.0.0.1:48000:8000/tcp --link redroid8:myphone1 emptysuns/scrcpy-web:v0.1

# 连接ADB
docker exec -it scrcpy-web adb connect myphone1:5555

# 其他步骤，如nginx配置和Cloudflare设置，需要手动完成
echo "请手动完成nginx配置和Cloudflare设置。"
