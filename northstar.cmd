@echo off
setlocal
cd /d "%~dp0"

if not exist "%~dp0index.html" (
  echo ERROR: index.html was not found.
  echo Keep this launcher in the extracted Northstar folder.
  pause
  exit /b 1
)
if not exist "%~dp0northstar.ps1" (
  echo ERROR: northstar.ps1 was not found.
  echo Keep all Northstar files together in the extracted folder.
  pause
  exit /b 1
)

set "PORT=8765"
if not "%~1"=="" set "PORT=%~1"

where powershell.exe >nul 2>nul
if errorlevel 1 (
  echo ERROR: Windows PowerShell was not found.
  echo Open index.html manually, or install PowerShell and try again.
  pause
  exit /b 1
)

powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -File "%~dp0northstar.ps1" -Port "%PORT%"
if errorlevel 1 pause
