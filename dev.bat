@echo off
setlocal enabledelayedexpansion

echo --- Bearfit Development Launcher (LAN Mode) ---

set IP=
:: Loop through IPv4 addresses to find the local network IP
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /c:"IPv4 Address"') do (
    set temp_ip=%%a
    set temp_ip=!temp_ip:~1!
    
    if not defined IP set IP=!temp_ip!
)

if "!IP!"=="" (
    echo(Could not detect local IP. Falling back to localhost.)
    set REACT_NATIVE_PACKAGER_HOSTNAME=localhost
    set EXPO_START_ARGS=
) else (
    echo(Detected LAN IP: !IP!)
    set REACT_NATIVE_PACKAGER_HOSTNAME=!IP!
    set EXPO_START_ARGS=--lan
)

echo(Starting Docker containers...)
docker-compose up --build