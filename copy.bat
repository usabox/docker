cd /d %~dp0

xcopy %USERPROFILE%\.ssh %~dp0workspace\ /Y

xcopy %USERPROFILE%\.ssh %~dp0consul\ /Y

pause
