@echo off
set /p host="host">> "
set /p user="user">> "
set /p pass="pass">> "

cmdkey /add:%host% /user:%user% /pass:%pass% >nul
mstsc /v:%host%
cmdkey /delete:%host% >nul