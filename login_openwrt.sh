#!/bin/bash

# 校园网账号
USERID=20xxxxxxxxx
# 校园网密码
PASSWORD=abcdefxxxxxx
# 中国移动：cmcc 中国电信：telecom
CHANNEL=cmcc

WANIP=$(ifconfig eth0 | grep 'inet addr' | cut -d ':' -f2 | cut -d ' ' -f1)

url="http://www.baidu.com"
status=$(curl -IsS -m 5 $url | head -n 1 | cut -d ' ' -f 2)

if [ "$status" = "200" ]; then
    echo "Internet connection is active!" | logger
else
    echo "Internet connecting..." | logger
    curl "http://10.50.255.11:801/eportal/?c=ACSetting&a=Login&protocol=http:&hostname=10.50.255.11&iTermType=1&wlanuserip=$WANIP&wlanacip=null&wlanacname=me60-2&mac=00-00-00-00-00-00&ip=$WANIP&enAdvert=0&queryACIP=0&jsVersion=2.4.3&loginMethod=1" \
      -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7' \
      -H 'Accept-Language: zh-CN,zh;q=0.9' \
      -H 'Cache-Control: max-age=0' \
      -H 'Connection: keep-alive' \
      -H 'Content-Type: application/x-www-form-urlencoded' \
      -H 'Origin: http://10.50.255.11' \
      -H 'Referer: http://10.50.255.11/' \
      -H 'Upgrade-Insecure-Requests: 1' \
      -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36' \
      --data-raw "DDDDD=%2C0%2C$USERID%40$CHANNEL&upass=$PASSWORD&R1=0&R2=0&R3=0&R6=0&para=00&0MKKey=123456&buttonClicked=&redirect_url=&err_flag=&username=&password=&user=&cmd=&Login=&v6ip="
    echo "Internet connection is active!" | logger
fi
