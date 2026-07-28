@echo off
setlocal
cd /d "%~dp0"

where py >nul 2>&1
if %errorlevel% equ 0 (
  py -3 "%~dp0scan-ledger" %*
  exit /b %errorlevel%
)

where python >nul 2>&1
if %errorlevel% equ 0 (
  python "%~dp0scan-ledger" %*
  exit /b %errorlevel%
)

echo Scan Ledger needs Python 3, but Python was not found.
echo Install it from https://www.python.org/downloads/windows/ and try again.
exit /b 1
