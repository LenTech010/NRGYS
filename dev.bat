@echo off
setlocal enabledelayedexpansion

:: Function to detect local IP address
: get_local_ip
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /c:"IPv4 Address"') do (
    set IP=%%a
    set IP=!IP:~1! 
    goto :ip_found
)
:ip_found
exit /b

echo --- Bearfit Development Launcher ---
echo Using LAN mode (for physical devices on same WiFi)...
echo. 

call :get_local_ip
if "!IP!"=="" (
    echo Could not detect local IP.  Falling back to localhost.
    set REACT_NATIVE_PACKAGER_HOSTNAME=localhost
    set EXPO_START_ARGS=
) else (
    echo Detected LAN IP: ! IP!
    set REACT_NATIVE_PACKAGER_HOSTNAME=!IP!
    set EXPO_START_ARGS=--lan
)

echo Starting Docker containers...
docker-compose up --build

endlocal

