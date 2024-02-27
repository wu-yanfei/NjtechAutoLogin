#!/bin/bash

# 校园网账号
USERID=20xxxxxxxxx
# 校园网密码
PASSWORD=abcdefxxxxxx
# 中国移动：cmcc 中国电信：telecom
CHANNEL=cmcc

WANIP=$(ifconfig eth0 | grep 'inet addr' | cut -d ':' -f2 | cut -d ' ' -f1)

LOGIN_URL="http://10.50.255.11:801/eportal/portal/login"
LOGIN_REQUEST_URL="${LOGIN_URL}?callback=dr1003&login_method=1&user_account=%2C1%2C${USERID}%40${CHANNEL}&user_password=${PASSWORD}&wlan_user_ip=${WANIP}&wlan_user_ipv6=&wlan_user_mac=000000000000&wlan_ac_ip=&wlan_ac_name=&jsVersion=4.1.3&terminal_type=2&lang=zh-cn&v=8166&lang=zh"

url="http://www.baidu.com"
status=$(curl -IsS -m 5 $url | head -n 1 | cut -d ' ' -f 2)

if [ "$status" = "200" ]; then
    echo "Internet connection is active!" | logger
else
    echo "Internet connecting..." | logger
    curl -s "$LOGIN_REQUEST_URL"
    echo "Internet connection is active!" | logger
fi
