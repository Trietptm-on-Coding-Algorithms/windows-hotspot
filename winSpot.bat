@echo OFF
:start

TITLE WinSpot - Windows WIFI Hotspot
Color 0B

SET v=3.0

cls
echo.
echo Welcome to winSpot v.%v%!
echo.
echo [1] Start hotspot.
echo [2] Stop hotspot.
echo [3] Configure the hotspot.
echo [4] Load a profile.
echo.
SET /P START=What would you like to do? 

if /i %START%==1 (goto startnet)
if /i %START%==2 (goto stop)
if /i %START%==3 (goto config)
if /i %START%==4 (goto profile)
if /i %START%==exit (exit)
goto unrecog

:startnet
cls
echo.
echo [*] Starting hotspot...
netsh wlan start hostednetwork
echo.
timeout 5
goto start

:stop
cls
echo.
echo [*] Stopping hotspot...
netsh wlan stop hostednetwork
echo.
timeout 5
goto start

:profile
SET SSID=
SET PSK=
cls
echo.
echo Profiles:
echo.
echo -------------------------------
for %%a in (*.hsp) do (echo %%~na)
echo -------------------------------
echo.
SET /p profile= Choose your profile (full name): 
echo.
if exist "%profile%.hsp" (
	for /F "tokens=1 delims=," %%i in (%profile%.hsp) do (set SSID="%%i")
	for /F "tokens=2 delims=," %%i in (%profile%.hsp) do (set PSK="%%i")
) else (
	COLOR 0C
	echo.
	echo # Error! No such profile found.
	echo.
)
netsh wlan set hostednetwork ssid="%SSID%" key="%PSK%"
timeout 5
goto start

:config
Color 0E
cls
echo.
SET /P SSID= Please choose an SSID (single word!): 
SET /P PSK= Give your network a password (8-63 characters, single word!): 
echo.
netsh wlan set hostednetwork ssid="%SSID%" key="%PSK%"
echo.
SET /p SP= Save this configuration to a profile? (y/n): 
if /i %SP%==y (goto savep)
echo.
timeout 5
goto start

:savep
echo.
SET /p PN= Enter any profile name (single word!): 
echo %SSID%,%PSK%>"%PN%.hsp"
cls
echo.
echo Saved profile "%PN%".
echo.
timeout 5
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

