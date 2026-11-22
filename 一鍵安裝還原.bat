@echo off
chcp 950 >nul
setlocal enabledelayedexpansion
title ZAR 繁體中文 - 一鍵安裝／還原
cls
echo ============================================================
echo    Zombies Aren't Real  繁體中文  一鍵安裝／還原
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
  echo.
  echo 請確認路徑正確後重試。
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
echo [1/2] 備份原始檔案（僅首次）...
if not exist "%GAMEDIR%\_zh-Hant_backup\fonts\cjk\NotoSansSC-Subset.otf" (
  robocopy "%GAMEDIR%\fonts\cjk" "%GAMEDIR%\_zh-Hant_backup\fonts\cjk" NotoSansSC-Subset.otf /NFL /NDL /NP >nul
  robocopy "%GAMEDIR%\mutators"  "%GAMEDIR%\_zh-Hant_backup\mutators"  *.ini /NFL /NDL /NP >nul
  robocopy "%GAMEDIR%\campaigns" "%GAMEDIR%\_zh-Hant_backup\campaigns" *.cmp order.txt /NFL /NDL /NP >nul
  echo        已備份到 %GAMEDIR%\_zh-Hant_backup
) else (
  echo        已有備份，略過。
)

echo.
echo [2/2] 安裝繁體中文檔案...
robocopy "%PKG%\zh-hant" "%GAMEDIR%" /E /NFL /NDL /NP >nul
if errorlevel 8 (
  echo [錯誤] 複製檔案失敗，請檢查權限或路徑。
  pause
  exit /b 1
)

echo.
echo ============================================================
echo    完成！
echo    啟動遊戲 → 設定 → 語言 → 選「繁體中文」
echo    （遊戲更新後重跑本腳本即可還原）
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
