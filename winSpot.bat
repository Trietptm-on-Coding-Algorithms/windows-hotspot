@echo OFF
:start

TITLE WinSpot - Windows WIFI Hotspot
Color 0B

SET v=4.0

cls
echo.
echo Welcome to winSpot v.%v%!
echo.
echo [1] Start hotspot.
echo [2] Stop hotspot.
echo [3] Configure the hotspot.
echo.
SET /P START=What would you like to do? 

if /i %START%==1 (goto startnet)
if /i %START%==2 (goto stop)
if /i %START%==3 (goto config)
if /i %START%==exit (exit)
goto unrecog

:startnet
cls
echo.
echo [*] Starting hotspot...
netsh wlan start hostednetwork
ping -n 1 127.0.0.1>NUL
echo.
echo Started WiFi hotspot.
ping -n 4 127.0.0.1>NUL
goto start

:stop
cls
echo.
echo [*] Stopping hotspot...
netsh wlan stop hostednetwork
ping -n 1 127.0.0.1>NUL
echo.
echo Stopped WiFi hotspot.
ping -n 4 127.0.0.1>NUL
goto start

:config
Color 0E
cls
echo.
SET /P SSID= Please choose an SSID (single word!): 
SET /P PSK= Give your network a password (8-63 characters, single word!): 
netsh wlan set hostednetwork ssid="%SSID%" key="%PSK%">NUL
ping -n 1 127.0.0.1>NUL
echo.
echo WiFi set!
ping -n 2 127.0.0.1>NUL
goto start

:unrecog
COLOR 0C
cls
echo.
echo An error occured!
echo Bad usage!: You have to choose "s" to start, "e" to stop and "c" to configure.
echo.
echo Press any key to get back to the menu...
echo.
pause > NUL
goto start