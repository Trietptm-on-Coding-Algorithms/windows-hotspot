@echo off
:start

TITLE winSpot - Windows WIFI Hotspot
Color 0B

SET v=2.0

cls
echo.
echo Welcome to winSpot v.%v%!
echo.
echo [1] Start hotspot (s).
echo [2] Stop hotspot (e).
echo [3] Configure the hotspot (c).
echo [4] Load a profile (p).
echo.
SET /P START=What would you like to do? (s/e/c/p): 

if /i %START%==s (goto startnet)
if /i %START%==e (goto stop)
if /i %START%==c (goto config)
if /i %START%==p (goto profile)
if /i %START%==exit (exit)
goto unrecog

:startnet
Color 09
cls
echo.
echo [*] Starting hotspot...
netsh wlan start hostednetwork
echo.
timeout 5
goto start

:stop
Color 0D
cls
echo.
echo [*] Stopping hotspot...
netsh wlan stop hostednetwork
echo.
timeout 5
goto start

:profile
Color 0E
SET "SSID="
SET "PSK="
cls
echo.
echo Profiles:
echo.
echo -------------------------------
for %%a in (*.cmd) do (echo %%~na)
echo -------------------------------
echo.
SET /p profile=Choose your profile (full name): 
echo.
if exist %profile%.cmd (
	call %profile%.cmd
	netsh wlan set hostednetwork ssid=%SSID% key=%PSK%
) else (echo ## Error! No such profile found. ##)
timeout 5
goto start

:config
Color 0E
cls
echo.
SET /P SSID=Please choose an SSID (name): 
SET /P PSK=Give your network a password (8-63 characters): 
echo.
netsh wlan set hostednetwork ssid=%SSID% key=%PSK%
echo.
SET /p SP=Save this configuration to a profile? (y/n): 
if /i %SP%==y (goto savep)
echo.
timeout 5
goto start

:savep
echo.
SET /p PN=Enter the profile name (1 word): 
echo SET SSID=%SSID%>"%PN%.cmd"
echo SET PSK=%PSK%>>"%PN%.cmd"
cls
echo.
echo Saved the profile %PN%!
echo.
timeout 5
goto start

:unrecog
COLOR 04
cls
echo.
echo An error occured!
echo Unrecognized command. You have to choose "s" for start, "e" for stop and "c" for configure.
echo.
echo Press any key to go back to the menu...
echo.
pause > NUL
goto start

