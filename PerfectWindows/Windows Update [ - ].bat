Windows Registry Editor Version 5.00

set name=Windows Update


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
if /i %0 == "%~dp0%name% [ O ].bat" goto disable
md Temp
copy %0 %A%

icacls "%WINDIR%\System32\UsoClient.exe" /reset
echo.>>%A%
(echo [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU] &echo "NoAutoUpdate"=- &echo "AUOptions"=- )>>%A%


regedit /s %A% 1>nul 2>nul
rd /s /q "Temp"
ren %0 "%name% [ O ].bat"
:disable
md Temp
copy %0 %A%

icacls "%WINDIR%\System32\UsoClient.exe" /reset
takeown /f "%WINDIR%\System32\UsoClient.exe" /a
icacls "%WINDIR%\System32\UsoClient.exe" /inheritance:r /remove "Administrators" "Authenticated Users" "Users" "System"

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU]
"NoAutoUpdate"=-
"AUOptions"=dword:00000002


regedit /s %A% 1>nul 2>nul
rd /s /q "Temp"
ren %0 "%name% [ X ].bat"