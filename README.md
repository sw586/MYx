# MYx

自动修改root/Xray/config.json中的端口并重启Xray

curl -s https://raw.githubusercontent.com/sw586/MYx/master/x_port_R.sh | bash
定时任务
输入 crontab -e 命令来编辑 cron 作业。
*/10 * * * * /usr/bin/curl -s https://raw.githubusercontent.com/sw586/MYx/master/x_port_R.sh | /bin/bash
