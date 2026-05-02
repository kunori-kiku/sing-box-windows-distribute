@echo off
setlocal enabledelayedexpansion

:: Set script directory
cd /d "%~dp0"

:: Define file paths
set "CONFIG_FILE=config.json"
set "EXECUTABLE=sing-box.exe"
set "URL="

:: Open http://localhost:9090 in browser
start "" http://localhost:9090

:: Run sing-box.exe with config.json
"%EXECUTABLE%" run -c "%CONFIG_FILE%"

:: Keep the window open in case of errors
pause
