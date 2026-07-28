@echo off
setlocal
cd /d "%~dp0"

if not exist "%~dp0scan-ledger.html" (
  echo ERROR: scan-ledger.html was not found.
  echo Keep this launcher in the extracted Scan Ledger folder.
  echo.
  pause
  exit /b 1
)

echo Opening Scan Ledger in your default browser...
start "" "%~dp0scan-ledger.html"
if errorlevel 1 (
  echo ERROR: Windows could not open Scan Ledger.
  echo Open scan-ledger.html manually from this folder.
  echo.
  pause
  exit /b 1
)

echo Scan Ledger opened successfully. You can close this window.
timeout /t 3 /nobreak >nul
exit /b 0
