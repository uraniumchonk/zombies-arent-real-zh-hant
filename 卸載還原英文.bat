@echo off
chcp 950 >nul
setlocal enabledelayedexpansion
title ZAR 繁體中文 - 卸載（還原英文）
cls
echo ============================================================
echo    Zombies Aren't Real  繁體中文  卸載
echo    （還原為英文原版）
echo ============================================================
echo.
set "PKG=%~dp0"
set "PKG=%PKG:~0,-1%"

call :find_gamedir
if defined GAMEDIR (
  echo [偵測到遊戲目錄]
  echo    %GAMEDIR%
  echo.
  set /p CONFIRM=這是正確的遊戲目錄嗎？(Y=是 / N=手動輸入): 
  if /i not "!CONFIRM!"=="Y" set /p GAMEDIR=請貼上遊戲目錄完整路徑（含 zombies-arent-real.exe 的資料夾）：
) else (
  echo [無法自動偵測遊戲目錄]
  echo.
  set /p GAMEDIR=請貼上遊戲目錄完整路徑（含 zombies-arent-real.exe 的資料夾）：
)
set "GAMEDIR=%GAMEDIR:"=%"

if not exist "%GAMEDIR%\zombies-arent-real.exe" (
  echo.
  echo [錯誤] 在以下路徑找不到 zombies-arent-real.exe：
  echo    %GAMEDIR%
  pause
  exit /b 1
)

tasklist | find /i "zombies-arent-real.exe" >nul
if not errorlevel 1 (
  echo.
  echo [提示] 偵測到遊戲正在執行，先關閉它...
  taskkill /f /im zombies-arent-real.exe >nul 2>&1
  timeout /t 2 /nobreak >nul
)

echo.
if not exist "%GAMEDIR%\_zh-Hant_backup\fonts\cjk\NotoSansSC-Subset.otf" (
  echo [錯誤] 找不到備份資料夾 _zh-Hant_backup。
  echo        可能是未用「一鍵安裝還原.bat」安裝，或備份已被刪除。
  echo.
  echo        請改用 Steam：右鍵遊戲 → 屬性 → 已安裝的檔案 →
  echo        驗證遊戲檔案完整性，即可還原英文原版。
  pause
  exit /b 1
)

echo [1/2] 從備份還原英文原版檔案...
robocopy "%GAMEDIR%\_zh-Hant_backup" "%GAMEDIR%" /E /NFL /NDL /NP >nul
if errorlevel 8 (
  echo [錯誤] 還原失敗，請檢查權限或路徑。
  pause
  exit /b 1
)

echo [2/2] 移除繁體中文語言檔...
del "%GAMEDIR%\lang\zh-Hant.lang" >nul 2>&1
echo        已移除 zh-Hant.lang

echo.
echo ============================================================
echo    卸載完成！遊戲已還原為英文原版。
echo    （備份資料夾 _zh-Hant_backup 可手動刪除）
echo ============================================================
echo.
pause
exit /b 0

:find_gamedir
set "GAMEDIR="
rem --- try registry Steam install path ---
for /f "tokens=2,*" %%a in ('reg query "HKLM\SOFTWARE\WOW6432Node\Valve\Steam" /v SteamInstall 2^>nul') do set "STEAMROOT=%%b"
if defined STEAMROOT if exist "%STEAMROOT%\steamapps\common\Zombies-Arent-Real\zombies-arent-real.exe" set "GAMEDIR=%STEAMROOT%\steamapps\common\Zombies-Arent-Real"
for /f "tokens=2,*" %%a in ('reg query "HKLM\SOFTWARE\Valve\Steam" /v SteamInstall 2^>nul') do set "STEAMROOT=%%b"
if defined STEAMROOT if exist "%STEAMROOT%\steamapps\common\Zombies-Arent-Real\zombies-arent-real.exe" set "GAMEDIR=%STEAMROOT%\steamapps\common\Zombies-Arent-Real"
rem --- try common drives/paths ---
if not defined GAMEDIR for %%d in (C D E F G H I J) do (
  if not defined GAMEDIR if exist "%%d:\steam\steamapps\common\Zombies-Arent-Real\zombies-arent-real.exe" set "GAMEDIR=%%d:\steam\steamapps\common\Zombies-Arent-Real"
  if not defined GAMEDIR if exist "%%d:\Steam\steamapps\common\Zombies-Arent-Real\zombies-arent-real.exe" set "GAMEDIR=%%d:\Steam\steamapps\common\Zombies-Arent-Real"
  if not defined GAMEDIR if exist "%%d:\Program Files (x86)\Steam\steamapps\common\Zombies-Arent-Real\zombies-arent-real.exe" set "GAMEDIR=%%d:\Program Files (x86)\Steam\steamapps\common\Zombies-Arent-Real"
  if not defined GAMEDIR if exist "%%d:\Program Files\Steam\steamapps\common\Zombies-Arent-Real\zombies-arent-real.exe" set "GAMEDIR=%%d:\Program Files\Steam\steamapps\common\Zombies-Arent-Real"
  if not defined GAMEDIR if exist "%%d:\steamapps\common\Zombies-Arent-Real\zombies-arent-real.exe" set "GAMEDIR=%%d:\steamapps\common\Zombies-Arent-Real"
)
exit /b 0
