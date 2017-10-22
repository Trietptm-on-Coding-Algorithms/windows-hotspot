@echo OFF

TITLE WinSpot - Windows WIFI Hotspot
Color 0C
SET v=5

net session>nul 2>&1
    if NOT %errorLevel% == 0 (
        echo.
		echo # For this to work you need admin rights!
		echo # Right-click this file and choose "Run as administrator".
		echo.
		echo # Press any key to exit...
		pause>NUL
		exit
    )

:start
Color 0B
cls
echo.
echo Welcome to WinSpot v%v%!
echo.
echo [1] Start hotspot.
echo [2] Stop hotspot.
echo [3] Configure the hotspot.
echo [4] Exit
echo.
SET /P START=What would you like to do? 

if /i %START%==1 (goto startnet)
if /i %START%==2 (goto stop)
if /i %START%==3 (goto config)
if /i %START%==4 (exit)
goto unrecog

:startnet
cls
echo.
echo [*] Starting hotspot...
netsh wlan start hostednetwork>NUL
echo.
echo Started WiFi hotspot.
ping -n 4 127.0.0.1>NUL
goto start

:stop
cls
echo.
echo [*] Stopping hotspot...
netsh wlan stop hostednetwork>NUL
echo.
echo Stopped WiFi hotspot.
ping -n 4 127.0.0.1>NUL
goto start

:config
Color 0E
cls
echo.
SET /P SSID= Please choose an SSID: 
SET /P PSK= Give your network a password (8-63 characters): 
netsh wlan set hostednetwork ssid="%SSID%" key="%PSK%">NUL
echo.
echo WiFi hotspot name and password set!
ping -n 3 127.0.0.1>NUL
goto start

:unrecog
COLOR 0C
cls
echo.
echo An error occured!
echo Bad usage: You have to choose either "1" to start, "2" to stop or "3" to configure the hotspot.
echo.
echo Press any key to get back to the menu...
echo.
pause>NUL
goto start