Windows Registry Editor Version 5.00

set name=Lock Screen


@echo off
pushd "%~dp0"
set A=Temp\Temp.reg
md "%systemroot%\checkadmin"
if exist "%systemroot%\checkadmin" (
rd /s /q "%systemroot%\checkadmin"
goto main) else (
exit
)

:main
if /i %0 == "%~dp0%name% [ON].bat" goto disable
md Temp
copy %0 %A%

echo.>>%A%

(echo [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Personalization] &echo "NoLockScreen"=- )>>%A%


regedit /s %A% 1>nul 2>nul
rd /s /q "Temp"
ren %0 "%name% [ON].bat"
:disable
md Temp
copy %0 %A%

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System]
"DisableLogonBackgroundImage"=-

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Personalization]
"NoLockScreen"=dword:00000001


regedit /s %A% 1>nul 2>nul
rd /s /q "Temp"
ren %0 "%name% [OFF].bat"