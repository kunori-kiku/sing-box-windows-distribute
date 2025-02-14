@echo off
setlocal enabledelayedexpansion

:: Set script directory
cd /d "%~dp0"

:: Define file paths
set "SUB_FILE=sub.txt"
set "CONFIG_FILE=config.json"
set "EXECUTABLE=sing-box.exe"
set "URL="

:: Check if sub.txt exists
if not exist "%SUB_FILE%" (
    echo file not found > "%SUB_FILE%"
    echo file not found
    pause
    exit /b 1
)

:: Read the URL from sub.txt
set /p URL=<"%SUB_FILE%"

:: Check if URL is empty
if "%URL%"=="" (
    echo Error: sub.txt is empty or could not be read.
    pause
    exit /b 1
)

:: Check if curl is available
where curl >nul 2>nul
if %errorlevel% neq 0 (
    echo curl is not installed. Attempting to install...

    :: Check if winget is available
    where winget >nul 2>nul
    if %errorlevel% neq 0 (
        echo Error: winget is not installed. Please install curl manually.
        pause
        exit /b 1
    )

    :: Install curl using winget
    winget install --id curl.curl -e
    if %errorlevel% neq 0 (
        echo Error: Failed to install curl.
        pause
        exit /b 1
    )

    echo curl installed successfully.
)

:: Download JSON using curl
curl -s -o "%CONFIG_FILE%" "%URL%"
if %errorlevel% neq 0 (
    echo Error: Failed to fetch data from %URL%
    pause
    exit /b 1
)

:: Check if sing-box.exe exists
if not exist "%EXECUTABLE%" (
    echo Error: %EXECUTABLE% not found.
    pause
    exit /b 1
)

:: Open http://localhost:9090 in browser
start "" http://localhost:9090

:: Run sing-box.exe with config.json
"%EXECUTABLE%" run -c "%CONFIG_FILE%"

:: Keep the window open in case of errors
pause
