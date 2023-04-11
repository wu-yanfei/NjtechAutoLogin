@echo off
setlocal EnableDelayedExpansion

:: Campus network account
set USERID=20xxxxxxxxx
:: Campus network password
set PASSWORD=abc123aaaa
:: China Mobile: cmcc, China Telecom: telecom
set CHANNEL=cmcc

for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /c:"IPv4"') do (
  set WANIP=%%a
  set WANIP=!WANIP:~1!
)

ping -n 1 www.baidu.com >nul

if %errorlevel% equ 0 (
  echo Internet connection is active
) else (
  echo Internet connecting...
  curl "http://10.50.255.11:801/eportal/?c=ACSetting&a=Login&protocol=http:&hostname=10.50.255.11&iTermType=1&wlanuserip=%WANIP%&wlanacip=null&wlanacname=me60-2&mac=00-00-00-00-00-00&ip=%WANIP%&enAdvert=0&queryACIP=0&jsVersion=2.4.3&loginMethod=1" ^
    -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7" ^
    -H "Accept-Language: zh-CN,zh;q=0.9" ^
    -H "Cache-Control: max-age=0" ^
    -H "Connection: keep-alive" ^
    -H "Content-Type: application/x-www-form-urlencoded" ^
    -H "Origin: http://10.50.255.11" ^
    -H "Referer: http://10.50.255.11/" ^
    -H "Upgrade-Insecure-Requests: 1" ^
    -H "User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36" ^
    --data-raw "DDDDD=%%2C0%%2C%USERID%%%40%CHANNEL%&upass=%PASSWORD%&R1=0&R2=0&R3=0&R6=0&para=00&0MKKey=123456&buttonClicked=&redirect_url=&err_flag=&username=&password=&user=&cmd=&Login=&v6ip="
  echo Internet connection is active
)

endlocal
