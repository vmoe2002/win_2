@echo off
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
echo Requesting administrative privileges..
goto UACPrompt
) else ( goto GotAdminn )
:UACPrompt
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs"
exit /B
:GotAdminn
if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
pushd "%CD%"
CD /D "%~dp0"
REG ADD HKLM\SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName /v ComputerName /t REG_SZ /d Mrose /f
REG ADD HKLM\SYSTEM\CurrentControlSet\Control\ComputerName\ActiveComputerName\ /v ComputerName /t REG_SZ /d Mrose /f
REG ADD HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\ /v Hostname /t REG_SZ /d Mrose /f
REG ADD HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\ /v "NV Hostname" /t REG_SZ /d Mrose /f
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarSmallIcons /t REG_DWORD /d 1 /f
REG ADD "HKEY_CURRENT_USER\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d D:\a\wallpaper.bmp /f
RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters
taskkill /f /im explorer.exe
start explorer.exe
