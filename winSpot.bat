@echo off
:start

TITLE winSpot - Windows Wireless Hotspot
Color 0F

SET v=1.0

cls
echo.
echo Welcome to winSpot v.%v%!
echo.
echo [1] Start hotspot (s).
echo [2] Stop hotspot (e).
echo [3] Configure the hotspot (c).
echo.
SET /P START=What would you like to do? (s/e/c): 

if /i %START%==s (goto start)
if /i %START%==e (goto stop)
if /i %START%==c (goto config)
if /i %START%==exit (exit)
goto unrecog

:start
cls
echo.
echo [*] Starting hotspot...
netsh wlan start hostednetwork
echo.
echo Press any key to go back to the menu...
echo.
pause > NUL
goto start

:stop
cls
echo.
echo [*] Stopping hotspot...
netsh wlan stop hostednetwork
echo.
echo Press any key to go back to the menu...
pause > NUL
goto start

:config
cls
echo.
SET /P SSID=Please choose an SSID (name): 
SET /P PSK=Give your network a password (8-63 characters): 
echo.
netsh wlan set hostednetwork ssid=%SSID% key=%PSK%
echo.
echo.
echo Press any key to go back to the menu...
echo.
pause > NUL
goto start

:unrecog
COLOR 0C
cls
echo.
echo An error occured!
echo Unrecognized command. You have to choose "s" for start, "e" for stop and "c" for configure.
echo.
echo Press any key to go back to the menu...
echo.
pause > NUL
goto start

