:: The following Batch program is a Command Line Network Tool that continuously updates and displays key information about one's network connection
:: DISCLAIMER: TO BE USED RESPONSIBLY AND FOR EDUCATIONAL PURPOSES ONLY, THE DEVELOPER IS NOT LIABLE FOR ANY MISUSE OF THE PROGRAM
@echo off
:: The mode line creates a fixed size window
mode 38,20
:: Loads the command portal and informs the user it is loading
title Network Stats
echo Loading Network Information...
:: Continuously loops the following for loops that each gather information from the user's network interface before saving it to it's respective variable
:loop
for /f "tokens=2 delims=:" %%a in ('netsh wlan show interface ^| find "Name"') do set name=%%a
for /f "tokens=2 delims=:" %%a in ('netsh wlan show interface ^| find "State"') do set state=%%a
for /f "tokens=2 delims=:" %%a in ('netsh wlan show interface ^| find "SSID" ^| findstr /v "BSSID"') do set ssid=%%a
for /f "tokens=2 delims=:" %%a in ('netsh wlan show interface ^| find "Band"') do set band=%%a
for /f "tokens=2 delims=:" %%a in ('netsh wlan show interface ^| find "Authentication"') do set auth=%%a
for /f "tokens=2 delims=:" %%a in ('netsh wlan show interface ^| find "Cipher"') do set ciph=%%a
for /f "tokens=2 delims=:" %%a in ('netsh wlan show interface ^| find "Signal"') do set signal=%%a
for /f "tokens=4 delims==" %%a in ('ping -n 2 8.8.8.8 ^| find "Average"') do set avg=%%a
for /f "tokens=2 delims= " %%a in ('netstat -e ^| find "Bytes"') do set recv=%%a
for /f "tokens=3 delims= " %%a in ('netstat -e ^| find "Bytes"') do set sent=%%a
:: Clears the console terminal for a cleaner final appearance for the user
cls
:: Prints the network information to the user including network name, state, SSID, and speed
echo  Network:
echo  --------------------
echo  Name:%name%
echo  State:%state%
echo  SSID:%ssid%
echo  Band:%band%
echo  Authentication:%auth%
echo  Cipher:%ciph%
echo  Signal:%signal%
echo.
echo  Speed:
echo  --------------------
echo  Average Ping:%avg%
echo  Bytes Received:%recv% Bytes
echo  Bytes Sent:%sent% Bytes
:: Triggers the loop subroutine to update the console infinitely
goto loop